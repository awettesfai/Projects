DROP DATABASE if EXISTS cs457;
CREATE DATABASE cs457;
USE cs457;

CREATE TABLE lives (
	person_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	person_name VARCHAR(50) NOT NULL,
	street VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	PRIMARY KEY (person_id)
);

CREATE TABLE works (
	person_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	person_name VARCHAR(50) NOT NULL,
	company_name VARCHAR(50) NOT NULL,
	salary INT,
	PRIMARY KEY (person_id)
);


CREATE TABLE located_in (
	company_name VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL, 
	PRIMARY KEY (company_name, city)
);


CREATE TABLE manages (
	person_name VARCHAR(50) NOT NULL,
	manager_name VARCHAR(50) NOT NULL,
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
(18, 'Lisa Monroe', '659 Vaduz Drive', 'Chicago')
;

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
(16, 'Groucho Williams', 'Chase', 60000)
;

-- Example filename: larni_ashkan_A7.sql
# ** Attention: DO NOT INCLUDE THE QUERIES FOR PART 0. Just execute them in your environment. **
/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 1.1 */
-- YOUR CODE HERE

drop view if exists workers_by_city;

/*
/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 1.2 */
-- YOUR CODE HERE
create view workers_by_city as
select
l.person_name,
l.city,
w.salary
from lives as l
inner join works as w
on l.person_name = w.person_name;

/*
/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 1.3 */
-- YOUR CODE HERE
select * from workers_by_city;

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 1.4 */
-- YOUR CODE HERE
drop view if exists avg_city_salary;
create view avg_city_salary as
select
city,
avg(salary) as avg_salary
from workers_by_city group by city;

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 2 */
-- YOUR CODE HERE
drop procedure createAverageList;
Delimiter $$
create procedure createAverageList (inout avglist varchar(4000))
begin
declare finished int default false;
declare city_name varchar(100);
declare average decimal(10, 2);
-- cursor
declare avg_per_city cursor for select city, avg_salary from avg_city_salary;
-- not found handler
declare continue handler for not found set finished = True;
open avg_per_city;
getAverage: loop
fetch avg_per_city into city_name, average;
if finished then
leave getAverage;
end if;
-- build the average list
set avglist = concat(avglist, "Average salary in ", city_name, " is ", average, ". ");
end loop getAverage;
close avg_per_city;
End$$
Delimiter ;

set @avglist = "";
call createAverageList(@avglist);
select @avglist;

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 3.1 */
-- YOUR CODE HERE
drop procedure if exists change_city; 

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 3.2 */
-- YOUR CODE HERE

Delimiter $$
create procedure change_city (in tmp_person_id integer, in new_city varchar(30))
begin
/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 3.3 */
-- YOUR CODE HERE
update lives set city = new_city where person_id = tmp_person_id;
end$$
Delimiter ;

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 3.4 */
-- YOUR CODE HERE
call change_city(1, "Chicago");

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 3.5 */
-- YOUR CODE HERE
call change_city(1, "Las Vegas");

/* END */