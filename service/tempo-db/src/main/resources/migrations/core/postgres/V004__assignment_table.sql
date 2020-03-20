CREATE TABLE IF NOT EXISTS ASSIGNMENT (
    user_email     TEXT NOT NULL UNIQUE REFERENCES APP_USER ON DELETE CASCADE,
    room           TEXT NOT NULL UNIQUE,
    date_from      TIMESTAMP NOT NULL UNIQUE,
    end_time       TIME NOT NULL UNIQUE,
    is_present     BOOLEAN,
    PRIMARY KEY(user_email, room, date_from, end_time),
    FOREIGN KEY (room) REFERENCES MEETING (room) ON DELETE CASCADE,
    FOREIGN KEY (date_from) REFERENCES MEETING (date_from) ON DELETE CASCADE,
    FOREIGN KEY (end_time) REFERENCES MEETING (end_time) ON DELETE CASCADE
);

INSERT INTO ASSIGNMENT (user_email, room, date_from, end_time, is_present)
VALUES ('example@email.com', 'EB.03.22', '2020-03-11T21:12:14+0000', '15:00', FALSE);