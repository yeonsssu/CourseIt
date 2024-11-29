package admin;

import beans.user.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/userServlet.do")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDao = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("Action: " + action); // 로그 출력

        if ("add".equals(action)) {
            addUser(request, response);
        } else if ("edit".equals(action)) {
            editUser(request, response);
        } else if ("delete".equals(action)) {
            deleteUser(request, response);
        }
    }


    private void addUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = request.getParameter("userId");
        String userPw = request.getParameter("userPw");
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");

        UserDTO newUser = new UserDTO();
        newUser.setUserId(userId);
        newUser.setUserPw(userPw);
        newUser.setUserName(userName);
        newUser.setUserEmail(userEmail);

        if (userDao.userInsert(newUser)) {
        	response.sendRedirect(request.getContextPath() + "/AdminPage/User_management.jsp");
        } else {
            response.getWriter().println("Error adding user.");
        }
    }

    private void editUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String userId = request.getParameter("userId");
        UserDTO user = userDao.getUserInfo(userId);

        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("edit_user.jsp").forward(request, response);
        } else {
            response.getWriter().println("User not found.");
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = request.getParameter("userId");
        
        if (userDao.deleteUser(userId)) {
        	response.sendRedirect(request.getContextPath() + "/AdminPage/User_management.jsp");
        } else {
            response.getWriter().println("Error deleting user.");
        }
    }
}
