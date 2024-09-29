UPDATE c
SET Website = LOWER(REPLACE(CONCAT('www.', a.[Name], '.com'), ' ', ''))
FROM Contacts AS c 
JOIN Authors AS a ON a.ContactId = c.Id
WHERE c.Website IS NULL;