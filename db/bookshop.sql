DROP TABLE IF EXISTS bookauthors;
DROP TABLE IF EXISTS bookgenres;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS wholesalers;


CREATE TABLE authors
( id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE genres
( id SERIAL8 PRIMARY KEY,
  title VARCHAR(255) NOT NULL
);

CREATE TABLE books
( id SERIAL8 PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  edition VARCHAR(255),
  year_published INT2,
  rrp DECIMAL(5,2),
  quantity INT2,
  description TEXT
);

CREATE TABLE bookauthors
( id SERIAL8 PRIMARY KEY,
  book_id INT8 REFERENCES books(id) ON DELETE CASCADE,
  author_id INT8 REFERENCES authors(id) ON DELETE CASCADE
);

CREATE TABLE bookgenres
( id SERIAL8 PRIMARY KEY,
  book_id INT8 REFERENCES books(id) ON DELETE CASCADE,
  genre_id INT8 REFERENCES genres(id) ON DELETE CASCADE
);

CREATE TABLE wholesalers
( id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  contact_number VARCHAR(255),
  discount_offered DECIMAL(5,2),
  CHECK (discount_offered >= 0 AND discount_offered <= 100)
);
