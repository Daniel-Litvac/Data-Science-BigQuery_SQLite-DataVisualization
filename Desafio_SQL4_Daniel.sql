/*Crie uma view (SELLER_STATS) para mostrar por fornecedor, a quantidade de itens enviados,
 o tempo médio de postagem após a aprovação da compra, a quantidade total de pedidos de cada Fornecedor,
 note que trabalharemos na mesma query com 2 granularidades diferentes.*/
--Create view `projeto-342322.Pagamentos.SELLER_STATS` as(
 select Vendedores.seller_id as Idvendedor,
 --count(itens.order_item_id),
 count(*) as qtdItens,
avg(datetime_diff(pedidos.order_delivered_carrier_date, pedidos.order_approved_at, day)) as TempoMedioPostagem, --perguntar a questão do avg
count(distinct pedidos.order_id) as QTDTotalPedidos 


            from `projeto-342322.Pagamentos.Clientes` as Clientes
            inner join `projeto-342322.Pagamentos.Orders` as pedidos on Clientes.customer_id = pedidos.customer_id
            inner join `projeto-342322.Pagamentos.Itens` as itens on pedidos.order_id = itens.order_id
            inner join `projeto-342322.Pagamentos.Sellers` as Vendedores on itens.seller_id = Vendedores.seller_id
group by Idvendedor
having qtdItens =9;

/*Queremos dar um cupom de 10% do valor da última compra do cliente.
 Porém os clientes elegíveis a este cupom devem ter feito uma compra anterior a última
 (a partir da data de aprovação do pedido) que tenha sido maior ou igual o valor da última compra.
 Crie uma querie que retorne os valores dos cupons para cada um dos clientes elegíveis.*/

select *,
lag(ValorTotal) over (partition by Idcliente order by DataAprovacao desc) as ValorPedidoAnterior
 from(
                select Clientes.customer_id as Idcliente,
                pedidos.order_id as IdPedido,
                pedidos.order_approved_at as DataAprovacao,
                sum(pagamentos.payment_value) as ValorTotal,
                from `projeto-342322.Pagamentos.Clientes` as Clientes
                            inner join `projeto-342322.Pagamentos.Orders` as pedidos on Clientes.customer_id = pedidos.customer_id
                            inner join `projeto-342322.Pagamentos.Pagamento` as pagamentos on pedidos.order_id = pagamentos.order_id
                group by Idcliente, IdPedido, DataAprovacao
                order by Idcliente)