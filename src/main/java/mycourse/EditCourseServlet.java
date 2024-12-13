package mycourse;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/EditCourseServlet")
public class EditCourseServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/backend?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root"; // 데이터베이스 사용자명
    private static final String DB_PASSWORD = "dongyang"; // 데이터베이스 비밀번호

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain; charset=UTF-8");

        // 쿼리 매개변수에서 oldName과 newName 가져오기
        String oldName = request.getParameter("oldCourseName");
        String newName = request.getParameter("newCourseName");

        // 매개변수 검증
        if (oldName == null || newName == null || oldName.trim().isEmpty() || newName.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid course names provided");
            return;
        }

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // 데이터베이스에서 코스 이름 업데이트
            String sql = "UPDATE markers SET course_name = ? WHERE course_name = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, newName);
                statement.setString(2, oldName);

                int rowsUpdated = statement.executeUpdate();

                if (rowsUpdated > 0) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Course name updated successfully");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("Course not found");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database error: " + e.getMessage());
        }
    }
}
