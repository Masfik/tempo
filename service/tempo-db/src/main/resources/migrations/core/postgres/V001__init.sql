CREATE TABLE IF NOT EXISTS APP_USER
(
    email      VARCHAR(64) PRIMARY KEY,
    first_name VARCHAR(32) NOT NULL,
    surname    VARCHAR(32) NOT NULL
);

CREATE TABLE IF NOT EXISTS MEETING
(
    qr_hash      TEXT      NOT NULL UNIQUE,
    meeting_name TEXT      NOT NULL,
    room         TEXT      NOT NULL,
    date_from    TIMESTAMP NOT NULL,
    end_time     TIME      NOT NULL,
    organiser    TEXT      NOT NULL REFERENCES APP_USER ON DELETE CASCADE,
    PRIMARY KEY (room, date_from, end_time)
);
CREATE TABLE IF NOT EXISTS ASSIGNMENT
(
    user_email TEXT      NOT NULL REFERENCES APP_USER ON DELETE CASCADE,
    room       TEXT      NOT NULL,
    date_from  TIMESTAMP NOT NULL,
    end_time   TIME      NOT NULL,
    is_present BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (user_email, room, date_from, end_time),
    FOREIGN KEY (room, date_from, end_time) REFERENCES MEETING ON DELETE CASCADE
);

INSERT INTO APP_USER (email, first_name, surname)
VALUES ('example@email.com', 'John', 'Smith');

INSERT INTO APP_USER (email, first_name, surname)
VALUES ('example_2@email.com', 'Herbert', 'James');

INSERT INTO MEETING (qr_hash, meeting_name, room, date_from, end_time, organiser)
VALUES ('SomeRandomAssString!?DdjsasoDJFAF*&$#432',
        'Progress Report',
        'EB.03.22',
        '2020-03-11T21:12:14+0000',
        '15:00',
        'example_2@email.com');

INSERT INTO ASSIGNMENT (user_email, room, date_from, end_time, is_present)
VALUES ('example@email.com', 'EB.03.22', '2020-03-11T21:12:14+0000', '15:00', FALSE);
