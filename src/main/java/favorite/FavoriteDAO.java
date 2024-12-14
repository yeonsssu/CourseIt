package favorite;

import java.sql.*;
import java.util.*;

import favorite.dto.FavoriteDTO;
import favorite.beans.user.JDBCUtil;

public class FavoriteDAO {
    public boolean addFavorite(FavoriteDTO favorite) {
        String sql = "INSERT INTO favorites (userId, title) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, favorite.getUserId());
            pstmt.setString(2, favorite.getTitle());
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeFavorite(FavoriteDTO favorite) {
        String sql = "DELETE FROM favorites WHERE userId = ? AND title = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, favorite.getUserId());
            pstmt.setString(2, favorite.getTitle());
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<FavoriteDTO> getFavoritesByUser(String userId) {
        String sql = "SELECT * FROM favorites WHERE userId = ?";
        List<FavoriteDTO> favorites = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                FavoriteDTO favorite = new FavoriteDTO();
                favorite.setId(rs.getInt("id"));
                favorite.setUserId(rs.getString("userId"));
                favorite.setTitle(rs.getString("title"));
                favorite.setCreatedAt(rs.getString("created_at"));
                favorites.add(favorite);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return favorites;
    }
}

