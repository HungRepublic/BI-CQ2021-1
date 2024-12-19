create database [AirQualityData_Stage]
go
USE [AirQualityData_Stage]
GO

CREATE TABLE GeographyData (
    County VARCHAR(255),
    CountyAscii VARCHAR(255),
    CountyFull VARCHAR(255),
    CountyFips INT,
    StateId CHAR(2),
    StateName VARCHAR(255),
    Lat DECIMAL(9, 6),
    Lng DECIMAL(9, 6),
    Population INT,
	StateCode INT,
	CountyCode INT
);

CREATE TABLE AirQualityData (
    StateName VARCHAR(255),
    CountyName VARCHAR(255),
    StateCode INT,
    CountyCode INT,
    Date DATE,
    AQI INT,
    Category VARCHAR(50),
    DefiningParameter VARCHAR(50),
    DefiningSite VARCHAR(50),
    NumberOfSiteRep INT,
    Created DATETIME,
    LastUpdated DATETIME,
	SourceID INT
);

Select * from GeographyData;
Select * from AirQualityData;

