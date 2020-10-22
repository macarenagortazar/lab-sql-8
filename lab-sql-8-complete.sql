# Lab | SQL Queries 8

-- In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals. You have been using this database for a couple labs already, but if you need to get the data again, refer to the official [installation link](https://dev.mysql.com/doc/sakila/en/sakila-installation.html).
use sakila;

-- 1. Rank films by length.
select film_id as "Film Id", title as "Title", length, row_number() over (order by length desc) as "Row Number" , rank() over (order by length desc) as "Rank", dense_rank() over (order by length desc) as "Dense Rank" from sakila.film;

-- 2. Rank films by length within the `rating` category.
select title, length, rating, row_number() over(partition by rating order by length desc) as "Row Number", rank() over(partition by rating order by length desc) as "Rank", dense_rank() over(partition by rating order by length desc) as "Dense Rank" from sakila.film;

-- 3. Rank languages by the number of films (as original language).
select name, count(film_id) as number_films from sakila.film as f
join sakila.language as l
on f.language_id=l.language_id
group by name;

select distinct language_id from sakila.film;
select distinct original_language_id from sakila.film;
#(All the movies are originally ioriginal_language_idn English, note that in original_language_id all values are null that is why we are taking language_id)

-- 4. Rank categories by the number of films.
select c.name, count(*), row_number() over (order by count(*) desc) from sakila.film_category as fc
join sakila.category as c 
on fc.category_id=c.category_id
group by name
order by count(*) desc;

-- 5. Which actor has appeared in the most films?
select a.actor_id, concat(first_name," ",last_name) as actor, count(*) from sakila.film_actor as fa
join sakila.actor as a 
on a.actor_id=fa.actor_id
group by actor_id
order by count(*) desc
limit 1;

-- 6. Most active customer
select concat(first_name," ",last_name) as customer, count(*) from sakila.customer as c
join sakila.rental as r
on c.customer_id=r.customer_id
group by c.customer_id
order by count(*) desc
limit 1;

-- 7. Most rented film.
select title, count(*) from sakila.film as f
join sakila.inventory as i
on f.film_id=i.film_id
join sakila.rental as r
on i.inventory_id=r.inventory_id
group by title
order by count(*) desc
limit 1;
