# Fetch how much money is spent by each customer on the best selling artist in the data set
select * from artist ;
with cte as(
select ar.artist_id as artist_id,ar.name as artist_name, sum(il.unit_price*il.quantity) as total_sspent from artist ar
join album al on ar.artist_id=al.artist_id
join track t on al.album_id=t.album_id
join invoice_line il on t.track_id=il.track_id
group by ar.artist_id
order by sum(il.unit_price*il.quantity) desc limit 1)
select c.customer_id,c.first_name,c.last_name,ct.artist_name,sum(il.unit_price*il.quantity) as total_money_spent from customer c
join invoice i on c.customer_id=i.customer_id
join invoice_line il on i.invoice_id=il.invoice_id
join track t on il.track_id=t.track_id
join album al on  t.album_id=al.album_id
join cte ct on ct.artist_id=al.album_id
group by c.customer_id,c.first_name,c.last_name
order by sum(il.unit_price*il.quantity) desc;

# Return country name and top selling genre
select distinct country from customer;

with cte as(
select c.country as country_name,g.genre_id as genre_id,g.name as genre_name, count(il.quantity) as total_purchase ,
ROW_NUMBER() over (partition by c.country order by count(il.quantity) desc) as row_no
from customer c
join invoice i on c.customer_id=i.customer_id
join invoice_line il on il.invoice_id=i.invoice_id
join track t on il.track_id=t.track_id
join genre g on t.genre_id=g.genre_id
group by c.country,g.genre_id
order by c.country asc,count(il.quantity) desc)
select country_name,genre_name  from cte where row_no=1;

# Fetch the customer who spent most money on music from each country present in this dataset
with cte as
(select c.customer_id,c.first_name,c.last_name,c.country,sum(il.unit_price*il.quantity) as money_spent,
row_number() over (partition by c.country order by sum(il.unit_price*il.quantity) desc) as row_no 
from customer c
join invoice i on c.customer_id=i.customer_id
join invoice_line il on i.invoice_id=il.invoice_id
group by c.customer_id
order by c.country asc)
select * from cte where row_no=1

