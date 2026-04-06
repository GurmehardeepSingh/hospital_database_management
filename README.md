# Hospital Database Management & Administration (DBA) Project

A robust, enterprise-grade MySQL database system designed for high-availability healthcare environments. This project demonstrates advanced DBA skills including **Schema Optimization**, **Role-Based Access Control (RBAC)**, **Automated Cloud Disaster Recovery**, and **Performance Tuning**.

##  Key Features
* **Scalable Schema:** Normalized relational structure handling Patients, Doctors, and Appointments.
* **Massive Data Seeding:** 10,000+ records generated using SQL Cartesian products for stress testing.
* **Advanced Security (RBAC):** Granular permissions for 'Doctors' vs 'Receptionists' to ensure PII (Patient Identifiable Information) protection.
* **Automated Audit Logging:** Triggers to track sensitive data changes in real-time.
* **Cloud Disaster Recovery:** Automated Bash scripts for scheduled backups to **AWS S3** and one-click recovery.

---

## Project Structure
```text
Hospital-DBA-Core/
├── sql/
│   ├── 01_schema.sql           # Table structures & Constraints
│   ├── 02_rbac_roles.sql       # User creation & Role permissions
│   ├── 03_audit_triggers.sql   # Data change tracking logic
│   └── 04_data_seed.sql        # 10k+ row generation script
├── scripts/
│   ├── backup.sh               # Daily mysqldump + AWS S3 upload
│   └── recovery.sh             # Point-in-time restore from Cloud
├── docs/
│   ├── er_diagram.png          # Visual Database Schema
│   └── performance_report.md   # Indexing & Query optimization results
└── README.md
