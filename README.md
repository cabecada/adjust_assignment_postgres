# adjust_assignment_postgres


## Assignment
```
Below, you will find a small challenge that we would like you to work on. We’re looking forward to
seeing your skills put into action, and the test will also offer you more insights on the role and
industry that we operate in.
Best of luck!
Task
Write an aggregate that returns a text formatted like: min -> max for an integer column, where
min and max are minimum and maximum values of that column.
For example:
SELECT min_to_max(val) FROM (VALUES(5),(3),(6),(7),(9),(10),(7)) t(val);
min_to_max
-----------
3 -> 10

Extra points:
● make it work for wider range of datatypes
● make the output format configurable in any way
● use of C language
● package into an extension

Thank you for taking the time to work on this challenge! Please use the instructions from the
email on how to submit your solution(s).
```


## Instructions to install and run the extension

```
postgres@controller:/tmp$ git clone git@github.com:cabecada/adjust_assignment_postgres.git
Cloning into 'adjust_assignment_postgres'...
remote: Enumerating objects: 18, done.
remote: Counting objects: 100% (18/18), done.
remote: Compressing objects: 100% (11/11), done.
remote: Total 18 (delta 3), reused 17 (delta 2), pack-reused 0
Receiving objects: 100% (18/18), done.
Resolving deltas: 100% (3/3), done.
postgres@controller:/tmp$ cd adjust_assignment_postgres/
postgres@controller:/tmp/adjust_assignment_postgres$ make installcheck
/usr/lib/postgresql/14/lib/pgxs/src/makefiles/../../src/test/regress/pg_regress --inputdir=./ --bindir='/usr/lib/postgresql/14/bin'    --dbname=contrib_regression mintomax_test
(using postmaster on Unix socket, default port)
============== dropping database "contrib_regression" ==============
DROP DATABASE
============== creating database "contrib_regression" ==============
CREATE DATABASE
ALTER DATABASE
============== running regression test queries        ==============
test mintomax_test                ... ok            8 ms

=====================
 All 1 tests passed.
=====================

postgres@controller:/tmp/adjust_assignment_postgres$ sudo make install
/bin/mkdir -p '/usr/share/postgresql/14/extension'
/bin/mkdir -p '/usr/share/postgresql/14/extension'
/usr/bin/install -c -m 644 .//mintomax.control '/usr/share/postgresql/14/extension/'
/usr/bin/install -c -m 644 .//mintomax--0.0.1.sql  '/usr/share/postgresql/14/extension/'
postgres@controller:/tmp/adjust_assignment_postgres$ createdb testdb
postgres@controller:/tmp/adjust_assignment_postgres$ psql testdb
psql (14.1 (Ubuntu 14.1-2.pgdg20.04+1))
Type "help" for help.

testdb=# create extension mintomax;
CREATE EXTENSION
testdb=# select array_to_string(mintomax(x), '->') from generate_series(1, 5) x;
 array_to_string
-----------------
 1->5
(1 row)

testdb=# \q


```
