CREATE TABLE IF NOT EXISTS MEETING (
    qr_hash        TEXT NOT NULL UNIQUE,
    meeting_name   TEXT NOT NULL,
    room           TEXT NOT NULL UNIQUE,
    date_from      TIMESTAMP NOT NULL UNIQUE,
    end_time       TIME NOT NULL UNIQUE,
    organiser      TEXT NOT NULL REFERENCES APP_USER ON DELETE CASCADE,
    PRIMARY KEY(room, date_from, end_time)
);

INSERT INTO MEETING (qr_hash, meeting_name, room, date_from, end_time, organiser)
VALUES ('SomeRandomAssString!?DdjsasoDJFAF*&$#432','Progress Report', 'EB.03.22','2020-03-11T21:12:14+0000', '15:00', 'example_2@email.com');