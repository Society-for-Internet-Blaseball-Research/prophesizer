using System;
using System.Collections.Generic;
using System.Text;

class SeasonDay : IEquatable<SeasonDay>, IComparable<SeasonDay>
{
	public int Tournament;
	public int Season;
	public int Day;
	public bool IsTournament => (Tournament != -1);

	private const int MAX_DAY = 135;

	public string HumanReadable
	{
		get
		{
			if (IsTournament) return $"Tournament {Tournament}, Day {Day + 1}";
			else return $"Season {Season + 1}, Day {Day + 1}";
		}
	}

	public SeasonDay(int season, int day, int tournament = -1)
	{
		Tournament = tournament;
		Season = season;
		Day = day;
	}

	public override string ToString()
	{
		string s = IsTournament ? $"T{Tournament}" : "";
		return s + $"S{Season}D{Day}";
	}

	int IComparable<SeasonDay>.CompareTo(SeasonDay other)
	{
		if (IsTournament)
		{
			int tournDiff = Tournament - other.Tournament;

			if (tournDiff == 0)
			{
				return Day - other.Day;
			}
			else
			{
				return tournDiff;
			}
		}
		else
		{
			int seasonDiff = Season - other.Season;

			if (seasonDiff == 0)
			{
				return Day - other.Day;
			}
			else
			{
				return seasonDiff;
			}
		}
	}

	public override bool Equals(object other)
	{
		return 
			Tournament == ((SeasonDay)other).Tournament &&
			Season == ((SeasonDay)other).Season && 
			Day == ((SeasonDay)other).Day;
	}

	public override int GetHashCode()
	{
		return Season.GetHashCode() ^ Day.GetHashCode() ^ Tournament.GetHashCode();
	}

	bool IEquatable<SeasonDay>.Equals(SeasonDay other)
	{
		return 
			Tournament == other.Tournament &&
			Season == other.Season && 
			Day == other.Day;
	}

	public static bool operator <=(SeasonDay a, SeasonDay b)
	{
		int tournDiff = a.Tournament - b.Tournament;

		if (tournDiff == 0)
		{
			if (a.Season == b.Season)
			{
				return a.Day <= b.Day;
			}
			else
			{
				return a.Season < b.Season;
			}
		}
		else
		{
			return tournDiff <= 0;
		}
	}
	public static bool operator >=(SeasonDay a, SeasonDay b)
	{
		int tournDiff = a.Tournament - b.Tournament;

		if (tournDiff == 0)
		{
			if (a.Season == b.Season)
			{
				return a.Day >= b.Day;
			}
			else
			{
				return a.Season > b.Season;
			}
		}
		else
		{
			return tournDiff >= 0;
		}
	}

	public static bool operator <(SeasonDay a, SeasonDay b)
	{
		int tournDiff = a.Tournament - b.Tournament;

		if (tournDiff == 0)
		{
			if (a.Season == b.Season)
			{
				return a.Day < b.Day;
			}
			else
			{
				return a.Season < b.Season;
			}
		}
		else
		{
			return tournDiff < 0;
		}
	}
	public static bool operator >(SeasonDay a, SeasonDay b)
	{
		int tournDiff = a.Tournament - b.Tournament;

		if (tournDiff == 0)
		{
			if (a.Season == b.Season)
			{
				return a.Day > b.Day;
			}
			else
			{
				return a.Season > b.Season;
			}
		}
		else
		{
			return tournDiff > 0;
		}
	}

	public static SeasonDay operator ++(SeasonDay a)
	{
		return a + 1;
	}

	public static SeasonDay operator +(SeasonDay a, int offset)
	{
		int tournament = a.Tournament;
		int season = a.Season;
		int day = a.Day + offset;

		if (day > MAX_DAY)
		{
			if (a.IsTournament)
			{
				tournament++;
			}
			else
			{
				season++;
			}
			day = 0;
		}

		return new SeasonDay(season, day, tournament);
	}
}
