CREATE DATABASE school;

CREATE TABLE student(
stu_id INT PRIMARY KEY,
stu_Fname VARCHAR(255) NOT NULL,
stu_Lname VARCHAR(255) NOT NULL,
DOB DATE NOT NULL,
admit_date DATE NOT NULL,
ethnicity_id INT,
risk_id INT,
housing_id iNT,
FOREIGN KEY(ethnicity_id) REFERENCES ethnicity(ethnicity_id),
FOREIGN KEY(risk_id) REFERENCES risk_group(risk_id)
);

ALTER TABLE student
ADD FOREIGN KEY (ethnicity_id) REFERENCES ethnicity(ethnicity_id) 
;

CREATE TABLE ethnicity (
ethnicity_id INT PRIMARY KEY AUTO_INCREMENT,
ethnicity_name VARCHAR(255) NOT NULL 
);

CREATE TABLE risk_group(
risk_id INT PRIMARY KEY AUTO_INCREMENT,
risk_description VARCHAR (255) NOT NULL
);

CREATE TABLE housing(
housing_id INT PRIMARY KEY AUTO_INCREMENT,
stu_id INT,
housing_status ENUM('temporary', 'permanent') NOT NULL,
housing_name VARCHAR(255) NOT NULL,
FOREIGN KEY(stu_id) REFERENCES student(stu_id)
);

CREATE TABLE transit_mode(
transit_id INT PRIMARY KEY AUTO_INCREMENT,
transit_name VARCHAR(255) NOT NULL
);

CREATE TABLE commute(
commute_id INT PRIMARY KEY AUTO_INCREMENT,
stu_id INT,
distance DECIMAL(3,2),
time_minutes INT,
transit_id INT,
FOREIGN KEY(stu_id) REFERENCES student(stu_id),
FOREIGN KEY(transit_id) REFERENCES transit_mode(transit_id)
);

CREATE TABLE student_rewards(
stu_id int,
date DATE NOT NULL,
reward_type VARCHAR(255) NOT NULL,
FOREIGN KEY(stu_id) REFERENCES student(stu_id)
);

CREATE TABLE intervention(
stu_id INT,
intervention_type VARCHAR(255) NOT NULL,
intervention_severity ENUM ('low', 'medium','critical') NOT NULL,
intervention_date DATE,
FOREIGN KEY(stu_id) REFERENCES student(stu_id)
);

CREATE TABLE teacher(
teacher_id INT PRIMARY KEY,
teacher_Fname VARCHAR(255) NOT NULL,
teacher_Lname VARCHAR(255) NOT NULL,
teacher_email VARCHAR(255) NOT NULL UNIQUE,
teacher_phone CHAR(10) NOT NULL
);

CREATE TABLE class(
class_id INT PRIMARY KEY AUTO_INCREMENT,
class_name VARCHAR(255) NOT NULL,
grade_level INT,
teacher_id INT,
FOREIGN KEY(teacher_id) REFERENCES teacher(teacher_id)
);

CREATE TABLE class_schedule (
  class_schedule_id INT PRIMARY KEY AUTO_INCREMENT,
  day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  room VARCHAR(10) NOT NULL,
  class_id INT,
  FOREIGN KEY (class_id) REFERENCES class(class_id)
);

CREATE TABLE enrollment(
enroll_id INT PRIMARY KEY AUTO_INCREMENT,
stu_id INT,
class_id INT,
enroll_date DATE,
FOREIGN KEY(stu_id) REFERENCES student(stu_id),
FOREIGN KEY (class_id) REFERENCES class(class_id)
);

CREATE TABLE reason(
reason_id INT PRIMARY KEY AUTO_INCREMENT,
reason_description VARCHAR(255) NOT NULL
);

CREATE TABLE absences(
stu_id INT,
class_id INT,
date DATE,
reason_id INT,
FOREIGN KEY(stu_id) REFERENCES student(stu_id),
FOREIGN KEY (class_id) REFERENCES class(class_id),
FOREIGN KEY(reason_id) REFERENCES reason(reason_id)
);

CREATE TABLE lateness(
stu_id INT,
class_id INT,
date DATE,
reason_id INT,
FOREIGN KEY(stu_id) REFERENCES student(stu_id),
FOREIGN KEY (class_id) REFERENCES class(class_id),
FOREIGN KEY(reason_id) REFERENCES reason(reason_id)
);

INSERT INTO ethnicity (ethnicity_name) VALUES
('Asian'),
('African American'),
('Hispanic'),
('White'),
('Native American');

INSERT INTO risk_group (risk_description) VALUES
('Low Risk'),
('Medium Risk'),
('High Risk'),
('At-Risk'),
('Critical');


INSERT INTO teacher (teacher_id, teacher_Fname, teacher_Lname, teacher_email, teacher_phone) VALUES
(1, 'John', 'Smith', 'john.smith@email.com', '5551234567'),
(2, 'Jane', 'Doe', 'jane.doe@email.com', '5559876543'),
(3, 'Michael', 'Johnson', 'michael.johnson@email.com', '5551239876'),
(4, 'Emily', 'Clark', 'emily.clark@email.com', '5557891234'),
(5, 'Daniel', 'Williams', 'daniel.williams@email.com', '5554567891');


INSERT INTO student (stu_id, stu_Fname, stu_Lname, DOB, admit_date, ethnicity_id, risk_id) VALUES
(1, 'Alice', 'Brown', '2009-01-15', '2020-08-25', 1, 1),
(2, 'Bob', 'Johnson', '2009-07-20', '2020-08-25', 2, 2),
(3, 'Charlie', 'Miller', '2009-05-30', '2020-08-25', 3, 3),
(4, 'David', 'Smith', '2009-10-10', '2020-08-25', 4, 1),
(5, 'Eva', 'Davis', '2009-03-25', '2020-08-25', 5, 2);

INSERT INTO student (stu_id, stu_Fname, stu_Lname, DOB, admit_date, ethnicity_id, risk_id) VALUES
(6, 'Frank', 'Garcia', '2009-08-05', '2020-08-25', 2, 2),
(7, 'Grace', 'Lee', '2009-04-12', '2020-08-25', 1, 3),
(8, 'Henry', 'Nguyen', '2009-11-28', '2020-08-25', 4, 1),
(9, 'Isabella', 'Perez', '2009-06-15', '2020-08-25', 3, 2),
(10, 'Jack', 'Robinson', '2009-02-23', '2020-08-25', 5, 3),
(11, 'Karen', 'Smith', '2009-10-11', '2020-08-25', 1, 1),
(12, 'Lucas', 'Taylor', '2009-05-19', '2020-08-25', 2, 2),
(13, 'Mia', 'Williams', '2009-12-17', '2020-08-25', 4, 1),
(14, 'Nathan', 'Wong', '2009-07-09', '2020-08-25', 3, 2),
(15, 'Olivia', 'Yang', '2009-03-04', '2020-08-25', 5, 3);

INSERT INTO housing (stu_id, housing_status, housing_name) VALUES
(1, 'permanent', 'Apartment'),
(2, 'temporary', 'Hotel'),
(3, 'permanent', 'House'),
(4, 'permanent', 'House'),
(5, 'temporary', 'Shelter');

INSERT INTO housing (stu_id, housing_status, housing_name) VALUES
(6, 'permanent', 'House'),
(7, 'temporary', 'Shelter'),
(8, 'permanent', 'Apartment'),
(9, 'permanent', 'Apartment'),
(10, 'temporary', 'Shelter'),
(11, 'temporary', 'Hotel'),
(12, 'permanent', 'House'),
(13, 'temporary', 'Shelter'),
(14, 'permanent', 'Apartment'),
(15, 'permanent', 'House');

INSERT INTO transit_mode (transit_name) VALUES
('Walking'),
('Biking'),
('Car'),
('Public Transit'),
('Carpool');

INSERT INTO class (class_name, grade_level, teacher_id) VALUES
('Math', 5, 1),
('Science', 6, 2),
('History', 5, 3),
('English', 6, 4),
('Physical Education', 5, 5);

INSERT INTO class_schedule (day_of_week, start_time, end_time, room, class_id) VALUES
('Monday', '08:00:00', '09:30:00', 'A101', 1),
('Tuesday', '09:45:00', '11:15:00', 'A102', 2),
('Wednesday', '11:30:00', '13:00:00', 'A103', 3),
('Thursday', '14:00:00', '15:30:00', 'A104', 4),
('Friday', '15:45:00', '17:15:00', 'A105', 5);

INSERT INTO enrollment (stu_id, class_id, enroll_date) VALUES
(1, 1, '2020-08-25'),
(1, 2, '2020-08-25'),
(2, 3, '2020-08-25'),
(2, 4, '2020-08-25'),
(3, 5, '2020-08-25');

INSERT INTO enrollment (stu_id, class_id, enroll_date) VALUES
(5, 1, '2022-01-01'),
(5, 2, '2022-01-01'),
(5, 3, '2022-01-01'),
(6, 1, '2022-01-01'),
(6, 2, '2022-01-01'),
(6, 3, '2022-01-01'),
(7, 1, '2022-01-01'),
(7, 2, '2022-01-01'),
(7, 3, '2022-01-01'),
(8, 1, '2022-01-01'),
(8, 2, '2022-01-01'),
(8, 3, '2022-01-01'),
(9, 1, '2022-01-01'),
(9, 2, '2022-01-01'),
(9, 3, '2022-01-01'),
(10, 1, '2022-01-01'),
(10, 2, '2022-01-01'),
(10, 3, '2022-01-01'),
(11, 1, '2022-01-01'),
(11, 2, '2022-01-01'),
(11, 3, '2022-01-01'),
(12, 1, '2022-01-01'),
(12, 2, '2022-01-01'),
(12, 3, '2022-01-01'),
(13, 1, '2022-01-01'),
(13, 2, '2022-01-01'),
(13, 3, '2022-01-01'),
(14, 1, '2022-01-01'),
(14, 2, '2022-01-01'),
(14, 3, '2022-01-01'),
(15, 1, '2022-01-01'),
(15, 2, '2022-01-01'),
(15, 3, '2022-01-01');

INSERT INTO reason (reason_description) VALUES
('Illness'),
('Family Emergency'),
('Doctor Appointment'),
('Weather'),
('Other');

INSERT INTO lateness (stu_id, class_id, date, reason_id) VALUES
(1, 1, '2021-01-11', 1),
(2, 3, '2021-01-12', 2),
(3, 5, '2021-01-13', 3),
(4, 4, '2021-01-14', 4),
(5, 2, '2021-01-15', 5);

INSERT INTO lateness (stu_id, class_id, date, reason_id) VALUES
(6, 2, '2021-01-18', 3),
(7, 3, '2021-01-19', 1),
(8, 4, '2021-01-20', 2),
(9, 5, '2021-01-21', 4),
(10, 1, '2021-01-22', 5);

INSERT INTO absences (stu_id, class_id, date, reason_id) VALUES
(1, 1, '2021-02-01', 1),
(2, 3, '2021-02-02', 2),
(3, 5, '2021-02-03', 3),
(4, 4, '2021-02-04', 4),
(5, 2, '2021-02-05', 5);
INSERT INTO absences (stu_id, class_id, date, reason_id) VALUES
(6, 2, '2021-02-08', 2),
(7, 3, '2021-02-09', 3),
(8, 4, '2021-02-10', 4),
(9, 5, '2021-02-11', 5),
(10, 1, '2021-02-12', 1);

INSERT INTO student_rewards (stu_id, date, reward_type) VALUES
(1, '2021-03-01', 'Good Attendance'),
(2, '2021-03-02', 'Academic Achievement'),
(3, '2021-03-03', 'Outstanding Effort'),
(4, '2021-03-04', 'Good Behavior'),
(5, '2021-03-05', 'Helping Others');
INSERT INTO student_rewards (stu_id, date, reward_type) VALUES
(6, '2021-03-08', 'Good Behavior'),
(7, '2021-03-09', 'Helping Others'),
(8, '2021-03-10', 'Academic Achievement'),
(9, '2021-03-11', 'Good Attendance');

INSERT INTO intervention (stu_id, intervention_type, intervention_severity, intervention_date) VALUES
(1, 'Academic Support', 'low', '2021-04-01'),
(2, 'Behavioral Intervention', 'medium', '2021-04-02'),
(3, 'Counseling', 'critical', '2021-04-03'),
(4, 'Peer Mentoring', 'low', '2021-04-04'),
(5, 'Social Skills Training', 'medium', '2021-04-05');

INSERT INTO intervention (stu_id, intervention_type, intervention_severity, intervention_date) VALUES
(6, 'Counseling', 'medium', '2021-04-08'),
(7, 'Behavioral Intervention', 'critical', '2021-04-09'),
(8, 'Social Skills Training', 'low', '2021-04-10'),
(9, 'Peer Mentoring', 'medium', '2021-04-11'),
(10, 'Academic Support', 'low', '2021-04-12');


INSERT INTO commute (stu_id, distance, time_minutes, transit_id) VALUES
(1, 1.2, 15, 1),
(2, 2.5, 10, 2),
(3, 3.0, 20, 3),
(4, 1.5, 25, 4),
(5, 2.0, 30, 5);
INSERT INTO enrollment (stu_id, class_id, enroll_date) VALUES (4, 2, '2022-01-15');
UPDATE enrollment 
SET enroll_date = DATE_SUB(enroll_date, INTERVAL 1 YEAR)
WHERE stu_id BETWEEN 4 AND 15;


INSERT INTO commute (stu_id, distance, time_minutes, transit_id) VALUES
(6, 1.8, 20, 1),
(7, 2.2, 15, 2),
(8, 2.5, 25, 3),
(9, 1.6, 10, 4),
(10, 3.0, 35, 5),
(11, 1.3, 30, 1),
(12, 2.9, 45, 2),
(13, 1.1, 10, 3),
(14, 2.4, 20, 4),
(15, 1.7, 15, 5);



/*view student's enrollment records, lateness, absence and interventions */


SELECT 
  s.stu_id,
  s.stu_Fname,
  s.stu_Lname,
  c.class_name,
  e.enroll_date,
  a.date AS absence_date,
  r.reason_description AS absence_reason,
  l.date AS lateness_date,
  r2.reason_description AS lateness_reason,
  i.intervention_type,
  i.intervention_severity,
  i.intervention_date
FROM 
  student s
  LEFT JOIN enrollment e ON s.stu_id = e.stu_id
  LEFT JOIN class c ON e.class_id = c.class_id
  LEFT JOIN absences a ON s.stu_id = a.stu_id AND c.class_id = a.class_id
  LEFT JOIN reason r ON a.reason_id = r.reason_id
  LEFT JOIN lateness l ON s.stu_id = l.stu_id AND c.class_id = l.class_id
  LEFT JOIN reason r2 ON l.reason_id = r2.reason_id
  LEFT JOIN intervention i ON s.stu_id = i.stu_id
ORDER BY 
  s.stu_Lname,
  s.stu_Fname,
  c.class_name;



/* view a class scheduling, including the teacher who teaches the class and the enrolled students */
SELECT 
  c.class_name,
  t.teacher_Fname,
  t.teacher_Lname,
  cs.day_of_week,
  cs.start_time,
  cs.end_time,
  cs.room,
  GROUP_CONCAT(CONCAT(s.stu_Fname, ' ', s.stu_Lname) SEPARATOR ', ') AS enrolled_students
FROM 
  class c
  JOIN teacher t ON c.teacher_id = t.teacher_id
  JOIN class_schedule cs ON c.class_id = cs.class_id
  LEFT JOIN enrollment e ON c.class_id = e.class_id
  LEFT JOIN student s ON e.stu_id = s.stu_id
GROUP BY 
  c.class_id,
  t.teacher_id,
  cs.day_of_week,
  cs.start_time,
  cs.end_time,
  cs.room
ORDER BY 
  c.class_name,
  cs.day_of_week,
  cs.start_time;



/* view student's housing status and commute information */
SELECT 
  s.stu_Fname,
  s.stu_Lname,
  h.housing_name,
  h.housing_status,
  t.transit_name,
  c.distance,
  c.time_minutes
FROM 
  student s
  LEFT JOIN housing h ON s.stu_id = h.stu_id
  LEFT JOIN commute c ON s.stu_id = c.stu_id
  LEFT JOIN transit_mode t ON c.transit_id = t.transit_id;


/* filtering latenes by month */

SELECT 
  s.stu_Fname,
  s.stu_Lname,
  l.date,
  r.reason_description
FROM 
  student s
  JOIN lateness l ON s.stu_id = l.stu_id
  JOIN reason r ON l.reason_id = r.reason_id
WHERE 
  MONTH(l.date) = 1
ORDER BY 
  s.stu_Lname,
  s.stu_Fname,
  l.date;


