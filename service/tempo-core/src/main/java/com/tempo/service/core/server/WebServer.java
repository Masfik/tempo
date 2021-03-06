package com.tempo.service.core.server;

import com.tempo.service.core.services.AssignmentService;
import com.tempo.service.core.services.CheckinService;
import com.tempo.service.core.services.MeetingService;
import com.tempo.service.core.services.UserService;
import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ServerConnector;
import org.eclipse.jetty.servlet.ServletHandler;
import org.eclipse.jetty.util.thread.QueuedThreadPool;

public class WebServer {
    private Server server;

    public Handler getServer() {
        var handler = new ServletHandler();
        handler.addServletWithMapping(MeetingService.class, "/meetings");
        handler.addServletWithMapping(CheckinService.class, "/meetings/checkin");
        handler.addServletWithMapping(UserService.class, "/users");
        handler.addServletWithMapping(AssignmentService.class, "/meetings/assign");
        return handler;
    }

    public void start() throws Exception {
        var maxThreads = 100;
        var minThreads = 10;
        var idleTimeout = 120;

        var threadPool = new QueuedThreadPool(maxThreads, minThreads, idleTimeout);
        server = new Server(threadPool);
        var connector = new ServerConnector(server);
        connector.setPort(8090);
        server.setConnectors(new Connector[]{connector});
        server.setHandler(getServer());
        server.setStopAtShutdown(true);
        server.start();
        server.join();
    }
}
