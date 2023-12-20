--Select all authors.
SELECT a.id , a.name FROM Authors a;


--Select all categories.
SELECT c.id, c.name FROM categories c;
    

--Select all users
SELECT u.id, u.name, u.login FROM users u;
    

--Select all coupons.
SELECT c.id, c.discount FROM coupons c ORDER BY c.discount DESC;
    

--Select coupons that has discound in cpecific range.
SELECT c.id, c.discount FROM coupons c WHERE c.discount BETWEEN 'Start' AND 'Finish';


--Select all roles.
SELECT r.id, r.name FROM roles r;