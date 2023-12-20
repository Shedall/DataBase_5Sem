--Select all books wiht it's author name.
SELECT 
    b.id, 
    b.title, 
    a.name AS author_name

    FROM books b 
    LEFT JOIN authors a ON b.author_id = a.id;


--Select books by a specific author.
SELECT
    b.id,
    b.title

    FROM books b 
    LEFT JOIN authors a ON b.author_id = a.id
    
    WHERE LOWER(a.name) = LOWER('Author name');
    

--Select categories by a specific book.
SELECT 
    c.id,
    c.name
       
    FROM books_categories bc
    JOIN books b ON bc.book_id = b.id AND b.id = 'Book id'
    JOIN categories c ON bc.category_id = c.id;   


--Select users that have specific book in a cart.
SELECT 
    u.id,
    u.name,
    u.login     
     
    FROM carts_books cb
    JOIN books b ON cb.book_id = b.id AND b.id = 'Book id'
    JOIN carts c ON cb.cart_id = c.id
    JOIN users u ON c.user_id = u.id;


--Select all books from specific user cart.
SELECT 
    b.id,
    b.title,
    a.name AS author_name
    
    FROM carts_books cb
    JOIN carts c ON cb.cart_id = c.id
    JOIN users u ON c.user_id = u.id AND LOWER(u.name) = LOWER('User name')
    JOIN books b ON cb.book_id = b.id
    LEFT JOIN authors a ON b.author_id = a.id;


--Select users that have specific book in orders.
SELECT 
    u.id,
    u.name,
    u.login     
     
    FROM orders_books ob
    JOIN books b ON ob.book_id = b.id AND b.id = 'Book id'
    JOIN orders o ON ob.order_id = o.id
    JOIN users u ON o.user_id = u.id;


--Select books that was ordered by specific user.
SELECT 
    b.id,
    b.title,
    a.name AS author_name
    
    FROM orders_books ob
    JOIN orders o ON ob.order_id = o.id
    JOIN users u ON o.user_id = u.id AND LOWER(u.name) = LOWER('User name')
    JOIN books b ON ob.book_id = b.id 
    LEFT JOIN authors a ON b.author_id = a.id;


--Select all providers
SELECT
    u.id,
    u.name,
    u.login  
    
    FROM users u 
    WHERE id IN (SELECT p.user_ptr_id FROM providers p);



--Select providers by specific book.
SELECT 
    u.id,
    u.name,
    u.login  
    
    FROM providers_books pb
    JOIN books b ON pb.book_id = b.id AND b.id = 'Book id' 
    JOIN users u ON pb.provider_id = u.id;


--Select books that providered by special provider.
SELECT 
    b.id,
    b.title,
    a.name AS author_name
    
    FROM providers_books pb
    JOIN users u ON pb.provider_id = u.id AND LOWER(u.name) = LOWER('Provider name')
    JOIN books b ON pb.book_id = b.id            
    LEFT JOIN authors a ON b.author_id = a.id;

--Select coupons of specific user.
SELECT 
    c.id,
    c.discount
    
    FROM coupons c
    JOIN users u ON u.coupon_id = c.id AND LOWER(u.name) = LOWER('User name');

--Select users by role.
SELECT 
    u.id,
    u.name,
    u.login    
    
    FROM users u
    JOIN roles r ON u.role_id = r.id AND LOWER(r.name) = LOWER('Role name');


--Select user role.
SELECT
    r.id,
    r.name

    FROM roles r
    JOIN users u ON u.role_id = r.id AND LOWER(u.name) = LOWER('User name');


--Select all reviews by specific book.
SELECT 
    r.id,
    r.text
    
    FROM reviews r
    JOIN books b ON r.book_id = b.id AND b.id = 'Book id';


--Select all reviews by specific user.
SELECT 
    r.id,
    r.text
    
    FROM reviews r
    JOIN users u ON r.user_id = u.id AND LOWER(u.name) = LOWER('User name');


--Select average price for every category.
SELECT
    c.id,
    c.name,
    AVG(b.price) as average_price
    
    FROM books_categories bc
    JOIN books b ON bc.book_id = b.id
    JOIN categories c ON bc.category_id = c.id
    
    GROUP BY bc.category_id;


--Select count of orders of every book.
SELECT
    b.id,
    b.title,
    a.name AS author_name,
    SUM(ob.count) AS orders_count

    FROM books b 
    LEFT JOIN authors a ON b.author_id = a.id
    LEFT JOIN orders_books ob ON ob.book_id = b.id
    
    GROUP BY b.id, a.name;


--Select books that are in the cart of at least two users.
SELECT
    b.id,
    b.title,
    a.name AS author_name,
    SUM(cb.count) AS in_cart_count

    FROM books b 
    LEFT JOIN authors a ON b.author_id = a.id
    LEFT JOIN carts_books cb ON cb.book_id = b.id
    
    GROUP BY b.id, a.name
    HAVING SUM(cb.count) >= 2;


--Select all persons names.
SELECT u.name FROM users u
UNION 
SELECT a.name FROM authors a;


--Select books and it's popularity level.
SELECT b.id,
       b.title,
       a.name AS author_name,
       CASE 
           WHEN bto.total_ordered > 5 THEN 'Super popular'
           WHEN bto.total_ordered BETWEEN 2 AND 5 THEN 'Meadle popular'
           ELSE 'Not popular'
       END AS popularity                          
       

       FROM books b
            LEFT JOIN authors a ON b.author_id = a.id
            JOIN (SELECT ob.book_id AS book_id,
                         SUM(ob.count) AS total_ordered 
                    FROM orders_books ob 
                GROUP BY ob.book_id) AS bto
              ON bto.book_id = b.id;


--Select books with max price of it's author book.
SELECT b.id,
       b.title,
       a.name AS author_name,
       MAX(b.price) OVER (PARTITION BY b.author_id) AS max_price_of_author
       
  FROM books b
       JOIN authors a ON b.author_id = a.id;
  
