package beans.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login.do")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 요청 파라미터에서 사용자 입력 데이터 가져오기
        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");

        // DAO 객체 생성 및 로그인 검증
        UserDAO userDAO = new UserDAO();
        boolean isValidUser = userDAO.loginCheck(userId, userPw);

        if (isValidUser) {
            // 로그인 성공: 세션에 사용자 정보 저장
            HttpSession session = request.getSession();
            session.setAttribute("userId", userId); // 세션에 userId 저장
            response.sendRedirect(request.getContextPath() + "/Main.jsp");
        } else {
            // 로그인 실패: 에러 메시지를 설정하고 로그인 페이지로 포워드
            request.setAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        }
    }
}