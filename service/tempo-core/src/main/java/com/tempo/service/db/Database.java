package com.tempo.service.db;

import org.jooq.DSLContext;
import org.jooq.Record;
import org.jooq.Result;
import org.jooq.SQLDialect;
import org.jooq.impl.DSL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.function.Function;

public class Database {
    public Connection conn;

    public Database() {
        var userName = "vagrant";
        var password = "postgres";
        var url = "jdbc:postgresql://localhost:5432/tempo";

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(url, userName, password);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String execute(Function<DSLContext, String> callback) {
        DSLContext sql = DSL.using(conn, SQLDialect.POSTGRES);
        return callback.apply(sql);
    }
}
