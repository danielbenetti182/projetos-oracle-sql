# Sistema de Cursos Extracurriculares

Modelagem de dados completa (do zero) para um sistema de gestão de cursos
extracurriculares, contemplando as seguintes regras de negócio:

- **Aluno** se matricula em um **Curso** através de uma **Matrícula**.
- Cada **Matrícula** possui um **Status de Matrícula** (ex: ativa, trancada, concluída).
- Um **Curso** é ministrado por um **Professor** e possui carga horária, dia da
  semana, horário e número de vagas.
- O controle de frequência é feito por meio da entidade **Presença**, vinculada
  à matrícula do aluno, registrando data da aula e status de presença.

## Diagramas

- 🧩 [Diagrama Conceitual](./diagrama_conceitual_cursos.png) — entidades, atributos
  e relacionamentos com suas cardinalidades.
- 🔗 [Diagrama Lógico/Relacional](./diagrama_logico_cursos.png) — tabelas, chaves
  primárias (PK), chaves estrangeiras (FK) e tipos de dados, pronto para
  implementação em Oracle SQL.

Os arquivos-fonte de modelagem (formato brModelo) também estão disponíveis:
[`ConceitoAulas.brM3`](./ConceitoAulas.brM3) e [`LogicoAulas.brM3`](./LogicoAulas.brM3).
