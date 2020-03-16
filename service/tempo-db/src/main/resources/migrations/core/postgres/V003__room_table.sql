CREATE TABLE IF NOT EXISTS ROOM (
    room_id        SERIAL PRIMARY KEY,
    building       VARCHAR(64) NOT NULL,
    room           VARCHAR(64) NOT NULL   
);

INSERT INTO ROOM (building, room)
VALUES ('Tower 42', 'Conference Room');