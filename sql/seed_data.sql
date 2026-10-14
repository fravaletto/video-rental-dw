SET search_path TO "3nf";

INSERT INTO client (full_name, phone, email, address) VALUES
('Иванов Иван Иванович', '+79991112233', 'ivanov@example.com', 'Москва, ул. Ленина, д. 10'),
('Петров Петр Петрович', '+79992223344', 'petrov@example.com', 'Москва, ул. Тверская, д. 5'),
('Сидорова Анна Сергеевна', '+79993334455', 'sidorova@example.com', 'Санкт-Петербург, Невский пр., д. 20');

INSERT INTO movie (title, genre, release_year, rental_rate) VALUES
('Матрица', 'Фантастика', 1999, 150.00),
('Интерстеллар', 'Фантастика', 2014, 200.00),
('Криминальное чтиво', 'Криминал', 1994, 180.00),
('Побег из Шоушенка', 'Драма', 1994, 150.00);

INSERT INTO employee (full_name, phone, position) VALUES
('Смирнов Алексей Владимирович', '+79110001122', 'Менеджер'),
('Кузнецова Елена Демьяновна', '+79110002233', 'Кассир');

INSERT INTO rental (rental_date, due_date, return_date, status, client_id, employee_id) VALUES
('2026-03-01 10:00:00', '2026-03-05', '2026-03-04', 'завершена', 1, 2),
('2026-03-10 14:30:00', '2026-03-14', NULL, 'активна', 2, 1);

INSERT INTO rental_item (rental_id, movie_id, fee) VALUES
(1, 1, 150.00),
(1, 3, 180.00),
(2, 2, 200.00);