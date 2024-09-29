CREATE FUNCTION udf_AuthorsWithBooks(@name NVARCHAR(100))
RETURNS INT
AS
BEGIN
	RETURN (SELECT 
		COUNT(b.Id) AS [Count]
	FROM Books AS b
	JOIN Authors AS a ON a.Id = b.AuthorId
	WHERE a.[Name] = @name)
END


SELECT dbo.udf_AuthorsWithBooks('J.K. Rowling')


CREATE PROCEDURE usp_SearchByGenre(@GenreName NVARCHAR(30))
AS
BEGIN
	SELECT
		b.Title AS Title,
		b.YearPublished AS [Year],
		b.ISBN AS ISBN,
		a.[Name] AS Author,
		g.[Name] AS Genre
	FROM Books AS b
	JOIN Genres AS g ON g.Id = b.GenreId
	JOIN Authors AS a ON a.Id = b.AuthorId
	WHERE g.[Name] = @GenreName
	ORDER BY b.Title ASC;
END


EXEC usp_SearchByGenre 'Fantasy'