package com.tempo.service.core.services;

import com.tempo.service.core.server.AsyncProvider;
import com.tempo.service.db.Database;

import javax.servlet.ServletException;
import javax.servlet.WriteListener;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;

import static com.tempo.service.core.db.tables.Test.TEST;

public class TestService extends HttpServlet {
    private Database db;

    public TestService() {
        db = new Database(); //TODO: Connect on start
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        var testQuery = db.execute(sql -> sql.selectFrom(TEST).fetchOne(TEST.USER_ID));
        AsyncProvider.print(request, response, getServletContext(), testQuery);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.getWriter().print("GET KEEP IT IN YOUR PANTS");
    }
}
