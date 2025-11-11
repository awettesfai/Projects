
/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 1 */

-- YOUR CODE HERE
select person_name from works
where company_name = "ACME Corporation" and salary >= 50000;

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 2 */

-- YOUR CODE HERE 
select company_name from located_in
where company_name != "ACME Corporation" and city in ( select l.city from located_in as l
where l.company_name = "ACME Corporation");

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 3 */

-- YOUR CODE HERE
select person_name from lives
where city in ( select loc.city from works as w join located_in as loc on w.company_name = loc.company_name where lives.person_id = w.person_id);

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 4 */

-- YOUR CODE HERE
select person_name from lives
where (city, street) in ( select e.city, e.street from manages as m join lives as e on e.person_name = m.manager_name
where lives.person_name = e.person_name);
  

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 5 */

-- YOUR CODE HERE
select person_name from lives
where person_name not in (select person_name from works where company_name = "ACME Corporation");

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 6 */

-- YOUR CODE HERE
select person_name from works
where company_name != "ACME Corporation" and salary > all (select w_2.salary from works as w_2 where
w_2.company_name = "ACME Corporation");

/*
DO NOT TOUCH THE COMMENTS.
Just write your code in the specified sections.
*/
/* PART 7 */

-- YOUR CODE HERE
select company_name from located_in
where company_name != "ACME Corporation" and city in ( select l.city from located_in as l
where l.company_name = "ACME Corporation");

/* END */
