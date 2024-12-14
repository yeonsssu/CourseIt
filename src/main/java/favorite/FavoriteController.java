package favorite;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


import org.json.*;

import favorite.dao.FavoriteDAO;
import favorite.dto.FavoriteDTO;

@WebServlet("/favorite")
public class FavoriteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FavoriteDAO favoriteDAO = new FavoriteDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            // Parse JSON request
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            JSONObject jsonRequest = new JSONObject(sb.toString());

            String userId = jsonRequest.getString("userId");
            String title = jsonRequest.getString("title");
            boolean isFavorited = jsonRequest.getBoolean("isFavorited");

            FavoriteDTO favorite = new FavoriteDTO(userId, title);
            boolean success;

            if (isFavorited) {
                success = favoriteDAO.addFavorite(favorite);
            } else {
                success = favoriteDAO.removeFavorite(favorite);
            }

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", success);
            jsonResponse.put("isFavorited", isFavorited);
            response.getWriter().write(jsonResponse.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            String userId = request.getParameter("userId");
            List<FavoriteDTO> favorites = favoriteDAO.getFavoritesByUser(userId);

            JSONArray jsonArray = new JSONArray();
            for (FavoriteDTO favorite : favorites) {
                JSONObject json = new JSONObject();
                json.put("id", favorite.getId());
                json.put("title", favorite.getTitle());
                json.put("createdAt", favorite.getCreatedAt());
                jsonArray.put(json);
            }

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("favorites", jsonArray);
            response.getWriter().write(jsonResponse.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false}");
        }
    }
}
