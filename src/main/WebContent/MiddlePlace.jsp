<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>
    <title>중간 지점 찾기</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            background-color: #f4f4f4;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            max-width: 800px;
        }
        .collection-item {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            background-color: #f9f9f9;
            border-radius: 4px;
            margin-bottom: 10px;
            padding: 10px 15px;
        }
        .collection-item div {
            display: flex;
            flex-direction: row;
            align-items: center;
            width: 100%;
            justify-content: space-between;
        }
        .collection-item h2 {
            font-size: 1.2em;
            margin: 0;
            color: #333;
            display: inline;
            margin-right: 5px;
        }
        .collection-item span {
            margin: 0 5px;
            border-left: 1px solid #ccc;
            padding-left: 5px;
        }
        .collection-item p {
            margin: 0;
            color: #777;
            display: inline;
        }
        .collection-item .secondary-content {
            color: #e57373;
            cursor: pointer;
        }
        .collection-item .secondary-content i {
            font-size: 24px;
        }
        .btn {
            margin: 10px 0;
        }
        .collection {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h3 class="center">중간 지점 찾기</h3>

        <!-- 데이터베이스에서 가져온 사용자 목록 표시 -->
        <h4>데이터베이스에 저장된 사용자 목록</h4>
        <ul class="collection" id="dbMembersList"></ul>

        <!-- 참석자 추가 버튼 -->
        <button class="btn waves-effect waves-light" onclick="addMember()">Add Member</button>

        <!-- 중간 지점 찾기 버튼 -->
        <button class="btn waves-effect waves-light" onclick="findMidpoint()">중간 지점 찾기</button>
    </div>

    <script>
        // 페이지 로드 시 데이터베이스에서 사용자 목록 가져오기
        $(document).ready(function() {
            $.ajax({
                url: "/ProjectCourseit/SearchMemberServlet",
                type: "GET",
                success: function(data) {
                    console.log("응답 데이터:", data);
                    if (Array.isArray(data)) {
                        const dbMembersList = $('#dbMembersList');
                        dbMembersList.empty(); // 기존 목록 비우기

                        data.forEach(member => {
                            const name = member.name || "정보 없음";
                            const placeName = member.placeName || "정보 없음";

                            // 새로운 리스트 아이템 생성
                            const div = document.createElement("li");
                            div.classList.add('collection-item');
                            const contentDiv = document.createElement("div");

                            // 이름 생성
                            const heading = document.createElement("h2");
                            heading.textContent = name;
                            contentDiv.appendChild(heading);

                            // 구분선 추가
                            const separator = document.createElement("span");
                            contentDiv.appendChild(separator);

                            // 장소 이름 추가
                            const heading2 = document.createElement("p");
                            heading2.textContent = placeName;
                            contentDiv.appendChild(heading2);

                            // 삭제 버튼 생성 및 이벤트 연결
                            const deleteButton = document.createElement("button");
                            deleteButton.classList.add('btn', 'black', 'waves-effect', 'waves-light', 'secondary-content', 'delete-btn');
                            deleteButton.textContent = '삭제';
                            deleteButton.dataset.name = name;
                            deleteButton.addEventListener('click', function() {
                                deleteMember(name);
                            });
                            contentDiv.appendChild(deleteButton);

                            // 생성된 내용을 목록에 추가
                            div.appendChild(contentDiv);
                            dbMembersList.append(div);
                        });

                        // 참석자 수 출력
                        console.log('참석자 수:', data.length);
                    } else {
                        console.error("응답 형식이 잘못되었습니다:", data);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('회원 가져오기 오류:', error);
                }
            });
        });

        // 참석자 추가 함수
        function addMember() {
            window.location.href = 'addMember.jsp';
        }

        // 중간 지점 찾기 함수
        function findMidpoint() {
            const members = document.querySelectorAll('#dbMembersList .collection-item');
            console.log('참석자 수:', members.length);

            if (members.length < 2) {
                alert('중간 지점을 찾으려면 최소 2명의 참석자가 필요합니다. 참석자를 추가해주세요.');
                return;
            }
            window.location.href = 'goSpot.jsp';
        }

        // 멤버 삭제 함수
        function deleteMember(memberName) {
            if (confirm('정말로 이 멤버를 삭제하시겠습니까?')) {
                $.ajax({
                    url: '/ProjectCourseit/DeleteMemberServlet',
                    type: 'GET',
                    data: { name: memberName },
                    success: function(response) {
                        alert('멤버가 삭제되었습니다.');
                        // 삭제된 항목을 DOM에서 제거
                        $('#dbMembersList .collection-item').each(function() {
                            if ($(this).find('button').data('name') === memberName) {
                                $(this).remove();
                            }
                        });
                    },
                    error: function(xhr, status, error) {
                        console.error('멤버 삭제 중 오류가 발생했습니다.', error);
                        alert('멤버 삭제 중 오류가 발생했습니다.');
                    }
                });
            }
        }
    </script>
</body>
</html>
