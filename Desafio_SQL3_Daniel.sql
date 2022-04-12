/*crie uma tabela analítica de todos os itens que foram vendidos,
 mostrando somente pedidos interestaduais. Queremos saber quantos
  dias os fornecedores demoram para postar o produto, se o produto chegou ou não no prazo.*/

select  itens.order_id as Itens_ID,
        clientes.customer_state as EstadoCliente,
        vendedor.seller_state as EstadoVendedor,
        datetime_diff(order_delivered_carrier_date, order_approved_at, day) as DemoraParaPostar,
        IF(( date(order_delivered_customer_date) <= date(order_estimated_delivery_date)), "Dentro do prazo", "Fora do prazo") as Prazo
from
  `projeto-342322.Pagamentos.Clientes` as clientes 
 inner join `projeto-342322.Pagamentos.Orders` as pedidos on clientes.customer_id = pedidos.customer_id
 inner join `projeto-342322.Pagamentos.Itens` as itens on pedidos.order_id = itens.order_id
 inner join `projeto-342322.Pagamentos.Produtos` as produtos on itens.product_id = produtos.product_id
 inner join `projeto-342322.Pagamentos.Sellers` as vendedor on itens.seller_id = vendedor.seller_id
 
 where customer_state <> seller_state;

 /*retorne todos os pagamentos do cliente, com suas datas de aprovação, valor da compra e
  o valor total que o cliente já gastou em todas as suas compras,
  mostrando somente os clientes onde o valor da compra é diferente do valor total já gasto.*/

 select customer_unique_id as Cliente, order_approved_at as DatadeAprovacao, price as ValordaCompra,
 ValorTotal,
 count(payment_value) over(partition by customer_unique_id) as qtdCompras from
 (select *, sum(payment_value) over(partition by customer_unique_id) as ValorTotal from `projeto-342322.Pagamentos.Clientes` as clientes 
 inner join `projeto-342322.Pagamentos.Orders` as pedidos on clientes.customer_id = pedidos.customer_id
 inner join `projeto-342322.Pagamentos.Pagamento`as pagamento on pedidos.order_id = pagamento.order_id
 inner join `projeto-342322.Pagamentos.Itens` as itens on pedidos.order_id = itens.order_id)
 where price<>ValorTotal;

 /*retorne as categorias válidas, suas somas totais dos valores de vendas, um ranqueamento de maior
  valor para menor valor junto com o somatório acumulado dos valores pela mesma regra do ranqueamento.*/
  select categoria, valor, 
  sum(valor) over(partition by categoria order by valor desc) as TotalAcumulado
   from
(select product_category_name as categoria, sum(payment_value) as valor from 
 `projeto-342322.Pagamentos.Orders` as pedidos 
 inner join `projeto-342322.Pagamentos.Pagamento`as pagamento on pedidos.order_id = pagamento.order_id
 inner join `projeto-342322.Pagamentos.Itens` as itens on pedidos.order_id = itens.order_id
 inner join `projeto-342322.Pagamentos.Produtos` as produtos on itens.product_id = produtos.product_id
 where product_category_name is not null
 group by product_category_name
 order by valor desc);