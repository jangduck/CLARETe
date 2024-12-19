<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
    
    <!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 
	
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 


</head>
<body>
    <header class="side-header">
        <nav class="header-nav">
            <ul>
                <li>
                    <div>회원관리</div>
                    <ul>
                        <li>회원조회</li>
                        <li>탈퇴회원조회</li>
                    </ul>
                </li>
                <li>
                    <div>상품관리</div>
                    <ul>
                        <li>상품조회</li>
                        <li>상품 카테고리 별 조회</li>
                        <li><a href="<%= ctxPath%>/admin/adminProductInsertGo.cl">상품등록</a></li>
                        <li>상품 재고 관리</li>
                        <li>상품 삭제</li>
                    </ul>
                </li>
                <li>
                    <div>주문관리</div>
                    <ul>
                        <li>주문상세조회</li>
                        <li>배송상태변경</li>
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
            <a href="<%= ctxPath%>/admin/adminMain.cl"><div class="home-btn">홈으로</div></a>
            <a href="#"><div class="end-btn">종료</div></a>
        </div>
    </nav>