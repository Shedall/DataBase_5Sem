--Select books with it's authors.
CREATE VIEW books_authors_view AS
    SELECT b.id,
           b.title,
           a.name AS author_name
    
      FROM books b 
           LEFT JOIN authors a 
                  ON b.author_id = a.id;


--Select users with it's provider status.
CREATE VIEW users_is_providers_view AS
    SELECT u.id,
           u.name,
           u.Login,
           EXISTS
           (SELECT *
              FROM providers p
             WHERE p.user_ptr_id = u.id) 
                AS is_provider
                              
      FROM users u;


--Select books, ordered less than two times
CREATE VIEW unpopular_books_view AS
    SELECT *
      FROM books_authors_view ba
           JOIN (SELECT ob.book_id AS book_id,
                        SUM(ob.count) AS total_ordered 
                   FROM orders_books ob 
               GROUP BY ob.book_id) AS bto
             ON ba.id = bto.book_id AND bto.total_ordered < 2;


--Select users and count of books in a cart
CREATE VIEW users_and_count_books_in_cart AS
    SELECT u.id,
           u.name,
           u.login,
           cbc.summary_in_cart
           
           FROM users u
                JOIN (SELECT c.user_id AS user_id,
                             SUM(cb.count) AS summary_in_cart
                        FROM carts c
                             JOIN carts_books cb
                               ON c.id = cb.cart_id
                    GROUP BY user_id) AS cbc                    
             ON cbc.user_id = u.id;
