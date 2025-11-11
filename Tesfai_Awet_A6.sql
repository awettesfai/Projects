-- Example filename: larni_ashkan_A6.sql
DROP DATABASE if EXISTS cs457;
CREATE DATABASE cs457;
USE cs457;

CREATE TABLE lives (
	person_id SMALLINT UNSIGNED,
	person_name VARCHAR(50),
	street VARCHAR(50),
	city VARCHAR(50),
	PRIMARY KEY (person_id)
);


CREATE TABLE works (
	person_id SMALLINT UNSIGNED,
	person_name VARCHAR(50),
	company_name VARCHAR(50),
	salary INT,
	PRIMARY KEY (person_id)
);


CREATE TABLE located_in (
	company_name VARCHAR(50),
	city VARCHAR(50), 
	PRIMARY KEY (company_name, city)
);


CREATE TABLE manages (
	person_name VARCHAR(50),
	manager_name VARCHAR(50),
	PRIMARY KEY (person_name, manager_name)
);

USE cs457;

INSERT INTO lives VALUES 
(1, 'Burt Temple', '23 Workhaven Lane', 'Las Vegas'),
(2, 'Mary Keitel', '1411 Lillydale Drive', 'Chicago'),
(3, 'Reese West', '1913 Hanoi Way', 'La Paz'), 
(4, 'Julia Fawcett', '1121 Loja Avenue', 'Chicago'), 
(5, 'Ed Guiness', '23 Workhaven Lane', 'Las Vegas'),
(6, 'Laura Brody', '1913 Hanoi Way', 'La Paz'),
(7, 'Jada Ryder', '909 Garland Manor', 'South Hill'),
(8, 'Ed Mansfield', '1135 Izumisano Parkway', 'Korla'),
(9, 'Gene Hopkins', '939 Probolinggo Loop', 'Lincoln'),
(10, 'Morgan Williams', '1697 Kowloon', 'Las Vegas'),
(11, 'Ewan Gooding', '1213 Ranchi Parkway', 'Las Vegas'),
(12, 'Ben Harris', '915 Ponce Place', 'Manchester'),
(13, 'Ian Tandy', '927 Baha Blanca Parkway', 'Teboksary'),
(14, 'Chris Depp', '1599 Plock Drive', 'Las Vegas'),
(15, 'Al Garland', '1913 Kamakura Place', 'Moscow'),
(16, 'Groucho Williams', '33 Mandaluyong Place', 'Las Vegas'),
(17, 'Jon Chase', '23 Workhaven Lane', 'Usak'),
(18, 'Lisa Monroe', '659 Vaduz Drive', 'Chicago'),
(19, 'Jimmy Neutron', '659 Vaduz Drive', 'Chicago'),
(20, 'Shaq', '1234 Fake Street', NULL)
;

set sql_safe_updates = 0;

update lives set person_name = null where person_name = 'Jimmy Neutron';

INSERT INTO located_in VALUES
('ACME Corporation', 'Las Vegas'),
('ACME Corporation', 'Chicago'),
('ACME Corporation', 'La Paz'),
('ACME Corporation', 'Lima'),
('ACME Corporation', 'Lincoln'),
('ACME Corporation', 'Manchester'),
('ACME Corporation', 'Korla'),
('Bank of America', 'Las Vegas'),
('Bank of America', 'Moscow'),
('Bank of America', 'South Hill'),
('Bank of America', 'Chicago'),
('Bank of America', 'La Paz'),
('Bank of America', 'Lima'),
('Bank of America', 'Lincoln'),
('Bank of America', 'Manchester'),
('Bank of America', 'Korla'),
('Bank of America', 'Teboksary'),
('American Express', 'Las Vegas'),
('American Express', 'Chicago'),
('Chase', 'La Paz'),
('American Express', 'Lima'),
('Chase', 'Lincoln'),
('Chase', 'Manchester'),
('Chase', 'Korla'),
('Chase', 'Teboksary'),
('Capital One', 'Las Vegas'),
('Capital One', 'Chicago'),
('Capital One', 'La Paz'),
('Capital One', 'Lima'),
('Capital One', 'Lincoln'),
('Capital One', 'Manchester'),
('Capital One', 'Korla'),
('HSBC', 'Las Vegas'),
('HSBC', 'Moscow'),
('HSBC', 'South Hill'),
('HSBC', 'Chicago'),
('HSBC', 'La Paz'),
('HSBC', 'Usak'),
('HSBC', 'Vancouver'),
('HSBC', 'Yangor'),
('UniCredit', 'Las Vegas'),
('UniCredit', 'Chicago'),
('UniCredit', 'La Paz'),
('UniCredit', 'Lima'),
('UniCredit', 'Lincoln'),
('UniCredit', 'Manchester'),
('UniCredit', 'Korla'),
('UniCredit', 'Tarlac'),
('UniCredit', 'Sunnyvale')
;


INSERT INTO manages VALUES 
('Burt Temple', 'Ed Guiness'),
('Mary Keitel', 'Ed Guiness'),
('Reese West', 'Julia Fawcett'),
('Laura Brody', 'Jada Ryder'),
('Ed Mansfield', 'Gene Hopkins'),
('Laura Brody', 'Morgan Williams'),
('Ewan Gooding', 'Ben Harris'),
('Ian Tandy', 'Ben Harris'),
('Ewan Gooding', 'Chris Depp'),
('Al Garland', 'Groucho Williams'),
('Jon Chase', 'Lisa Monroe')
;

INSERT INTO works VALUES
(1, 'Burt Temple', 'ACME Corporation', 51000),
(2, 'Mary Keitel', 'ACME Corporation', 54000),
(3, 'Reese West', 'Capital One', 45000), 
(4, 'Julia Fawcett', 'Capital One', 92000), 
(5, 'Ed Guiness', 'ACME Corporation', 72000),
(6, 'Laura Brody', 'Bank of America', 49200),
(7, 'Jada Ryder', 'Bank of America', 68300),
(8, 'Ed Mansfield', 'Capital One', 38000),
(9, 'Gene Hopkins', 'Capital One', 66000),
(10, 'Morgan Williams', 'Bank of America', 77000),
(11, 'Ewan Gooding', 'UniCredit', 59000),
(12, 'Ben Harris', 'UniCredit', 72000),
(13, 'Ian Tandy', 'UniCredit', 44000),
(14, 'Chris Depp', 'UniCredit', 70000),
(15, 'Al Garland', 'Chase', 50000),
(16, 'Groucho Williams', 'Chase', 60000),
(17, 'Jimmy Neutron', 'Planet Fitness', 100000),
(18, 'Shaq', 'Big Chicken', -40000)
;
/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 1 */
-- YOUR CODE HERE
start transaction;
savepoint reverse;

delete from lives where person_name is null
or street is null or city is null;

delete from works where salary < 0;

delete from works where company_name
not in ("ACME Corporation", "Bank of America", "Chase", "Capital One", "UniCredit");

commit;

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 2 */
-- YOUR CODE HERE
start transaction;
savepoint reverse_2;

alter table lives
modify person_name varchar(100) not null,
modify street varchar(50) not null,
modify city varchar(50) not null;

alter table works modify salary int check (salary > 0);

alter table works add constraint check_cmp_name check 
(company_name in ("ACME Corporation", "Bank of America", "Chase", "Capital One", "UniCredit"));

commit;
/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 3 */
-- YOUR CODE HERE
Delimiter //
create trigger contractor_salary
before insert on works
for each row
begin
if new.salary = 0 then
set new.salary = 3000;
end if;
end;
//

/* END */