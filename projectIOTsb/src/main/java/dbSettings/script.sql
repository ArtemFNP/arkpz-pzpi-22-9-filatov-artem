-- Удаляем таблицы, если они существуют (чтобы избежать ошибок при повторном запуске)
DROP TABLE IF EXISTS measurements CASCADE;
DROP TABLE IF EXISTS sensors CASCADE;
DROP TABLE IF EXISTS offices CASCADE;
DROP TABLE IF EXISTS buildings CASCADE;

-- Создаем таблицу "Buildings" для хранения данных о зданиях
CREATE TABLE buildings (
                           id SERIAL PRIMARY KEY,        -- Уникальный идентификатор здания
                           name VARCHAR(100) NOT NULL,   -- Название здания
                           address TEXT NOT NULL         -- Адрес здания
);

-- Создаем таблицу "Offices" для хранения данных об офисах
CREATE TABLE offices (
                         id SERIAL PRIMARY KEY,        -- Уникальный идентификатор офиса
                         building_id INT NOT NULL,     -- Ссылка на здание
                         name VARCHAR(100) NOT NULL,   -- Название офиса (например, "HR Department")
                         floor INT NOT NULL,           -- Этаж
                         FOREIGN KEY (building_id) REFERENCES buildings (id) ON DELETE CASCADE
);

-- Создаем таблицу "Sensors" для хранения данных о датчиках
CREATE TABLE sensors (
                         id SERIAL PRIMARY KEY,        -- Уникальный идентификатор датчика
                         office_id INT NOT NULL,       -- Ссылка на офис
                         type VARCHAR(50) NOT NULL,    -- Тип датчика (например, "Light", "Noise", "Oxygen")
                         location VARCHAR(100) NOT NULL, -- Позиция датчика в офисе
                         FOREIGN KEY (office_id) REFERENCES offices (id) ON DELETE CASCADE
);

-- Создаем таблицу "Measurements" для хранения данных об измерениях
CREATE TABLE measurements (
                              id SERIAL PRIMARY KEY,            -- Уникальный идентификатор измерения
                              sensor_id INT NOT NULL,           -- Ссылка на датчик
                              measurement_date DATE NOT NULL,   -- Дата измерения
                              measurement_time TIME NOT NULL,   -- Время измерения
                              light_level NUMERIC(10, 2),       -- Освещенность (люксы)
                              noise_level NUMERIC(10, 2),       -- Уровень шума (дБ)
                              oxygen_level NUMERIC(10, 2),      -- Концентрация кислорода (%)
                              FOREIGN KEY (sensor_id) REFERENCES sensors (id) ON DELETE CASCADE
);

-- Добавляем тестовые данные для таблицы "Buildings"
INSERT INTO buildings (name, address)
VALUES
    ('Business Center A', '123 Main St'),
    ('Tech Park B', '456 Technology Ave');

-- Добавляем тестовые данные для таблицы "Offices"
INSERT INTO offices (building_id, name, floor)
VALUES
    (1, 'HR Department', 2),
    (1, 'IT Department', 3),
    (2, 'Marketing', 1),
    (2, 'Development', 2);

-- Добавляем тестовые данные для таблицы "Sensors"
INSERT INTO sensors (office_id, type, location)
VALUES
    (1, 'Light', 'Near Window'),
    (1, 'Noise', 'Center Room'),
    (2, 'Oxygen', 'Corner A'),
    (3, 'Light', 'Entrance'),
    (4, 'Noise', 'Conference Room');

-- Добавляем тестовые данные для таблицы "Measurements"
INSERT INTO measurements (sensor_id, measurement_date, measurement_time, light_level, noise_level, oxygen_level)
VALUES
    (1, '2024-11-30', '09:00:00', 500.5, NULL, NULL), -- Освещенность
    (2, '2024-11-30', '09:05:00', NULL, 35.2, NULL),  -- Уровень шума
    (3, '2024-11-30', '09:10:00', NULL, NULL, 21.0),  -- Концентрация кислорода
    (4, '2024-11-30', '09:15:00', 450.8, NULL, NULL), -- Освещенность
    (5, '2024-11-30', '09:20:00', NULL, 50.0, NULL);  -- Уровень шума