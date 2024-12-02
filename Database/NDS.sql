create database [AirQualityData_NDS]
go
USE [AirQualityData_NDS]
GO

CREATE TABLE STATE (
    StateSK INT IDENTITY(1,1) PRIMARY KEY,
    StateID CHAR(2),
    StateCode CHAR(2),
    StateName VARCHAR(255),
    CreatedTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedTime DATETIME,
    SourceID INT
);

CREATE TABLE COUNTY (
    CountySK INT IDENTITY(1,1) PRIMARY KEY,
    CountyCode CHAR(5),
    CountyName VARCHAR(255),
    CountyNameAscii VARCHAR(255),
    CountyFull VARCHAR(255),
    CountyFips CHAR(5),
    Latitude DECIMAL(9, 6),
	Longtitude DECIMAL(9, 6),
    Population INT,
    CreatedTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedTime DATETIME,
    StateSK INT,
    SourceID INT,
    FOREIGN KEY (StateSK) REFERENCES STATE(StateSK)
);

CREATE TABLE AQI (
    AQIEntrySK INT IDENTITY(1,1) PRIMARY KEY,
    Date DATE,
    AQI INT,
    Category VARCHAR(50),
    DefiningParameter VARCHAR(50),
    DefiningSite VARCHAR(50),
    NumberOfSitesReporting INT,
    CreatedTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedTime DATETIME,
    CountySK INT,
    SourceID INT,
    FOREIGN KEY (CountySK) REFERENCES COUNTY(CountySK)
);
