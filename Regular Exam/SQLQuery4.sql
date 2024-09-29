DELETE FROM LibrariesBooks
WHERE BookId = 
	(SELECT 
		Id
	FROM Books
	WHERE AuthorId = 
		(SELECT 
			Id 
		FROM Authors
		WHERE [Name] = 'Alex Michaelides'));

DELETE FROM Books
WHERE AuthorId = 
	(SELECT 
		Id 
	FROM Authors
	WHERE [Name] = 'Alex Michaelides');

DELETE FROM Authors
WHERE [Name] = 'Alex Michaelides';