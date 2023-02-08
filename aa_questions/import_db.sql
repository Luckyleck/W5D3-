-- PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);


DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  associated_author INTEGER NOT NULL,
  
  FOREIGN KEY (associated_author) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  og_question INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  parent INTEGER,
  body TEXT NOT NULL,

  FOREIGN KEY (og_question) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  og_question INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (og_question) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Joe', 'Schmo'),
  ('Joe', 'Biden'),
  ('Cynthia', 'Beckenheart'),
  ('Joe', 'Mama'),
  ('Gary', 'Hor'),
  ('Alvin', 'Zablan');

INSERT INTO
  questions (title, body, associated_author)
VALUES
  ('How to tie shoes?', 'Can someone explain how to tie shoes? I keep tripping, please...', 5),
  ('President?', 'How to be president?', 2),
  ('Lip fillers?', 'Good or bad?', 3),
  ('Make videos?', 'How do you make videos', 6);

INSERT INTO 
  question_follows (user_id, question_id)
VALUES
  (5, 1) -- Gary Hor
  (2, 2) -- Joe Biden
  (3, 3) -- Cynthia
  (6, 4); -- Alvin Zablan