use portflio;
# Fetch email, firstname, lastname and Genre of all rock music listener. 
# return a list ordered alphabetically by email
select * from genre;

select c.email,c.first_name,c.last_name,g.name from customer c
join invoice i on c.customer_id=i.customer_id
join invoice_line il on i.invoice_id=il.invoice_id
join track t on il.track_id=t.track_id
join genre g on t.genre_id=g.genre_id 
where g.name='Rock'
group by c.email
order by c.email asc;
# Fetch top 10 list of employees and total track count
select * from artist;

select a.name,count(g.genre_id) as "number of track" from artist a
join album al on a.artist_id=al.artist_id
join track t on al.album_id=t.album_id
join genre g on t.genre_id=g.genre_id  and g.name='Rock'
group by a.artist_id
order by count(g.genre_id) desc
limit 10;

#Return all the tracks having length more than avarage length of all tracks

#1st method
with average_length(avg_length) as(
select avg(milliseconds) from track)
select name,concat(milliseconds," ms")  as length, 
concat(round((milliseconds/60000),2)," min")as length_in_minute 
from track t,average_length av
where t.milliseconds>av.avg_length
order by length desc;
#2nd method
select name,concat(milliseconds," ms")  as length,concat(round((milliseconds/60000),2)," min")as length_in_minute 
from track 
where milliseconds>(select avg(milliseconds) from track)
order by length desc;