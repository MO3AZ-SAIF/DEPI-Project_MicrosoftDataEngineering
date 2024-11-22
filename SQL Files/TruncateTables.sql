USE Prison_DB;
GO

ALTER TABLE InmateManagement.Sentences
DROP CONSTRAINT IF EXISTS FK_Inmate

ALTER TABLE InmateManagement.Sentences
DROP CONSTRAINT IF EXISTS FK_Crime

ALTER TABLE InmateManagement.Visitation
DROP CONSTRAINT IF EXISTS FK_VisitInmate

ALTER TABLE ProgramManagement.Participation
DROP CONSTRAINT IF EXISTS FK_Program

ALTER TABLE ProgramManagement.Participation
DROP CONSTRAINT IF EXISTS FK_Participant

ALTER TABLE HealthManagement.HealthRecords
DROP CONSTRAINT IF EXISTS FK_HealthInmate

ALTER TABLE HealthManagement.HealthRecords
DROP CONSTRAINT IF EXISTS FK_HealthCondition

ALTER TABLE InmateManagement.DisciplinaryActions
DROP CONSTRAINT IF EXISTS FK_DisciplinaryInmate

ALTER TABLE InmateManagement.Inmates
DROP CONSTRAINT IF EXISTS FK_InmateFacility

ALTER TABLE InmateManagement.ReleaseRecords
DROP CONSTRAINT IF EXISTS FK_ReleaseInmate

TRUNCATE TABLE InmateManagement.Visitation
TRUNCATE TABLE InmateManagement.DisciplinaryActions
TRUNCATE TABLE InmateManagement.ReleaseRecords
TRUNCATE TABLE ProgramManagement.Participation
TRUNCATE TABLE InmateManagement.Sentences
TRUNCATE TABLE HealthManagement.HealthRecords
TRUNCATE TABLE InmateManagement.Inmates
TRUNCATE TABLE ProgramManagement.Programs
TRUNCATE TABLE CrimeManagement.Crimes
TRUNCATE TABLE HealthManagement.Conditions
TRUNCATE TABLE InmateManagement.Facilities