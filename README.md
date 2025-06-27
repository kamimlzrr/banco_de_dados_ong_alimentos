# relational-db-college-activity
# banco-de-dados-ong

# 🍲 Sistema de Gerenciamento para ONG de Banco de Alimentos

Este repositório contém o esquema completo do banco de dados para um sistema de gerenciamento de doações de alimentos e refeições prontas para uma ONG. Ele foi projetado para rastrear e otimizar o fluxo de doações, desde a entrada de alimentos e voluntários até a entrega final aos necessitados.

## 🌟 Visão Geral do Projeto

O objetivo principal deste banco de dados é fornecer uma estrutura robusta para que uma ONG de banco de alimentos possa gerenciar suas operações de forma eficiente, garantindo que as doações sejam rastreadas, o estoque seja controlado e as entregas sejam registradas.

## 🚀 Funcionalidades Principais do Banco de Dados

O esquema do banco de dados é composto por tabelas interconectadas que suportam as seguintes funcionalidades:

* **`Doadores`**: Gerenciamento de informações de contato e endereço de doadores (pessoas físicas ou jurídicas) que fornecem insumos ou refeições prontas.
* **`Voluntarios`**: Registro de voluntários que se candidataram para auxiliar em diversas etapas, como preparação de refeições, doação de alimentos ou realização de entregas.
* **`Alimentos`**: Um catálogo geral de tipos de alimentos brutos (ingredientes), como "Arroz Agulhinha" ou "Feijão Carioca", com suas unidades padrão de medida (ex: 'kg', 'litros').
* **`AlimentosDoados`**: Rastreia as doações de alimentos não preparados (ingredientes), vinculando ao doador (pessoa ou voluntário), o tipo de alimento, a quantidade, data de validade e data da doação.
* **`RefeicoesProntas`**: Gerencia lotes de refeições já preparadas, registrando quem preparou/doou, a descrição da refeição, quantidade total, unidade de medida (ex: 'marmitas'), e datas de preparo/validade.
* **`IngredientesRefeicao`**: Detalha quais alimentos (ingredientes) e em que quantidades foram usados para compor cada `RefeicaoPronta`, ligando-as ao catálogo de `Alimentos`.
* **`EstoqueAlimentos`**: Controla o inventário atual de todos os itens disponíveis na ONG, sejam alimentos brutos ou refeições prontas, incluindo a quantidade atual, unidade de medida e a data de validade mais próxima para o lote.
* **`Entregas`**: Registra as entregas realizadas, incluindo o voluntário responsável, a data e o endereço de destino.
* **`DetalheEntrega`**: Permite especificar quais e quantas unidades de `Alimentos` e/ou `RefeicoesProntas` foram incluídas em cada `Entrega`.

Modelo Conceitual: 
![Modelo Conceitual](https://github.com/user-attachments/assets/780ba9c8-c0de-44af-b39b-a2476a1fafba)

## 🛠️ Tecnologias Utilizadas

* **Sistema de Gerenciamento de Banco de Dados:** MySQL
* **Linguagem de Consulta:** SQL

## 🚀 Como Configurar e Rodar o Banco de Dados

Siga os passos abaixo para configurar o banco de dados em seu ambiente local:

1.  **Pré-requisitos:**
    * Certifique-se de ter um servidor MySQL instalado e funcionando.
    * Tenha um cliente MySQL (como MySQL Workbench, DBeaver, DataGrip ou o cliente de linha de comando `mysql`) para executar os scripts.

2.  **Crie o Banco de Dados e as Tabelas:**
    * Baixe ou clone este repositório para o seu ambiente local.
    * Localize o arquivo `ong_bancalimentos.sql` dentro da pasta do projeto.
    * Abra seu cliente MySQL e execute o conteúdo do arquivo `ong_bancalimentos.sql`. Este script irá:
        * Remover o banco de dados `ong_bancalimentos` se ele já existir (para garantir um recomeço limpo).
        * Criar o banco de dados `ong_bancalimentos`.
        * Selecionar o banco de dados `ong_bancalimentos` para uso.
        * Criar todas as tabelas (`Doadores`, `Voluntarios`, `Alimentos`, `AlimentosDoados`, `RefeicoesProntas`, `IngredientesRefeicao`, `EstoqueAlimentos`, `Entregas`, `DetalheEntrega`) com suas respectivas colunas, tipos de dados e chaves estrangeiras.

Modelo Lógico:
![MER](https://github.com/user-attachments/assets/8c29fd31-095b-45b6-aca0-470aee480c3c)


    ```

3.  **Popular com Dados de Teste (Opcional, mas recomendado):**
    * Para testar a estrutura e as funcionalidades, você pode inserir dados de teste. Se houver um arquivo `dados_teste.sql` separado no repositório, execute-o. Caso contrário, você pode preparar seus próprios comandos `INSERT`.
    * Exemplo de inserção de dados de teste (estes não estão incluídos diretamente neste `README`, mas você pode tê-los em um script separado):
        ```sql
        -- Exemplo de inserção para Doadores
        INSERT INTO Doadores (nome, cpf, telefone, email, endereco) VALUES
        ('João Silva', '111.111.111-11', '41991234567', 'joao.s@email.com', 'Rua Alfa, 123, Curitiba - PR');

        -- Exemplo de inserção para Alimentos
        INSERT INTO Alimentos (nomeAlimento, unidadePadrao) VALUES
        ('Arroz Agulhinha', 'kg');

        -- ... e assim por diante para as outras tabelas com dados de exemplo.
        ```

4.  **Verificar os Dados:**
    * Após a inserção de dados, você pode verificar o conteúdo das tabelas executando consultas `SELECT` em seu cliente MySQL:
        ```sql
        USE ong_bancalimentos;

        SELECT * FROM Doadores;
        SELECT * FROM Voluntarios;
        SELECT * FROM Alimentos;
        SELECT * FROM AlimentosDoados;
        SELECT * FROM RefeicoesProntas;
        SELECT * FROM IngredientesRefeicao;
        SELECT * FROM EstoqueAlimentos;
        SELECT * FROM Entregas;
        SELECT * FROM DetalheEntrega;
        ```

## 📂 Estrutura do Projeto

* `ong_bancalimentos.sql`: Contém o esquema completo do banco de dados (CREATE TABLEs).
* `README.md`: Este arquivo, descrevendo o projeto.

## 🤝 Contribuição

Contribuições são bem-vindas! Se você tiver sugestões, melhorias ou encontrar bugs, sinta-se à vontade para:

1.  Abrir uma `Issue` descrevendo o problema ou sugestão.
2.  Criar um `Fork` do projeto.
3.  Fazer suas alterações e enviar um `Pull Request`.


---

**Autor:** Kamille Maciel Melzer Oliveira / (https://github.com/kamimlzrr)
**Contato:** kamimlzr@gmail.com
