/*retorne a quantidade de itens vendidos em cada categoria por estado em que o cliente se encontra,
 mostrando somente categorias que tenham vendido uma quantidade de items acima de 1000.*/

 select tab.product_category_name as Categoria, tab.customer_state as Estado, count(tab.order_item_id) as QTD_Itens, 
 sum(tab.order_item_id) as QTD_Itens2
  from
 ( select * from `projeto-342322.Pagamentos.Clientes` as clientes
     inner join `projeto-342322.Pagamentos.Orders` as pedidos on clientes.customer_id = pedidos.customer_id
     inner join `projeto-342322.Pagamentos.Itens` as itens on pedidos.order_id = itens.order_id
     inner join `projeto-342322.Pagamentos.Produtos` as produtos on itens.product_id = produtos.product_id
 ) as tab
 group by Categoria, Estado;

/*mostre os 5 clientes (customer_id) que gastaram mais dinheiro em compras, qual foi o valor total de todas as compras deles,
  quantidade de compras, e valor médio gasto por compras. Ordene os mesmos por ordem decrescente pela média do valor de compra.*/
   select customer_unique_id as Cliente, sum(pagamento.payment_value) as somaTOTAL,
    count(pedidos.order_id) as qtdCompras,
    avg(pagamento.payment_value) as ValorMedioCompra

      
     from  `projeto-342322.Pagamentos.Clientes` as clientes
      inner join `projeto-342322.Pagamentos.Orders` as pedidos on clientes.customer_id = pedidos.customer_id
      inner join `projeto-342322.Pagamentos.Itens` as itens on pedidos.order_id = itens.order_id
      inner join `projeto-342322.Pagamentos.Pagamento` as pagamento on pedidos.order_id = pagamento.order_id
  group by Cliente
  order by ValorMedioCompra desc
  limit 5;

  /*mostre o valor vendido total de cada vendedor (seller_id) em cada uma das categorias de produtos, somente retornando os vendedores que nesse somatório e agrupamento
   venderam mais de $1000. Desejamos ver a categoria do produto e os vendedores. Para cada uma dessas categorias, mostre seus valores de venda de forma decrescente.*/
   select Vendedores.seller_id as IdVendedor, 
   Produtos.product_category_name as Categoria, 
   sum(price) as Pagamentos --não pode ser payment_value
   from   `projeto-342322.Pagamentos.Itens` as Itens
   inner join `projeto-342322.Pagamentos.Produtos` as Produtos on itens.product_id = itens.product_id
   inner join `projeto-342322.Pagamentos.Sellers` as Vendedores on itens.seller_id = Vendedores.seller_id
   group by IdVendedor, Categoria
   having Pagamentos > 1000
   order by Categoria, Pagamentos desc;