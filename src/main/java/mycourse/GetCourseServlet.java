package mycourse;

import com.google.gson.Gson;

import mycourse.CourseServlet.Marker;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
@WebServlet("/GetCourseServlet")
public class GetCourseServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/backend?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "dongyang";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        System.out.println("GetCourseServlet 요청이 시작되었습니다.");

        List<Marker> markers = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("JDBC 드라이버 로드 완료.");

            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                System.out.println("데이터베이스 연결 성공.");
                String sql = "SELECT course_name, place_name, address, latitude, longitude FROM markers";
                try (PreparedStatement statement = connection.prepareStatement(sql);
                     ResultSet resultSet = statement.executeQuery()) {
                    
                    System.out.println("데이터베이스에서 데이터 조회 중...");
                    while (resultSet.next()) {
                        Marker marker = new Marker();
                        marker.setCourseName(resultSet.getString("course_name"));
                        marker.setName(resultSet.getString("place_name"));
                        marker.setAddress(resultSet.getString("address"));
                        marker.setLatitude(resultSet.getDouble("latitude"));
                        marker.setLongitude(resultSet.getDouble("longitude"));

                        
                        // 디버깅 출력
                        System.out.println("코스 이름: " + marker.getCourseName());
                        System.out.println("장소: " + marker.getName());
                        System.out.println("주소: " + marker.getAddress());
                        System.out.println("위도: " + marker.getLatitude());
                        System.out.println("경도: " + marker.getLongitude());
 

                        markers.add(marker);

                    }
                    System.out.println("데이터베이스에서 데이터 조회 완료.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database error: " + e.getMessage());
            return;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("JDBC Driver not found: " + e.getMessage());
            return;
        }

        // JSON으로 반환
        Gson gson = new Gson();
        String json = gson.toJson(markers);
        System.out.println("JSON 데이터 반환 준비 완료.");
        response.getWriter().write(json);
        System.out.println("json데이터 변환 후"  + json);
    }
}
