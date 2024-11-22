USE master;

-- Drop the database if it exists
IF DB_ID(N'Prison_DB') IS NOT NULL
BEGIN
    PRINT 'Dropping existing database: Prison_DB';
    ALTER DATABASE Prison_DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Prison_DB;
    PRINT 'Database dropped successfully';
END
ELSE
    PRINT 'Database does not exist';

GO

-- Create the database
CREATE DATABASE Prison_DB
ON PRIMARY 
(
    NAME = N'Prison_DB_data',
    FILENAME = N'C:\SQLData\Prison_DB.mdf',
    SIZE = 50MB,
    MAXSIZE = 1GB,
    FILEGROWTH = 10MB
)
LOG ON 
(
    NAME = N'Prison_DB_log',
    FILENAME = N'C:\SQLData\Prison_DB.ldf',
    SIZE = 10MB,
    MAXSIZE = 500MB,
    FILEGROWTH = 5MB
)
COLLATE Latin1_General_CI_AS;

GO

-- Switch to the Prison database
USE Prison_DB;
GO

PRINT 'Prison_DB is ready for use';
GO 