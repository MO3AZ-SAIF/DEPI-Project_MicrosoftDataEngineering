CREATE PROCEDURE CreateDateDimension
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    -- Drop DimDate table if it exists
    IF OBJECT_ID('DimDate', 'U') IS NOT NULL
        DROP TABLE DimDate;

    -- Create Date Dimension Table
    CREATE TABLE DimDate (
        DateKey INT,
        FullDate DATE,
        Year INT,
        Month INT,
        Day INT,
        Weekday NVARCHAR(10),
        IsWeekend BIT
    );

    DECLARE @CurrentDate DATE = @StartDate;

    -- Insert dates within the specified range using a WHILE loop
    WHILE @CurrentDate <= @EndDate
    BEGIN
        INSERT INTO DimDate (DateKey, FullDate, Year, Month, Day, Weekday, IsWeekend)
        SELECT 
            CAST(CONVERT(VARCHAR(10), @CurrentDate, 112) AS INT) AS DateKey,
            @CurrentDate AS FullDate,
            YEAR(@CurrentDate) AS Year,
            MONTH(@CurrentDate) AS Month,
            DAY(@CurrentDate) AS Day,
            DATENAME(WEEKDAY, @CurrentDate) AS Weekday,
            CASE WHEN DATENAME(WEEKDAY, @CurrentDate) IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END AS IsWeekend;
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END;
END;
