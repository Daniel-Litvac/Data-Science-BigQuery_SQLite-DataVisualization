--Tarefa: Desafios de SQL 1

-- 1) selecione os dados da tabela de pagamentos onde só apareçam os tipos de pagamento “VOUCHER” e “BOLETO”.
select * from olist_order_payments_dataset
where payment_type in ('voucher','boleto');

-- 2) retorne os campos da tabela de produtos e calcule o volume de cada produto em um novo campo.
select *, count(*) from olist_products_dataset
group by product_category_name;

select distinct *, product_category_name, count(*) from olist_products_dataset
order by product_category_name asc;

-- 3) retorne somente os reviews que não tem comentários.
select review_comment_message, count(review_comment_message) from olist_order_reviews_dataset
where review_comment_message!=' '
group by review_comment_message; --*** perguntar

-- 4) retorne pedidos que foram feitos somente no ano de 2017.
select * FROM olist_orders_dataset
where substr(order_purchase_timestamp,1,4)='2017';

-- 5) encontre os clientes do estado de SP e que não morem na cidade de São Paulo.
SELECT * from olist_customers_dataset
where customer_state='SP' and customer_city!='sao paulo';
