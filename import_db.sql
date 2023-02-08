PRAGMA foreign_keys = ON; 

DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;


CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL
);



CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  body TEXT NOT NULL
);


CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);



CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  parent_id INTEGER,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);



CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
  users (fname, lname)
VALUES
  ('Fahim', 'Khan'),
  ('Kelsang', "Tsering"),
  ('Tom', 'Hardy'),
  ('Vin', 'Diesel'),
  ('Chris', 'Hemsworth'),
  ('Will', 'Ferrell'),
  ('Dwayne', 'Johnson'),
  ('Tom', 'Holland'),
  ('Kevin', 'Hart');

INSERT INTO
  questions (title, body)
VALUES
  ('Sky', 'What color is the sky?'),
  ('Mirror', "What's the color of a mirror?"),
  ('Date', "What's today's date?"),
  ('You?', 'Who are you?'),
  ('Me?', 'Who am I?');

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (
    (SELECT id FROM users WHERE fname = 'Fahim'),
    (SELECT id FROM questions WHERE title = 'Me?')
  ),
  (
    (SELECT id FROM users WHERE fname = 'Kelsang'),
    (SELECT id FROM questions WHERE title = 'You?')
  ),
  (
    (SELECT id FROM users WHERE fname = 'Chris'),
    (SELECT id FROM questions WHERE title = 'Mirror')
  ),
  (
    (SELECT id FROM users WHERE fname = 'Dwayne'),
    (SELECT id FROM questions WHERE title = 'Sky')
  ),
  (
    (SELECT id FROM users WHERE fname = 'Kevin'),
    (SELECT id FROM questions WHERE title = 'Date')
  );


INSERT INTO
  replies (question_id, user_id, parent_id, body)
VALUES
  (
    (SELECT id FROM questions WHERE title = 'Sky'),
    (SELECT id FROM users WHERE fname = 'Chris'),
    NULL,
    "red"
  ),
  (
    (SELECT id FROM questions WHERE title = 'Sky'),
    (SELECT id FROM users WHERE fname = 'Will'),
    (SELECT id FROM replies WHERE body = 'red'),
    "No, it's pink"
  ),
  (
    (SELECT id FROM questions WHERE title = 'Sky'),
    (SELECT id FROM users WHERE fname = 'Vin'),
    (SELECT id FROM replies WHERE body = "No, it's pink"),
    "No, it's flat"
  ),
  (
    (SELECT id FROM questions WHERE title = 'Date'),
    (SELECT id FROM users WHERE fname = 'Dwayne'),
    NULL,
    "2-8-23"
  ),
  (
    (SELECT id FROM questions WHERE title = 'Date'),
    (SELECT id FROM users WHERE fname = 'Tom' AND lname = 'Holland'),
    (SELECT id FROM replies WHERE body = "2-8-23"),
    "No I don't think you're right! It's friday!"
  );

INSERT INTO
  question_likes (user_id, question_id)
VALUES
(
    (SELECT id FROM users WHERE fname = 'Dwayne'),
    (SELECT id FROM questions WHERE title = 'Me?')
  ),
  (
    (SELECT id FROM users WHERE fname = 'Vin'),
    (SELECT id FROM questions WHERE title = 'You?')
  ),
  (
    (SELECT id FROM users WHERE fname = 'Kevin'),
    (SELECT id FROM questions WHERE title = 'Mirror')
  ),
  (
    (SELECT id FROM users WHERE fname = 'Kelsang'),
    (SELECT id FROM questions WHERE title = 'Sky')
  ),
  (
    (SELECT id FROM users WHERE fname = 'Fahim'),
    (SELECT id FROM questions WHERE title = 'Date')
  );

