<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 상품관리</title>
    <link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_header.css">
    <link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_section.css">
</head>
<body>

<header class="side-header">
    <nav class="header-nav">
        <ul>
            <li>
                <div>회원관리</div>
                <ul>
                    <li><a href="<%= ctxPath %>/admin/admin.cl">회원조회</a></li>
                    <li><a href="<%= ctxPath %>/admin/adminRemove.cl">탈퇴회원조회</a></li>
                </ul>
            </li>
            <li>
                <div>상품관리</div>
                <ul>
                    <a href="<%= request.getContextPath() %>/admin/adminProduct.cl">상품조회</a>
					<li><a href="<%= request.getContextPath() %>/admin/adminProductInsertGo.cl">상품등록</li>
                </ul>
            </li>
            <li>
                <div>주문관리</div>
                <ul>
                    <li><a href="<%= ctxPath %>/admin/adminOrder.cl">주문회원조회</a></li>
                    <li><a href="<%= ctxPath %>/admin/adminDelivery.cl">주문배송관리</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</header>

<nav class="top-nav">
    <div class="nav-logo">
        <div>LOGO</div>
    </div>
    <div class="nav-btn">
        <a href="<%=request.getContextPath()%>/index.cl"><div class="home-btn">홈으로</div></a>
        <a href="<%=request.getContextPath()%>/login/logout.cl"><div class="end-btn">종료</div></a>
    </div>
</nav>

<section>
    <div style="display: flex; flex-wrap: wrap;">
        <div class="first-div">
            <div style="margin: 30px 0px 0px 30px;">
                <form>
                    <div style="display: flex; gap: 8px; flex-wrap: wrap;">
                        <div class="input-box">
                            <div><label for="userid">유저 아이디</label></div>
                            <div>
                                <input type="text" id="userid" name="userid" placeholder="유저 아이디를 입력하세요">
                            </div>
                        </div>
                        <div class="input-box">
                            <div><label for="username">유저명</label></div>
                            <div>
                                <input type="text" id="username" name="username" placeholder="유저명을 입력하세요">
                            </div>
                        </div>
                    </div>
                    <div style="display: flex; gap: 8px; flex-wrap: wrap;">
                        <div class="input-box">
                            <div><label for="deleteStatus">삭제여부</label></div>
                            <div>
                                <input type="text" id="deleteStatus" name="deleteStatus" placeholder="전체">
                            </div>
                        </div>
                        <div class="input-box">
                            <div><label for="dormantStatus">휴면여부</label></div>
                            <div>
                                <input type="text" id="dormantStatus" name="dormantStatus" placeholder="전체">
                            </div>
                        </div>
                    </div>
                </form>
                <div class="form-btn-box">
                    <input type="submit" class="btn search" value="검색"/>
                    <input type="reset" class="btn reset" value="초기화"/>
                </div>
            </div>
        </div>
    </div>
    <div class="second-div">
        <h1>관리자 메인으로 쓸 페이지입니다.!!!!!!!!!!!!</h1>
    </div>
</section>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="<%= ctxPath %>/js/admin_header.js"></script>
</body>
</html>
