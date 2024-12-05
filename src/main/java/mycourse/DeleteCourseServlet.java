package mycourse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import mycourse.CourseServlet.Marker;

@WebServlet("/DeleteCourseServlet")
public class DeleteCourseServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/coursedb?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseName = request.getParameter("courseName");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC 드라이버 로드
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("JDBC Driver not found: " + e.getMessage());
            return;
        }

        if (courseName == null || courseName.isEmpty()) {
            response.getWriter().write("{\"error\":\"코스 이름이 필요합니다.\"}");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "DELETE FROM markers WHERE course_name = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, courseName);
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    // 삭제 후, 남아있는 코스를 반환하기 위해 GetCourseServlet을 호출
                    response.setContentType("application/json; charset=UTF-8");
                    response.setCharacterEncoding("UTF-8");

                    List<Marker> markers = new ArrayList<>();
                    String sql = "SELECT course_name, place_name, address, latitude, longitude FROM markers";
                    try (PreparedStatement statement = conn.prepareStatement(sql);
                         ResultSet resultSet = statement.executeQuery()) {
                        while (resultSet.next()) {
                            Marker marker = new Marker();
                            marker.setCourseName(resultSet.getString("course_name"));
                            marker.setName(resultSet.getString("place_name"));
                            marker.setAddress(resultSet.getString("address"));
                            marker.setLatitude(resultSet.getDouble("latitude"));
                            marker.setLongitude(resultSet.getDouble("longitude"));

                            markers.add(marker);
                        }
                    }

                    // JSON으로 반환
                    Gson gson = new Gson();
                    String json = gson.toJson(markers);
                    response.getWriter().write(json);
                } else {
                    response.getWriter().write("{\"error\":\"코스를 찾을 수 없습니다.\"}");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"error\":\"서버 오류 발생.\"}");
        }
    }
}
