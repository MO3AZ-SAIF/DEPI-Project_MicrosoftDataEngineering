USE Prison_DB;
GO

-- Adding Foreign Key Constraints

-- InmateManagement.Sentences
ALTER TABLE InmateManagement.Sentences
ADD CONSTRAINT FK_Inmate FOREIGN KEY (InmateID) REFERENCES InmateManagement.Inmates(InmateID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE InmateManagement.Sentences
ADD CONSTRAINT FK_Crime FOREIGN KEY (CrimeID) REFERENCES CrimeManagement.Crimes(CrimeID) ON DELETE CASCADE ON UPDATE CASCADE;

-- InmateManagement.Visitation
ALTER TABLE InmateManagement.Visitation
ADD CONSTRAINT FK_VisitInmate FOREIGN KEY (InmateID) REFERENCES InmateManagement.Inmates(InmateID) ON DELETE CASCADE ON UPDATE CASCADE;

-- ProgramManagement.Participation
ALTER TABLE ProgramManagement.Participation
ADD CONSTRAINT FK_Program FOREIGN KEY (ProgramID) REFERENCES ProgramManagement.Programs(ProgramID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ProgramManagement.Participation
ADD CONSTRAINT FK_Participant FOREIGN KEY (InmateID) REFERENCES InmateManagement.Inmates(InmateID) ON DELETE CASCADE ON UPDATE CASCADE;

-- HealthManagement.HealthRecords
ALTER TABLE HealthManagement.HealthRecords
ADD CONSTRAINT FK_HealthInmate FOREIGN KEY (InmateID) REFERENCES InmateManagement.Inmates(InmateID) ON DELETE CASCADE ON UPDATE CASCADE;

-- HealthManagement.Conditions
ALTER TABLE HealthManagement.HealthRecords
ADD CONSTRAINT FK_HealthCondition FOREIGN KEY (ConditionID) REFERENCES HealthManagement.Conditions (ConditionID) ON DELETE CASCADE ON UPDATE CASCADE;

-- InmateManagement.DisciplinaryActions
ALTER TABLE InmateManagement.DisciplinaryActions
ADD CONSTRAINT FK_DisciplinaryInmate FOREIGN KEY (InmateID) REFERENCES InmateManagement.Inmates(InmateID) ON DELETE CASCADE ON UPDATE CASCADE;

-- InmateManagement.Inmates
ALTER TABLE InmateManagement.Inmates
ADD CONSTRAINT FK_InmateFacility FOREIGN KEY (FacilityID) REFERENCES InmateManagement.Facilities(FacilityID) ON DELETE CASCADE ON UPDATE CASCADE;

-- InmateManagement.ReleaseRecords
ALTER TABLE InmateManagement.ReleaseRecords
ADD CONSTRAINT FK_ReleaseInmate FOREIGN KEY (InmateID) REFERENCES InmateManagement.Inmates(InmateID) ON DELETE CASCADE ON UPDATE CASCADE;