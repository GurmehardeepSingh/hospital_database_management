-- Speed up patient lookups by Insurance ID
CREATE INDEX idx_patient_insurance ON patients(insurance_id);

-- Speed up appointment searches by Date (very common in hospital front desks)
CREATE INDEX idx_appointment_date ON appointments(appointment_datetime);

-- Speed up doctor lookups by Specialization
CREATE INDEX idx_doctor_specialty ON doctors(specialization);

EXPLAIN ANALYZE
select * from appointments where appointment_datetime < '2026-08-01'