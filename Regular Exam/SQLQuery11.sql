SELECT 
	Title AS [Book Title],
	ISBN AS ISBN,
	YearPublished AS YearReleased
FROM Books
ORDER BY YearPublished DESC, Title ASC;


SELECT 
	b.Id AS Id,
	b.Title AS Title,
	b.ISBN AS ISBN,
	g.[Name] AS Genre
FROM Books AS b
JOIN Genres AS g ON g.Id = b.GenreId
WHERE g.[Name] IN ('Biography', 'Historical Fiction')
ORDER BY g.[Name] ASC, b.Title ASC;


SELECT
	l.[Name] AS [Library],
	c.Email AS Email
FROM Libraries AS l
JOIN Contacts AS c ON c.Id = l.ContactId
WHERE l.Id NOT IN
	(SELECT Id FROM LibrariesBooks AS lb JOIN Books AS b ON b.Id = lb.BookId 
	 WHERE b.GenreId NOT IN (SELECT Id FROM Genres WHERE [Name] NOT LIKE '%Mystery%'))
ORDER BY l.[Name] ASC;


SELECT TOP 3
	b.Title AS Title,
	b.YearPublished AS [Year],
	g.[Name] AS Genre
FROM Books AS b
JOIN Genres AS g ON g.Id = b.GenreId
WHERE (b.YearPublished > 2000 AND b.Title LIKE '%a%') 
	OR 
	(b.YearPublished < 1950 AND g.[Name] LIKE '%Fantasy%')
ORDER BY b.Title ASC, b.YearPublished DESC;


SELECT
	a.[Name] AS Author,
	c.Email AS Email,
	c.PostAddress AS [Address]
FROM Authors AS a
JOIN Contacts AS c ON c.Id = a.ContactId
WHERE c.PostAddress LIKE '%UK%'
ORDER BY a.[Name] ASC;


SELECT
	a.[Name] AS Author,
	b.Title AS Title,
	l.[Name] AS [Library],
	c.PostAddress AS [Library Address]
FROM Books AS b
JOIN LibrariesBooks AS lb ON lb.BookId = b.Id
JOIN Libraries AS l on l.Id = lb.LibraryId
JOIN Contacts AS c ON c.Id = l.ContactId
JOIN Authors AS a ON a.Id = b.AuthorId
WHERE b.GenreId IN (SELECT Id FROM Genres WHERE [Name] = 'Fiction') AND c.PostAddress LIKE '%Denver%'
ORDER BY b.Title ASC