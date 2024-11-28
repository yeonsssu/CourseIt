<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Settings</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Settings</h2>
        <form class="mt-4">
            <!-- 사이트 설정 -->
            <h4>Site Settings</h4>
            <div class="mb-3">
                <label for="siteName" class="form-label">Site Name</label>
                <input type="text" class="form-control" id="siteName" value="데이트 코스 추천 웹">
            </div>
            <div class="mb-3">
                <label for="siteLogo" class="form-label">Site Logo</label>
                <input type="file" class="form-control" id="siteLogo">
            </div>

            <!-- API 연동 -->
            <h4>API Settings</h4>
            <div class="mb-3">
                <label for="mapApiKey" class="form-label">Map API Key</label>
                <input type="text" class="form-control" id="mapApiKey" placeholder="Enter Map API Key">
            </div>
            <div class="mb-3">
                <label for="bookingApiKey" class="form-label">Booking API Key</label>
                <input type="text" class="form-control" id="bookingApiKey" placeholder="Enter Booking API Key">
            </div>

            <!-- 저장 버튼 -->
            <button type="submit" class="btn btn-primary">Save Settings</button>
        </form>
    </div>
</body>
</html>
