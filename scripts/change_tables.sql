INSERT INTO Users (Name, Login, Password, RoleId)
SELECT a.Name, a.Name, "pass1pass", 1
FROM Brand a
WHERE EXISTS(SELECT * FROM cars b WHERE a.Id = b.BrandId);
