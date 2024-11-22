USE Prison_DB;
GO

UPDATE CrimeManagement.Crimes SET DateReported = '2025-06-01' WHERE DateReported >= '2026-01-01'

UPDATE InmateManagement.Inmates SET AdmissionDate = '2025-06-01' WHERE AdmissionDate >= '2026-01-01'

UPDATE InmateManagement.ReleaseRecords SET ReleaseDate = '2025-06-01' WHERE ReleaseDate >= '2026-01-01'

UPDATE InmateManagement.Sentences SET StartDate = '2025-06-01' WHERE StartDate >= '2026-01-01'

UPDATE InmateManagement.Sentences SET EndDate = '2025-06-01' WHERE EndDate >= '2026-01-01'

UPDATE InmateManagement.Visitation SET VisitDate = '2025-06-01' WHERE VisitDate >= '2026-01-01'

UPDATE InmateManagement.Inmates SET AdmissionDate = '2025-06-01' WHERE AdmissionDate >= '2026-01-01'

UPDATE InmateManagement.DisciplinaryActions SET ActionDate = '2025-06-01' WHERE ActionDate >= '2026-01-01'

UPDATE ProgramManagement.Programs SET StartDate = '2025-06-01' WHERE StartDate >= '2026-01-01'

UPDATE ProgramManagement.Programs SET EndDate = '2025-06-01' WHERE EndDate >= '2026-01-01'

UPDATE ProgramManagement.Participation SET ParticipationDate = '2025-06-01' WHERE ParticipationDate >= '2026-01-01'

UPDATE HealthManagement.HealthRecords SET RecordDate = '2025-06-01' WHERE RecordDate >= '2026-01-01'


