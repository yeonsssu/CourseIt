<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보수정</title>
    <link rel="stylesheet" type="text/css" href="css/pages/EditMyProfile.css">
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
        <h1>회원정보수정</h1>
        <hr>
        <!-- 회원정보 수정 폼 -->
        <form name="editProfileForm" method="post" action="<%= request.getContextPath() %>/editMyProfile.do">
            <!-- 아이디 (수정 불가) -->
            <div class="form-group">
                <label for="userId">아이디 *</label>
                <input type="text" id="userId" name="userId" value="<%= session.getAttribute("userId") %>" readonly>
            </div>
            <!-- 비밀번호 수정 -->
            <div class="form-group">
                <label for="userPw">비밀번호 *</label>
                <input type="password" id="userPw" name="userPw" placeholder="새 비밀번호를 입력하세요" required>
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
                <input type="text" id="userName" name="userName" 
                       value="<%= session.getAttribute("userName") == null ? "" : session.getAttribute("userName") %>" required>
            </div>
            <!-- 이메일 -->
            <div class="form-group">
                <label for="userEmail">이메일 *</label>
                <input type="email" id="userEmail" name="userEmail" 
                       value="<%= session.getAttribute("userEmail") == null ? "" : session.getAttribute("userEmail") %>" required>
            </div>
            <hr>
            <!-- 정보 수정 버튼 -->
            <div class="form-group">
                <button type="submit" class="submit-btn">정보 수정</button>
            </div>
        </form>
    </div>

    <!-- 비밀번호 확인 JavaScript -->
    <script>
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
