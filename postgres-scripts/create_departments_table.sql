CREATE TABLE departments (
	id serial,
	dept_name varchar(100) DEFAULT NULL,
	address varchar(25) DEFAULT NULL,	
	email varchar(50) DEFAULT NULL,
	created_at TIMESTAMP WITHOUT TIME zone  DEFAULT NULL,
	updated_at TIMESTAMP WITHOUT TIME zone  DEFAULT NULL
);
