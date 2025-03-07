/*
=============================================================
Criando a base de dados e esquemas
=============================================================
Objetivo do script:
    Este script cria uma nova base de dados com o nome “DataWarehouse” depois de verificar se já existe. 
    Se a base de dados existir, é eliminada e recriada. Além disso, o script configura três esquemas 
    dentro da base de dados: “bronze”, ‘prata’ e ‘ouro’.
	
AVISO:
    A execução deste script eliminará toda a base de dados 'DataWarehouse', se existir. 
    Todos os dados na base de dados serão permanentemente eliminados. Proceda com cuidado 
    e certifique-se de que tem cópias de segurança adequadas antes de executar este script.
*/

USE master;
GO

-- Drop e recriar a base de dados “DataWarehouseAnalytics
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseAnalytics')
BEGIN
    ALTER DATABASE DataWarehouseAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouseAnalytics;
END;
GO

-- Criar a base de dados “DataWarehouseAnalytics
CREATE DATABASE DataWarehouseAnalytics;
GO

USE DataWarehouseAnalytics;
GO

-- Criar Esquemas

CREATE SCHEMA gold;
GO

CREATE TABLE gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number nvarchar(50),
	first_name nvarchar(50),
	last_name nvarchar(50),
	country nvarchar(50),
	marital_status nvarchar(50),
	gender nvarchar(50),
	birthdate date,
	create_date date
);
GO

CREATE TABLE gold.dim_products(
	product_key int ,
	product_id int ,
	product_number nvarchar(50) ,
	product_name nvarchar(50) ,
	category_id nvarchar(50) ,
	category nvarchar(50) ,
	subcategory nvarchar(50) ,
	maintenance nvarchar(50) ,
	cost int,
	product_line nvarchar(50),
	start_date date 
);
GO

CREATE TABLE gold.fact_sales(
	order_number nvarchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity tinyint,
	price int 
);
GO

TRUNCATE TABLE gold.dim_customers;
GO

BULK INSERT gold.dim_customers
FROM 'C:\Users\marga\OneDrive\Dados\Projetos\sql-data-analytics-project\datasets\gold.dim_customers.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE gold.dim_products;
GO

BULK INSERT gold.dim_products
FROM 'C:\Users\marga\OneDrive\Dados\Projetos\sql-data-analytics-project\datasets\gold.dim_products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE gold.fact_sales;
GO

BULK INSERT gold.fact_sales
FROM 'C:\Users\marga\OneDrive\Dados\Projetos\sql-data-analytics-project\datasets\gold.fact_sales.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO
