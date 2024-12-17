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
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="<%= ctx_path%>/css/member/find.css" >
</head>
<body>
    <div class="find_check_container">
        <div class="find_logo">
            LOGO
        </div>
        <div class="find_title">
            비밀번호 찾기
        </div>
        <div class="input_box">

            <div class="input_container">
                <input type="text" name="name" placeholder="아이디를 입력해주세요" />
                <input type="text" name="name" placeholder="이메일을 입력해주세요" />
            </div>
            
            <div class="find_btn">
                <a href="#">아이디 찾기</a>
            </div>
            <div class="find_go">
                확인
            </div>
        </div>
    </div>

</body>
</html>