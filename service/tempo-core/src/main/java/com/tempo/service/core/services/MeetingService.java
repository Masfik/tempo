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

public class MeetingService extends HttpServlet {
    private Database db;

    public MeetingService() {
        db = new Database(); //TODO: Connect on start
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        var rows = db.execute(sql -> sql.selectFrom(MEETING)
                .fetch(r -> new Meeting(
                        r.get(ASSIGNMENT.ROOM),
                        r.get(ASSIGNMENT.DATE_FROM),
                        r.get(ASSIGNMENT.END_TIME),
                        r.get(MEETING.MEETING_NAME),
                        r.get(MEETING.ORGANISER))));
        AsyncProvider.print(request, response, getServletContext(), parseJSON(rows));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            var map = check(request, response,
                    "qrHash", "meetingName",
                    "room", "dateFrom",
                    "endTime", "organiser");
            if (map == null) return;

            var dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS");
            var timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
            var rows = db.execute(sql -> sql.insertInto(MEETING)
                    .set(MEETING.QR_HASH, map.get("qrHash"))
                    .set(MEETING.MEETING_NAME, map.get("meetingName"))
                    .set(MEETING.ROOM, map.get("room"))
                    .set(MEETING.DATE_FROM, LocalDateTime.parse(map.get("dateFrom"), dateTimeFormatter))
                    .set(MEETING.END_TIME, LocalTime.parse(map.get("endTime"), timeFormatter))
                    .set(MEETING.ORGANISER, map.get("organiser"))
                    .execute());
            response.getWriter().print("Rows inserted: " + rows);
        } catch (MismatchedInputException ex) {
            response.sendError(1, "Missing or invalid parameters");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendError(1, "Internal server error");
        }
    }

    static class Meeting {
        final String room;
        final LocalDateTime dateFrom;
        final LocalTime endTime;
        final String meetingName;
        final String organiser;

        Meeting(String room, LocalDateTime dateFrom, LocalTime endTime, String meetingName, String organiser) {
            this.room = room;
            this.dateFrom = dateFrom;
            this.endTime = endTime;
            this.meetingName = meetingName;
            this.organiser = organiser;
        }

        @Override
        public String toString() {
            return String.format("{" +
                            "\"room\": \"%s\", " +
                            "\"dateFrom\": \"%s\", " +
                            "\"endTime\": \"%s\", " +
                            "\"meetingName\": \"%s\", " +
                            "\"organiser\": \"%s\"" +
                            "}",
                    room, dateFrom, endTime, meetingName, organiser);
        }
    }
}
