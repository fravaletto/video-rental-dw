-- ============================================
-- Схема Data Vault для учета в видеопрокате
-- ============================================
CREATE SCHEMA IF NOT EXISTS dv;
SET search_path TO dv;

-- ============================================
-- HUBS (Хабы)
-- ============================================
CREATE TABLE hub_client (
    client_hkey UUID PRIMARY KEY,
    client_bk VARCHAR(50) UNIQUE NOT NULL,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

CREATE TABLE hub_movie (
    movie_hkey UUID PRIMARY KEY,
    movie_bk VARCHAR(50) UNIQUE NOT NULL,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

CREATE TABLE hub_employee (
    employee_hkey UUID PRIMARY KEY,
    employee_bk VARCHAR(50) UNIQUE NOT NULL,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

CREATE TABLE hub_rental (
    rental_hkey UUID PRIMARY KEY,
    rental_bk VARCHAR(50) UNIQUE NOT NULL,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

-- ============================================
-- LINKS (Ссылки)
-- ============================================
CREATE TABLE link_rental_client (
    link_rental_client_hkey UUID PRIMARY KEY,
    rental_hkey UUID NOT NULL REFERENCES hub_rental(rental_hkey),
    client_hkey UUID NOT NULL REFERENCES hub_client(client_hkey),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

CREATE TABLE link_rental_employee (
    link_rental_employee_hkey UUID PRIMARY KEY,
    rental_hkey UUID NOT NULL REFERENCES hub_rental(rental_hkey),
    employee_hkey UUID NOT NULL REFERENCES hub_employee(employee_hkey),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

CREATE TABLE link_rental_movie (
    link_rental_movie_hkey UUID PRIMARY KEY,
    rental_hkey UUID NOT NULL REFERENCES hub_rental(rental_hkey),
    movie_hkey UUID NOT NULL REFERENCES hub_movie(movie_hkey),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

-- ============================================
-- SATELLITES (Сателлиты)
-- ============================================
CREATE TABLE sat_client (
    client_hkey UUID NOT NULL REFERENCES hub_client(client_hkey),
    full_name VARCHAR(100),
    email VARCHAR(100),
    address TEXT,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (client_hkey, load_date)
);

CREATE TABLE sat_movie (
    movie_hkey UUID NOT NULL REFERENCES hub_movie(movie_hkey),
    title VARCHAR(150),
    genre VARCHAR(50),
    release_year INT,
    rental_rate NUMERIC(10,2),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (movie_hkey, load_date)
);

CREATE TABLE sat_employee (
    employee_hkey UUID NOT NULL REFERENCES hub_employee(employee_hkey),
    full_name VARCHAR(100),
    position VARCHAR(50),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (employee_hkey, load_date)
);

CREATE TABLE sat_rental (
    rental_hkey UUID NOT NULL REFERENCES hub_rental(rental_hkey),
    rental_date TIMESTAMP,
    due_date DATE,
    return_date DATE,
    status VARCHAR(30),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (rental_hkey, load_date)
);

CREATE TABLE sat_rental_movie (
    link_rental_movie_hkey UUID NOT NULL REFERENCES link_rental_movie(link_rental_movie_hkey),
    fee NUMERIC(10,2),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (link_rental_movie_hkey, load_date)
);