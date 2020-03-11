CREATE TABLE MEETING (
    guest_email    VARCHAR(64) REFERENCES APP_USER,
    room_fid       INT REFERENCES ROOM,
    date_from      TIMESTAMP,
    end_time       TIME,
    organiser      VARCHAR(64) NOT NULL REFERENCES APP_USER,
    qr_hash        TEXT NOT NULL,
    is_present     BOOLEAN DEFAULT FALSE,
    PRIMARY KEY(guest_email, room_fid, date_from, end_time)
);

INSERT INTO MEETING (guest_email, room_fid, date_from, end_time, organiser, qr_hash)
VALUES ('email@example.com', 1, '2020-03-11T21:12:14+0000', '15:00', 'please@pm.me', 'example string');