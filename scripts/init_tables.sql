INSERT INTO Coupons (Discount) VALUES 
(10.5), 
(11.8), 
(20.1);


INSERT INTO Roles (Name) VALUES
("Customer"),
("Admin");


INSERT INTO Brand (Name) VALUES
("BMW"),
("MERCEDES"),
("RANGEROVER"),
("PORSCHE");


INSERT INTO Users (Login, Password, Name, RoleId, CouponId) VALUES
("Log1", "Pass1", "Jhon", 1, NULL),
("Log2", "Pass2", "Peter", 1, 2),
("Log3", "Pass3", "Bob", 1, 1),
("Log4", "Pass4", "Tom", 1, 2),
("Log5", "Pass5", "SuperAdmin", 2, NULL);


INSERT INTO Providers (UserPtr) VALUES
(3),
(4);


INSERT INTO Categories (Name) VALUES
("Sedan"),
("Limousine"),
("Pickup truck"),
("Hatchback"),
("Station wagon"),
("Minivan"),
("Compartment"),
("Convertible"),
("Roadster"),
("crossover"),
("SUVs");


INSERT INTO Cars (Name, BrandId, CategoriesId) VALUES
("7-series", 1,1),
("S-class", 2, 1),
("disvovery", 3, 10),
("918", 4, 9);


INSERT INTO Reviews (Text, CarId, UserId) VALUES
("I like it. The best of the  best.", 1, 1),
("0 from 10.", 2, 2),
("Nothing", 4, 3);


INSERT INTO Orders (UserId) VALUES
(1),
(2),
(3);


INSERT INTO Carts (UserId) VALUES
(1),
(2),
(3),
(5);


INSERT INTO CartsCar (CartId, CarId) VALUES
(4, 2), 
(2, 4), (2, 4);


INSERT INTO OrdersCar (OrderId, CarId) VALUES
(2,3),(3,4);


INSERT INTO Providerscars (ProviderId, CarId) VALUES
(3, 1), (3, 4),
(4, 2), (4, 3), (4, 4);
