drop table if exists el_users;
CREATE TABLE el_users (
  id SERIAL PRIMARY KEY,
  email VARCHAR (355) UNIQUE NOT NULL,
  password VARCHAR (50) NOT NULL,
  firstname varchar (50) not null,
  lastname varchar (50) not null,
  created_on TIMESTAMP default current_timestamp,
  last_login TIMESTAMP
);