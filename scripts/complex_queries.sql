--Select all Cars wiht it's brand name.
SELECT 
    b.Id, 
    b.Name, 
    a.Name AS brand_name

    FROM Cars b 
    LEFT JOIN Brand a ON b.brandId = a.Id;


--Select Cars by a specific brand.
SELECT
    b.Id,
    b.Name

    FROM Cars b 
    LEFT JOIN Brand a ON b.brandId = a.Id
    
    WHERE LOWER(a.Name) = LOWER("car brend");--mercedes
    


--Select Cars by a specific Categories.
SELECT
    b.Id,
    b.Name

    FROM Cars b 
    JOIN Categories a ON b.CategoriesId = a.Id
    
    WHERE LOWER(a.Name) = LOWER("Categories name");--Sedan


--Select users that have specific car in a cart.
SELECT 
    u.Id,
    u.Name,
    u.Login     
     
    FROM CartsCar cb
    JOIN Cars b ON cb.carId = b.Id AND b.Id = "car id"--2
    JOIN Carts c ON cb.CartId = c.Id
    JOIN Users u ON c.UserId = u.Id;
    

--Select all Cars from specific user cart.
SELECT 
    b.Id,
    b.Name,
    a.Name AS brand_name
    
    FROM CartsCar cb
    JOIN Carts c ON cb.CartId = c.Id
    JOIN Users u ON c.UserId = u.Id AND LOWER(u.Name) = LOWER("user name")--Peter
    JOIN Cars b ON cb.carId = b.Id
    LEFT JOIN Brand a ON b.brandId = a.Id;


--Select users that have specific car in orders.
SELECT 
    u.Id,
    u.Name,
    u.Login     
     
    FROM OrdersCar ob
    JOIN Cars b ON ob.carId = b.Id AND b.Id = "car id"--3,4
    JOIN Orders o ON ob.OrderId = o.Id
    JOIN Users u ON o.UserId = u.Id;
    

--Select Cars that was ordered by specific user.
SELECT 
    b.Id,
    b.Name,
    a.Name AS brand_name
    
    FROM OrdersCar ob
    JOIN Orders o ON ob.OrderId = o.Id
    JOIN Users u ON o.UserId = u.Id AND LOWER(u.Name) = LOWER("User name")--Peter
    JOIN Cars b ON ob.carId = b.Id 
    LEFT JOIN Brand a ON b.brandId = a.Id;


--Select all providers
SELECT
    u.Id, 
    u.Name, 
    u.Login  
    
    FROM Users u 
    WHERE Id IN (SELECT p.UserPtr FROM Providers p);
    


--Select providers by specific car.
SELECT 
    u.Id,
    u.Name,
    u.Login  
    
    FROM ProvidersCars pb
    JOIN Cars b ON pb.carId = b.Id AND b.Id = "car id" --2
    JOIN Users u ON pb.ProviderId = u.Id; 
    
    
--Select coupons of specific user.
SELECT 
    c.Id,
    c.Discount
    
    FROM Coupons c
    JOIN Users u ON u.CouponId = c.Id AND LOWER(u.Name) = LOWER("User name");--Peter

--Select users by role.
SELECT 
    u.Id,
    u.Name,
    u.Login    
    
    FROM Users u
    JOIN Roles r ON u.RoleId = r.Id AND LOWER(r.Name) = LOWER("Role name");--Customer
    

--Select user role.
SELECT
    r.Id,
    r.Name
    
    FROM Roles r
    JOIN Users u ON u.RoleId = r.Id AND LOWER(u.Name) = LOWER("User name");--Peter, SuperAdmin
    

--Select all reviews by specific car.
SELECT 
    r.Id,
    r.Text
    
    FROM Reviews r
    JOIN Cars b ON r.carId = b.Id AND b.Id = "car id";--2
    

--Select all reviews by specific user.
SELECT 
    r.Id,
    r.Text
    
    FROM Reviews r
    JOIN Users u ON r.UserId = u.Id AND LOWER(u.Name) = LOWER("User name");--Peter

    

--Select count of orders of every car.
SELECT
    b.Id, 
    b.Name, 
    a.Name AS brand_name,
    SUM(ob.Count) AS orders_count

    FROM Cars b 
    LEFT JOIN Brand a ON b.brandId = a.Id
    LEFT JOIN OrdersCar ob ON ob.carId = b.Id
    
    GROUP BY b.Id;


--Select Cars that are in the cart of at least 1 users.
SELECT
    b.Id, 
    b.Name, 
    a.Name AS brand_name,
    SUM(cb.Count) AS in_cart_count

    FROM Cars b 
    LEFT JOIN Brand a ON b.brandId = a.Id
    LEFT JOIN CartsCar cb ON cb.carId = b.Id
    
    GROUP BY b.Id 
    HAVING SUM(cb.Count) >= 1;


--Select all persons names.(show union)
SELECT u.Name FROM Users u
UNION 
SELECT a.Name FROM Brand a;


--Select Cars and it's popularity level.
SELECT b.Id, 
       b.Name, 
       a.Name AS brand_name,
       CASE 
           WHEN bto.total_ordered > 5 THEN "Super popular"
           WHEN bto.total_ordered BETWEEN 1 AND 5 THEN "Meadle popular"
           ELSE "Not popular"
       END AS popularity                          
       

       FROM Cars b
            LEFT JOIN Brand a ON b.brandId = a.Id
            JOIN (SELECT ob.carId AS car_id, 
                         SUM(ob.Count) AS total_ordered 
                    FROM OrdersCar ob 
                GROUP BY ob.carId) AS bto
              ON bto.car_id = b.Id;
              
            