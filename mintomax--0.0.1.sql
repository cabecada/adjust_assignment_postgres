\echo Use "CREATE EXTENSION mintomax" to load this file. \quit

CREATE OR REPLACE FUNCTION mintomax_sf(anyarray, anyelement)
RETURNS anyarray LANGUAGE sql IMMUTABLE STRICT AS $$
        SELECT ARRAY[least($1[1],$2), greatest($1[2], $2)];
$$;

CREATE OR REPLACE FUNCTION mintomax_final(anyarray)
RETURNS anyarray LANGUAGE sql IMMUTABLE STRICT AS $$
	SELECT $1;
$$;

CREATE AGGREGATE mintomax(anyelement) (
        sfunc     = mintomax_sf,
        stype     = anyarray,
        finalfunc = mintomax_final,
        initcond = '{NULL, NULL}'
);
