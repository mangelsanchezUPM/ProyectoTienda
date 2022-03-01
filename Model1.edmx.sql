
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 02/28/2022 21:22:37
-- Generated from EDMX file: C:\Users\Miguel Angel\source\repos\ProyectoTienda\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [ProyectoTienda];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_ProductWithoutStockProduct]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductsWithoutStock] DROP CONSTRAINT [FK_ProductWithoutStockProduct];
GO
IF OBJECT_ID(N'[dbo].[FK_ProductProductOrdered]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductsOrdered] DROP CONSTRAINT [FK_ProductProductOrdered];
GO
IF OBJECT_ID(N'[dbo].[FK_ClientOrder]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_ClientOrder];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderProductOrdered]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductsOrdered] DROP CONSTRAINT [FK_OrderProductOrdered];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Products]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Products];
GO
IF OBJECT_ID(N'[dbo].[ProductsOrdered]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProductsOrdered];
GO
IF OBJECT_ID(N'[dbo].[Orders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Orders];
GO
IF OBJECT_ID(N'[dbo].[Clients]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Clients];
GO
IF OBJECT_ID(N'[dbo].[ProductsWithoutStock]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProductsWithoutStock];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Products'
CREATE TABLE [dbo].[Products] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Price] float  NOT NULL,
    [Amount] int  NOT NULL,
    [Image] nvarchar(max)  NULL
);
GO

-- Creating table 'ProductsOrdered'
CREATE TABLE [dbo].[ProductsOrdered] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Amount] int  NOT NULL,
    [ProductId] int  NOT NULL,
    [OrderId] int  NOT NULL
);
GO

-- Creating table 'Orders'
CREATE TABLE [dbo].[Orders] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Date] datetime  NOT NULL,
    [ClientId] int  NOT NULL,
    [Total] float  NOT NULL
);
GO

-- Creating table 'Clients'
CREATE TABLE [dbo].[Clients] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'ProductsWithoutStock'
CREATE TABLE [dbo].[ProductsWithoutStock] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Product_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ProductsOrdered'
ALTER TABLE [dbo].[ProductsOrdered]
ADD CONSTRAINT [PK_ProductsOrdered]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Clients'
ALTER TABLE [dbo].[Clients]
ADD CONSTRAINT [PK_Clients]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ProductsWithoutStock'
ALTER TABLE [dbo].[ProductsWithoutStock]
ADD CONSTRAINT [PK_ProductsWithoutStock]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Product_Id] in table 'ProductsWithoutStock'
ALTER TABLE [dbo].[ProductsWithoutStock]
ADD CONSTRAINT [FK_ProductWithoutStockProduct]
    FOREIGN KEY ([Product_Id])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductWithoutStockProduct'
CREATE INDEX [IX_FK_ProductWithoutStockProduct]
ON [dbo].[ProductsWithoutStock]
    ([Product_Id]);
GO

-- Creating foreign key on [ProductId] in table 'ProductsOrdered'
ALTER TABLE [dbo].[ProductsOrdered]
ADD CONSTRAINT [FK_ProductProductOrdered]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductProductOrdered'
CREATE INDEX [IX_FK_ProductProductOrdered]
ON [dbo].[ProductsOrdered]
    ([ProductId]);
GO

-- Creating foreign key on [ClientId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_ClientOrder]
    FOREIGN KEY ([ClientId])
    REFERENCES [dbo].[Clients]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ClientOrder'
CREATE INDEX [IX_FK_ClientOrder]
ON [dbo].[Orders]
    ([ClientId]);
GO

-- Creating foreign key on [OrderId] in table 'ProductsOrdered'
ALTER TABLE [dbo].[ProductsOrdered]
ADD CONSTRAINT [FK_OrderProductOrdered]
    FOREIGN KEY ([OrderId])
    REFERENCES [dbo].[Orders]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderProductOrdered'
CREATE INDEX [IX_FK_OrderProductOrdered]
ON [dbo].[ProductsOrdered]
    ([OrderId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------