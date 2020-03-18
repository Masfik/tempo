CREATE TABLE IF NOT EXISTS APP_USER (
    email       VARCHAR(64) PRIMARY KEY UNIQUE,
    first_name  VARCHAR(32) NOT NULL,
    surname     VARCHAR(32) NOT NULL
);

INSERT INTO APP_USER (email, first_name, surname) 
VALUES ('example@email.com','John', 'Smith');

INSERT INTO APP_USER (email, first_name, surname) 
VALUES ('example_2@email.com','Herbert', 'James');