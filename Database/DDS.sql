-- Tạo cơ sở dữ liệu
CREATE DATABASE AirQualityData_DDS;
GO

USE AirQualityData_DDS;
GO

-- Tạo bảng DateDimension
CREATE TABLE DateDimension (
    DateSK INT NOT NULL IDENTITY(1, 1),
    Day INT,
    Month INT,
    Quarter INT,
    Year INT,
    DayLightSaving INT,
    CreatedDate DATETIME,
    UpdatedDate DATETIME,
    SourceID INT,
    CONSTRAINT PK_DateDimension PRIMARY KEY (DateSK)
);
GO

-- Tạo bảng DefiningParamDim
CREATE TABLE DefiningParamDim (
    DefParamSK INT,
    ParaName VARCHAR(100),
    CreatedTime DATETIME,
    UpdatedTime DATETIME,
    SourceID INT,
    CONSTRAINT PK_DefiningParamDim PRIMARY KEY (DefParamSK)
);
GO

-- Tạo bảng StateDimension
CREATE TABLE StateDimension (
    StateSK INT,
    StateName VARCHAR(255),
    StateID VARCHAR(10),
    CreatedTime DATETIME,
    UpdatedTime DATETIME,
    SourceID INT,
    CONSTRAINT PK_StateDimension PRIMARY KEY (StateSK)
);
GO

-- Tạo bảng CountyDimension
CREATE TABLE CountyDimension (
    CountySK INT,
    CountyCode CHAR(5),
    CountyName VARCHAR(255),
    CountyNameAscii VARCHAR(255),
    CountyFull VARCHAR(255),
    CountyFips CHAR(5),
    Latitude DECIMAL(9, 6),
	Longtitude DECIMAL(9, 6),
    Population INT,
    CreatedTime DATETIME,
    UpdatedTime DATETIME,
    StateSK INT,
    SourceID INT,
    CONSTRAINT FK_CountyDimension_StateDimension FOREIGN KEY (StateSK)
    REFERENCES StateDimension(StateSK)
);
GO

-- Tạo bảng AQICategoryDim
CREATE TABLE AQICategoryDim (
    CategorySK INT,
    LevelsOfConcern VARCHAR(100),
    Description VARCHAR(200),
    MinValuesOfIndex INT,
    MaxValuesOfIndex INT,
    DailyAQIColor VARCHAR(10),
    CreatedTime DATETIME,
    UpdatedTime DATETIME,
    SourceID INT,
    CONSTRAINT PK_AQICategoryDim PRIMARY KEY (CategorySK)
);
GO

-- Tạo bảng AQIFactTable
CREATE TABLE AQIFactTable (
    AQISK INT NOT NULL IDENTITY(1, 1),
    DateSK INT,
    CountySK INT,
    CategorySK INT,
    DefParamSK INT,
    AQI INT,
    CreatedDate DATETIME,
    UpdatedDate DATETIME,
    SourceID INT,
    CONSTRAINT PK_AQIFactTable PRIMARY KEY (AQISK),
    CONSTRAINT FK_AQIFactTable_DateDimension FOREIGN KEY (DateSK)
    REFERENCES DateDimension(DateSK),
    CONSTRAINT FK_AQIFactTable_AQICategoryDim FOREIGN KEY (CategorySK)
    REFERENCES AQICategoryDim(CategorySK),
    CONSTRAINT FK_AQIFactTable_DefiningParamDim FOREIGN KEY (DefParamSK)
    REFERENCES DefiningParamDim(DefParamSK)
);
GO

-- Tạo thủ tục PopulateDateDimension
CREATE OR ALTER PROCEDURE PopulateDateDimension
AS
BEGIN
    INSERT INTO DateDimension (Day, Month, Quarter, Year, DayLightSaving)
    SELECT 
        DAY(Date) AS Day,
        MONTH(Date) AS Month,
        CASE
            WHEN MONTH(Date) IN (1, 2, 3) THEN 1
            WHEN MONTH(Date) IN (4, 5, 6) THEN 2
            WHEN MONTH(Date) IN (7, 8, 9) THEN 3
            ELSE 4
        END AS Quarter,
        YEAR(Date) AS Year,
        CASE
            WHEN Date BETWEEN '2023-03-12' AND '2023-11-05' THEN 1
            ELSE 0
        END AS DayLightSaving
    FROM 
        (SELECT DISTINCT Date FROM AirQualityData_NDS.dbo.AQI) AQI
    ORDER BY
        Date ASC;
END;
GO

-- Gọi thủ tục và kiểm tra dữ liệu
EXEC PopulateDateDimension;

Select * from StateDimension
Select * from CountyDimension
