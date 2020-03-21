package com.tempo.service.core.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.simple.JSONArray;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class HttpHelper {

    public static Map<String, String> check(HttpServletRequest request,
                                HttpServletResponse response,
                                String... params) throws IOException {
        var body = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        var mapper = new ObjectMapper();
        Map<String, String> map = mapper.readValue(body, Map.class);
        for (var key : params) {
            if (map.get(key) == null) {
                response.sendError(1, "Missing parameter: " + key);
                return null;
            }
        }
        return map;
    }

    public static <T> String parseJSON(List<T> rows) {
        var output = new JSONArray();
        for (int i = 0; i < rows.size(); i++) {
            output.add(i, rows.get(i));
        }
        return output.toJSONString();
    }
}
