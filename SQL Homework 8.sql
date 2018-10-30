use sakila;

select actor.first_name, actor.last_name from actor;

alter table actor 
add actor_name varchar(50);
SET SQL_SAFE_UPDATES = 0;
update sakila.actor
   set actor.first_name = UPPER(first_name);
update sakila.actor
   set actor.last_name = UPPER(last_name) ;
update sakila.actor
   set actor_name = concat(first_name," ",last_name);
 
select actor_id, first_name, last_name 
  from actor
where first_name like 'Joe';
 
select * 
  from actor
where last_name like '%GEN%';
 
select * 
  from actor 
where last_name like '%LI%'
 order by last_name,first_name;
 
select country_id, country 
  from country
where country in ('Afghanistan', 'Bangladesh', 'China');
 
alter table actor
add middle_name varchar(50) after first_name;
 
alter table actor 
modify middle_name blob;

alter table actor
drop middle_name;

select last_name
     , count(last_name) as 'Counter last name'
from actor
group by last_name;

select last_name
     , count(last_name) as 'Counter last name'
  from actor
 group by last_name
 having count(last_name) > 1;

select first_name
	 , actor_name 
  from actor
where actor_name = 'HARPO WILLIAMS';
 SET SQL_SAFE_UPDATES = 0;

UPDATE actor
   SET first_name='HARPO'
     , actor_name = 'HARPO WILLIAMS'
WHERE actor_name='GROUCHO WILLIAMS';
 
 
 SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name='GROUCHO',actor_name = 'GROUCHO WILLIAMS'
WHERE actor_name='HARPO WILLIAMS';
 
 

show create table address;
  
select s.first_name,s.last_name,a.address 
from staff s
join address a
on a.address_id = s.address_id; 
   
select s.staff_id
     , sum(p.amount) as 'total amount'
from payment p
inner join staff s 
   on p.staff_id = s.staff_id
where p.payment_date between '2005-08-01 00:00:00' and '2005-08-31 23:59:59'
 group by p.staff_id;
  
select f.title
     , count(fa.actor_id) as 'number of actors'
from film f
join film_actor fa
on f.film_id = fa.film_id
group by f.title;
 
select f.title
     , count(i.film_id) as 'Number of copies'
from film f
join inventory i 
  on f.film_id = i.film_id
where f.title= 'Hunchback Im possible';


select customer.first_name
     , customer.last_name
     , sum(payment.amount) as 'Total Amount Paid'
from customer 
join payment
on customer.customer_id = payment.customer_id
group by customer.customer_id
Order by customer.last_name;

select film.title
  from film 
where film.language_id in
  (select language.language_id
from language
where language.name ='English')
having film.title REGEXP '^[KQ]';

select actor.actor_name 
from actor
where actor.actor_id in
(select film_actor.actor_id
from film_actor
where film_actor.film_id in
(select  film.film_id 
from film
where film.title = 'Alone Trip'));

select customer.first_name, customer.last_name, customer.email, country.country
from customer
join address
on customer.address_id = address.address_id
join city
on city.city_id = address.city_id
join country
on country.country_id = city.country_id
where country.country = 'Canada';


 select film.title, film_category.category_id
from film
join film_category
on film.film_id = film_category.film_id
join category
on film_category.category_id = category.category_id
where category.category_id=8;
 -- 7e. Display the most frequently rented movies in descending order. 
-- Check Solution
select film.title, count(film.title) as 'times of rented'
from film
join inventory
on film.film_id = inventory.film_id
join rental 
on inventory.inventory_id = rental.inventory_id
group by film.title
order by count(film.title) desc;

select store.store_id, count(film.rental_rate) as 'Store revenue in dollar $'
from film
join inventory
on film.film_id = inventory.film_id
join store
on inventory.store_id = store.store_id
group by store.store_id;

select store.store_id, city.city,country.country
from store
join address
on store.address_id = address.address_id
join city
on address.city_id = city.city_id
join country
on city.country_id = country.country_id
group by store.store_id;


select category.category_id, category.name, sum(payment.amount) as 'Gross Revenue'
from category
join film_category
on category.category_id = film_category.category_id
join inventory
on film_category.film_id = inventory.film_id
join rental 
on inventory.inventory_id = rental.inventory_id
join payment
on rental.rental_id = payment.rental_id
group by category.name
order by sum(payment.amount) desc limit 5;


create view top_five_genres as  
select category.category_id, category.name, sum(payment.amount) as 'top_five_genres'
from category
join film_category
on category.category_id = film_category.category_id
join inventory
on film_category.film_id = inventory.film_id
join rental 
on inventory.inventory_id = rental.inventory_id
join payment
on rental.rental_id = payment.rental_id
group by category.name
order by sum(payment.amount) desc limit 5;

select * from top_five_genres;

 drop view top_five_genres;