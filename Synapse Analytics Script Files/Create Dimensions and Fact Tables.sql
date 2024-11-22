EXEC CreateDateDimension @StartDate = '2024-01-01', @EndDate = '2026-01-01';

CREATE TABLE DimInmates 
WITH (
    DISTRIBUTION = HASH(InmateKey),
    CLUSTERED COLUMNSTORE INDEX
) AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY InmateID) AS InmateKey,
    InmateID,
    FirstName,
    LastName,
    Age,
    Gender,
    City,
    State,
    Ethnicity
FROM stgInmates;

CREATE TABLE DimFacilities 
WITH (
    DISTRIBUTION = HASH(FacilityKey),
    CLUSTERED COLUMNSTORE INDEX
) AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY FacilityID) AS FacilityKey,
    FacilityID,
    FacilityName,
    Location,
    Capacity
FROM stgFacilities;

CREATE TABLE DimCrimes 
WITH (
    DISTRIBUTION = HASH(CrimeKey),
    CLUSTERED COLUMNSTORE INDEX
) AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY CrimeID) AS CrimeKey,
    CrimeID,
    CrimeDescription,
    CrimeType,
    Severity
FROM stgCrimes;

CREATE TABLE DimPrograms 
WITH (
    DISTRIBUTION = HASH(ProgramKey),
    CLUSTERED COLUMNSTORE INDEX
) AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY p.ProgramID) AS ProgramKey,
    p.ProgramID,
    p.ProgramName,
    p.ProgramDescription,
    p.StartDate,
    p.EndDate,
    pa.ParticipationDate,
    pa.Status
FROM stgPrograms p
LEFT JOIN stgParticipation pa ON p.ProgramID = pa.ProgramID;

CREATE TABLE DimConditions 
WITH (
    DISTRIBUTION = HASH(ConditionKey),
    CLUSTERED COLUMNSTORE INDEX
) AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY ConditionID) AS ConditionKey,
    ConditionID,
    Condition,
    Treatment
FROM stgConditions;

-- Fact table for tracking inmate-related events
CREATE TABLE FactInmateEvents 
WITH (
    DISTRIBUTION = HASH(EventKey),
    CLUSTERED COLUMNSTORE INDEX
) AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY i.InmateKey, d.DateKey) AS EventKey, 
    i.InmateKey, 
    f.FacilityKey,  
    c.CrimeKey, 
    p.ProgramKey,  
    cond.ConditionKey, 
    d.DateKey,
    p.StartDate AS ProgramStartDate,
    p.EndDate AS ProgramEndDate,
    pa.ParticipationDate AS EventDate,
    pa.Status AS EventStatus
FROM DimInmates i
JOIN DimFacilities f ON i.City = f.Location
LEFT JOIN DimCrimes c ON i.InmateID = c.CrimeID 
LEFT JOIN DimPrograms p ON i.InmateID = p.ProgramID
LEFT JOIN stgParticipation pa ON pa.ProgramID = p.ProgramID
LEFT JOIN DimConditions cond ON i.InmateID = cond.ConditionID
JOIN DimDate d ON pa.ParticipationDate = d.FullDate;