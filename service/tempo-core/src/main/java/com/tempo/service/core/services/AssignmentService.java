package com.tempo.service.core.services;

import com.fasterxml.jackson.databind.exc.MismatchedInputException;
import com.tempo.service.core.server.AsyncProvider;
import com.tempo.service.db.Database;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import static com.tempo.service.core.db.tables.Assignment.ASSIGNMENT;
import static com.tempo.service.core.db.tables.Meeting.MEETING;
import static com.tempo.service.core.utils.HttpHelper.check;
import static com.tempo.service.core.utils.HttpHelper.parseJSON;

public class AssignmentService extends HttpServlet {
    private Database db;

    public AssignmentService() {
        db = new Database(); //TODO: Connect on start
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        var rows = db.execute(sql -> sql.select(
                ASSIGNMENT.USER_EMAIL,
                ASSIGNMENT.ROOM,
                ASSIGNMENT.DATE_FROM,
                ASSIGNMENT.END_TIME,
                MEETING.MEETING_NAME,
                MEETING.ORGANISER,
                ASSIGNMENT.IS_PRESENT)
                .from(ASSIGNMENT)
                .innerJoin(MEETING).using(ASSIGNMENT.ROOM, ASSIGNMENT.DATE_FROM, ASSIGNMENT.END_TIME)
                .fetch(r -> new Assignment(
                        r.get(ASSIGNMENT.USER_EMAIL),
                        r.get(ASSIGNMENT.ROOM),
                        r.get(ASSIGNMENT.DATE_FROM),
                        r.get(ASSIGNMENT.END_TIME),
                        r.get(MEETING.MEETING_NAME),
                        r.get(MEETING.ORGANISER),
                        r.get(ASSIGNMENT.IS_PRESENT))));
        AsyncProvider.print(request, response, getServletContext(), parseJSON(rows));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            var map = check(request, response, "userEmail", "room", "dateFrom", "endTime");
            if (map == null) return;

            var dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS");
            var timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
            var rows = db.execute(sql -> sql.insertInto(ASSIGNMENT)
                    .set(ASSIGNMENT.USER_EMAIL, map.get("userEmail"))
                    .set(ASSIGNMENT.ROOM, map.get("room"))
                    .set(ASSIGNMENT.DATE_FROM, LocalDateTime.parse(map.get("dateFrom"), dateTimeFormatter))
                    .set(ASSIGNMENT.END_TIME, LocalTime.parse(map.get("endTime"), timeFormatter))
                    .execute());
            response.getWriter().print("Rows inserted: " + rows);
        } catch (MismatchedInputException ex) {
            response.sendError(1, "Missing or invalid parameters");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendError(1, "Internal server error");
        }
    }

    static class Assignment {
        final String userEmail;
        final String room;
        final LocalDateTime dateFrom;
        final LocalTime endTime;
        final String meetingName;
        final String organiser;
        final Boolean isPresent;

        Assignment(String userEmail,
                   String room,
                   LocalDateTime dateFrom,
                   LocalTime endTime,
                   String meetingName,
                   String organiser,
                   Boolean isPresent) {
            this.userEmail = userEmail;
            this.room = room;
            this.dateFrom = dateFrom;
            this.endTime = endTime;
            this.meetingName = meetingName;
            this.organiser = organiser;
            this.isPresent = isPresent;
        }

        @Override
        public String toString() {
            return String.format("{" +
                            "\"userEmail\": \"%s\", " +
                            "\"room\": \"%s\", " +
                            "\"dateFrom\": \"%s\", " +
                            "\"endTime\": \"%s\", " +
                            "\"meetingName\": \"%s\", " +
                            "\"organiser\": \"%s\", " +
                            "\"isPresent\": \"%s\"" +
                            "}",
                    userEmail, room, dateFrom, endTime,
                    meetingName, organiser, isPresent);
        }
    }
}
