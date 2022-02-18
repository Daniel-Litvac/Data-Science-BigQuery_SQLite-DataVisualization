--Lista de Exercicios Simples SQL

SELECT customer_city as Cidade from olist_customers_dataset --Exercicios 1
GROUP by customer_city;

SELECT customer_state as Estado, count(customer_state) from olist_customers_dataset where customer_state='RJ'
group by customer_state;

SELECT customer_city as Cidade, customer_state as Estado from olist_customers_dataset where customer_state in ('SP','MG','RJ'); --Exercicio 2

select price as preco, freight_value as frete, shipping_limit_date as Data_Limite From olist_order_items_dataset
where (preco > 50 and preco < 250 AND Data_Limite >= '2018-02-08')
order by Data_Limite asc; --Exercicio 3

select price as preco, freight_value as frete, shipping_limit_date as Data_Limite From olist_order_items_dataset
where (frete > 149 or (frete > 50 AND frete > 250))
order by Data_Limite asc; --Exercicio 4

select * From olist_order_payments_dataset as Pagamentos; --Exercicio 5

select payment_type as Tipo_pagamento, payment_value as Valor_pagamento, payment_installments AS Parcelas
from olist_order_payments_dataset
where( Parcelas >= 12 and Parcelas <=24 and Valor_pagamento > 245.99); --Exercicio 6

select review_score as pontuacao From olist_order_reviews_dataset;--Exercicio 7

Select order_status as Status from olist_orders_dataset; --Exercicio 8

delete from olist_orders_dataset
where (order_status='unvaible' and order_approved_at>='2017-10-10');-- Exercicio 9

