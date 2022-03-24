drop aggregate if exists minmax(anyelement);
drop function if exists  minmax_sf(anyarray, anyelement);
drop function if exists  minmax_final(anyarray);

CREATE OR REPLACE FUNCTION minmax_sf(anyarray, anyelement)
RETURNS anyarray LANGUAGE sql IMMUTABLE STRICT AS $$
        SELECT ARRAY[least($1[1],$2), greatest($1[2], $2)];
$$;

CREATE OR REPLACE FUNCTION minmax_final(anyarray)
RETURNS text LANGUAGE sql IMMUTABLE STRICT AS $$
	SELECT case when $1 is NULL then NULL else $1[1]::text || ' -> ' || $1[2]::text END;
$$;

CREATE AGGREGATE minmax(anyelement) (
        sfunc     = minmax_sf,
        stype     = anyarray,
        finalfunc = minmax_final,
        initcond = '{NULL, NULL}'
);

