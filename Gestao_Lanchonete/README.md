# Gestão de Lanchonete

Este projeto trabalha sobre um modelo de banco de dados **pré-modelado pelo professor**,
simulando o sistema de pedidos de uma lanchonete (clientes, cardápio, categorias,
formas de pagamento, garçons, pedidos e itens de pedido).

O foco aqui não foi a modelagem, e sim a habilidade de **ler e interpretar uma
arquitetura de dados já existente** e construir consultas SQL sobre ela, incluindo:

- `JOINs` entre múltiplas tabelas (estilo ANSI antigo, com `WHERE`)
- Subqueries correlacionadas e não correlacionadas (`NOT IN`, subquery escalar)
- Agregações (`SUM`, `COUNT`, `MAX`, `AVG`) e `GROUP BY`
- Filtros por intervalo de datas (faturamento mensal/anual)
- `INSERT` e `UPDATE` de dados
- Filtros de texto com `LIKE` e `LOWER`

📄 Arquivo: [`queries_lanchonete.sql`](./queries_lanchonete.sql)
