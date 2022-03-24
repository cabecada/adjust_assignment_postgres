drop aggregate if exists minmax(anyelement);
drop function if exists  minmax_sf(anyarray, anyelement);
drop function if exists  minmax_final(anyarray);

CREATE OR REPLACE FUNCTION minmax_sf(anyarray, anyelement)
RETURNS anyarray LANGUAGE sql IMMUTABLE STRICT AS $$
        SELECT ARRAY[least($1[1],$2), greatest($1[2], $2)];
$$;

CREATE OR REPLACE FUNCTION minmax_final(anyarray)
RETURNS anyarray LANGUAGE sql IMMUTABLE STRICT AS $$
	SELECT $1;
$$;

CREATE AGGREGATE minmax(anyelement) (
        sfunc     = minmax_sf,
        stype     = anyarray,
        finalfunc = minmax_final,
        initcond = '{NULL, NULL}'
);

/*
example=# table t;
 col1 | col2
------+------
    1 |    1
    2 |    0
    3 |    1
    4 |    0
    5 |    1
    6 |    0
    7 |    1
    8 |    0
    9 |    1
   10 |    0
(10 rows)

example=# select array_to_string(minmax(col1), '->') as min_to_max, col2 from t group by col2;
 min_to_max | col2
------------+------
 2->10      |    0
 1->9       |    1
(2 rows)
*/

