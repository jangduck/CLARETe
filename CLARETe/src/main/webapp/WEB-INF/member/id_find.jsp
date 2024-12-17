<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctx_path = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="<%= ctx_path%>/css/member/find.css" >
</head>
<body>
    <div class="find_check_container">
        <div class="find_logo">
            LOGO
        </div>
        <div class="find_title">
            아이디 찾기
        </div>
        <div class="input_box">

            <div class="input_container">
                <input type="text" name="name" placeholder="이름을 입력해주세요" />
                <input type="text" name="name" placeholder="이메일을 입력해주세요" />
            </div>

            <div class="find_result_contants">
                <span>강이훈</span><span> 님의 아이디는 </span><br>
                <span>dlgns1110</span><span> 입니다.</span>
            </div>

            <div class="find_btn">
                <a href="#">비밀번호 찾기</a>
            </div>
            <div class="find_go">
                확인
            </div>
        </div>
    </div>


    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script>
        
    </script>
</body>
</html>