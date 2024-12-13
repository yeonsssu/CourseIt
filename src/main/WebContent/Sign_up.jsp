<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" type="text/css" href="css/pages/Sign_up.css">
</head>
<body>
    <div class="sign_up-container">
        <!-- 로고 -->
        <div id="logo">
            <a href="Main.jsp">
                <img src="img/headerImg/logoMain.png" alt="코스잇 메인 로고">
            </a>
        </div>
        <!-- 제목 -->
        <h1>회원가입</h1>
        <hr>
        <!-- 회원가입 폼 -->
        <form name="signUpForm" method="post" action="<%= request.getContextPath() %>/signUp.do">
            <!-- 아이디 입력 -->
            <div class="form-group">
                <label for="userId">아이디 *</label>
                <input type="text" id="userId" name="userId" placeholder="4~16자 영문/숫자만 허용" required>
                <button type="button" class="check-btn">중복 확인</button>
                <span id="userIdFeedback" class="feedback"></span>
            </div>
            <!-- 비밀번호 입력 -->
            <div class="form-group">
                <label for="userPw">비밀번호 *</label>
                <input type="password" id="userPw" name="userPw" placeholder="영문, 숫자 조합 8~16자" required>
            </div>
            <!-- 비밀번호 확인 -->
            <div class="form-group">
                <label for="pwdre">비밀번호 확인 *</label>
                <input type="password" id="pwdre" name="pwdre" placeholder="비밀번호를 한 번 더 입력하세요" required>
                <span id="pwdreFeedback" class="feedback"></span>
            </div>
            <!-- 닉네임 -->
            <div class="form-group">
                <label for="userName">닉네임 *</label>
                <input type="text" id="userName" name="userName" placeholder="예) 홍길동123" required>
            </div>
            <!-- 이메일 -->
            <div class="form-group">
                <label for="userEmail">이메일 *</label>
                <input type="email" id="userEmail" name="userEmail" placeholder="예) example@example.com" required>
            </div>
            <hr>
            <!-- 회원가입 버튼 -->
            <div class="form-group">
                <button type="submit" class="submit-btn">회원가입</button>
            </div>
        </form>
    </div>

    <!-- JavaScript 추가 -->
    <script>
        // 아이디 중복 확인
        document.querySelector(".check-btn").addEventListener("click", function () {
            const userId = document.querySelector("#userId").value.trim();

            if (!userId) {
                document.querySelector("#userIdFeedback").innerText = "아이디를 입력해주세요.";
                document.querySelector("#userIdFeedback").style.color = "red";
                return;
            }

            fetch("<%= request.getContextPath() %>/idCheck.do?userId=" + encodeURIComponent(userId))
                .then(response => response.json())
                .then(data => {
                    if (data.isDuplicate) {
                        document.querySelector("#userIdFeedback").innerText = "이미 사용 중인 아이디입니다.";
                        document.querySelector("#userIdFeedback").style.color = "red";
                    } else {
                        document.querySelector("#userIdFeedback").innerText = "사용 가능한 아이디입니다.";
                        document.querySelector("#userIdFeedback").style.color = "green";
                    }
                })
                .catch(error => {
                    console.error("Error:", error);
                    document.querySelector("#userIdFeedback").innerText = "오류가 발생했습니다.";
                    document.querySelector("#userIdFeedback").style.color = "red";
                });
        });

        // 비밀번호 확인
        document.querySelector("#pwdre").addEventListener("input", function () {
            const password = document.querySelector("#userPw").value.trim();
            const confirmPassword = document.querySelector("#pwdre").value.trim();
            const feedback = document.querySelector("#pwdreFeedback");

            if (confirmPassword === "") {
                feedback.textContent = ""; // 비워진 경우 피드백 제거
            } else if (password === confirmPassword) {
                feedback.textContent = "비밀번호가 일치합니다.";
                feedback.style.color = "green";
            } else {
                feedback.textContent = "비밀번호가 일치하지 않습니다.";
                feedback.style.color = "red";
            }
        });

        // 폼 제출 시 비밀번호 확인
        document.querySelector("form").addEventListener("submit", function (event) {
            const password = document.querySelector("#userPw").value.trim();
            const confirmPassword = document.querySelector("#pwdre").value.trim();
            if (password !== confirmPassword) {
                event.preventDefault();
                alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
            }
        });
    </script>
</body>
</html>
