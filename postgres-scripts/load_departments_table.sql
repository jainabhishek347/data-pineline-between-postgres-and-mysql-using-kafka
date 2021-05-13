INSERT INTO departments (dept_name, address, email, created_at, updated_at)
WITH RECURSIVE temp AS(
SELECT 'hr@test.com'::varchar(50) AS email, 1 AS step
UNION ALL
SELECT concat('hr@test.com', step::varchar)::varchar(50) AS email, step+1 AS step FROM temp WHERE step< 1000
)SELECT 'HR', 'block-b', email, now(), now() FROM temp;	


INSERT INTO departments (dept_name, address, email, created_at, updated_at)
WITH RECURSIVE temp AS(
SELECT 'it@test.com'::varchar(50) AS email, 1 AS step
UNION ALL
SELECT concat('it@test.com', step::varchar)::varchar(50) AS email, step+1 AS step FROM temp WHERE step< 1000
)SELECT 'It', 'block-b', email, now(), now() FROM temp;	


INSERT INTO departments (dept_name, address, email, created_at, updated_at)
WITH RECURSIVE temp AS(
SELECT 'admin@test.com'::varchar(50) AS email, 1 AS step
UNION ALL
SELECT concat('admin@test.com', step::varchar)::varchar(50) AS email, step+1 AS step FROM temp WHERE step< 1000
)SELECT 'admin', 'block-c', email, now(), now() FROM temp;	

INSERT INTO departments (dept_name, address, email, created_at, updated_at)
WITH RECURSIVE temp AS(
SELECT 'support@test.com'::varchar(50) AS email, 1 AS step
UNION ALL
SELECT concat('support@test.com', step::varchar)::varchar(50) AS email, step+1 AS step FROM temp WHERE step< 1000
)SELECT 'support', 'block-d', email, now(), now() FROM temp;	

INSERT INTO departments (dept_name, address, email, created_at, updated_at)
WITH RECURSIVE temp AS(
SELECT 'finance@test.com'::varchar(50) AS email, 1 AS step
UNION ALL
SELECT concat('finance@test.com', step::varchar)::varchar(50) AS email, step+1 AS step FROM temp WHERE step< 1000
)SELECT 'finance', 'block-e', email, now(), now() FROM temp;	
