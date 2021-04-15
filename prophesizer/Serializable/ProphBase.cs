using Cauldron.Serializable;
using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;

namespace prophesizer.Serializable
{
	public class ProphBase
	{
		[DbIgnore]
		public virtual bool UseHash => true;

		public virtual Guid Hash(HashAlgorithm hashAlgorithm)
		{
			int hashCode = 0;

			foreach (var prop in this.GetType().GetProperties())
			{
				if (!Attribute.IsDefined(prop, typeof(DbIgnoreAttribute)))
				{
					var value = prop.GetValue(this);
					if (value != null)
					{
						hashCode = hashCode ^ value.GetHashCode();
					}
					else
					{
						hashCode = hashCode ^ "null".GetHashCode();
					}
				}
			}

			// Convert the input string to a byte array and compute the hash.
			byte[] data = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes(hashCode.ToString()));

			return new Guid(data);

		}
	}
}
