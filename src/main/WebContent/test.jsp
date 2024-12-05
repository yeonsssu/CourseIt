<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카카오맵 AJAX</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>카카오맵 장소 검색</h1>

    <!-- 검색 결과를 출력할 영역 -->
    <div id="results"></div>

    <script>
        // 카테고리 기반 장소 검색 AJAX 요청
        function searchCategoryPlaces() {
            $.ajax({
                url: "https://dapi.kakao.com/v2/local/search/category",
                type: "GET",
                headers: {
                    "Authorization": "KakaoAK 676ae9f87e9169483e6cbd17eb3c6b17" // 수정된 부분
                },
                data: {
                    category_group_code: "FD6", // 음식점
                    x: 126.9784, // 경도
                    y: 37.5665, // 위도
                    radius: 2000, // 반경 2km
                    sort: "distance" // 거리순 정렬
                },
                success: function (response) {
                	 console.log("API 응답:", response); 
                   // 디버깅용 데이터 확인
                    if (response && Array.isArray(response.documents) && response.documents.length > 0) {
                        displayResults(response.documents);
                    } else {
                        $("#results").html("<p>결과가 없습니다.</p>");
                    }
                },
                error: function (xhr, status, error) {
                    console.error("AJAX 요청 오류:", error);
                    $("#results").html("<p>요청 처리 중 오류가 발생했습니다.</p>");
                }
            });
        }

     // 검색 결과 표시 함수
        function displayResults(documents) {
            const resultsContainer = document.getElementById("results");
            resultsContainer.innerHTML = ""; // 기존 내용을 초기화

            if (!documents || documents.length === 0) {
                const noResultsMessage = document.createElement("p");
                noResultsMessage.textContent = "결과가 없습니다.";
                resultsContainer.appendChild(noResultsMessage);
                return;
            }

            // documents 배열을 순회하며 필요한 정보만 바로 출력
            documents.forEach(place => {
                const name = place.place_name || "정보 없음";
                const phone = place.phone || "정보 없음";

                // 새로운 div 요소 생성
                const div = document.createElement("div");

                // 제목 생성 (가게 이름)
                const heading = document.createElement("h3");
                heading.textContent = name;
                div.appendChild(heading);

                // 전화번호 생성
                const phoneParagraph = document.createElement("p");
                phoneParagraph.textContent = phone;
                div.appendChild(phoneParagraph);

                // 구분선 생성
                const hr = document.createElement("hr");
                div.appendChild(hr);

                // 생성한 div 요소를 결과 컨테이너에 추가
                resultsContainer.appendChild(div);
            });
        }
     
     
        $(document).ready(function () {
            searchCategoryPlaces();
        });

    </script>
</body>
</html>
