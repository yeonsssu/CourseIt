<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/exhibition.css">
<title>exhibition page</title>
</head>
<body>
 <header>
        <!-- 최상단 메인 로고-->
    	<div id="top">
    		<section id="logo">
    	            <a><img src="img/headerImg/logoMain.png" alt="코스잇 메인 로고"></a>	
    		</section>
	        <nav id="head">
	            <ul>
	                <li><a href="#"><img alt="" src="img/headerImg/profile.jpg" style='border-radius: 100%'>프로필</a></li>
	                <li><a href="#"><img alt="" src="img/headerImg/mycourse.png">마이코스</a></li>
	                <li><a href="#"><img alt="" src="img/headerImg/daylog.png">데이로그</a></li>
	                <li><a href="#"><img alt="" src="img/headerImg/perform.png">전시/공연</a></li>
	                <li><a href="#"><img alt="" src="img/headerImg/middle.png">중간 지점 찾기</a></li>
	            </ul>
	        </nav>
        </div>
    </header>
    <div class="main-content">
        <h2>공연 / 전시</h2>
        <div class="month-navigation">
            <button id="prevMonth">&lt;</button>
		    <span id="currentMonth">2024.10</span>
		    <button id="nextMonth" onclick="location.href='exhibition11.jsp'">&gt;</button>
        </div>
        <div class="exhibition-list">
            <div class="exhibition-item">
                <img src="img/exhibition9.jpg" alt="우연히 웨스 앤더슨 2" />
                <div class="details">
                    <h3>우연히 웨스 앤더슨 2: 모험은 계속된다</h3>
                    <p>기간: 24.10.18(금) ~ 25.04.13(일)</p>
                    <p>장소: 그라운드시소 센트럴</p>
                </div>
            </div>
            <div class="exhibition-item">
                <img src="img/exhibition10.jpg" alt="유토피아" />
                <div class="details">
                    <h3>유토피아: 노웨어, 나우 히어</h3>
                    <p>기간: 24.03.29(금) ~ 24.10.13(일)</p>
                    <p>장소: 그라운드시소 성수</p>
                </div>
            </div>
            <!-- 추가 콘텐츠는 여기에 -->
        </div>
    </div>
</body>
</html>