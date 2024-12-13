package mycourse;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/CourseServlet")
public class CourseServlet extends HttpServlet {
	private static final String DB_URL = "jdbc:mysql://localhost:3306/backend?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root"; // 데이터베이스 사용자명
    private static final String DB_PASSWORD = "dongyang"; // 데이터베이스 비밀번호
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try {
    	    Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC 드라이버 로드
    	} catch (ClassNotFoundException e) {
    	    e.printStackTrace();
    	    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    	    response.getWriter().write("JDBC Driver not found: " + e.getMessage());
    	    return;
    	}

    	

        // JSON 데이터 읽기
        String jsonData = request.getParameter("data"); // 쿼리 파라미터에서 JSON 데이터 가져오기
        if (jsonData == null || jsonData.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("No data provided");
            return;
        }

        Gson gson = new Gson();
        Type markerListType = new TypeToken<List<Marker>>() {}.getType();
        List<Marker> markers = gson.fromJson(jsonData, markerListType);

        // 데이터베이스에 저장
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO markers (course_name, place_name, address, latitude, longitude) VALUES (? ,?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
            	System.out.println("JSON Data: " + jsonData);
            	System.out.println("Parsed Markers: " + markers);
                for (Marker marker : markers) {
                	statement.setString(1, marker.getCourseName()); 
                    statement.setString(2, marker.getName());
                    statement.setString(3, marker.getAddress());
                    statement.setDouble(4, marker.getLatitude());
                    statement.setDouble(5, marker.getLongitude());
                   
                    statement.addBatch();
                }
                statement.executeBatch();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database error: " + e.getMessage());
            return;
        }

        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("Data saved successfully!");
    }

    // Marker 클래스 정의
    public static class Marker {
    	private String courseName;
        private String name;
        private String address;
        private double latitude;
        private double longitude;

        // Getters and Setters
        public String getCourseName() { return courseName; } 
        public void setCourseName(String courseName) { this.courseName = courseName; }
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }
        public double getLatitude() { return latitude; }
        public void setLatitude(double latitude) { this.latitude = latitude; }
        public double getLongitude() { return longitude; }
        public void setLongitude(double longitude) { this.longitude = longitude; }
    }
}
