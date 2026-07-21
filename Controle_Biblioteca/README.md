# Controle de Biblioteca

Modelagem conceitual (Entidade-Relacionamento) de um sistema de controle de
biblioteca, cobrindo o fluxo completo de materiais, usuários e empréstimos:

- **Material** (livros, revistas etc.) é classificado por **Tipo de Material** e
  **Área**, e possui um ou mais **Autores**.
- **Usuário** pode realizar **Empréstimos** de materiais, com controle de data de
  início e fim.
- **Funcionário** é responsável por registrar/gerenciar os empréstimos.

## Diagrama

- 🧩 [Diagrama Entidade-Relacionamento](./diagrama_er_biblioteca.png) — entidades,
  atributos e cardinalidades dos relacionamentos entre Autor, Material, Área,
  Usuário, Funcionário e Empréstimo.

Arquivo-fonte de modelagem (formato brModelo):
[`Conceitual_Biblioteca.brM3`](./Conceitual_Biblioteca.brM3).
