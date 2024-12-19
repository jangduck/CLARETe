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
    
    <!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 
	
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

</head>
<body class="allbody" style="background-color: #F1F5F9 !important; width: 100% !important;">
    
    <jsp:include page="adminheader.jsp"></jsp:include>
    
    <section>
        <div style="display: flex; flex-wrap: wrap;">
	        
	            <div class="first-div">
	            <%-- 
	            	<div style="display: flex; gap: 8px; flex-wrap: wrap;">
                        <div class="input-box">
                            <div><label for="userid">유저 아이디</label></div>
                            <div>
                                <input type="text" id="userid" name="userid" placeholder="유저 아이디를 입력하세요">
                            </div>
                        </div>
                        <div class="input-box">
                            <div><label for="userid">유저명</label></div>
                            <div>
                                <input type="text" id="userid" name="userid" placeholder="유저명을 입력하세요">
                            </div>
                        </div>
                    </div>
	            --%>
	            
		            <form name="myFrm" method="post" action="<%= ctxPath%>/admin/adminProductInsertGo.cl">
			            <table border="1">
			            	<tr>
			            		<th><label>상품명</label></th>
			            		<td><input type="text" name="p_name" placeholder="상품명" /></td>
			            	</tr>
			            	<tr>
			            		<th><label>카테고리</label></th>
			            		<td><input type="text" name="p_season" placeholder="카테고리" /></td>
			            	</tr>
			            	<tr>
			            		<th><label>제품설명</label></th>
			            		<td><input type="text" name="p_ex" placeholder="제품설명" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>가격</label></th>
			            		<td><input type="text" name="p_price" placeholder="가격" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>재고</label></th>
			            		<td><input type="text" name="p_inven" placeholder="재고" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>발매일</label></th>
			            		<td><input type="text" name="p_release" placeholder="발매일" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>할인률</label></th>
			            		<td><input type="text" name="p_sale" placeholder="할인률" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>성별</label></th>
			            		<td><input type="text" name="p_gender" placeholder="성별" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>상품이미지</label></th>
			            		<td><input type="text" name="p_image" placeholder="상품이미지" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>상품상세이미지</label></th>
			            		<td><input type="text" name="p_detail_image" placeholder="상품상세이미지" /></td>
			            	</tr>
			            </table>
			            <input type="submit" value="등록"/> <input type="reset" value="취소"/>
			        </form>
	            
	            	
	            </div>
	            	
        </div>
        
    </section>

</body>
</html>