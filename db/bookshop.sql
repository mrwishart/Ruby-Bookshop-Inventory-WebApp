DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS shopbooks;
DROP TABLE IF EXISTS neilsenbooks;

CREATE TABLE authors
( id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE genres
( id SERIAL8 PRIMARY KEY,
  title VARCHAR(255) NOT NULL
);

CREATE TABLE shopbooks
( id SERIAL8 PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  stock_quantity INT2,
  rrp DECIMAL(5,2),
  edition INT2,
  year_published INT2
);
