create extension mintomax;
select array_to_string(mintomax(x), '->') from generate_series(1, 5) x;
select array_to_string(mintomax(x), '::') from generate_series(1, 5) x;
