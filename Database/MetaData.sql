create database [AirQualityData_Metadata]
go
USE [AirQualityData_Metadata]
GO

CREATE TABLE data_flow (
    DataFlowID INT IDENTITY(1,1) PRIMARY KEY,
    TableName VARCHAR(255) NOT NULL,      
    CET DATETIME NOT NULL DEFAULT GETDATE(), 
    LSET DATETIME NULL,         
);

INSERT INTO data_flow (TableName, CET)
SELECT 'AirQualityData' AS TableName, GETDATE() AS CET; 

INSERT INTO data_flow (TableName, CET)
SELECT 'GeographyData' AS TableName, GETDATE() AS CET; 
