CREATE TABLE Roles (
    Id           INTEGER          PRIMARY KEY,        
    Name         VARCHAR (64)     NOT NULL UNIQUE
);

CREATE TABLE Coupons (
    Id           INTEGER          PRIMARY KEY ,        
    Discount     REAL             NOT NULL UNIQUE
);


CREATE TABLE Users (
    Id           INTEGER          PRIMARY KEY ,
    Login        VARCHAR (64)     NOT NULL UNIQUE,
    Password     VARCHAR (64)     NOT NULL,	
    Name         VARCHAR (64)     NOT NULL UNIQUE,
    RoleId       INTEGER          REFERENCES Roles (Id) ON DELETE SET NULL,
    CouponId     INTEGER          REFERENCES Coupons (Id) ON DELETE SET NULL
);

CREATE TABLE Carts (
    Id           INTEGER          PRIMARY KEY ,        
    UserId       INTEGER          NOT NULL UNIQUE REFERENCES Users (Id) ON DELETE CASCADE
);


CREATE TABLE Providers (
    UserPtr      INTEGER          PRIMARY KEY REFERENCES Users (Id) ON DELETE CASCADE
);

CREATE TABLE Categories (
    Id           INTEGER          PRIMARY KEY ,        
    Name         VARCHAR (64)     NOT NULL UNIQUE
);

CREATE TABLE Brand         (
    Id           INTEGER          PRIMARY KEY,        
    Name         VARCHAR (64)     NOT NULL UNIQUE
);

CREATE TABLE Cars (
    Id           INTEGER          PRIMARY KEY,   
    Name         VARCHAR (64)     NOT NULL,
    BrandId      INTEGER          REFERENCES Brand (Id) ON DELETE CASCADE,
    CategoriesId INTEGER          REFERENCES Brand (Id) ON DELETE CASCADE
);


CREATE TABLE Orders (
    Id           INTEGER          PRIMARY KEY ,        
    UserId       INTEGER          REFERENCES Users (Id) ON DELETE SET NULL
);


CREATE TABLE Reviews (
    Id           INTEGER          PRIMARY KEY ,        
    Text         VARCHAR (1024)   NOT NULL,
    CarId        INTEGER          REFERENCES  Cars (Id) ON DELETE CASCADE,
    UserId       INTEGER          REFERENCES Users (Id) ON DELETE CASCADE
);


CREATE TABLE ProvidersCars (
    Id           INTEGER          PRIMARY KEY ,      
    ProviderId   INTEGER          REFERENCES Providers (UserPtr) ON DELETE CASCADE,
    CarId       INTEGER          REFERENCES Cars (Id) ON DELETE CASCADE,

    UNIQUE (ProviderId, CarId)
);


CREATE TABLE OrdersCar (
    Id           INTEGER          PRIMARY KEY ,      
    OrderId      INTEGER          REFERENCES Orders (Id) ON DELETE CASCADE,
    CarId        INTEGER          REFERENCES Cars (Id) ON DELETE CASCADE,
    Count        INTEGER          NOT NULL DEFAULT 1,

    UNIQUE (OrderId, CarId)
);



CREATE TABLE CartsCar (
    Id           INTEGER          PRIMARY KEY ,      
    CartId       INTEGER          REFERENCES Carts (Id) ON DELETE CASCADE,
    CarId        INTEGER          REFERENCES Cars (Id) ON DELETE CASCADE,
    Count        INTEGER          NOT NULL DEFAULT 1,

    UNIQUE (CartId, CarId)
);