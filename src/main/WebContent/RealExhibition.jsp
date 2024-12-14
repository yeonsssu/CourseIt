<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>전시/공연 목록</title>
    <link rel="stylesheet" type="text/css" href="/ProjectCourseit/css/pages/RealExhibition.css">
</head>

<body>
    <%@ include file="resource/common/Header.jsp" %>
    <h2 class="exhibition-header">전시/공연 전체보기</h2>
    <div class="exhibition-list">
        <!-- Exhibition items will be loaded here -->
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const fetchExhibitions = async () => {
                try {
                    const response = await fetch('resource/data/finalExhibitions.json');
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }

                    const data = await response.json();
                    renderExhibitions(data);
                } catch (error) {
                    console.error('Error loading exhibitions:', error);
                }
            };

            const renderExhibitions = (data) => {
                const container = document.querySelector('.exhibition-list');
                if (!container) {
                    console.error('Container for exhibition list not found.');
                    return;
                }

                const savedFavorites = JSON.parse(localStorage.getItem('favorites')) || [];

                container.innerHTML = data.map(item => {
                    const isFavorited = savedFavorites.includes(item.title);
                    return `
                        <div class="exhibition-item">
                            <a href="\${item.link}" target="_blank" rel="noopener noreferrer">
                                <img src="\${item.image}" alt="\${item.title}">
                                <div class="exhibition-info">
                                    <h3 class="title">\${item.title}</h3>
                                    <p class="schedule">📆 \${item.date}</p>
                                    <p class="location">🚩 \${item.place}</p>
                                </div>
                            </a>
                            <button 
                                class="favorite-btn" 
                                data-title="\${item.title}" 
                                aria-label="\${isFavorited ? '찜 취소' : '찜하기'}"
                                style="background-color: \${isFavorited ? 'red' : 'gray'};">
                                ❤️
                            </button>
                        </div>
                    `;
                }).join('');

                attachFavoriteEventHandlers();
            };

            const attachFavoriteEventHandlers = () => {
                const buttons = document.querySelectorAll('.favorite-btn');
                const savedFavorites = JSON.parse(localStorage.getItem('favorites')) || [];

                buttons.forEach(button => {
                    button.addEventListener('click', (event) => {
                        const title = event.target.getAttribute('data-title');
                        const index = savedFavorites.indexOf(title);

                        if (index > -1) {
                            // Remove from favorites
                            savedFavorites.splice(index, 1);
                        } else {
                            // Add to favorites
                            savedFavorites.push(title);
                        }

                        // Save updated favorites to localStorage
                        localStorage.setItem('favorites', JSON.stringify(savedFavorites));

                        // Update button appearance
                        event.target.style.backgroundColor = index > -1 ? 'gray' : 'red';
                        event.target.setAttribute('aria-label', index > -1 ? '찜하기' : '찜 취소');
                    });
                });
            };

            // Fetch and render exhibitions
            fetchExhibitions();
        });
    </script>
</body>

</html>
