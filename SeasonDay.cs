using System;
using System.Collections.Generic;
using System.Text;

struct SeasonDay : IEquatable<SeasonDay>, IComparable<SeasonDay>
{
	public int Season;
	public int Day;

	private const int MAX_DAY = 135;

	public SeasonDay(int season, int day)
	{
		Season = season;
		Day = day;
	}

	public override string ToString()
	{
		return $"S{Season}D{Day}";
	}

	int IComparable<SeasonDay>.CompareTo(SeasonDay other)
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

	public override bool Equals(object other)
	{
		return Season == ((SeasonDay)other).Season && Day == ((SeasonDay)other).Day;
	}

	public override int GetHashCode()
	{
		return Season.GetHashCode() ^ Day.GetHashCode();
	}

	bool IEquatable<SeasonDay>.Equals(SeasonDay other)
	{
		return Season == other.Season && Day == other.Day;
	}

	public static bool operator <=(SeasonDay a, SeasonDay b)
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
	public static bool operator >=(SeasonDay a, SeasonDay b)
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
	public static bool operator <(SeasonDay a, SeasonDay b)
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
	public static bool operator >(SeasonDay a, SeasonDay b)
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

		return new SeasonDay(season, day);
	}
}
