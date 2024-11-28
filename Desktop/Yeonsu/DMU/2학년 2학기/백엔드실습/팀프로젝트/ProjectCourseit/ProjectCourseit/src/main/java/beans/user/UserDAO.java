package beans.user;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;




public class UserDAO {

    public boolean loginCheck(String userId, String userPw) {// 로그인, 회원가입 아이디 중복 확인
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean loginCon = false;
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "select userId, userPw from user where userId = ? and userPw = ?";

            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, userId);
            pstmt.setString(2, userPw);
            rs = pstmt.executeQuery();
            loginCon = rs.next();
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return loginCon;
    }	
    
    public boolean idCheck(String userId) {// 로그인, 회원가입 아이디 중복 확인
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean loginCon = false;
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "select userId from users where userId = ?";

            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            loginCon = rs.next();
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return loginCon;
    }	
	
	
    public boolean userInsert(UserDTO uDTO) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;

        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "INSERT INTO user (userId, userEmail, userPw, userName) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, uDTO.getUserId());
            pstmt.setString(2, uDTO.getUserEmail());
            pstmt.setString(3, uDTO.getUserPw());
            pstmt.setString(4, uDTO.getUserName());

            int count = pstmt.executeUpdate();

            if (count == 1) {
                flag = true;
            }
          
    	} catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
            JDBCUtil.close(pstmt, conn);
        }

        return flag;
    }

    public boolean updateUser(UserDTO uDTO) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean isUpdated = false;

        try {
            conn = JDBCUtil.getConnection();
            String strQuery = "UPDATE user SET userPw = ?, userName = ?, userEmail = ? WHERE userId = ?";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, uDTO.getUserPw()); // 비밀번호
            pstmt.setString(2, uDTO.getUserName()); // 닉네임
            pstmt.setString(3, uDTO.getUserEmail()); // 이메일
            pstmt.setString(4, uDTO.getUserId()); // 아이디

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isUpdated = true;
            }
        } catch (Exception ex) {
            System.out.println("Exception: " + ex.getMessage());
        } finally {
            JDBCUtil.close(pstmt, conn);
        }

        return isUpdated;
    }
    
    public UserDTO getUserInfo(String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        UserDTO user = null;

        try {
            conn = JDBCUtil.getConnection();
            String strQuery = "SELECT userId, userName, userEmail FROM user WHERE userId = ?";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new UserDTO();
                user.setUserId(rs.getString("userId"));
                user.setUserName(rs.getString("userName"));
                user.setUserEmail(rs.getString("userEmail"));
            }
        } catch (Exception ex) {
            System.out.println("Exception: " + ex.getMessage());
        } finally {
            JDBCUtil.close(rs, pstmt, conn);
        }

        return user;
    }
    
    public List<UserDTO> getAllUsers() {
        List<UserDTO> userList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = JDBCUtil.getConnection();
            String query = "SELECT userId, userName, userEmail FROM user";
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserId(rs.getString("userId"));
                user.setUserName(rs.getString("userName"));
                user.setUserEmail(rs.getString("userEmail"));
                userList.add(user);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            JDBCUtil.close(rs, pstmt, conn);
        }
        return userList;
    }

    public boolean deleteUser(String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean isDeleted = false;

        try {
            conn = JDBCUtil.getConnection();
            String query = "DELETE FROM user WHERE userId = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);
            isDeleted = pstmt.executeUpdate() > 0;
            
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            JDBCUtil.close(pstmt, conn);
        }
        return isDeleted;
    }




	

}
