--Lista de Exercicios Simples SQL

--Crie uma query em SQL que retorne os valores distintos de cidade. Utilize a tabela
“olist_customers_dataset” e a função aliases para retornar o dado.
SELECT customer_city as Cidade from olist_customers_dataset 
GROUP by customer_city;

/*Crie uma query em SQL que retorne os valores distintos de cidade e estado, para os estados de
são paulo, minas gerais e rio de janeiro. Utilize a tabela “olist_customers_dataset” e a função
aliases para retornar o dado.*/
SELECT customer_city as Cidade, customer_state as Estado from olist_customers_dataset where customer_state in ('SP','MG','RJ'); --Exercicio 2

/*Crie uma ou mais queries que retornem o preço, o frete, a data limite para envio, e o identificador
do pedido para os registros que tem o preço entre 50 e 250, e que tem ao mesmo tempo a data
de de envio limite maior do que 08 de Fevereiro de 2018. Utilize a função aliases para retornar o
dado. Utilize a tabela “olist_order_items_dataset” e a função aliases para retornar o dado.*/
select price as preco, freight_value as frete, shipping_limit_date as Data_Limite From olist_order_items_dataset
where (preco > 50 and preco < 250 AND Data_Limite >= '2018-02-08')
order by Data_Limite asc; --Exercicio 3

/*Crie uma ou mais queries que retornem o preço, o frete, a data limite para envio, e o identificador
do pedido para os registros que tem o preço do frete inferior a 149 ou que tem um preço entre
250 e 500. Utilize a função aliases para retornar o dado. Utilize a tabela
“olist_order_items_dataset” e a função aliases para retornar o dado.*/
select price as preco, freight_value as frete, shipping_limit_date as Data_Limite From olist_order_items_dataset
where (frete > 149 or (frete > 50 AND frete > 250))
order by Data_Limite asc; --Exercicio 4

/*Crie uma query em SQL que retorne todos os tipos de pagamento. Utilize a tabela
“olist_order_payments_dataset” e a função aliases para retornar o dado.
*/
select * From olist_order_payments_dataset as Pagamentos; --Exercicio 5

/*Crie uma query em SQL que retorne o tipo de pagamento, e o valor do pagamento para as
compras que foram parceladas de 12 a 24 vezes e que tiveram um valor superior a 245,99 . Utilize
a tabela “olist_order_payments_dataset” e a função aliases para retornar o dado*/
select payment_type as Tipo_pagamento, payment_value as Valor_pagamento, payment_installments AS Parcelas
from olist_order_payments_dataset
where( Parcelas >= 12 and Parcelas <=24 and Valor_pagamento > 245.99); --Exercicio 6

/*Crie uma query em SQL que retorne todas as pontuações de avaliação. Utilize a tabela
“olist_order_reviews_dataset” e a função aliases para retornar o dado.*/
select review_score as pontuacao From olist_order_reviews_dataset;--Exercicio 7

*/Crie uma query em SQL que retorne todos os status de pedidos. Utilize a tabela
“olist_orders_dataset” e a função aliases para retornar o dado.*/
Select order_status as Status from olist_orders_dataset; --Exercicio 8

/*Crie uma query em SQL que delete os registros para os pedidos que tenham o status é igual à
“unavailable” e que tem uma data de aprovação igual ou anterior a 10 de Outubro de 2017. Utilize
a tabela “olist_orders_dataset” e a função aliases para retornar o dado.
*/
delete from olist_orders_dataset
where (order_status='unvaible' and order_approved_at>='2017-10-10');-- Exercicio 9

