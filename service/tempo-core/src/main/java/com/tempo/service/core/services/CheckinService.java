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

import static com.tempo.service.core.db.tables.Assignment.ASSIGNMENT;
import static com.tempo.service.core.db.tables.Meeting.MEETING;
import static com.tempo.service.core.utils.HttpHelper.check;
import static com.tempo.service.core.utils.HttpHelper.parseJSON;

public class CheckinService extends HttpServlet {
    private Database db;

    public CheckinService() {
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
                .where(ASSIGNMENT.IS_PRESENT.eq(true))
                .fetch(r -> new CheckedIn(
                        r.get(ASSIGNMENT.USER_EMAIL),
                        r.get(ASSIGNMENT.ROOM),
                        r.get(ASSIGNMENT.DATE_FROM),
                        r.get(ASSIGNMENT.END_TIME),
                        r.get(MEETING.MEETING_NAME),
                        r.get(MEETING.ORGANISER))));
        AsyncProvider.print(request, response, getServletContext(), parseJSON(rows));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            var map = check(request, response, "userEmail", "qrHash");
            if (map == null) return;

            var rows = db.execute(sql -> sql.update(ASSIGNMENT)
                    .set(ASSIGNMENT.IS_PRESENT, true)
                    .from(MEETING)
                    .where(ASSIGNMENT.ROOM.eq(MEETING.ROOM))
                    .and(ASSIGNMENT.DATE_FROM.eq(MEETING.DATE_FROM))
                    .and(ASSIGNMENT.END_TIME.eq(MEETING.END_TIME))
                    .and(ASSIGNMENT.USER_EMAIL.eq(map.get("userEmail")))
                    .and(MEETING.QR_HASH.eq(map.get("qrHash")))
                    .execute());
            response.getWriter().print("Rows updated: " + rows);
        } catch (MismatchedInputException ex) {
            response.sendError(1, "Missing or invalid parameters");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendError(1, "Internal server error");
        }
    }

    class CheckedIn {
        final String userEmail;
        final String room;
        final LocalDateTime dateFrom;
        final LocalTime endTime;
        final String meetingName;
        final String organiser;

        CheckedIn(String userEmail,
                  String room,
                  LocalDateTime dateFrom,
                  LocalTime endTime,
                  String meetingName,
                  String organiser) {
            this.userEmail = userEmail;
            this.room = room;
            this.dateFrom = dateFrom;
            this.endTime = endTime;
            this.meetingName = meetingName;
            this.organiser = organiser;
        }

        @Override
        public String toString() {
            return String.format("{" +
                            "\"userEmail\": \"%s\", " +
                            "\"room\": \"%s\", " +
                            "\"dateFrom\": \"%s\", " +
                            "\"endTime\": \"%s\", " +
                            "\"meetingName\": \"%s\", " +
                            "\"organiser\": \"%s\"" +
                            "}",
                    userEmail, room, dateFrom, endTime, meetingName, organiser);
        }
    }
}
