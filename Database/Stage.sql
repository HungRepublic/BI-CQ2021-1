create database [AirQualityData_Stage]
go
USE [AirQualityData_Stage]
GO

CREATE TABLE GeographyData (
    County VARCHAR(255),
    CountyAscii VARCHAR(255),
    CountyFull VARCHAR(255),
    CountyFips CHAR(5),
    StateId CHAR(2),
    StateName VARCHAR(255),
    Lat DECIMAL(9, 6),
    Lng DECIMAL(9, 6),
    Population INT,
	StateCode int,
	CountyCode int
);

CREATE TABLE AirQualityData (
    StateName VARCHAR(255),
    CountyName VARCHAR(255),
    StateCode CHAR(2),
    CountyCode CHAR(5),
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

