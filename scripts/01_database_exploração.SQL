/*
===============================================================================
Explorando o Banco de Dados
===============================================================================
Objetivo:
    - Explorar a estrutura da base de dados, incluindo a lista de tabelas e os respectivos esquemas.
    - Inspecionar as colunas e os metadados de tabelas específicas.

Tabela utilizada:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

--  Obter uma lista de todas as tabelas da base de dados
SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

-- Obter todas as colunas de uma tabela específica (dim_customers)
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';
