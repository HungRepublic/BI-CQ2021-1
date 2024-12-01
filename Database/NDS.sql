create database [AirQualityData_NDS]
go
USE [AirQualityData_NDS]
GO

CREATE TABLE STATE (
    StateSK INT IDENTITY(1,1) PRIMARY KEY,
    StateID CHAR(2) NOT NULL,
    StateCode CHAR(2) NOT NULL,
    StateName VARCHAR(255) NOT NULL,
    CreatedTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedTime DATETIME NULL,
    SourceID INT NOT NULL
);

CREATE TABLE COUNTY (
    CountySK INT IDENTITY(1,1) PRIMARY KEY,
    CountyCode CHAR(5) NOT NULL,
    CountyName VARCHAR(255) NOT NULL,
    CountyNameAscii VARCHAR(255),
    CountyFull VARCHAR(255),
    CountyFips CHAR(5),
    Latitud DECIMAL(9, 6),
    Population INT,
    CreatedTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedTime DATETIME NULL,
    StateSK INT NOT NULL,
    SourceID INT NOT NULL,
    FOREIGN KEY (StateSK) REFERENCES STATE(StateSK)
);

CREATE TABLE AQI (
    AQIEntrySK INT IDENTITY(1,1) PRIMARY KEY,
    Date DATE NOT NULL,
    AQI INT NOT NULL,
    Category VARCHAR(50),
    DefiningParameter VARCHAR(50),
    DefiningSite VARCHAR(50),
    NumberOfSitesReporting INT,
    CreatedTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedTime DATETIME NULL,
    CountySK INT NOT NULL,
    SourceID INT NOT NULL,
    FOREIGN KEY (CountySK) REFERENCES COUNTY(CountySK)
);
