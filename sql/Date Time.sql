-- Create Database
CREATE DATABASE datetime_examples;

-- Use Database
USE datetime_examples;

-- Create Table - events
CREATE TABLE events (
    id INT PRIMARY KEY,
    event_name VARCHAR(100),
    event_date DATE,
    event_time TIME,
    event_timestamp TIMESTAMP
);

-- Insert Data into events
INSERT INTO events (id, event_name, event_date, event_time, event_timestamp) VALUES 
(1, 'Meeting', '2024-06-17', '09:00:00', '2024-06-17 09:00:00'),
(2, 'Conference', '2024-06-18', '11:00:00', '2024-06-18 11:00:00'),
(3, 'Workshop', '2024-06-19', '14:00:00', '2024-06-19 14:00:00'),
(4, 'Seminar', '2024-06-20', '16:00:00', '2024-06-20 16:00:00');

-- Retrieve all events happening today
SELECT event_name, event_date, event_time
FROM events
WHERE event_date = CURDATE();

-- Retrieve all events happening within the next 7 days
SELECT event_name, event_date, event_time
FROM events
WHERE event_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY);

-- Retrieve the earliest and latest event dates
SELECT MIN(event_date) AS earliest_event, MAX(event_date) AS latest_event
FROM events;

-- Calculate the number of days until each event
SELECT event_name, event_date, DATEDIFF(event_date, CURDATE()) AS days_until_event
FROM events;

-- Retrieve events that happen before noon
SELECT event_name, event_time
FROM events
WHERE event_time < '12:00:00';

-- Retrieve events that happen in the afternoon
SELECT event_name, event_time
FROM events
WHERE event_time >= '12:00:00' AND event_time < '18:00:00';

-- Retrieve events that happen in the evening
SELECT event_name, event_time
FROM events
WHERE event_time >= '18:00:00';

-- Retrieve events that happened in the past
SELECT event_name, event_timestamp
FROM events
WHERE event_timestamp < NOW();

-- Retrieve events that will happen in the future
SELECT event_name, event_timestamp
FROM events
WHERE event_timestamp > NOW();

-- Retrieve events that happen on weekends
SELECT event_name, event_date
FROM events
WHERE DAYOFWEEK(event_date) IN (1, 7);

-- Retrieve the day of the week for each event
SELECT event_name, event_date, DAYNAME(event_date) AS day_of_week
FROM events;

-- Retrieve events grouped by the month they occur in
SELECT MONTHNAME(event_date) AS month, COUNT(*) AS event_count
FROM events
GROUP BY MONTH(event_date)
ORDER BY MONTH(event_date);

-- Retrieve the hour and minute of each event
SELECT event_name, HOUR(event_time) AS event_hour, MINUTE(event_time) AS event_minute
FROM events;

-- Add 1 hour to the event time of all events
SELECT event_name, event_time, ADDTIME(event_time, '01:00:00') AS new_event_time
FROM events;

-- Subtract 30 minutes from the event time of all events
SELECT event_name, event_time, SUBTIME(event_time, '00:30:00') AS new_event_time
FROM events;

-- Calculate the difference in days between the earliest and latest events
SELECT DATEDIFF(MAX(event_date), MIN(event_date)) AS days_between_events
FROM events;

-- Retrieve events that happen on the first day of the month
SELECT event_name, event_date
FROM events
WHERE DAY(event_date) = 1;

-- Retrieve events with timestamps in the last 24 hours
SELECT event_name, event_timestamp
FROM events
WHERE event_timestamp >= DATE_SUB(NOW(), INTERVAL 1 DAY);

-- Retrieve events and convert their timestamps to a different time zone
SELECT event_name, event_timestamp, CONVERT_TZ(event_timestamp, '+00:00', '-05:00') AS event_timestamp_est
FROM events;

-- Retrieve events and format the event date and time
SELECT event_name, DATE_FORMAT(event_date, '%W, %M %d, %Y') AS formatted_event_date, 
       TIME_FORMAT(event_time, '%h:%i %p') AS formatted_event_time
FROM events;
