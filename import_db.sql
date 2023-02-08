DROP TABLE IF EXISTS users

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS questions

CREATE TABLE questions (
  title VARCHAR(200) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

