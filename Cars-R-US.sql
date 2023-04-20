CREATE TABLE [Vehicles] (
  [vin] varchar(20) PRIMARY KEY,
  [make] varchar(20) NOT NULL,
  [model] varchar(20) NOT NULL,
  [exterior_color] varchar(20) NOT NULL,
  [interior_color] varchar(20) NOT NULL,
  [model_year] year NOT NULL,
  [drivetrain] varchar(20) NOT NULL,
  [is_new] bool NOT NULL
)
GO

CREATE TABLE [Inventory] (
  [stock_id] int PRIMARY KEY IDENTITY(1, 1),
  [vin] varchar(20) NOT NULL,
  [landed_cost] decimal(10,2) NOT NULL,
  [asking_price] decimal(10,2) NOT NULL,
  [incoming_mileage] int NOT NULL,
  [sale_id] int
)
GO

CREATE TABLE [Salesperson] (
  [sp_id] varchar(20) PRIMARY KEY,
  [name] varchar(20) NOT NULL,
  [hire_year] year NOT NULL,
  [commission_rate] int NOT NULL
)
GO

CREATE TABLE [Sales] (
  [sale_id] int IDENTITY(1, 1),
  [stock_id] int NOT NULL,
  [customer_id] int NOT NULL,
  [sp_id] varchar(20) NOT NULL,
  [sold_price] decimal(10,2) NOT NULL,
  PRIMARY KEY ([sale_id], [stock_id])
)
GO

CREATE TABLE [Customers] (
  [customer_id] int PRIMARY KEY,
  [name] varchar(20) NOT NULL,
  [phone] varchar(12) NOT NULL,
  [email] varchar(20) NOT NULL,
  [birthday] date NOT NULL
)
GO

CREATE TABLE [VehicleAttributes] (
  [vin] varchar(20) NOT NULL,
  [attribute] varchar(20) NOT NULL,
  [value] varchar(20) NOT NULL,
  PRIMARY KEY ([vin], [attribute])
)
GO

CREATE TABLE [Packages] (
  [pkg_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(20) NOT NULL,
  [contents] text NOT NULL
)
GO

CREATE TABLE [Vehicle_Packages] (
  [vin] int PRIMARY KEY,
  [package_id] varchar(20) NOT NULL
)
GO

CREATE INDEX [VehicleAttributes_index_0] ON [VehicleAttributes] ("attribute")
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'If not present, vehicle can be sold',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Inventory',
@level2type = N'Column', @level2name = 'sale_id';
GO

ALTER TABLE [Inventory] ADD FOREIGN KEY ([vin]) REFERENCES [Vehicles] ([vin])
GO

ALTER TABLE [Sales] ADD FOREIGN KEY ([stock_id]) REFERENCES [Inventory] ([stock_id])
GO

ALTER TABLE [Sales] ADD FOREIGN KEY ([customer_id]) REFERENCES [Customers] ([customer_id])
GO

ALTER TABLE [Sales] ADD FOREIGN KEY ([sp_id]) REFERENCES [Salesperson] ([sp_id])
GO

ALTER TABLE [VehicleAttributes] ADD FOREIGN KEY ([vin]) REFERENCES [Vehicles] ([vin])
GO

ALTER TABLE [Vehicle_Packages] ADD FOREIGN KEY ([vin]) REFERENCES [Vehicles] ([vin])
GO

ALTER TABLE [Vehicle_Packages] ADD FOREIGN KEY ([package_id]) REFERENCES [Packages] ([pkg_id])
GO
