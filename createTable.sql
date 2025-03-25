CREATE TABLE COMPANY (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE EMPLOYEE (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    role VARCHAR(100) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (company_id) REFERENCES COMPANY(id) ON DELETE CASCADE
);

CREATE TABLE INTERVIEW_FLOW (
    id SERIAL PRIMARY KEY,
    description TEXT
);

CREATE TABLE INTERVIEW_TYPE (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE INTERVIEW_STEP (
    id SERIAL PRIMARY KEY,
    interview_flow_id INT NOT NULL,
    interview_type_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    order_index INT NOT NULL,
    FOREIGN KEY (interview_flow_id) REFERENCES INTERVIEW_FLOW(id) ON DELETE CASCADE,
    FOREIGN KEY (interview_type_id) REFERENCES INTERVIEW_TYPE(id) ON DELETE CASCADE
);

CREATE TABLE POSITION (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL,
    interview_flow_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50) NOT NULL,
    is_visible BOOLEAN DEFAULT TRUE,
    location VARCHAR(255),
    job_description TEXT,
    requirements TEXT,
    responsibilities TEXT,
    salary_min NUMERIC,
    salary_max NUMERIC,
    employment_type VARCHAR(100),
    benefits TEXT,
    company_description TEXT,
    application_deadline DATE,
    contact_info VARCHAR(255),
    FOREIGN KEY (company_id) REFERENCES COMPANY(id) ON DELETE CASCADE,
    FOREIGN KEY (interview_flow_id) REFERENCES INTERVIEW_FLOW(id) ON DELETE SET NULL
);

CREATE TABLE CANDIDATE (
    id SERIAL PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT
);

CREATE TABLE APPLICATION (
    id SERIAL PRIMARY KEY,
    position_id INT NOT NULL,
    candidate_id INT NOT NULL,
    application_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    notes TEXT,
    FOREIGN KEY (position_id) REFERENCES POSITION(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES CANDIDATE(id) ON DELETE CASCADE
);

CREATE TABLE APPLICATION_HISTORY (
    id SERIAL PRIMARY KEY,
    application_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    changed_by INT,
    FOREIGN KEY (application_id) REFERENCES APPLICATION(id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by) REFERENCES EMPLOYEE(id) ON DELETE SET NULL
);

CREATE TABLE INTERVIEW (
    id SERIAL PRIMARY KEY,
    application_id INT NOT NULL,
    interview_step_id INT NOT NULL,
    employee_id INT NOT NULL,
    interview_date DATE NOT NULL,
    result VARCHAR(255),
    score INT,
    notes TEXT,
    FOREIGN KEY (application_id) REFERENCES APPLICATION(id) ON DELETE CASCADE,
    FOREIGN KEY (interview_step_id) REFERENCES INTERVIEW_STEP(id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(id) ON DELETE SET NULL
);

CREATE TABLE INTERVIEW_EVENT (
    id SERIAL PRIMARY KEY,
    interview_id INT NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    event_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT,
    FOREIGN KEY (interview_id) REFERENCES INTERVIEW(id) ON DELETE CASCADE
);

-- Índices adicionales para optimizar consultas
CREATE INDEX idx_employee_company ON EMPLOYEE(company_id);
CREATE INDEX idx_position_company ON POSITION(company_id);
CREATE INDEX idx_application_candidate ON APPLICATION(candidate_id);
CREATE INDEX idx_application_position ON APPLICATION(position_id);
CREATE INDEX idx_interview_application ON INTERVIEW(application_id);
CREATE INDEX idx_interview_employee ON INTERVIEW(employee_id);
CREATE INDEX idx_application_history_application ON APPLICATION_HISTORY(application_id);
CREATE INDEX idx_interview_event_interview ON INTERVIEW_EVENT(interview_id);
