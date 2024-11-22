USE Prison_DB;
GO

-- Procedure to insert participation data
IF OBJECT_ID('ProgramManagement.InsertParticipation', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE ProgramManagement.InsertParticipation;
END;
GO

-- Create the procedure to insert participation data
CREATE PROCEDURE ProgramManagement.InsertParticipation
    @InmateID INT,
    @ProgramID INT
AS
BEGIN
    -- Insert data into the table with the current date and 'Active' as the default status
    INSERT INTO ProgramManagement.Participation (InmateID, ProgramID, ParticipationDate, Status)
    VALUES (@InmateID, @ProgramID, GETDATE(), 'Active');
END;
GO



-- Procedure to insert inmate data
IF OBJECT_ID('InmateManagement.InsertInmate', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE InmateManagement.InsertInmate;
END;
GO

-- Create the procedure to insert inmate data
CREATE PROCEDURE InmateManagement.InsertInmate
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Age INT,
    @Gender NVARCHAR(50),
    @City NVARCHAR(50),
    @State NVARCHAR(50),
    @AdmissionDate DATE,
    @FacilityID INT,
    @Ethnicity NVARCHAR(50)
AS
BEGIN
    INSERT INTO InmateManagement.Inmates (FirstName, LastName, Age, Gender, City, State, AdmissionDate, FacilityID, Ethnicity)
    VALUES (@FirstName, @LastName, @Age, @Gender, @City, @State, @AdmissionDate, @FacilityID, @Ethnicity);
END;
GO


-- Procedure to insert disciplinary action data
IF OBJECT_ID('InmateManagement.InsertDisciplinaryAction', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE InmateManagement.InsertDisciplinaryAction;
END;
GO

CREATE PROCEDURE InmateManagement.InsertDisciplinaryAction
    @InmateID INT,
    @ActionDescription NVARCHAR(100),
    @Consequence NVARCHAR(100)
AS
BEGIN
    INSERT INTO InmateManagement.DisciplinaryActions (InmateID, ActionDescription, ActionDate, Consequence)
    VALUES (@InmateID, @ActionDescription, GETDATE(), @Consequence);
END;
GO


-- Procedure to insert release record data and update FacilityID
IF OBJECT_ID('InmateManagement.InsertReleaseRecord', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE InmateManagement.InsertReleaseRecord;
END;
GO

CREATE PROCEDURE InmateManagement.InsertReleaseRecord
    @InmateID INT,
    @Reason NVARCHAR(50)
AS
BEGIN
    INSERT INTO InmateManagement.ReleaseRecords (InmateID, ReleaseDate, Reason)
    VALUES (@InmateID, GETDATE(), @Reason);

    UPDATE InmateManagement.Inmates
    SET FacilityID = -1
    WHERE InmateID = @InmateID;
END;
GO



