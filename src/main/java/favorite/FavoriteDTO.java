package favorite;

public class FavoriteDTO {
    private int id; // Primary Key
    private String userId; // 외래 키로 userId 참조
    private String title; // 찜한 전시 제목
    private String createdAt; // 생성 시간

    public FavoriteDTO() {}

    public FavoriteDTO(String userId, String title) {
        this.userId = userId;
        this.title = title;
    }

    // Getter and Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}
