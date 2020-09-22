using Cauldron.Serializable;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Text;

/// <summary>
/// Class that uses reflection to construct an INSERT INTO <table> command for an object
/// </summary>
internal class InsertCommand {

  public NpgsqlCommand Command => m_command;
  private NpgsqlCommand m_command;

  /// <summary>
  /// Constructor
  /// </summary>
  /// <param name="connection">SQL connection</param>
  /// <param name="tableName">Name of table to insert into</param>
  /// <param name="obj">Object to insert</param>
  public InsertCommand(NpgsqlConnection connection, string tableName, object obj, Dictionary<string, object> extraFields = null) {
    m_command = new NpgsqlCommand();
    Populate(tableName, obj, extraFields);
    m_command.Connection = connection;
    //m_command.Prepare();
  }

  /// <summary>
  /// Populate the command with info
  /// </summary>
  /// <param name="tableName">Name of table to insert into</param>
  /// <param name="obj">Object to insert</param>
  private void Populate(string tableName, object obj, Dictionary<string, object> extraFields, string returnColumn = "id") {

    StringBuilder query = new StringBuilder();
    query.Append($"INSERT INTO {tableName}(\n");

    // Separate lists for column names and value tags
    StringBuilder colText = new StringBuilder();
    StringBuilder varText = new StringBuilder();

    // Loop through all properties on the object
    foreach (var prop in obj.GetType().GetProperties()) {

      // Ignore stuff with [DbIgnore]
      if (!Attribute.IsDefined(prop, typeof(DbIgnoreAttribute))) {
        
        // Column names are snake case
        string colName = SnakeCaseify(prop.Name);

        // Use the [DbAlias] name if there is one
        if (Attribute.IsDefined(prop, typeof(DbAliasAttribute))) {
          var aliasAttr = Attribute.GetCustomAttribute(prop, typeof(DbAliasAttribute)) as DbAliasAttribute;
          if (aliasAttr != null)
            colName = aliasAttr.Alias;
        }

        // Append to both strings
        colText.Append($"{colName},\n");
        varText.Append($"@{colName},\n");

        // Use the [DbNullValue] value if the value is null
        object value = prop.GetValue(obj);
        if(value == null && Attribute.IsDefined(prop, typeof(DbNullValueAttribute))) {
          var nullValAttr = Attribute.GetCustomAttribute(prop, typeof(DbNullValueAttribute)) as DbNullValueAttribute;
          if(nullValAttr != null) {
            value = nullValAttr.Value;
          }
        }

        m_command.Parameters.AddWithValue(colName, value);
      }
    }

    if (extraFields != null) {
      foreach (var field in extraFields) {
        colText.Append($"{field.Key},\n");
        varText.Append($"@{field.Key},\n");

        m_command.Parameters.AddWithValue(field.Key, field.Value);
      }
    }

    string columns = colText.ToString().TrimEnd(',','\n');
    string values = varText.ToString().TrimEnd(',','\n');
    query.Append($"{columns}\n) VALUES (\n{values}) RETURNING {returnColumn};");

    m_command.CommandText = query.ToString();
  }


  // Copied from a dotnet pull request
  internal enum SnakeCaseState {
    Start,
    Lower,
    Upper,
    NewWord
  }

  private string SnakeCaseify(string name) {
    if (string.IsNullOrEmpty(name)) {
      return name;
    }

    var sb = new StringBuilder();
    var state = SnakeCaseState.Start;

    var nameSpan = name.AsSpan();

    for (int i = 0; i < nameSpan.Length; i++) {
      if (nameSpan[i] == ' ') {
        if (state != SnakeCaseState.Start) {
          state = SnakeCaseState.NewWord;
        }
      } else if (char.IsUpper(nameSpan[i])) {
        switch (state) {
          case SnakeCaseState.Upper:
            bool hasNext = (i + 1 < nameSpan.Length);
            if (i > 0 && hasNext) {
              char nextChar = nameSpan[i + 1];
              if (!char.IsUpper(nextChar) && nextChar != '_') {
                sb.Append('_');
              }
            }
            break;
          case SnakeCaseState.Lower:
          case SnakeCaseState.NewWord:
            sb.Append('_');
            break;
        }
        sb.Append(char.ToLowerInvariant(nameSpan[i]));
        state = SnakeCaseState.Upper;
      } else if (nameSpan[i] == '_') {
        sb.Append('_');
        state = SnakeCaseState.Start;
      } else {
        if (state == SnakeCaseState.NewWord) {
          sb.Append('_');
        }

        sb.Append(nameSpan[i]);
        state = SnakeCaseState.Lower;
      }
    }

    return sb.ToString();
  }

}
