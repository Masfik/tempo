package com.tempo.service.core;

import com.tempo.service.core.server.WebServer;

public class Tempo {

    public static void main(String[] args) throws Exception {
        WebServer shit = new WebServer();
        shit.start();
    }
}
