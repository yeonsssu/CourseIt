
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>카테고리별 장소 검색하기</title>
    <style>
.map_wrap, .map_wrap * {
    margin: 0;
    padding: 0;
    font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
    font-size: 12px;
}

.map_wrap {
    position: relative;
    margin-left: 17vw; /* 헤더 너비에 맞춰 지도 위치 조정 */
    margin-top: -29vw; /* 헤더 아래 간격 */
    width: 40vw; /* 지도 너비 */
    height: 600px; /* 지도 높이 */
}


#category {
    position: absolute;
    top: 5px; /* 지도 상단과 간격 */
    left: 10px; /* 지도 왼쪽과 간격 */
    border-radius: 5px;
    border: 1px solid #909090;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
    background: #fff;
    z-index: 2;
}

#category li {
    float: left;
    list-style: none;
    width: 50px;
    border-right: 1px solid #acacac;
    padding: 6px 0;
    text-align: center;
    cursor: pointer;
 	color : black;
}

#category li.on {
    background: #eee;
}

#category li:hover {
    background: #ffe6e6;
    border-left: 1px solid #acacac;
    margin-left: -1px;
}

#category li:last-child {
    margin-right: 0;
    border-right: 0;
}

#category li span {
    display: block;
    margin: 0 auto 3px;
    width: 27px;
    height: 28px;
}

#category li .category_bg {
    background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;
}

#category li .food {
    background-position: -10px 0;
}

#category li .mart {
    background-position: -10px -36px;
}

#category li .culture {
    background-position: -10px -72px;
}

#category li .tour {
    background-position: -10px -108px;
}

#category li .cafe {
    background-position: -10px -144px;
}


#category li.on .category_bg {
    background-position-x: -46px;
}

.placeinfo_wrap {
    position: absolute;
    bottom: 28px;
    left: -150px;
    width: 300px;
}

.placeinfo {
    position: relative;
    width: 100%;
    border-radius: 6px;
    border: 1px solid #ccc;
    border-bottom: 2px solid #ddd;
    padding-bottom: 10px;
    background: #fff;
}

.placeinfo:nth-of-type(n) {
    border: 0;
    box-shadow: 0px 1px 2px #888;
}

.placeinfo_wrap .after {
    content: '';
    position: relative;
    margin-left: -12px;
    left: 50%;
    width: 22px;
    height: 12px;
    background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png');
}

.placeinfo a,
.placeinfo a:hover,
.placeinfo a:active {
    color: #fff;
    text-decoration: none;
}

.placeinfo a,
.placeinfo span {
    display: block;
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
}

.placeinfo span {
    margin: 5px 5px 0 5px;
    cursor: default;
    font-size: 13px;
}

.placeinfo .title {
    font-weight: bold;
    font-size: 14px;
    border-radius: 6px 6px 0 0;
    margin: -1px -1px 0 -1px;
    padding: 10px;
    color: #fff;
    background: #d95050;
    background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;
}

.placeinfo .tel {
    color: #0f7833;
}

.placeinfo .jibun {
    color: #999;
    font-size: 11px;
    margin-top: 0;
}



/* 메인 css 추가*/
body, html {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    overflow-x: hidden; /* 좌우 스크롤 제거 */
}

/* 헤더css 시작 */

header {
    background-color: black;
    color: white;
    padding: 20px;
    text-align: center;
    height: 100vh;
    width: 15vw; /* 너비 설정 */
    min-width: 220px; /* 최소 너비 */
    max-width: 320px; /* 최대 너비 */
    position: fixed;
    left: 0; /* 화면 왼쪽에 고정 */
}

#head {
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: black;
}

#head ul {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex;
    flex-direction: column;
    gap: 68px;
}

#head ul li {
    display: flex;
    align-items: center;
    font-size: 1.5em;
    color: white;
}

#head ul li img {
    width: 40px;
    height: 40px;
    margin-right: 15px;
}

#head ul li a {
    text-decoration: none;
    color: white;
    display: flex;
    align-items: center;
}


/* 헤더css 끝 */


#main {
    margin-left: 15vw; /* 헤더 고정 너비에 맞춘 여백 */
    padding: 20px;
}


#logo img {
    width: 180px;
    height: 80px;
    margin-top: 50px;
    margin-bottom: 70px;
}



#sidebar {
    position: fixed;
    top: 0;
    right: 0;
    width: 250px;
    height: 100%;
    background-color: #f4f4f4;
    overflow-y: auto;
    padding: 20px;
    box-shadow: -2px 0 5px rgba(0, 0, 0, 0.3);
    float: left;
}

#sidebar h2 {
    margin-bottom: 20px;
    color : gray;

}

#placeList {
    list-style-type: none;
    padding: 0;
}

#placeList li {
    padding: 10px 0;
    border-bottom: 1px solid #ddd;
}

#placeList li a {
    text-decoration: none;
    color: #333;
    font-weight: bold;
}

        /* 새로 추가된 코스 이름 입력 부분 스타일 */
        #courseNameWrapper {
            margin-top: 20px; /* 기존 장소 정보와 간격 조정 */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color : lime;
        }

        #courseNameWrapper label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color : black;
        }

        #courseNameWrapper input {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
    #courseList li {
        color: black; /* 글자색을 검은색으로 설정 */
        padding: 5px 0;
        border-bottom: 1px solid #ddd;
    }
    
    
    
/* 팝업 css */
#coursePopup {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    padding: 20px;
    background-color: white;
    border: 1px solid #ccc;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    z-index: 1000;
    overflow-y: auto;
    max-width: 400px;
    border-radius: 8px;
}

#coursePopup h3 {
    margin: 10px 0 5px;
    font-size: 1.2em;
    color: #333;
}

#coursePopup p {
    margin: 5px 0;
    font-size: 1em;
    color: #555;
}

#coursePopup button {
    margin-top: 10px;
    padding: 8px 16px;
    cursor: pointer;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 1em;
}

#coursePopup button:hover {
    background-color: #0056b3;
}



/* *************************************/
/* box 스타일 */

.box {
  width: 821px;
  height: 55px;
  position: fixed;
  top: 10px; /* 페이지 상단에서 떨어진 거리 */
  left: 50%; /* 화면 중심에 위치 */
  transform: translateX(-50%); /* 수평 가운데 정렬 */
  background-color: #d9d9d9; /* 배경 색상 */
  border-radius: 40px; /* 모서리 둥글게 */
  display: flex;
  align-items: center;
  justify-content: center;
  padding-right: 10px; /* 오른쪽 여백 */
}

/* rectangle 스타일 */
.box .rectangle {
  width: 100%; /* box 너비에 맞춤 */
  height: 100%; /* box 높이에 맞춤 */
  display: flex;
  align-items: center;
  justify-content: space-between; /* input과 button 사이의 공간 조정 */
}

#searchForm {
  width: 100%; /* rectangle 안에 꽉 채우기 */
  display: flex;
  gap: 10px;
  align-items: center;
}

#searchForm input {
  flex: 1; /* 남은 공간을 모두 채우도록 설정 */
  padding: 5px;
  border: 1px solid #ccc;
  border-radius: 5px;
  font-size: 14px;
  color: #4d4d4d; /* 진한 회색 텍스트 색상 */
}

#searchForm button {
  padding: 5px 10px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

#searchForm button:hover {
  background-color: #0056b3;
}



</style>
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

		<!-- 기존 form 부분을 수정 -->
	  <div class="box">
	    <div class="rectangle">
	      <div id="searchForm">
	        <form onsubmit="searchKeyword(); return false;">
	          <input type="text" value="이태원 맛집" id="keyword" placeholder="키워드를 입력하세요" required>
	          <button type="submit">검색하기</button>
	        </form>
	      </div>
	    </div>
	  </div>


        <div id="sidebar">
            <h2>장소 정보</h2>
            <ul id="placeList"></ul>
            <!-- 마커 정보 리스트 -->
            <ul id="markerList"></ul>
            
            <!-- 코스 이름 입력 필드 추가 -->
            <div id="courseNameWrapper" style="margin-top: 20px;">
                <label for="courseName">코스 이름 입력:</label>
                <input type="text" id="courseName" placeholder="코스 이름을 입력하세요" required>
            </div>

            <!-- 저장 버튼 추가 -->
            <button id="saveButton" onclick="saveMarkerData()">저장</button>

            <!-- 저장된 코스를 보여주는 공간 -->
			<div>
			    <h2>저장된 코스 목록</h2>
			    <button onclick="loadSavedCourses()">코스 불러오기</button>
			    <ul id="savedCourses"></ul>
			</div>
        </div>    


        <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
            <ul id="category">
                <li id="FD6" data-order="0"> 
                    <span class="category_bg food"></span>
                    음식
                </li>       
                <li id="MT1" data-order="1"> 
                    <span class="category_bg mart"></span>
                    마트
                </li>  
                <li id="CT1" data-order="2"> 
                    <span class="category_bg culture"></span>
                    문화시설
                </li>  
                <li id="AT4" data-order="3"> 
                    <span class="category_bg tour"></span>
                    관광명소
                </li>  
                <li id="CE7" data-order="4"> 
                    <span class="category_bg cafe"></span>
                    카페
                </li>  
            </ul>
        </div>

	





<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9d4fdebbd05e105355e69928d6b9cb28&libraries=services"></script>
<script>
// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
    markers = [], // 마커를 담을 배열입니다
    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
 
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(map); 

// 지도에 idle 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'idle', searchPlaces);

// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
contentNode.className = 'placeinfo_wrap';

// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

// 커스텀 오버레이 컨텐츠를 설정합니다
placeOverlay.setContent(contentNode);  

// 각 카테고리에 클릭 이벤트를 등록합니다
addCategoryClickEvent();

// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
function addEventHandle(target, type, callback) {
    if (target.addEventListener) {
        target.addEventListener(type, callback);
    } else {
        target.attachEvent('on' + type, callback);
    }
}

// 카테고리 검색을 요청하는 함수입니다
function searchPlaces() {
    if (!currCategory) {
        return;
    }
    
    // 커스텀 오버레이를 숨깁니다 
    placeOverlay.setMap(null);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {
                // 기존 마커 제거
                removeMarker();
                // 검색된 장소를 표시
                displayPlaces(data);
                // 첫 번째 검색 결과를 중심으로 지도를 이동
                var firstPlace = data[0];
                var position = new kakao.maps.LatLng(firstPlace.y, firstPlace.x);
                map.panTo(position);
            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                alert('검색 결과가 없습니다.');
            } else if (status === kakao.maps.services.Status.ERROR) {
                alert('검색 중 오류가 발생했습니다.');
            }
        }

// 지도에 마커를 표출하는 함수입니다
function displayPlaces(places) {

    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
    var order = document.getElementById(currCategory).getAttribute('data-order');

    

    for ( var i=0; i<places.length; i++ ) {

            // 마커를 생성하고 지도에 표시합니다
            var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

            // 마커와 검색결과 항목을 클릭 했을 때
            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
            (function(marker, place) {
                kakao.maps.event.addListener(marker, 'click', function() {
                    displayPlaceInfo(place);
                    displayPlaceInfoOnSidebar(place);
                });
            })(marker, places[i]);
    }
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, order) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}


function displayPlaceInfo(place) {
    var content = '<div class="placeinfo">' +
                    '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';
    
    // 주소 표시
    if (place.road_address_name) {
        content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
    } else {
        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
    }

    // 전화번호 표시
    if (place.phone) {
        content += '    <span class="tel">' + place.phone + '</span>';
    }

    // 리뷰 및 평점 정보 추가 (예시로 간단하게 구현)
    if (place.rating) {
        content += '    <span class="rating">평점: ' + place.rating + '</span>';
    }
    if (place.reviews && place.reviews.length > 0) {
        content += '    <div class="reviews"><strong>리뷰:</strong>';
        for (var i = 0; i < place.reviews.length && i < 3; i++) { // 최대 3개 리뷰 표시
            content += '<p>' + place.reviews[i] + '</p>';
        }
        content += '</div>';
    }

    // 사진 표시 (예시로 첫 번째 사진 추가)
    if (place.photos && place.photos.length > 0) {
        content += '    <div class="photos"><strong>사진:</strong><img src="' + place.photos[0].url + '" alt="사진" style="width: 100px; height: 100px;"></div>';
    }

    content += '</div>' +
                '<div class="after"></div>';

    contentNode.innerHTML = content;
    placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
    placeOverlay.setMap(map);
}




// 각 카테고리에 클릭 이벤트를 등록합니다
function addCategoryClickEvent() {
    var category = document.getElementById('category'),
        children = category.children;

    for (var i=0; i<children.length; i++) {
        children[i].onclick = onClickCategory;
    }
}

// 카테고리를 클릭했을 때 호출되는 함수입니다
function onClickCategory() {
    var id = this.id,
        className = this.className;

    placeOverlay.setMap(null);

    if (className === 'on') {
        currCategory = '';
        changeCategoryClass();
        removeMarker();
    } else {
        currCategory = id;
        changeCategoryClass(this);
        searchPlaces();
    }
}

// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
function changeCategoryClass(el) {
    var category = document.getElementById('category'),
        children = category.children,
        i;

    for ( i=0; i<children.length; i++ ) {
        children[i].className = '';
    }

    if (el) {
        el.className = 'on';
    } 
} 




//===============================================================================================//
function saveMarkerData() {
    var courseName = document.getElementById('courseName').value.trim();
    if (!courseName) {
        alert('코스 이름을 입력해주세요!');
        return;
    }

    // 서버에 중복 여부 확인 요청
    $.ajax({
        url: "http://localhost:8080/ProjectCourseit/CheckCourseNameServlet?courseName=" + encodeURIComponent(courseName),
        type: "GET",
        success: function(response) {
            console.log("서버 응답:", response);
            try {
                if (response.error) {
                    console.error("서버 오류:", response.error);
                    alert("서버 응답 오류: " + response.error);
                    return;
                }

                if (response.exists) {
                    alert("이미 존재하는 코스 이름입니다.");
                    return;
                }

                // 중복되지 않은 경우 마커 데이터 저장
                var markerData = [];
                var placeList = document.getElementById('placeList');
                var listItems = placeList.getElementsByTagName('li');

                for (var i = 0; i < listItems.length; i++) {
                    var listItem = listItems[i];
                    var link = listItem.querySelector('a');
                    var placeName = link.textContent;
                    var latitude = parseFloat(link.getAttribute('data-latitude'));
                    var longitude = parseFloat(link.getAttribute('data-longitude'));
                    var address = listItem.getAttribute('data-address'); // data-address 속성에서 주소 가져오기
                    
                    markerData.push({
                        courseName: courseName,
                        name: placeName,
                        address: '', // 필요시 주소 추가 로직
                        latitude: latitude,
                        longitude: longitude,
                        address: address, // 주소 추가
                    });
                }

                console.log("사이드바 장소 데이터:", markerData);
                const jsonData = JSON.stringify(markerData);

                // 서버에 데이터 저장 요청
                $.ajax({
                    url: "http://localhost:8080/ProjectCourseit/CourseServlet?data=" + encodeURIComponent(jsonData),
                    type: "GET",
                    contentType: "application/json",
                    success: function(response) {
                        alert("장소 데이터가 성공적으로 저장되었습니다!");
                        console.log("서버 응답:", response);

                        // 저장 후 사이드바 내용을 비움
                        placeList.innerHTML = '';
                        // 코스 이름 입력란 초기화
                        document.getElementById('courseName').value = '';
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX 요청 오류:", error);
                        console.error("서버 응답 상태:", xhr.status);
                        console.error("서버 응답 텍스트:", xhr.responseText);
                        alert("서버 응답 오류: " + error);
                    }
                });
            } catch (e) {
                console.error("JSON 파싱 오류:", e);
                alert("서버 응답 형식 오류: " + e.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 오류:", error);
            console.error("서버 응답 상태:", xhr.status);
            console.error("서버 응답 텍스트:", xhr.responseText);
            alert("서버 응답 오류: " + error);
        }
    });
}




//// 코스 이름 받아오는거랑 팝업 띄우는거 완 , 이름 띄우기만 추가하면 됨 ///////  

function loadSavedCourses() {
    $.ajax({
        url: "http://localhost:8080/ProjectCourseit/GetCourseServlet",
        type: "GET",
        success: function(response) {
            console.log("서버 응답 데이터:", response);

            if (Array.isArray(response)) {
                var savedCoursesList = document.getElementById('savedCourses');
                savedCoursesList.innerHTML = ''; // 기존 내용을 비움

                // 중복 제거를 위해 Set 사용
                var uniqueCourseNames = new Set();
                response.forEach(function(marker) {
                    if (!uniqueCourseNames.has(marker.courseName)) {
                        uniqueCourseNames.add(marker.courseName);

                        var listItem = document.createElement('li');
                        listItem.textContent = marker.courseName; // 코스 이름만 출력
                        listItem.style.color = 'black'; // 텍스트 색상 설정
                        listItem.style.cursor = 'pointer'; // 클릭할 수 있도록 설정
                        
                        // 삭제 버튼 생성
                        var deleteButton = document.createElement('button');
                        deleteButton.textContent = '삭제';
                        deleteButton.style.marginLeft = '10px';
                        deleteButton.onclick = function() {
                            deleteCourse(marker.courseName);
                        };

                        // 리스트 항목에 삭제 버튼 추가
                        listItem.appendChild(deleteButton);

                        // 클릭 시 팝업 표시 함수 호출
                        listItem.addEventListener('click', function() {
                            showCoursePopup(marker);
                        });

                        savedCoursesList.appendChild(listItem);
                    }
                });
            } else {
                console.error("응답 데이터가 올바른 JSON 배열이 아닙니다.");
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 오류:", error);
            alert("서버 응답 오류: " + error);
        }
    });
}

// 코스를 삭제하는 함수
function deleteCourse(courseName) {
    if (confirm(`정말 "${courseName}" 코스를 삭제하시겠습니까?`)) {
        $.ajax({
            url: "http://localhost:8080/ProjectCourseit/DeleteCourseServlet?courseName=" + encodeURIComponent(courseName),
            type: "GET",
            success: function(response) {
                if (response.includes('error')) {
                    alert("삭제 실패: " + response);
                } else {
                    alert("코스가 삭제되었습니다!");
                    closeCoursePopup(); // 삭제 후 팝업 닫기
                    loadSavedCourses(); // 삭제 후 목록 새로고침
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 오류:", error);
                alert("서버 응답 오류: " + error);
            }
        });
    }
}



/////////////////////팝업...(코스 세부요소 띄우기.....)
function showCoursePopup(marker) {
    // 팝업 요소가 이미 존재하는지 확인하고, 있으면 제거
    var existingPopup = document.getElementById('coursePopup');
    if (existingPopup) {
        document.body.removeChild(existingPopup);
    }

    // 코스 이름을 사용하여 서버에서 상세 정보 가져오기
    $.ajax({
        url: "http://localhost:8080/ProjectCourseit/GetCourseDetailsServlet?courseName=" + encodeURIComponent(marker.courseName),
        type: "GET",
        dataType: "json",
        success: function(response) {
            console.log("코스 상세 정보:", response);

            // 응답이 배열이고 길이가 0이 아닌 경우
            if (Array.isArray(response) && response.length > 0) {
                var courseDetails = response;

                // 팝업 요소 생성
                var popup = document.createElement('div');
                popup.id = 'coursePopup';

                // 팝업 제목 표시 (기본 코스 이름 표시)
                var courseNameHeader = document.createElement('h2');
                courseNameHeader.textContent = "코스 이름: " + marker.courseName;
                courseNameHeader.id = 'courseNameHeader';
                popup.appendChild(courseNameHeader);

                // 각 장소 정보 출력
                courseDetails.forEach(detail => {
                    console.log("Detail 디버깅 : ", detail);

                    // 장소와 주소 값 설정
                    const name = detail.name || "정보 없음";
                    const address = detail.address || "정보 없음";

                    // 새로운 div 요소 생성
                    const placeItem = document.createElement("div");

                    // 장소 이름 생성
                    var placeName = document.createElement('h3');
                    placeName.textContent = '장소 :' + name;
                    placeItem.appendChild(placeName);

                    var addressParagraph = document.createElement('p');
                    addressParagraph.textContent = '주소 :' + address;
                    placeItem.appendChild(addressParagraph);

                    // 구분선 생성
                    const hr = document.createElement("hr");
                    placeItem.appendChild(hr);

                    // 생성된 장소 정보를 팝업에 추가
                    popup.appendChild(placeItem);
                });

                // 닫기 버튼 생성
                var closeButton = document.createElement('button');
                closeButton.textContent = '닫기';
                closeButton.onclick = function() {
                    document.body.removeChild(popup);
                };
                popup.appendChild(closeButton);

                // 코스 이름 수정 버튼 생성
                var editButton = document.createElement('button');
                editButton.textContent = '코스 이름 수정';
                editButton.onclick = function() {
                    // 코스 이름 수정 기능 실행
                    var newCourseName = prompt("새로운 코스 이름을 입력하세요:", marker.courseName);
                    if (newCourseName && newCourseName.trim() !== "") {
                        // 서버에 코스 이름 업데이트 요청 (GET 방식)
                        var updateUrl = "http://localhost:8080/ProjectCourseit/EditCourseServlet?" +
                            "oldCourseName=" + encodeURIComponent(marker.courseName) +
                            "&newCourseName=" + encodeURIComponent(newCourseName);

                        $.ajax({
                            url: updateUrl,
                            type: "GET",
                            success: function(response) {
                                console.log("코스 이름 수정 성공:", response);
                                alert("코스 이름이 성공적으로 수정되었습니다.");
                                marker.courseName = newCourseName; // 로컬에서도 이름 갱신
                                document.getElementById('courseNameHeader').textContent = "코스 이름: " + newCourseName;
                            },
                            error: function(xhr, status, error) {
                                console.error("코스 이름 수정 오류:", error);
                                alert("코스 이름 수정에 실패했습니다.");
                            }
                        });
                    }
                };
                popup.appendChild(editButton);

                // 팝업 내용 설정 및 문서에 추가
                document.body.appendChild(popup);

            } else {
                alert("해당 코스에 대한 정보가 없습니다.");
            }
        },
        error: function(xhr, status, error) {
            console.error("코스 정보 요청 오류:", error);
            alert("코스 정보를 가져오는 데 실패했습니다.");
        }
    });
}





// 팝업을 닫는 함수
function closeCoursePopup() {
    var popup = document.getElementById('coursePopup');
    if (popup) {
        document.body.removeChild(popup);
    }
}
	
//////////////////////팝업 없애기//////////////////////////////////



// 아래부터는 키워드 검색관련 함수
// 키워드로 장소를 검색합니다
searchKeyword();

// 키워드 검색을 요청하는 함수입니다
function searchKeyword() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, keywordSearchCB); 
}



// 키워드 받고 지도 위치 옮기는 함수
function keydisplayPlaces(places) {
    var bounds = new kakao.maps.LatLngBounds();
    
    // places 배열을 순회하며 지도 범위를 설정할 좌표를 추가합니다
    for (var i = 0; i < places.length; i++) {
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x);
        bounds.extend(placePosition);
    }

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}
	

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function keywordSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        keydisplayPlaces(data);


    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}


//displayPlaceInfoOnSidebar 함수에 추가
function displayPlaceInfoOnSidebar(place) {
    var placeList = document.getElementById('placeList');
    var listItem = document.createElement('li');
    listItem.innerHTML = '<a href="' + place.place_url + '" target="_blank" data-latitude="' + place.y + '" data-longitude="' + place.x + '">' + place.place_name + '</a>';
    
    // 주소를 data-속성으로 추가
    listItem.setAttribute('data-address', place.road_address_name);
    
    
    
    // 클릭 이벤트 추가 (상세 정보 보기)
    listItem.addEventListener('click', function() {
        displayPlaceInfo(place);
    });

    // 삭제 버튼 추가
    var deleteButton = document.createElement('button');
    deleteButton.textContent = '삭제';
    deleteButton.style.marginLeft = '10px';
    deleteButton.addEventListener('click', function(e) {
        e.stopPropagation(); // 이벤트 전파 방지
        placeList.removeChild(listItem);
    });

    listItem.appendChild(deleteButton);
    placeList.appendChild(listItem);
}


</script>
</body>
</html>