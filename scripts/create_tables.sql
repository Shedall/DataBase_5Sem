CREATE TABLE roles (
    id           SERIAL           PRIMARY KEY,        
    name         VARCHAR (64)     NOT NULL UNIQUE
);


CREATE TABLE coupons (
    id           SERIAL           PRIMARY KEY,        
    discount     REAL             NOT NULL UNIQUE
);


CREATE TABLE users (
    id           SERIAL           PRIMARY KEY,
    login        VARCHAR (64)     NOT NULL UNIQUE,
    password     VARCHAR (64)     NOT NULL,	
    name         VARCHAR (64)     NOT NULL UNIQUE,
    role_id      INTEGER          REFERENCES roles (id) ON DELETE SET NULL,
    coupon_id    INTEGER          REFERENCES coupons (id) ON DELETE SET NULL
);


CREATE TABLE providers (
    user_ptr_id  INTEGER          PRIMARY KEY REFERENCES users (id) ON DELETE CASCADE
);


CREATE TABLE carts (
    id           SERIAL           PRIMARY KEY,        
    user_id      INTEGER          NOT NULL UNIQUE REFERENCES users (id) ON DELETE CASCADE
);


CREATE TABLE categories (
    id           SERIAL           PRIMARY KEY,        
    name         VARCHAR (64)     NOT NULL UNIQUE
);


CREATE TABLE authors (
    id           SERIAL           PRIMARY KEY,        
    name         VARCHAR (64)     NOT NULL UNIQUE
);



CREATE TABLE books (
    id           SERIAL           PRIMARY KEY,   
    title        VARCHAR (64)     NOT NULL,
    author_id    INTEGER          REFERENCES authors (id) ON DELETE CASCADE,
    price        REAL             NOT NULL
);




CREATE TABLE orders (
    id           SERIAL           PRIMARY KEY,        
    user_id      INTEGER          REFERENCES users (id) ON DELETE SET NULL
);


CREATE TABLE reviews (
    id           SERIAL           PRIMARY KEY,        
    text         VARCHAR (1024)   NOT NULL,
    book_id      INTEGER          REFERENCES books (id) ON DELETE CASCADE,
    user_id      INTEGER          REFERENCES users (id) ON DELETE CASCADE
);


CREATE TABLE providers_books (
    id           SERIAL           PRIMARY KEY,      
    provider_id  INTEGER          REFERENCES providers (user_ptr_id) ON DELETE CASCADE,
    book_id      INTEGER          REFERENCES books (id) ON DELETE CASCADE,

    UNIQUE (provider_id, book_id)
);


CREATE TABLE orders_books (
    id           SERIAL           PRIMARY KEY,      
    order_id     INTEGER          REFERENCES orders (id) ON DELETE CASCADE,
    book_id      INTEGER          REFERENCES books (id) ON DELETE CASCADE,
    count        INTEGER          NOT NULL DEFAULT 1,

    UNIQUE (order_id, book_id)
);


CREATE TABLE books_categories (
    id           SERIAL           PRIMARY KEY,    
    book_id      INTEGER          REFERENCES books (id) ON DELETE CASCADE,
    category_id  INTEGER          REFERENCES categories (id) ON DELETE CASCADE,

    UNIQUE (category_id, book_id)
);



CREATE TABLE carts_books (
    id           SERIAL           PRIMARY KEY,      
    cart_id      INTEGER          REFERENCES carts (id) ON DELETE CASCADE,
    book_id      INTEGER          REFERENCES books (id) ON DELETE CASCADE,
    count        INTEGER          NOT NULL DEFAULT 1,

    UNIQUE (cart_id, book_id)
);