CREATE DATABASE sladkie_sny CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sladkie_sny;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    login VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('guest','admin') NOT NULL DEFAULT 'guest'
);

CREATE TABLE room_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code ENUM('standard','studio','lux') NOT NULL UNIQUE,
    title VARCHAR(50) NOT NULL,
    price_per_day DECIMAL(10,2) NOT NULL,
    capacity TINYINT UNSIGNED NOT NULL,
    area DECIMAL(5,2) NOT NULL,
    has_ac BOOLEAN DEFAULT FALSE,
    has_tv BOOLEAN DEFAULT FALSE,
    has_fridge BOOLEAN DEFAULT FALSE,
    has_wifi BOOLEAN DEFAULT FALSE,
    image_path VARCHAR(255) NOT NULL DEFAULT 'img/standart.png'
);

CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    type_id INT NOT NULL,
    FOREIGN KEY (type_id) REFERENCES room_types(id) ON DELETE CASCADE
);

CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name  VARCHAR(100) NOT NULL,
    phone      VARCHAR(20)  NOT NULL,
    email      VARCHAR(100) NOT NULL,
    check_in   DATE NOT NULL,
    check_out  DATE NOT NULL,
    status     ENUM('new','approved','rejected') NOT NULL DEFAULT 'new',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE,
    INDEX idx_status (status)
);

-- Админ: admin / admin123 (сгенерируйте хэш password_hash)
INSERT INTO users (login, password_hash, role) VALUES
('admin', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe1HlCS4bZJ18JuywdBqSfR0f3P7hE3K6', 'admin');

INSERT INTO room_types (code,title,price_per_day,capacity,area,has_ac,has_tv,has_fridge,has_wifi,image_path) VALUES
('standard','Стандарт',10000,1,18,0,0,0,1,'img/standart.png'),
('studio','Студия',8000,2,28,1,1,0,1,'img/studio.jpg'),
('lux','Люкс',19000,3,55,1,1,1,1,'img/lux.png');

INSERT INTO rooms (room_number,type_id) VALUES
('101',1),('102',1),('103',1),
('201',2),('202',2),('203',2),
('301',3),('302',3),('303',3);
