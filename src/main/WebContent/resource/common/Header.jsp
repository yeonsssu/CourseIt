<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/ProjectCourseit/css/common/header.css">

<header class="fixed-header">
    <div id="top">
        <!-- 로고 영역 -->
        <section id="logo">
            <a href="Main.jsp"><img src="/ProjectCourseit/img/headerImg/logoMain.png" alt="코스잇 메인 로고"></a>
        </section>
        
        <!-- 로그인 상태에 따라 메뉴 표시 -->
        <div id="user-menu">
            <%
                String userId = (String) session.getAttribute("userId"); // 세션에서 userId 가져오기
                if (userId == null) {
                	
                    // 로그아웃 상태
            %>
            <a href="<%= request.getContextPath() %>/Login.jsp">로그인</a> |
            <a href="<%= request.getContextPath() %>/Sign_up.jsp">회원가입</a>
            <%
                } else {
                    // 로그인 상태
            %>
            <a href="<%= request.getContextPath() %>/logout.do">로그아웃</a> |
            <a href="<%= request.getContextPath() %>/Mypage.jsp">마이페이지</a>
            <%
                }
            %>
        </div>
        
        <!-- 네비게이션 메뉴 -->
        <nav id="head">
            <ul>
                <li><a href="#"><img alt="" src="/ProjectCourseit/img/headerImg/profile.jpg" style='border-radius: 100%'>프로필</a></li>
                <li><a href="#"><img alt="" src="/ProjectCourseit/img/headerImg/mycourse.png">마이코스</a></li>
                <li><a href="#"><img alt="" src="/ProjectCourseit/img/headerImg/daylog.png">데이로그</a></li>
                <li><a href="#"><img alt="" src="/ProjectCourseit/img/headerImg/perform.png">전시/공연</a></li>
                <li><a href="#"><img alt="" src="/ProjectCourseit/img/headerImg/middle.png">중간 지점 찾기</a></li>
            </ul>
        </nav>


    </div>
</header>

