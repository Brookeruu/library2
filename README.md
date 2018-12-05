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
