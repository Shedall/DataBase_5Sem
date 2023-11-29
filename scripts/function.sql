CREATE OR REPLACE FUNCTION select_car_by_category(category_name varchar(64)) 
RETURNS TABLE(id INTEGER, name Varchar(64)) AS $$
BEGIN
  RETURN QUERY SELECT
  
    b.Id,
    b.Name

    FROM Cars b 
    JOIN Categories a ON b.categories_id = a.Id
    
    WHERE LOWER(a.Name) = LOWER(category_name);
END;
$$ LANGUAGE plpgsql;
