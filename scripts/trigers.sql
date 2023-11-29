CREATE OR REPLACE FUNCTION check_admin_will_remain(u RECORD)
RETURNS RECORD AS $$
BEGIN
  IF ((SELECT COUNT(*) FROM users WHERE role_id = 2) > 1) THEN
    RETURN u;
  ELSE
    RAISE EXCEPTION 'Cant execute operation because there must be at least one admin';
  END IF;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_admin_will_remain_after_delete()
RETURNS TRIGGER AS $$
	BEGIN RETURN check_admin_will_remain(OLD); END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_admin_will_remain_after_delete
	BEFORE DELETE ON users
	FOR EACH ROW
	WHEN (OLD.role_id = 2)
	EXECUTE FUNCTION check_admin_will_remain_after_delete();
	

CREATE OR REPLACE FUNCTION check_admin_will_remain_after_update()
RETURNS TRIGGER AS $$
	BEGIN RETURN check_admin_will_remain(NEW); END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_admin_will_remain_after_update
	BEFORE UPDATE ON users
	FOR EACH ROW
	WHEN (OLD.role_id = 2 AND NEW.role_id != 2)
	EXECUTE FUNCTION check_admin_will_remain_after_update();
	
	
CREATE OR REPLACE FUNCTION add_user_cart_if_not_exists()
RETURNS TRIGGER AS $$
BEGIN
  IF NOT EXISTS(SELECT * FROM carts AS c WHERE c.user_id = NEW.id) THEN
    INSERT INTO carts (user_id)
  	VALUES (NEW.id);
  	RETURN NEW;
  END IF;
END;
$$ LANGUAGE plpgsql;
