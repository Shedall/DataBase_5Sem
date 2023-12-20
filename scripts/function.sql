CREATE OR REPLACE FUNCTION select_books_by_user_cart(_user_id int) 
RETURNS TABLE(id INTEGER, image VARCHAR(64),price REAL,title VARCHAR(64),count INTEGER) AS $$
BEGIN
  RETURN QUERY SELECT
    b.id,
 b.image,
 b.price,
    b.title,
 cb.count
    
    FROM carts_books cb
    JOIN carts c ON cb.cart_id = c.id
    JOIN users u ON c.user_id = u.id AND u.id = _user_id
    JOIN books b ON cb.book_id = b.id;
END;
$$ LANGUAGE plpgsql;
