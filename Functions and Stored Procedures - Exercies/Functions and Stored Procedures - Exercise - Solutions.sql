USE Diablo
GO

CREATE FUNCTION ufn_CashInUsersGames (@GameName VARCHAR(100))
RETURNS TABLE
AS
RETURN
(
	SELECT
		SUM(Cash) AS [SumCash]
	FROM (SELECT
		ug.Cash,
		DENSE_RANK() OVER (ORDER BY ug.Cash DESC) AS [Rank]
	FROM UsersGames AS ug
	JOIN Games AS g ON g.Id = ug.GameId
	WHERE g.[Name] = @GameName) AS RankedCahs
	WHERE [Rank] % 2 = 1
)
