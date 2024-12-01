create database [AirQualityData_Stage]
go
USE [AirQualityData_Stage]
GO

CREATE TABLE GeographyData (
    county VARCHAR(255),
    county_ascii VARCHAR(255),
    county_full VARCHAR(255),
    county_fips CHAR(5),
    state_id CHAR(2),
    state_name VARCHAR(255),
    lat DECIMAL(9, 6),
    lng DECIMAL(9, 6),
    population INT
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
    LastUpdated DATETIME
);
