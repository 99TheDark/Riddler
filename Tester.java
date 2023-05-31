import java.io.IOException;

public class Tester {
	private static boolean DEBUG = true;
	private static int NUM_SERIES = 3;
	private static double HOME_TEAM_WIN_PCT = .6;

	public static void main(String[] args) throws IOException
	{
		System.out.println("{1, 1, 0, 0, 1, 0, 1}");
		int[] homeGamesSchedule1 = {1, 1, 0, 0, 1, 0, 1};
		testNumSeriesTimes(homeGamesSchedule1);
		
		System.out.println();
		System.out.println("{1, 1, 0, 0, 0, 1, 1}");
		int[] homeGamesSchedule2 = {1, 1, 0, 0, 0, 1, 1};
		testNumSeriesTimes(homeGamesSchedule2);
	}

	public static void testNumSeriesTimes(int[] homeGamesSchedule)
	{
		int team1WinsSeries = 0;
		int team2WinsSeries = 0;

		for (int i = 1; i <= NUM_SERIES; i++)
		{
			int team1WinsGame = 0;
			int team2WinsGame = 0;
			for (int j = 1; j <= 7; j++)
			{
				boolean homeTeamWins = Tester.playGame(homeGamesSchedule, j);

				if (homeTeamWins)
					team1WinsGame++;
				else
					team2WinsGame++;

				if (team1WinsGame == 4)
				{
					team1WinsSeries++;
					if (DEBUG) {
						System.out.println("team1WinsGame(1) == " + team1WinsGame);
						System.out.println("team2WinsGame(1) == " + team2WinsGame);
					}
					break;
				}
				else if (team2WinsGame == 4)
				{
					team2WinsSeries++;
					if (DEBUG) {
						System.out.println("team1WinsGame(2) == " + team1WinsGame);
						System.out.println("team2WinsGame(2) == " + team2WinsGame);
					}
					break;
				}	
			}
			if (DEBUG) {
				System.out.println();
			}
		}

		System.out.println("team1WinsSeries == " + ((double) team1WinsSeries)/((double) NUM_SERIES));
		System.out.println("team2WinsSeries == " + ((double) team2WinsSeries)/((double) NUM_SERIES));

	}
	public static boolean playGame(int[] homeGamesSchedule, int i)
	{
		boolean homeTeamWins = true;
		double randomNum = Math.random();

		if (DEBUG)
		{
			System.out.println("Game Number == " + i);
			System.out.println("randomNum == " + randomNum);
		}
		
		if (homeGamesSchedule[i-1] == 1)
		{
			if (DEBUG)
				System.out.println("Home Game");

			if (randomNum <= HOME_TEAM_WIN_PCT)
			{
				if (DEBUG)
					System.out.println("homeTeamWins");
				homeTeamWins = true;				
			}
			else
			{
				if (DEBUG)
					System.out.println("awayTeamWins");
				homeTeamWins = false;				
			}
		}
		else
		{
			if (DEBUG)
				System.out.println("Away Game");

			if (randomNum <= (1.0 - HOME_TEAM_WIN_PCT))
			{
				if (DEBUG)
					System.out.println("awayTeamWins");
				homeTeamWins = false;				
			}
			else
			{
				if (DEBUG)
					System.out.println("homeTeamWins");
				homeTeamWins = true;				
			}
		}

		return homeTeamWins;
	}

}
