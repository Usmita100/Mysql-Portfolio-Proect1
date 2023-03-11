# Who is the senior most employee based on job title 
select * from employee
order by levels desc
limit 1 ;

# Which countries have the most invoices
select count(invoice_id) as total_number_billing,billing_country as count_of_billing from invoice 
group by billing_country 
order by total_number_billing desc ;

-- select * from invoice order by total desc limit 3 ;
# Which City has best customers based on invoioce totals
select billing_city,round(sum(total),2) as Sum_of_invoice_totals From invoice 
group by billing_city 
order by Sum_of_invoice_totals desc
limit 1;

# Who is the best customer(based on spending most money)
select * from customer;
select * from invoice;
select count(distinct(customer_id)) from invoice;
select c.customer_id,c.first_name,c.last_name,round(sum(i.total),3) as money from customer c
join invoice i
on c.customer_id=i.customer_id
group by i.customer_id
order by money desc
limit 1;

