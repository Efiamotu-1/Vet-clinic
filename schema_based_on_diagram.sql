CREATE TABLE patients (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR,
    date_of_birth DATE
);

CREATE TABLE invoices (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INTEGER references medical_histories(id)
);

CREATE TABLE medical_histories (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INTEGER references patients(id),
    status VARCHAR
);

CREATE TABLE invoice_items (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    unit_price DECIMAL,
    quantity INTEGER,
    total_price DECIMAL,
    invoice_id INTEGER references invoices(id),
    treatment_id INTEGER references treatments(id)
);

CREATE TABLE treatments (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    type VARCHAR,
    name VARCHAR
);



CREATE TABLE medical_histories_treatments (
    medical_history_id int references medical_histories(id);
    treatment_id int references treatments(id)
)