-- Create Schemas
CREATE SCHEMA InmateManagement;
GO
CREATE SCHEMA CrimeManagement;
GO
CREATE SCHEMA HealthManagement;
GO
CREATE SCHEMA ProgramManagement;
GO

-- InmateManagement.Inmates Table
CREATE TABLE InmateManagement.Inmates (
    InmateID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Age INT,
    Gender NVARCHAR(50) CHECK (Gender IN ('M', 'F')),
    City NVARCHAR(50),
    State NVARCHAR(50),
    AdmissionDate DATE NOT NULL,
    FacilityID INT NOT NULL,
    Ethnicity NVARCHAR(50)
);

-- CrimeManagement.Crimes Table
CREATE TABLE CrimeManagement.Crimes (
    CrimeID INT PRIMARY KEY IDENTITY(1,1),
    CrimeDescription NVARCHAR(100) NOT NULL,
    CrimeType NVARCHAR(50) NOT NULL,
    Severity NVARCHAR(50) CHECK (Severity IN ('Low', 'Medium', 'High')),  -- Severity of the crime
    DateReported DATE NOT NULL            -- Date when the crime was reported
);

-- FacilityManagement.Facilities Table
CREATE TABLE InmateManagement.Facilities (
    FacilityID INT PRIMARY KEY,
    FacilityName NVARCHAR(50),
    Location NVARCHAR(50),
    Capacity INT
);

-- InmateManagement.Sentences Table
CREATE TABLE InmateManagement.Sentences (
    SentenceID INT PRIMARY KEY IDENTITY(1,1),
    InmateID INT NOT NULL,
    CrimeID INT NOT NULL,
    SentenceLength INT NOT NULL,  -- Length in months
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL
);

-- ProgramManagement.Programs Table
CREATE TABLE ProgramManagement.Programs (
    ProgramID INT PRIMARY KEY IDENTITY(1,1),
    ProgramName NVARCHAR(50) NOT NULL,
    ProgramDescription NVARCHAR(100),
    StartDate DATE NOT NULL,
    EndDate DATE
);

-- InmateManagement.Visitation Table
CREATE TABLE InmateManagement.Visitation (
    VisitID INT PRIMARY KEY IDENTITY(1,1),
    InmateID INT NOT NULL,
    VisitorName NVARCHAR(50) NOT NULL,
    VisitDate DATETIME NOT NULL,
    VisitDuration INT NOT NULL  -- Duration in minutes
);

-- ProgramManagement.Participation Table
CREATE TABLE ProgramManagement.Participation (
    ParticipationID INT PRIMARY KEY IDENTITY(1,1),
    InmateID INT NOT NULL,
    ProgramID INT NOT NULL,
    ParticipationDate DATE NOT NULL,
    Status NVARCHAR(50) CHECK (Status IN ('Active', 'Completed', 'Dropped'))
);

-- InmateManagement.HealthRecords Table
CREATE TABLE HealthManagement.HealthRecords (
    HealthRecordID INT PRIMARY KEY IDENTITY(1,1),
    InmateID INT NOT NULL,
    RecordDate DATE NOT NULL,
	ConditionID INT NOT NULL
);

-- InmateManagement.Conditions Table
CREATE TABLE HealthManagement.Conditions (
    ConditionID INT PRIMARY KEY IDENTITY(1,1),
    Condition NVARCHAR(50) NOT NULL,
    Treatment NVARCHAR(100)
);

-- InmateManagement.DisciplinaryActions Table
CREATE TABLE InmateManagement.DisciplinaryActions (
    DisciplinaryID INT PRIMARY KEY IDENTITY(1,1),
    InmateID INT NOT NULL,
    ActionDescription NVARCHAR(100) NOT NULL,
    ActionDate DATE NOT NULL,
    Consequence NVARCHAR(100)
);

-- InmateManagement.ReleaseRecords Table
CREATE TABLE InmateManagement.ReleaseRecords (
    ReleaseID INT PRIMARY KEY IDENTITY(1,1),
    InmateID INT,
    ReleaseDate DATE NOT NULL,
    Reason NVARCHAR(50)
);