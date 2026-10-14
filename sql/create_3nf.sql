-- ============================================
-- Создаем схему 3NF для учета в видеопрокате
-- ============================================
CREATE SCHEMA IF NOT EXISTS "3nf";

SET search_path TO "3nf";

-- ============================================
-- Таблица: Клиенты
-- ============================================
CREATE TABLE client (
    client_id SERIAL PRIMARY KEY,            
    full_name VARCHAR(100) NOT NULL,         
    phone VARCHAR(20) NOT NULL UNIQUE,       
    email VARCHAR(100) UNIQUE,               
    address TEXT                             
);

-- ============================================
-- Таблица: Фильмы
-- ============================================
CREATE TABLE movie (
    movie_id SERIAL PRIMARY KEY,           
    title VARCHAR(150) NOT NULL,              
    genre VARCHAR(50) NOT NULL,                        
    release_year INT CHECK (release_year > 1900),
    rental_rate NUMERIC(10,2) NOT NULL CHECK (rental_rate >= 0)
);

-- ============================================
-- Таблица: Сотрудники
-- ============================================
CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,          
    full_name VARCHAR(100) NOT NULL,         
    phone VARCHAR(20) UNIQUE,                
    position VARCHAR(50) NOT NULL                     
);

-- ============================================
-- Таблица: Аренда (заказы проката)
-- ============================================
CREATE TABLE rental (
    rental_id SERIAL PRIMARY KEY,             
    rental_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    due_date DATE NOT NULL,
    return_date DATE,                    
    status VARCHAR(30) NOT NULL CHECK (status IN ('активна', 'завершена', 'просрочена')),
    client_id INT NOT NULL,
    employee_id INT NOT NULL,                  
    CONSTRAINT fk_rental_client FOREIGN KEY (client_id)
        REFERENCES client (client_id) ON DELETE CASCADE,
    CONSTRAINT fk_rental_employee FOREIGN KEY (employee_id)
        REFERENCES employee (employee_id) ON DELETE SET NULL
);

-- ============================================
-- Таблица: Позиции аренды (связь многие-ко-многим)
-- ============================================
CREATE TABLE rental_item (
    rental_id INT NOT NULL,
    movie_id INT NOT NULL,
    fee NUMERIC(10,2) NOT NULL CHECK (fee >= 0),
    PRIMARY KEY (rental_id, movie_id),
    CONSTRAINT fk_ri_rental FOREIGN KEY (rental_id)
        REFERENCES rental (rental_id) ON DELETE CASCADE,
    CONSTRAINT fk_ri_movie FOREIGN KEY (movie_id)
        REFERENCES movie (movie_id) ON DELETE CASCADE
);

-- ============================================
-- Индексы
-- ============================================
CREATE INDEX idx_client_phone ON client (phone);
CREATE INDEX idx_rental_status ON rental (status);
CREATE INDEX idx_rental_client ON rental (client_id);