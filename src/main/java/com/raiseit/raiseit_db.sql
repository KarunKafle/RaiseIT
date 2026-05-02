CREATE DATABASE IF NOT EXISTS raiseit_db;
USE raiseit_db;

CREATE TABLE departments (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             name VARCHAR(100) NOT NULL,
                             description TEXT,
                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       role ENUM('student', 'staff', 'admin') NOT NULL DEFAULT 'student',
                       department_id INT DEFAULT NULL,
                       status ENUM('pending', 'active', 'suspended') DEFAULT 'pending',
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE categories (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            name VARCHAR(100) NOT NULL,
                            department_id INT NOT NULL,
                            FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE complaints (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            reference_number VARCHAR(20) NOT NULL UNIQUE,
                            user_id INT,
                            title VARCHAR(200) NOT NULL,
                            description TEXT NOT NULL,
                            category_id INT NOT NULL,
                            priority ENUM('low', 'medium', 'high') DEFAULT 'medium',
                            status ENUM('submitted','assigned','in_progress','resolved','escalated','closed') DEFAULT 'submitted',
                            is_anonymous BOOLEAN DEFAULT FALSE,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            FOREIGN KEY (user_id) REFERENCES users(id),
                            FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE assignments (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             complaint_id INT NOT NULL,
                             staff_id INT NOT NULL,
                             assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             deadline DATE NOT NULL,
                             note TEXT,
                             FOREIGN KEY (complaint_id) REFERENCES complaints(id),
                             FOREIGN KEY (staff_id) REFERENCES users(id)
);

CREATE TABLE responses (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           complaint_id INT NOT NULL,
                           user_id INT NOT NULL,
                           message TEXT NOT NULL,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           FOREIGN KEY (complaint_id) REFERENCES complaints(id),
                           FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE feedback (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          complaint_id INT NOT NULL UNIQUE,
                          student_id INT NOT NULL,
                          rating INT CHECK (rating BETWEEN 1 AND 5),
                          comment TEXT,
                          submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (complaint_id) REFERENCES complaints(id),
                          FOREIGN KEY (student_id) REFERENCES users(id)
);

CREATE TABLE contact_inquiries (
                                   id INT AUTO_INCREMENT PRIMARY KEY,
                                   name VARCHAR(100) NOT NULL,
                                   email VARCHAR(100) NOT NULL,
                                   message TEXT NOT NULL,
                                   submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO departments (name, description) VALUES
                                                ('SSD', 'Student Service Department - handles student welfare and conduct'),
                                                ('Finance', 'Handles fee payment, scholarships and refunds'),
                                                ('RTE', 'Handles class routines, exam schedules and timetable issues'),
                                                ('Resource', 'Handles equipment, materials and lab resources'),
                                                ('IT Support', 'Handles systems, internet and software access'),
                                                ('Academics', 'Handles grades, courses, attendance and teaching quality'),
                                                ('Library', 'Handles books, library access and borrowing issues');

INSERT INTO categories (name, department_id) VALUES
                                                 ('Student Welfare', 1),
                                                 ('Student Conduct', 1),
                                                 ('General Student Issues', 1),
                                                 ('Fee Payment Issues', 2),
                                                 ('Scholarship Issues', 2),
                                                 ('Refund Requests', 2),
                                                 ('Class Routine Issues', 3),
                                                 ('Exam Schedule Issues', 3),
                                                 ('Timetable Conflicts', 3),
                                                 ('Equipment Issues', 4),
                                                 ('Lab Resource Issues', 4),
                                                 ('Study Material Issues', 4),
                                                 ('System Access Issues', 5),
                                                 ('Internet Issues', 5),
                                                 ('Software Problems', 5),
                                                 ('Grade Issues', 6),
                                                 ('Course Issues', 6),
                                                 ('Attendance Issues', 6),
                                                 ('Book Availability', 7),
                                                 ('Library Access Issues', 7),
                                                 ('Borrowing Issues', 7);

INSERT INTO users (full_name, email, password, role, status) VALUES
    ('System Admin', 'admin@raiseit.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'admin', 'active');