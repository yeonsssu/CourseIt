<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/pages/exhibition.css">
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
            <button id="nextMonth" onclick="location.href='exhibition11.jsp'">&lt;</button>
		    <span id="currentMonth">2024.12</span>
		    <button id="nextMonth">&gt;</button>
        </div>
        <div class="exhibition-list">
            <div class="exhibition-item">
                <img src="img/exhibition9.jpg" alt="우연히 웨스 앤더슨 2" />
                <div class="details">
                    <a href="exhibition_detail.jsp"><h3>우연히 웨스 앤더슨 2: 모험은 계속된다</h3></a>
                    <p>기간: 24.10.18(금) ~ 25.04.13(일)</p>
                    <p>장소: 그라운드시소 센트럴</p>
                </div>
            </div>
             <div class="exhibition-item">
                <img src="img/exhibition11.jpg" alt="더현대 크리스마스" />
                <div class="details">
                    <h3>더현대 크리스마스 빌리지</h3>
                    <p>기간: 24.10.22(화) ~ 24.12.31(화)</p>
                    <p>장소: 더현대 서울</p>
                </div>
            </div>
           <div class="exhibition-item">
                <img src="img/exhibition13.jpg" alt="현대" />
                <div class="details">
                    <h3>현대 크리스마스 모빌리티 타운</h3>
                    <p>기간: 24.11.15(수) ~ 24.12.29(일)</p>
                    <p>장소: 현대모터스튜디오</p>
                </div>
            </div>
            <!-- 추가 콘텐츠는 여기에 -->
            
        </div>
    </div>
</body>
</html>