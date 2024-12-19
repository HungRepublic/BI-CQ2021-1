-- Tạo cơ sở dữ liệu
CREATE DATABASE AirQualityData_DDS;
GO

USE AirQualityData_DDS;
GO

CREATE TABLE DateDimension (
    DateSK INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	DATE DATE,
    Day INT,
    Month INT,
    Quarter INT,
    Year INT,
    DayLightSaving INT,
    CreatedDate DATETIME,
    UpdatedDate DATETIME,
    SourceID INT
);
GO

-- Tạo bảng DefiningParamDim
CREATE TABLE DefiningParamDim (
    DefParamSK INT PRIMARY KEY,
    ParaName VARCHAR(100),
    CreatedTime DATETIME,
    UpdatedTime DATETIME,
    SourceID INT
);
GO

-- Tạo bảng StateDimension
CREATE TABLE StateDimension (
    StateSK INT PRIMARY KEY,
    StateName VARCHAR(255),
    StateID VARCHAR(2),
    CreatedTime DATETIME,
    UpdatedTime DATETIME,
    SourceID INT
);
GO

-- Tạo bảng CountyDimension
CREATE TABLE CountyDimension (
    CountySK INT PRIMARY KEY,
    CountyCode INT,
    CountyName VARCHAR(255),
    CountyNameAscii VARCHAR(255),
    CountyFull VARCHAR(255),
    CountyFips INT,
    Latitude DECIMAL(9, 6),
    Longitude DECIMAL(9, 6),
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
    CategorySK INT PRIMARY KEY,
    LevelsOfConcern VARCHAR(100),
    Description VARCHAR(200),
    MinValuesOfIndex INT,
    MaxValuesOfIndex INT,
    DailyAQIColor VARCHAR(10),
    CreatedTime DATETIME,
    UpdatedTime DATETIME,
    SourceID INT
);
GO

-- Tạo bảng AQIFactTable
CREATE TABLE AQIFactTable (
    AQISK INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    DateSK INT,
    CountySK INT,
    CategorySK INT,
    DefParamSK INT,
    AQI INT,
    CreatedDate DATETIME,
    UpdatedDate DATETIME,
    SourceID INT,
    CONSTRAINT FK_AQIFactTable_DateDimension FOREIGN KEY (DateSK)
        REFERENCES DateDimension(DateSK),
    CONSTRAINT FK_AQIFactTable_CountyDimension FOREIGN KEY (CountySK)
        REFERENCES CountyDimension(CountySK),
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
    -- Insert dữ liệu vào DateDimension
    INSERT INTO DateDimension (DATE, Day, Month, Quarter, Year, DayLightSaving, CreatedDate, UpdatedDate, SourceID)
    SELECT 
        Date AS DATE, -- Thêm giá trị Date trực tiếp vào cột DATE
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
            -- Áp dụng quy tắc DayLightSaving cho từng ngày
            WHEN Date BETWEEN '2023-03-12' AND '2023-11-05' THEN 1
            ELSE 0
        END AS DayLightSaving,
        GETDATE() AS CreatedDate, -- Thêm giá trị thời gian tạo
        GETDATE() AS UpdatedDate, -- Thêm giá trị thời gian cập nhật
        NULL AS SourceID          -- Giữ SourceID NULL nếu không có giá trị tương ứng
    FROM 
        (SELECT DISTINCT Date FROM AirQualityData_NDS.dbo.AQI) AQI
    ORDER BY
        Date ASC;
END;
GO


-- Gọi thủ tục và kiểm tra dữ liệu
EXEC PopulateDateDimension;

Select * from DateDimension
Select * from CountyDimension;
Select * from AQIFactTable WHERE AQI = 500;
