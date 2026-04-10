
-- 1. Organizations
ALTER TABLE organizations MODIFY org_id VARCHAR(50);
ALTER TABLE organizations MODIFY industry VARCHAR(100), MODIFY country VARCHAR(100);

-- 2. Users
ALTER TABLE users MODIFY user_id VARCHAR(50);
ALTER TABLE users MODIFY org_id VARCHAR(50);
ALTER TABLE users MODIFY role VARCHAR(50);

-- 3. Systems
ALTER TABLE systems MODIFY system_id VARCHAR(50);
ALTER TABLE systems MODIFY org_id VARCHAR(50);
ALTER TABLE systems MODIFY os_type VARCHAR(50), MODIFY criticality VARCHAR(50);

-- 4. Security Incidents
ALTER TABLE security_incidents MODIFY incident_id VARCHAR(50);
ALTER TABLE security_incidents MODIFY org_id VARCHAR(50);
ALTER TABLE security_incidents MODIFY incident_type VARCHAR(100), MODIFY discovered_date DATE, MODIFY severity VARCHAR(50);

-- 5. Login Logs
ALTER TABLE login_logs MODIFY login_id VARCHAR(50);
ALTER TABLE login_logs MODIFY user_id VARCHAR(50);
ALTER TABLE login_logs MODIFY login_time DATE, MODIFY ip_address VARCHAR(45), MODIFY status VARCHAR(50);

-- 6. Network Events
ALTER TABLE network_events MODIFY event_id VARCHAR(50);
ALTER TABLE network_events MODIFY system_id VARCHAR(50);
ALTER TABLE network_events MODIFY event_type VARCHAR(100), MODIFY timestamp DATE, MODIFY severity VARCHAR(50);

-- 7. Incident Systems
ALTER TABLE incident_systems MODIFY incident_id VARCHAR(50);
ALTER TABLE incident_systems MODIFY system_id VARCHAR(50);

-- PHASE 2: ADD PRIMARY KEYS

ALTER TABLE organizations ADD PRIMARY KEY (org_id);
ALTER TABLE users ADD PRIMARY KEY (user_id);
ALTER TABLE systems ADD PRIMARY KEY (system_id);
ALTER TABLE security_incidents ADD PRIMARY KEY (incident_id);
ALTER TABLE login_logs ADD PRIMARY KEY (login_id);
ALTER TABLE network_events ADD PRIMARY KEY (event_id);
ALTER TABLE incident_systems ADD PRIMARY KEY (incident_id, system_id);

-- PHASE 3: ADD FOREIGN KEYS (THE CONNECTIONS)

-- Connect Users to Organizations
ALTER TABLE users 
ADD CONSTRAINT fk_user_org FOREIGN KEY (org_id) REFERENCES organizations(org_id);

-- Connect Systems to Organizations
ALTER TABLE systems 
ADD CONSTRAINT fk_system_org FOREIGN KEY (org_id) REFERENCES organizations(org_id);

-- Connect Security Incidents to Organizations
ALTER TABLE security_incidents 
ADD CONSTRAINT fk_incident_org FOREIGN KEY (org_id) REFERENCES organizations(org_id);

-- Connect Login Logs to Users
ALTER TABLE login_logs 
ADD CONSTRAINT fk_login_user FOREIGN KEY (user_id) REFERENCES users(user_id);

-- Connect Network Events to Systems
ALTER TABLE network_events 
ADD CONSTRAINT fk_event_system FOREIGN KEY (system_id) REFERENCES systems(system_id);

-- Connect Incident Systems to Security Incidents AND Systems
ALTER TABLE incident_systems 
ADD CONSTRAINT fk_junction_incident FOREIGN KEY (incident_id) REFERENCES security_incidents(incident_id);

ALTER TABLE incident_systems 
ADD CONSTRAINT fk_junction_system FOREIGN KEY (system_id) REFERENCES systems(system_id);
