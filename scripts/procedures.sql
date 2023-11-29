CREATE OR REPLACE PROCEDURE add_car_to_order(_order_id INTEGER, _car_id INTEGER, _count INTEGER DEFAULT 1) 
AS $$
BEGIN
	IF (EXISTS(SELECT * FROM orderscar AS ob 
			   WHERE ob.order_id = _order_id AND ob.car_id = _car_id)) THEN
    	UPDATE orders_car SET "count" = "count" + _count WHERE "order_id" = _order_id AND "car_id" = _car_id;
	ELSE
		INSERT INTO orderscar (order_id, car_id, count) 
		VALUES (_order_id, _car_id, _count);
	END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE add_car_to_cart(_cart_id INTEGER, _car_id INTEGER, _count INTEGER DEFAULT 1) 
AS $$
BEGIN
	IF (EXISTS(SELECT * FROM cartscar AS cb 
			   WHERE cb.cart_id = _cart_id AND cb.car_id = _car_id)) THEN
    	UPDATE cartscar SET "count" = "count" + _count WHERE "cart_id" = _cart_id AND "car_id" = _car_id;
	ELSE
		INSERT INTO cartscar (cart_id, car_id, count) 
		VALUES (_cart_id, _car_id, _count);
	END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE add_provider_to_car(_car_id INTEGER, _provider_id INTEGER) 
AS $$
BEGIN
	IF NOT (EXISTS(SELECT * FROM providerscars AS pb 
			   WHERE pb.provider_id = _provider_id AND pb.car_id = _car_id)) THEN
    	INSERT INTO providerscars (provider_id, car_id) 
		VALUES (_provider_id, _car_id);
	END IF;
END;
$$ LANGUAGE plpgsql;


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
