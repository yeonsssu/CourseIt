package beans.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/editMyProfile.do")
public class EditMyProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 세션에서 현재 로그인된 사용자 ID 가져오기
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            // 로그인 상태가 아니면 메인 페이지로 리디렉션
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
            return;
        }

        // 폼 데이터 가져오기
        String userPw = request.getParameter("userPw");
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");

        // DTO 객체 생성
        UserDTO user = new UserDTO();
        user.setUserId(userId); // 세션에서 가져온 ID
        user.setUserPw(userPw);
        user.setUserName(userName);
        user.setUserEmail(userEmail);

        // DAO를 이용하여 업데이트
        UserDAO userDAO = new UserDAO();
        boolean isUpdated = userDAO.updateUser(user);

        if (isUpdated) {
            // 정보 수정 성공
            session.setAttribute("userName", userName); // 세션에 닉네임 업데이트
            session.setAttribute("userEmail", userEmail); // 세션에 이메일 업데이트
            response.sendRedirect(request.getContextPath() + "/Mypage.jsp");
        } else {
            // 정보 수정 실패
            request.setAttribute("errorMessage", "회원정보 수정에 실패했습니다.");
        }
    }
}
