--Select books with it's authors.
CREATE VIEW cars_brands_view AS
    SELECT b.Id, 
           b.Name, 
           a.Name AS BrandName
    
      FROM Cars b 
           LEFT JOIN Brand a 
                  ON b.BrandId = a.Id;
        

--Select users with it's provider status.
CREATE VIEW users_is_providers_view AS
    SELECT u.Id,
           u.Name,
           u.Login,
           EXISTS
           (SELECT * 
              FROM Providers p 
             WHERE p.UserPtr = u.Id) 
                AS is_provider
                              
      FROM Users u;


--Select books, ordered less than two times
CREATE VIEW unpopular_cars_view AS
    SELECT *
      FROM cars_brands_view ba
           JOIN (SELECT ob.CarId AS car_id, 
                        SUM(ob.Count) AS total_ordered 
                   FROM OrdersCar ob 
               GROUP BY ob.CarId) AS bto
             ON ba.Id = bto.car_id AND bto.total_ordered < 2;    
             

--Select users and count of books in a cart
CREATE VIEW users_and_count_cars_in_cart AS
    SELECT u.Id,
           u.Name,
           u.Login,
           cbc.summary_in_cart
           
           FROM Users u
                JOIN (SELECT c.UserId AS user_id,
                             SUM(cb.Count) AS summary_in_cart
                        FROM Carts c
                             JOIN Cartscar cb
                               ON c.Id = cb.CartId
                    GROUP BY user_id) AS cbc                    
             ON cbc.user_id = u.Id;                               
                                    
