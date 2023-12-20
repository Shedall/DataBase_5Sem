CREATE OR REPLACE PROCEDURE add_order(_user_id INTEGER)
AS $$
DECLARE
	order_time TIMESTAMP := NOW();
	order_car_id INTEGER;
BEGIN
	INSERT INTO orders (user_id)
    VALUES (_user_id)
    RETURNING id INTO order_car_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_book_to_cart_by_user_id(_user_id INTEGER, _book_id INTEGER, _count INTEGER DEFAULT 1) 
AS $$
DECLARE
 _cart_id INTEGER := (SELECT c.id
  
    FROM carts c
    JOIN users u ON c.user_id = u.id AND u.id = _user_id );
BEGIN
 IF (EXISTS(SELECT * FROM carts_books AS cb 
      WHERE cb.cart_id = _cart_id AND cb.book_id = _book_id)) THEN
     UPDATE carts_books SET "count" = "count" + _count WHERE "cart_id" = _cart_id AND "book_id" = _book_id;
 ELSE
  INSERT INTO carts_books (cart_id, book_id, count) 
  VALUES (_cart_id, _book_id, _count);
 END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE remove_book_from_cart(_user_id INTEGER, _book_id INTEGER, _count INTEGER DEFAULT 1) 
AS $$
DECLARE
 _cart_id INTEGER := (SELECT c.id
  
    FROM carts c
    JOIN users u ON c.user_id = u.id AND u.id = _user_id );
BEGIN
 UPDATE carts_books SET "count" = "count" - _count WHERE "cart_id" = _cart_id AND "book_id" = _book_id;
 
 IF ((SELECT cb.count FROM carts_books AS cb 
      WHERE cb.cart_id = _cart_id AND cb.book_id = _book_id) = 0) THEN
     DELETE FROM carts_books WHERE id = (SELECT cb.id FROM carts_books AS cb WHERE cb.cart_id = _cart_id AND cb.book_id = _book_id);
 END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE create_full_order(_user_id INTEGER) 
AS $$
DECLARE
 _cart_id INTEGER := (SELECT c.id
  FROM carts c
  JOIN users u ON c.user_id = u.id AND u.id = _user_id);
  
 _order_id INTEGER;
 
 f RECORD;
BEGIN
  INSERT INTO orders (user_id) VALUES (_user_id) RETURNING id INTO _order_id;

 for f in (SELECT 
      b.id AS book_id,
      cb.count AS count
     
    FROM carts_books cb
       JOIN books b ON cb.book_id = b.id
       JOIN carts c ON cb.cart_id = c.id AND c.id = _cart_id
  )
    loop 
  CALL add_book_to_order(_order_id, f.book_id, f.count);
    end loop;
 
 DELETE FROM carts_books WHERE cart_id = _cart_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE add_book_to_order(_order_id INTEGER, _book_id INTEGER, _count INTEGER DEFAULT 1) 
AS $$
BEGIN
 IF (EXISTS(SELECT * FROM orders_books AS ob 
      WHERE ob.order_id = _order_id AND ob.book_id = _book_id)) THEN
     UPDATE orders_books SET "count" = "count" + _count WHERE "order_id" = _order_id AND "book_id" = _book_id;
 ELSE
  INSERT INTO orders_books (order_id, book_id, count) 
  VALUES (_order_id, _book_id, _count);
 END IF;
END;
$$ LANGUAGE plpgsql;

