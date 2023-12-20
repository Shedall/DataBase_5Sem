INSERT INTO coupons (discount) VALUES
(10.5), 
(11.8), 
(20.1);


INSERT INTO roles (name) VALUES
('Customer'),
('Admin');


INSERT INTO authors (name) VALUES
('Alex Maliarniy'),
('Kriss Whell'),
('Pavel Umnov'),
('Stella Jhonson');


INSERT INTO users (login, password, name, role_id, coupon_id) VALUES
('Log1', 'Pass1', 'Jhon', 1, NULL),
('Log2', 'Pass2', 'Peter', 1, 2),
('Log3', 'Pass3', 'Bob', 1, 1),
('Log4', 'Pass4', 'Tom', 1, 2),
('Log5', 'Pass5', 'SuperAdmin', 2, NULL);


INSERT INTO providers (user_ptr_id) VALUES
(3),
(4);


INSERT INTO categories (name) VALUES
('Detective'),
('Sci-fi'),
('Western'),
('Fairy tale');


INSERT INTO books (title, author_id, price) VALUES
('When pigs fly', 2, 120),
('Crumpled Fairy', 1, 150),
('Forgotten', 3, 90),
('Fall night', 2, 200),
('First of Mahikans', 3, 150);


INSERT INTO reviews (text, book_id, user_id) VALUES
('I like it. The best of the  best.', 2, 1),
('0 from 10.', 3, 2),
('Nothing', 3, 3);


INSERT INTO orders (user_id) VALUES
(1),
(2),
(3);


INSERT INTO carts (user_id) VALUES
(1),
(2),
(3),
(5);


INSERT INTO carts_books (cart_id, book_id) VALUES
(1, 1), (1, 3), (1, 4),
(2, 1), (2, 5),
(3, 2), (3, 4);


INSERT INTO books_categories (book_id, category_id) VALUES
(1, 4), (1, 1),
(2, 4),
(3, 2), (3, 3),
(4, 1),
(5, 3);


INSERT INTO orders_books (order_id, book_id) VALUES
(1, 1), (1, 3),
(2, 4), (2, 5),
(3, 2), (3, 3), (3, 4);


INSERT INTO providers_books (provider_id, Book_id) VALUES
(3, 1), (3, 4), (3, 5),
(4, 2), (4, 3), (4, 4), (4, 5);