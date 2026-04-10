# Cybersecurity Incident Analysis & SQL Practice Project

## Project Overview

This project simulates a real-world **cybersecurity monitoring and incident analysis environment** using a structured relational database. It demonstrates how SQL can be used to model, manage, and analyze cybersecurity data across multiple interconnected entities such as organizations, users, systems, login logs, network events, and security incidents.

The project was built to strengthen practical SQL and database design skills by solving realistic security analytics problems commonly encountered in Security Operations Centers (SOC), cybersecurity teams, and data analyst roles.

---

## Business Problem / Objective

Organizations generate large volumes of security-related data every day, including:

* Login attempts
* Network traffic events
* Security incidents
* Affected systems
* User activity records

The objective of this project is to structure that data into a relational database and use SQL to answer operational and analytical cybersecurity questions such as:

* Which organizations experience the most incidents?
* Which users show suspicious login behavior?
* Which systems generate the most problematic network activity?
* Which industries have the highest infrastructure footprint?
* What systems were impacted during each security incident?

---

## Dataset / Database Structure

The database consists of **7 interconnected tables**:

### 1. Organizations

Stores organization-level metadata.

| Column   | Description                    |
| -------- | ------------------------------ |
| org_id   | Unique organization identifier |
| org_name | Organization name              |
| industry | Industry category              |
| country  | Organization country           |

---

### 2. Users

Contains employee/user information.

| Column  | Description                      |
| ------- | -------------------------------- |
| user_id | Unique user identifier           |
| org_id  | Associated organization          |
| role    | User role (Admin, Analyst, etc.) |

---

### 3. Systems

Represents devices/systems owned by organizations.

| Column      | Description                 |
| ----------- | --------------------------- |
| system_id   | Unique system identifier    |
| org_id      | Owning organization         |
| os_type     | Operating system            |
| criticality | System business criticality |

---

### 4. Security Incidents

Tracks cybersecurity incidents.

| Column          | Description             |
| --------------- | ----------------------- |
| incident_id     | Unique incident ID      |
| org_id          | Associated organization |
| incident_type   | Type of incident        |
| discovered_date | Date discovered         |
| severity        | Incident severity       |

---

### 5. Login Logs

Authentication attempt records.

| Column     | Description           |
| ---------- | --------------------- |
| login_id   | Unique login record   |
| user_id    | User attempting login |
| login_time | Login timestamp       |
| ip_address | Source IP             |
| status     | Success / Failed      |

---

### 6. Network Events

Stores network/system event logs.

| Column     | Description           |
| ---------- | --------------------- |
| event_id   | Unique event ID       |
| system_id  | Associated system     |
| event_type | Type of network event |
| timestamp  | Event timestamp       |
| severity   | Event severity        |

---

### 7. Incident Systems

Junction table connecting incidents to impacted systems.

| Column      | Description               |
| ----------- | ------------------------- |
| incident_id | Incident reference        |
| system_id   | Impacted system reference |

---

## Database Engineering & Schema Design

To transform the raw CSV files into a production-style relational database, the following engineering steps were performed:

### Data Type Standardization

* Converted IDs to `VARCHAR`
* Converted date/time fields to `DATE`
* Standardized text columns using optimal `VARCHAR` lengths
* Configured IP fields to support IPv4/IPv6 (`VARCHAR(45)`)

### Constraint Implementation

* Added **Primary Keys** to all core tables
* Added **Composite Primary Key** to junction table
* Added **Foreign Keys** to enforce referential integrity

### Relationship Modeling

* One-to-Many Relationships
* Many-to-Many Relationships
* Junction Table Design

---

## SQL Analysis Performed

### Beginner Level Queries

* Filtering organizations by country and industry
* Counting critical incidents
* Finding failed login attempts after a date
* Listing unique operating systems

### Intermediate Level Queries

* Joining users with organizations
* Aggregating systems by industry
* Analyzing network events on high-criticality systems
* Detecting users with most failed logins

### Advanced Level Queries

* Top organizations by incident volume
* Users in breached organizations
* Failed admin login IP analysis
* Latest incident per organization using window functions
* Previous failed login using `LAG()`
* Ranking top problematic systems by industry

---

## Advanced SQL Concepts Demonstrated

This project showcases strong proficiency in:

* `SELECT`, `WHERE`, `DISTINCT`
* `GROUP BY`, `HAVING`
* Aggregate Functions
* `INNER JOIN`, Multi-Table Joins
* Subqueries
* Common Table Expressions (`CTEs`)
* Window Functions:

  * `ROW_NUMBER()`
  * `LAG()`
  * `DENSE_RANK()`
* Ranking / Top-N Analysis
* Relational Schema Design
* Referential Integrity Management

---

## Key Analytical Use Cases Solved

### Threat Detection

* Detect suspicious repeated failed logins
* Identify failed admin login attempts

### Incident Analysis

* Track incidents by organization
* Map incidents to impacted systems

### Infrastructure Monitoring

* Rank systems generating highest network events
* Analyze high-criticality systems

### Organizational Risk Analysis

* Compare incident trends across industries
* Identify top-risk organizations

---

## Tools & Technologies Used

* **SQL / MySQL**
* **CSV Datasets**
* **Git / GitHub**
* **Relational Database Modeling**

---

## Project Structure

```bash
Cybersecurity-SQL-Project/
│
├── datasets/
│   ├── organizations.csv
│   ├── users.csv
│   ├── systems.csv
│   ├── security_incidents.csv
│   ├── login_logs.csv
│   ├── network_events.csv
│   └── incident_systems.csv
│
├── schema_design.sql
├── sql_queries.sql
├── README.md
```

---

## Project Outcome

This project demonstrates the ability to:

* Design normalized relational databases
* Build production-style SQL schemas
* Solve real-world analytical business/security problems
* Perform advanced SQL analysis using joins, CTEs, and window functions
* Translate raw datasets into actionable insights

---

## Ideal For Showcasing Skills In

* Data Analyst Portfolio
* SQL Developer Portfolio
* Cybersecurity Analyst Portfolio
* SOC Analyst / Security Operations Roles
* Database Analyst Roles

---

## Author

**Soham Badgujar**
Aspiring Data Analyst / Cybersecurity Analyst
