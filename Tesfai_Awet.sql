-- Example filename: <larni><mohsen>.sql
/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 1 */

create database Tesfai_Awet;
use Tesfai_Awet;
-- YOUR CODE HERE


/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 2 */

create table lives(
	person_id smallint,
    person_name varchar(50),
    street varchar(100),
    city varchar(100)
);

create table works(
	person_id smallint,
    person_name varchar(50),
    company_id int,
    company_name varchar(50),
    salary int
);

create table located_in(
	company_name varchar(50),
    city varchar(50)
);

create table manages(
	person_name varchar(50),
    manager_name varchar(50)
);
-- YOUR CODE HERE


/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 3 */

insert into lives
values (1, "George Washington", "13th", "New York City"),
		(2, "John Adams", "Decatur", "Las Vegas"),
        (3, "Thomas Jefferson", "Gilespie", "Seattle");
        
insert into works
values (1, "George Washington", 1, "Tree Corp", 54000),
		(2, "John Adams", 2, "Fountain Pens", 40000),
        (3, "Thomas Jefferson", 2, "Founatain Pens", 43000);
        
insert into located_in
values ("Tree Corp", "New York City"),
		("Fountain Pens", "New Orleans"),
        ("Urns R Us", "Las Vegas");
        
insert into manages
values ("John Adams", "Thomas Jefferson");
-- YOUR CODE HERE

/* END */
