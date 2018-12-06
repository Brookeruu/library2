CREATE DATABASE library;
\c library
CREATE TABLE book (title varchar, author varchar, id serial PRIMARY KEY, duedate date, checkout boolean);


Table "public.book"
Column  |            Type             | Collation | Nullable |             Default              
----------+-----------------------------+-----------+----------+----------------------------------
title    | character varying           |           |          |
author   | character varying           |           |          |
id       | integer                     |           | not null | nextval('book_id_seq'::regclass)
duedate  | timestamp without time zone |           |          |
checkout | boolean

CREATE TABLE patron (name varchar, id serial PRIMARY KEY, checkout varchar, history varchar);

Table "public.authors"
Column |       Type        | Collation | Nullable |               Default               
--------+-------------------+-----------+----------+-------------------------------------
name   | character varying |           |          |
id     | integer           |           | not null | nextval('authors_id_seq'::regclass)
Indexes:
