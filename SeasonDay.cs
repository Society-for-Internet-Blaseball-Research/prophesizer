using System;
using System.Collections.Generic;
using System.Text;

class SeasonDay : IEquatable<SeasonDay>, IComparable<SeasonDay>
{
	public int Tournament;
	public int Season;
	public int Day;

	private const int MAX_DAY = 135;

	public SeasonDay(int season, int day, int tournament = -1)
	{
		Tournament = tournament;
		Season = season;
		Day = day;
	}

	public override string ToString()
	{
		string s = Tournament != -1 ? $"T{Tournament}" : "";
		return s + $"S{Season}D{Day}";
	}

	int IComparable<SeasonDay>.CompareTo(SeasonDay other)
	{
		int tournamentDiff = GetTournamentDiff(this, other);

		int seasonDiff = Season - other.Season;

		if (seasonDiff == 0 && tournamentDiff == 0)
		{
			return Day - other.Day;
		}
		else if(tournamentDiff == 0)
		{
			return seasonDiff;
		}
		else
		{
			return tournamentDiff;
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

	// Get an IComparable style number describing the tournament value of two SeasonDays
	private static int GetTournamentDiff(SeasonDay a, SeasonDay b)
	{
		return a.Tournament - b.Tournament;
		//if (a.Tournament.HasValue && !b.Tournament.HasValue)
		//{
		//	// non-null come after NULL tournaments
		//	return 1;
		//}
		//else if (!a.Tournament.HasValue && b.Tournament.HasValue)
		//{
		//	// NULL tournaments come after non-null
		//	return -1;
		//}
		//else
		//{
		//	int tournamentDiff = 0;
		//	if (a.Tournament.HasValue && b.Tournament.HasValue)
		//	{
		//		tournamentDiff = a.Tournament.Value - b.Tournament.Value;
		//	}

		//	return tournamentDiff;
		//}
	}

	public static bool operator <=(SeasonDay a, SeasonDay b)
	{
		int tournDiff = GetTournamentDiff(a, b);

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
		int tournDiff = GetTournamentDiff(a, b);

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
		int tournDiff = GetTournamentDiff(a, b);

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
		int tournDiff = GetTournamentDiff(a, b);

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
		int season = a.Season;
		int day = a.Day + offset;

		if (day > MAX_DAY)
		{
			season++;
			day = 0;
		}

		return new SeasonDay(season, day, a.Tournament);
	}
}
