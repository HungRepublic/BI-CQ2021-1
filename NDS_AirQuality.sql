USE StageDB
GO

CREATE TABLE USCounties_Jade_Stage (
	county VARCHAR(255),
    county_ascii VARCHAR(255),
    county_full VARCHAR(255),
    county_fips VARCHAR(255) PRIMARY KEY,
    state_id CHAR(2),
    state_name VARCHAR(255),
    lat DECIMAL(8, 5),
    lng DECIMAL(8, 5),
    population INT,
	LSET DATETIME DEFAULT GETDATE(),
	CET DATETIME DEFAULT GETDATE()
)

CREATE TABLE AirQualityData_Jade_Stage_2021 (
    StateName VARCHAR(100),
    CountyName VARCHAR(100),
    StateCode INT,
    CountyCode INT,
    Date DATE,
    AQI INT,
    Category VARCHAR(50),
    DefiningParameter VARCHAR(50),
    DefiningSite VARCHAR(20),
    NumberOfSitesReporting INT,
    Created DATETIME DEFAULT GETDATE(),
    LastUpdated DATETIME
);

CREATE TABLE AirQualityData_Jade_Stage_2022 (
    StateName VARCHAR(100),
    CountyName VARCHAR(100),
    StateCode INT,
    CountyCode INT,
    Date DATE,
    AQI INT,
    Category VARCHAR(50),
    DefiningParameter VARCHAR(50),
    DefiningSite VARCHAR(20),
    NumberOfSitesReporting INT,
    Created DATETIME DEFAULT GETDATE(),
    LastUpdated DATETIME
);

CREATE TABLE AirQualityData_Jade_Stage_2023 (
    StateName VARCHAR(100),
    CountyName VARCHAR(100),
    StateCode INT,
    CountyCode INT,
    Date DATE,
    AQI INT,
    Category VARCHAR(50),
    DefiningParameter VARCHAR(50),
    DefiningSite VARCHAR(20),
    NumberOfSitesReporting INT,
    Created DATETIME DEFAULT GETDATE(),
    LastUpdated DATETIME
);