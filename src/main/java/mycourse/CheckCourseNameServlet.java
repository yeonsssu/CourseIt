package mycourse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/CheckCourseNameServlet")
public class CheckCourseNameServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/backend?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "dongyang";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseName = request.getParameter("courseName");
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
    	try {
    	    Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC 드라이버 로드
    	} catch (ClassNotFoundException e) {
    	    e.printStackTrace();
    	    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    	    response.getWriter().write("JDBC Driver not found: " + e.getMessage());
    	    return;
    	}


        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT COUNT(*) AS count FROM markers WHERE course_name = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, courseName);
                ResultSet resultSet = statement.executeQuery();
                
                resultSet.next();
                int count = resultSet.getInt("count");

                // JSON 응답 작성
                boolean exists = (count > 0);
                String jsonResponse = new Gson().toJson(new Response(exists));

                response.getWriter().write(jsonResponse);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database error: " + e.getMessage() + "\"}");
        }
    }

    // JSON 응답 구조를 정의하는 클래스
    private static class Response {
        private boolean exists;

        public Response(boolean exists) {
            this.exists = exists;
        }
    }
}
