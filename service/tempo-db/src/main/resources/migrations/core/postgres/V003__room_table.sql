CREATE TABLE ROOM (
    room_id        SERIAL PRIMARY KEY,
    building       VARCHAR(32) NOT NULL,
    room           VARCHAR(32) NOT NULL   
);

INSERT INTO ROOM (building, room)
VALUES ('Tower 42', 'Conference Room');