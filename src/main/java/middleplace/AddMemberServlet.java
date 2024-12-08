package middleplace;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/AddMemberServlet")
public class AddMemberServlet extends HttpServlet {
    // 데이터베이스 연결 정보
    private static final String DB_URL = "jdbc:mysql://localhost:3306/coursedb"; // 데이터베이스 URL
    private static final String DB_USER = "root"; // 데이터베이스 사용자명
    private static final String DB_PASSWORD = "1234"; // 데이터베이스 비밀번호

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
    	try {
    	    Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC 드라이버 로드
    	} catch (ClassNotFoundException e) {
    	    e.printStackTrace();
    	    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    	    response.getWriter().write("JDBC Driver not found: " + e.getMessage());
    	    return;
    	}
        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 요청 파라미터 가져오기
        String attendeeName = request.getParameter("attendee_name"); // 참석자 이름
        String placeName = request.getParameter("place_name");
        String address = request.getParameter("address");
        String latitude = request.getParameter("latitude");
        String longitude = request.getParameter("longitude");

        // DB 연결 및 쿼리 실행
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO members (name, place_name, address, latitude, longitude) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, attendeeName);
                stmt.setString(2, placeName);
                stmt.setString(3, address);
                stmt.setDouble(4, Double.parseDouble(latitude)); // 위도를 DOUBLE로 변환
                stmt.setDouble(5, Double.parseDouble(longitude)); // 경로를 DOUBLE로 변환

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.print("SUCCESS");
                } else {
                    out.print("FAIL");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("ERROR: " + e.getMessage());
        } finally {
            out.close();
        }
    }
}
