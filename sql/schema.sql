CREATE DATABASE IF NOT EXISTS hms_db;
USE hms_db;

-- 1. Patients Table: Stores core identity and medical history
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    insurance_id VARCHAR(50) UNIQUE NOT NULL, -- Unique constraint for indexing
    contact_number VARCHAR(15),
    emergency_contact VARCHAR(15),
    medical_history TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Doctors Table: Managing staff records
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(50),
    license_number VARCHAR(50) UNIQUE NOT NULL,
    years_experience INT,
    is_active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

-- 3. Appointments Table: This will be your "High Traffic" table
-- We use Foreign Keys to ensure 'Referential Integrity'
CREATE TABLE appointments (
    app_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_datetime DATETIME NOT NULL,
    reason_for_visit VARCHAR(255),
    status ENUM('Scheduled', 'Completed', 'Cancelled', 'No-Show') DEFAULT 'Scheduled',
    notes TEXT,
    CONSTRAINT fk_patient FOREIGN KEY (patient_id) 
        REFERENCES patients(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) 
        REFERENCES doctors(doctor_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 4. Audit Log: Essential for DBA Security compliance
CREATE TABLE system_audit_log (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50),
    record_id INT,
    action_type ENUM('INSERT', 'UPDATE', 'DELETE'),
    changed_by VARCHAR(50),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_value JSON,
    new_value JSON
)