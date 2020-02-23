package com.tempo.service.core.server;

import javax.servlet.ServletContext;
import javax.servlet.WriteListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;

public class AsyncProvider {

    public static void print(HttpServletRequest request,
                             HttpServletResponse response,
                             ServletContext context,
                             String output) throws IOException {
        var content = ByteBuffer.wrap(output.getBytes(StandardCharsets.UTF_8));
        var async = request.startAsync();
        var out = response.getOutputStream();
        out.setWriteListener(new WriteListener() {
            @Override
            public void onWritePossible() throws IOException {
                while (out.isReady()) {
                    if (!content.hasRemaining()) {
                        response.setStatus(200);
                        async.complete();
                        return;
                    }
                    out.write(content.get());
                }
            }

            @Override
            public void onError(Throwable t) {
                context.log("Async Error", t);
                async.complete();
            }
        });
    }
}
