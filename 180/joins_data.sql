/**
* To execute
* psql -d library < joins_data.sql
*
*/

-- A user
INSERT INTO users (username) VALUES ('John Smith');

-- An address
INSERT INTO addresses (user_id, street, city, state)
VALUES (1, '1 Market Street', 'San Francisco', 'CA');

-- A book
INSERT INTO books (title, author, published_date)
VALUES('My First SQL book', 'Mary Parker', NOW());

INSERT INTO users_books (user_id, book_id, checkout_date)
VALUES(1, 1, NOW());

-- A review
INSERT INTO reviews (book_id, user_id, review_content)
VALUES (1, 1, 'My first review');

-- A second book
INSERT INTO books (title, author, published_date)
VALUES('My Second SQL book','John Mayer', NOW());

INSERT INTO users_books (user_id, book_id, checkout_date)
VALUES (1, 2 ,NOW());

-- A second review
INSERT INTO reviews (book_id, user_id, review_content)
VALUES (2, 1, 'My second review');

-- A second User
INSERT INTO users (username) VALUES ('Jane Smiley');

-- A second address
INSERT INTO addresses (user_id, street, city, state)
VALUES (2, '2 Elm Street', 'San Francisco', 'CA');

INSERT INTO users_books (user_id, book_id, checkout_date)
VALUES(2, 2 , NOW());

-- A third review
INSERT INTO reviews ( book_id, user_id, review_content )
VALUES (2, 2, 'review_content');

-- A Third User
INSERT INTO users (username) VALUES ('Alice Munro');

-- A Third book
INSERT INTO books (title, author, published_date)
VALUES('My Third SQL book','Cary Flint', NOW());

SELECT pg_catalog.setval('users_id_seq', 3);
SELECT pg_catalog.setval('books_id_seq', 3);
SELECT pg_catalog.setval('reviews_id_seq', 3);
