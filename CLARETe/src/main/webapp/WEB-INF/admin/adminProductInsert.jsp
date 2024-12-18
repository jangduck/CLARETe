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
    <link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_insert.css">
</head>
<body>
    
    <jsp:include page="adminheader.jsp"></jsp:include>
    
    <section>
        <div style="display: flex; flex-wrap: wrap;">
	        
	            <div class="first-div">
	            	<form name="myFrm" method="post" action="<%= ctxPath%>/admin/adminProductInsertGo.cl">
		            	<div>제품번호는 시퀀스 쓸거임</div>
		                <div class="input_container">
		                	<label>상품명</label>
			                <input type="text" name="p_name" placeholder="상품명" />
			            </div>
			            <div class="input_container">
		                	<label>카테고리</label>
			                <input type="text" name="p_season" placeholder="카테고리" />
			            </div>
			            <div class="input_container">
		                	<label>제품설명</label>
			                <input type="text" name="p_ex" placeholder="제품설명" />
			            </div>
			            <div class="input_container">
		                	<label>가격</label>
			                <input type="text" name="p_price" placeholder="가격" />
			            </div>
			            <div class="input_container">
		                	<label>재고</label>
			                <input type="text" name="p_inven" placeholder="재고" />
			            </div>
			            <div>제품등록일은 시퀀스 쓸거임</div>
			            <div class="input_container">
		                	<label>발매일</label>
			                <input type="text" name="p_release" placeholder="발매일" />
			            </div>
			            <div class="input_container">
		                	<label>할인률</label>
			                <input type="text" name="p_sale" placeholder="할인률" />
			            </div>
			            <div class="input_container">
		                	<label>성별</label>
			                <input type="text" name="p_gender" placeholder="성별" />
			            </div>
			            <div class="input_container">
		                	<label>상품이미지</label>
			                <input type="text" name="p_image" placeholder="상품이미지" />
			            </div>
			            <div class="input_container">
		                	<label>상품상세이미지</label>
			                <input type="text" name="p_detail_image" placeholder="상품상세이미지" />
			            </div>
			            <input type="submit" value="등록"/> <input type="reset" value="취소"/>
		            </form>
	            </div>
	            
			
        </div>
        
    </section>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="./js/admin_header.js">
    	const frm = document.myFrm
    	
    	frm.action="";
    	frm.method="POST";
    </script>
</body>
</html>