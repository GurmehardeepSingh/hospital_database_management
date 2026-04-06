DELIMITER //

CREATE TRIGGER after_patient_history_update
AFTER UPDATE ON patients
FOR EACH ROW
BEGIN
    IF OLD.medical_history != NEW.medical_history THEN
        INSERT INTO system_audit_log (table_name, record_id, action_type, changed_by)
        VALUES ('patients', OLD.patient_id, 'UPDATE', USER());
    END IF;
END //

DELIMITER ;