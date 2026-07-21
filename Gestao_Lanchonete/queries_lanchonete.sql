/*
============================================================
 PROJETO: Gestão de Lanchonete - Oracle SQL / Oracle APEX
 Autor: Daniel Felippe Dela Beta Benetti
 R.A: 2830482611006
 
 Contexto:
 O modelo de dados (tabelas, relacionamentos e chaves) desta
 lanchonete foi pré-modelado pelo professor do curso. O
 objetivo deste projeto foi consolidar a habilidade de ler,
 interpretar e manipular uma arquitetura de dados já existente,
 construindo consultas de complexidade crescente: JOINs,
 subqueries (correlacionadas e não correlacionadas), agregações
 de faturamento, filtros por período e agrupamentos.
============================================================
*/

-- 1. Exibir os dados dos clientes.
select *
from cliente;

-- 2. Exibir os dados das formas de pagamento.
select *
from formapagto;

-- 3. Exibir os dados das categorias.
select *
from categoria;

-- 4. Exibir os itens do cardápio (código, nome, preço e categoria), organizar por
-- categoria e nome do item.
select *
from cardapio
order by cat_codigo, car_nome;

-- 5. Exibir os dados do(s) pedido(s) da cliente "Manuel".
select cliente.cli_codigo, cliente.cli_nome, pedido.*, itempedido.*
from cliente, pedido, itempedido
where cliente.cli_codigo = pedido.cli_codigo
  and pedido.ped_numero = itempedido.ped_numero
  and cliente.cli_nome = 'Manuel';

-- 6. Alterar a descrição da categoria Doces para Guloseimas.
select * from categoria;

update categoria
set CAT_NOME = 'Guloseimas'
where CAT_NOME = 'Doces';

-- 7. Adicionar a categoria Massas.
insert into categoria
values (106, 'Massas');

-- 8. Adicionar o garçom Mário.
select * from garcom;

insert into garcom
values (405, 'Mário', '12/05/1985', '05h - 15h');

-- 9. Exibir o número do pedido, a quantidade de pessoas na mesa, o valor total do
-- pedido e o valor de cada pessoa.
select ped.ped_numero, ped.ped_numeropessoas, ped.ped_valortotal,
       ped.ped_valortotal / ped_numeropessoas as "valor por pessoa"
from pedido ped;

-- 10. Exibir a quantidade de itens do cardápio por categoria.
select car.car_nome, car.cat_codigo
from cardapio car, categoria cat
where car.cat_codigo = cat.cat_codigo
order by car.cat_codigo;

-- 11. Exibir a quantidade de itens consumidos em cada pedido.
select sum(itm_quantidade), pedido.ped_numero
from pedido, itempedido
where pedido.ped_numero = itempedido.ped_numero
group by pedido.ped_numero;

-- 12. Quais foram os itens já consumidos pela cliente "Manuel".
select car.car_nome, i.itm_quantidade
from cardapio car, itempedido i, pedido p, cliente cli
where car.car_codigo = i.car_codigo
  and i.ped_numero = p.ped_numero
  and cli.cli_codigo = p.cli_codigo
  and cli_nome = 'Manuel';

-- 13. Exibir a categoria dos itens que nunca foram vendidos para o Pedro.
select *
from categoria
where cat_codigo not in
    (select cat.cat_codigo
     from cardapio car, categoria cat, itempedido itm, pedido ped, cliente cli
     where car.cat_codigo = cat.cat_codigo
       and itm.ped_numero = ped.ped_numero
       and cli.cli_codigo = ped.cli_codigo
       and cli_nome like 'Pedro %'
     group by cat.cat_codigo);
-- pode ser usado distinct

-- 14. Exibir o nome dos clientes que nunca pediram "Doces".
select cli.cli_nome
from cliente cli
where cli.cli_codigo not in
    (select cli.cli_codigo
     from cardapio car, categoria cat, itempedido itm, pedido ped, cliente cli
     where car.cat_codigo = cat.cat_codigo
       and itm.car_codigo = car.car_codigo
       and itm.ped_numero = ped.ped_numero
       and cli.cli_codigo = ped.cli_codigo
       and cat.cat_codigo = 104);

-- 15. Exibir o faturamento no mês de Maio/2026.
select sum(ped_valortotal)
from pedido ped
where ped.ped_data >= DATE '2026-05-01'
  and ped.ped_data < DATE '2026-06-01';

-- 16. Exibir o faturamento no mês de Maio/2026 organizado por forma de pagamento.
select sum(ped_valortotal), pag.fpg_nome
from pedido ped, formapagto pag
where ped.ped_data >= DATE '2026-05-01'
  and ped.ped_data < DATE '2026-06-01'
  and pag.fpg_codigo = ped.fpg_codigo
group by pag.fpg_nome;

-- 17. Exibir o faturamento do mês de Maio/2026, organizado por categoria.
select sum(ped_valortotal)
from cardapio car, categoria cat, itempedido itm, pedido ped, cliente cli
where car.cat_codigo = cat.cat_codigo
  and itm.ped_numero = ped.ped_numero
  and cli.cli_codigo = ped.cli_codigo
  and ped.ped_data >= DATE '2026-05-01'
  and ped.ped_data < DATE '2026-06-01'
order by cat.cat_codigo;

-- 18. Exibir o(s) nome(s) dos garçons que já atenderam a cliente "Pedro".
select gar.gar_nome, gar.gar_codigo
from cliente cli, garcom gar, pedido ped, itempedido itm
where itm.ped_numero = ped.ped_numero
  and cli.cli_codigo = ped.cli_codigo
  and itm.gar_codigo = gar.gar_codigo
  and cli.cli_codigo = 3;

-- 19. Qual foi o valor do maior pedido?
select max(ped.ped_valortotal), ped.ped_numero
from pedido ped
group by ped.ped_numero;

-- 20. Quais clientes possuem pedidos maiores que a média dos pedidos do cliente Pedro?
-- Exibir o nome do cliente, número, data e hora do pedido; número do item, código e
-- nome do item do cardápio, quantidade, valor unitário e valor total do item.
select cli.cli_nome
from cliente cli, pedido ped, itempedido itm
where itm.ped_numero = ped.ped_numero
  and cli.cli_codigo = ped.cli_codigo
  and ped.ped_valortotal >
      (select avg(ped.ped_valortotal)
       from cliente cli, pedido ped, itempedido itm
       where itm.ped_numero = ped.ped_numero
         and cli.cli_codigo = ped.cli_codigo
         and cli.cli_codigo = 1)
  and cli.cli_nome != 'Manuel';

-- 21. Exibir o nome e e-mail de todos os clientes. Ordenar o resultado por nome.
select cli_nome, cli_email
from cliente cli
order by cli_nome;

-- 22. Exibir o nome e e-mail dos clientes que possuem email do gmail.
select cli.cli_nome, cli.cli_email
from cliente cli
where cli.cli_email like '%gmail%';

-- 23. Exibir o nome dos clientes que não possuem email.
select cli.cli_nome, cli.cli_status
from cliente cli
where cli.cli_email is null;

-- 24. Exibir o Status e o nome do cliente.
select cli.cli_nome, cli.cli_status
from cliente cli
order by cli.cli_nome;

-- 25. Quantos clientes estão ativos?
select count(cli_status) as "ativos"
from cliente
where cli_status like 'A%';

-- 26. Quantos clientes estão inativos?
select count(cli_status) as "inativos"
from cliente
where cli_status like 'I%';

-- 27. Exibir a quantidade de clientes por Status.
select
    (select count(cli_status) from cliente where cli_status like 'I%') as "INATIVO",
    (select count(cli_status) from cliente where cli_status like 'A%') as "ATIVO"
from dual;

-- 28. Exibir o código, nome e preço de todos os itens do cardápio.
select car.car_nome, car.car_preco, car.cat_codigo
from categoria cat, cardapio car
where cat.cat_codigo = car.cat_codigo
order by car.cat_codigo;

-- 29. Exibir o nome da categoria, código, nome e preço de todos os itens do cardápio.
select car.car_nome, car.car_preco, cat.cat_nome, car.cat_codigo
from categoria cat, cardapio car
where cat.cat_codigo = car.cat_codigo
order by cat.cat_nome;

-- 30. Quais formas de pagamento o restaurante utiliza?
select fpg.fpg_nome
from formapagto fpg
order by fpg.fpg_codigo;

-- 31. Exibir a quantidade de clientes do restaurante.
select count(*)
from cliente;

-- 32. Quais lanches iniciam com a letra "A".
select car.car_nome, car.car_preco
from cardapio car
where LOWER(car.car_nome) like 'a%';

-- 33. Quais itens do cardápio possuem "queijo" no nome.
select car.car_nome, car.car_preco
from cardapio car
where LOWER(car.car_nome) like '%queijo%'; -- ou x(cheese)

-- 34. Quais itens da categoria Doces estão com preço abaixo de 20.00.
select car.car_nome, car.car_preco
from cardapio car, categoria cat
where car.cat_codigo = cat.cat_codigo
  and car_preco < 20
  and cat.cat_codigo = 104;

-- 35. Exibir a categoria dos itens que nunca foram vendidos.
select *
from categoria
where cat_codigo not in
    (select cat.cat_codigo
     from cardapio car, categoria cat, itempedido itm, pedido ped, cliente cli
     where car.cat_codigo = cat.cat_codigo
       and itm.ped_numero = ped.ped_numero
       and cli.cli_codigo = ped.cli_codigo
     group by cat.cat_codigo);
-- pode ser usado distinct

-- 36. Exibir a média mensal de faturamento durante o ano de 2026.
select sum(ped_valortotal) as "faturamento total 2026"
from pedido ped
where ped_data >= DATE '2026-01-01'
  and ped.ped_data < DATE '2026-12-31';
