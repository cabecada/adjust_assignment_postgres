drop aggregate if exists min_to_max(int);
drop function if exists mintomax_sfunc(point, int);
drop function if exists mintomax_finalfunc(point);

create or replace function mintomax_sfunc(minmax point, el int) returns point immutable language plpgsql as $$
declare current_min int; current_max int;
begin
	if minmax is null then
		return point(el, el);
	end if;

	if minmax[0] is not null and minmax[0] > el then
		current_min := el;
	else
		current_min := minmax[0];
	end if;

	if minmax[0] is not null and minmax[1] < el then
		current_max := el;
	else
		current_max := minmax[1];
	end if;

	return point(current_min, current_max);

end;
$$;

create or replace function mintomax_finalfunc(minmax point) returns text immutable language plpgsql as $$
begin
	return format('%s -> %s', minmax[0], minmax[1]);
end;
$$;

create or replace aggregate min_to_max(int)
(
        sfunc = mintomax_sfunc,
        stype = point,
        finalfunc = mintomax_finalfunc
);


/*
example=# select min_to_max(id) from (values(NULL::int),(NULL::int),(NULL::int),(NULL::int)) t(id);
 min_to_max
------------
  ->
(1 row)

example=# select min_to_max(id) from (values(NULL::int),(NULL::int),(NULL::int),(1::int)) t(id);
 min_to_max
------------
 1 -> 1
(1 row)

example=# select min_to_max(id) from (values(NULL::int),(NULL::int),(2::int),(1::int)) t(id);
 min_to_max
------------
 1 -> 2
(1 row)

example=# select min_to_max(id) from (values(NULL::int),(NULL::int),(-2::int),(1::int)) t(id);
 min_to_max
------------
 -2 -> 1
(1 row)
*/

