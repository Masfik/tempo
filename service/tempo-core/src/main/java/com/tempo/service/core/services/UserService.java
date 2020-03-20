package com.tempo.service.core.services;

import com.tempo.service.core.server.AsyncProvider;
import com.tempo.service.db.Database;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static com.tempo.service.core.db.tables.AppUser.APP_USER;
import static com.tempo.service.core.utils.HttpHelper.parseJSON;

public class UserService extends HttpServlet {
    private Database db;

    public UserService() {
        db = new Database(); //TODO: Connect on start
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        var rows = db.execute(sql -> sql.selectFrom(APP_USER)
                .fetch(r -> new User(
                        r.get(APP_USER.EMAIL),
                        r.get(APP_USER.FIRST_NAME),
                        r.get(APP_USER.SURNAME))));
        AsyncProvider.print(request, response, getServletContext(), parseJSON(rows));
    }

    static class User {
        final String email;
        final String firstName;
        final String surname;

        User(String email, String firstName, String surname) {
            this.email = email;
            this.firstName = firstName;
            this.surname = surname;
        }

        @Override
        public String toString() {
            return String.format("{" +
                            "\"email\": \"%s\", " +
                            "\"firstName\": \"%s\", " +
                            "\"surname\": \"%s\"" +
                            "}",
                    email, firstName, surname);
        }
    }
}
