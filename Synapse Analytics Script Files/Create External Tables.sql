CREATE EXTERNAL DATA SOURCE StagedFiles
WITH (
    LOCATION = 'https://prisonproject.dfs.core.windows.net/goldlayer'
);

CREATE EXTERNAL FILE FORMAT ParquetFormat
WITH (
    FORMAT_TYPE = PARQUET
);

-- InmateManagement.Inmates External Table
CREATE EXTERNAL TABLE stgInmates (
    InmateID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Age INT,
    Gender NVARCHAR(50),
    City NVARCHAR(50),
    State NVARCHAR(50),
    AdmissionDate DATE,
    FacilityID INT,
    Ethnicity NVARCHAR(50)
)
WITH (
    LOCATION = '/InmateManagement/Inmates/*.parquet',
    DATA_SOURCE = StagedFiles,
    FILE_FORMAT = ParquetFormat
);

-- CrimeManagement.Crimes External Table
CREATE EXTERNAL TABLE stgCrimes (
    CrimeID INT,
    CrimeDescription NVARCHAR(100),
    CrimeType NVARCHAR(50),
    Severity NVARCHAR(50),
    DateReported DATE
)
WITH (
    LOCATION = '/CrimeManagement/Crimes/*.parquet',
    DATA_SOURCE = StagedFiles,
    FILE_FORMAT = ParquetFormat
);

-- InmateManagement.Facilities External Table
CREATE EXTERNAL TABLE stgFacilities (
    FacilityID INT,
    FacilityName NVARCHAR(50),
    Location NVARCHAR(50),
    Capacity INT
)
WITH (
    LOCATION = '/InmateManagement/Facilities/*.parquet',
    DATA_SOURCE = StagedFiles,
    FILE_FORMAT = ParquetFormat
);

-- InmateManagement.Sentences External Table
CREATE EXTERNAL TABLE stgSentences (
    SentenceID INT,
    InmateID INT,
    CrimeID INT,
    SentenceLength INT,
    StartDate DATE,
    EndDate DATE
)
WITH (
    LOCATION = '/InmateManagement/Sentences/*.parquet',
    DATA_SOURCE = StagedFiles,
    FILE_FORMAT = ParquetFormat
);

-- ProgramManagement.Programs External Table
CREATE EXTERNAL TABLE stgPrograms (
    ProgramID INT,
    ProgramName NVARCHAR(50),
    ProgramDescription NVARCHAR(100),
    StartDate DATE,
    EndDate DATE
)
WITH (
    LOCATION = '/ProgramManagement/Programs/*.parquet',
    DATA_SOURCE = StagedFiles,
    FILE_FORMAT = ParquetFormat
);

-- InmateManagement.Visitation External Table
CREATE EXTERNAL TABLE stgVisitation (
    VisitID INT,
    InmateID INT,
    VisitorName NVARCHAR(50),
    VisitDate DATETIME,
    VisitDuration INT
)
WITH (
    LOCATION = '/InmateManagement/Visitation/*.parquet',
    DATA_SOURCE = StagedFiles,
    FILE_FORMAT = ParquetFormat
);

-- ProgramManagement.Participation External Table
CREATE EXTERNAL TABLE stgParticipation (
    ParticipationID INT,
    InmateID INT,
    ProgramID INT,
    ParticipationDate DATE,
    Status NVARCHAR(50)
)
WITH (
    LOCATION = '/ProgramManagement/Participation/*.parquet',
    DATA_SOURCE = StagedFiles,
    FILE_FORMAT = ParquetFormat
);

-- HealthManagement.HealthRecords External Table
CREATE EXTERNAL TABLE stgHealthRecords (
    HealthRecordID INT,
    InmateID INT,
    RecordDate DATE,
    ConditionID INT
)
WITH (
    LOCATION = '/HealthManagement/HealthRecords/*.parquet',
    DATA_SOURCE = StagedFiles,
    FILE_FORMAT = ParquetFormat
);

-- HealthManagement.Conditions External Table
CREATE EXTERNAL TABLE stgConditions (
    ConditionID INT,
    Condition NVARCHAR(50),
    Treatment NVARCHAR(100)
)
WITH (
    LOCATION = '/HealthManagement/Conditions/*.parquet',
    DATA_SOURCE = StagedFiles,
    FILE_FORMAT = ParquetFormat
);

-- InmateManagement.DisciplinaryActions External Table
CREATE EXTERNAL TABLE stgDisciplinaryActions (
    DisciplinaryID INT,
    InmateID INT,
    ActionDescription NVARCHAR(100),
    ActionDate DATE,
    Consequence NVARCHAR(100)
)
WITH (
    LOCATION = '/InmateManagement/DisciplinaryActions/*.parquet',
    DATA_SOURCE = StagedFiles,
    FILE_FORMAT = ParquetFormat
);

-- InmateManagement.ReleaseRecords External Table
CREATE EXTERNAL TABLE stgReleaseRecords (
    ReleaseID INT,
    InmateID INT,
    ReleaseDate DATE,
    Reason NVARCHAR(50)
)
WITH (
    LOCATION = '/InmateManagement/ReleaseRecords/*.parquet',
    DATA_SOURCE = StagedFiles,
    FILE_FORMAT = ParquetFormat
);
