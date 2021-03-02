using System;
using System.Collections.Generic;
using System.Text;

namespace Cauldron.Serializable
{
	/// <summary>
	/// Ignore a property when inserting into the DB
	/// </summary>
	[System.AttributeUsage(System.AttributeTargets.Property)]
	public class DbIgnoreAttribute : System.Attribute
	{
		public DbIgnoreAttribute()
		{
		}
	}

	/// <summary>
	/// Call this property by the given column name when inserting into the DB
	/// </summary>
	[System.AttributeUsage(System.AttributeTargets.Property)]
	public class DbAliasAttribute : System.Attribute
	{
		public string Alias;
		public DbAliasAttribute(string alias)
		{
			Alias = alias;
		}
	}

	/// <summary>
	/// Use this default value if this property is NULL when inserting into the DB
	/// </summary>
	[System.AttributeUsage(System.AttributeTargets.Property)]
	public class DbNullValueAttribute : System.Attribute
	{
		public object Value;
		public DbNullValueAttribute(object value)
		{
			Value = value;
		}
	}

}
