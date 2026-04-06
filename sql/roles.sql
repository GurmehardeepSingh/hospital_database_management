-- 1. Create the Roles
CREATE ROLE IF NOT EXISTS 'hms_admin', 'hms_doctor', 'hms_receptionist';

-- 2. Define Permissions for 'hms_receptionist' (Limited Access)
-- Can view patients and manage appointments, but CANNOT see medical_history or audit logs.
GRANT SELECT, INSERT, UPDATE ON hms_db.appointments TO 'hms_receptionist';
GRANT SELECT (patient_id, full_name, contact_number, insurance_id) ON hms_db.patients TO 'hms_receptionist';

-- 3. Define Permissions for 'hms_doctor' (Clinical Access)
-- Can view/update patient history and see their own appointments.
GRANT SELECT, UPDATE (medical_history) ON hms_db.patients TO 'hms_doctor';
GRANT SELECT ON hms_db.appointments TO 'hms_doctor';
GRANT SELECT ON hms_db.doctors TO 'hms_doctor';

-- 4. Define Permissions for 'hms_admin' (Full Control)
GRANT ALL PRIVILEGES ON hms_db.* TO 'hms_admin';


-- Create a Receptionist User
CREATE USER 'reception'@'localhost' IDENTIFIED BY 'Reception123';
GRANT 'hms_receptionist' TO 'reception'@'localhost';

-- Create a Doctor User
CREATE USER 'doctor'@'localhost' IDENTIFIED BY 'Doctor123';
GRANT 'hms_doctor' TO 'doctor'@'localhost';

-- IMPORTANT: Set the roles to be active by default when they log in
SET DEFAULT ROLE 'hms_receptionist' TO 'reception'@'localhost';
SET DEFAULT ROLE 'hms_doctor' TO 'doctor'@'localhost';