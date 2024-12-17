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

            <div class="info_box">
                <div>
                    비밀번호가 <span>이메일로 발송</span> 되었습니다.
                </div>
                <div>
                    입력해주신 이메일 주소로 인증번호가 발송되었습니다.<br>
                    이메일에서 인증번호를 확인해주세요.
                </div>
            </div>

            <div class="input_container">
                <input type="text" name="name" placeholder="인증번호를 입력해주세요" />
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