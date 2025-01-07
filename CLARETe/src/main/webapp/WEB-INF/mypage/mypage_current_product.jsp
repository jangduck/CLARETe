<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
 String ctxPath = request.getContextPath();
		
		
%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>금쪽이</title>

	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/mapage.css">
	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/media_nav.css">    
	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/product_mypage.css">   
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    
</head>
<body> 
	<%-- 해더 include 받아옴 --%>
    <jsp:include page="../header.jsp"></jsp:include>
	<%-- 해더 include 받아옴 --%>
	
	<%-- 마이페이지해더 include 받아옴 --%>
    <jsp:include page="mypageheader.jsp"></jsp:include>    
	<%-- 마이페이지해더 include 받아옴 --%>
	

		<%-- =============================================== --%>
        <div class="mypage_contants_bottom">
            <div style="height: auto; display: flex; align-items: center; gap: 4px;">
                <span class="recent-orders-title">최근 본 향수</span>
            </div>

            <ul class="cardcontainer">
                <!-- === for문 대상 시작 === -->
                <c:if test="${not empty requestScope.pvoList}">
                	<c:forEach var="pvoList" items="${requestScope.pvoList}">
		                <li class="cardbox">
		                    <a  href="/CLARETe/shop/prodView.cl?p_num=${pvoList.p_num}">
		                        <div class="cardimg">
		                        	<img src="/CLARETe/images/${pvoList.p_image}" style="width: 100%; display: block;">
		                        </div>
		                        <div class="cardname">
		                            ${pvoList.p_name}
		                        </div>
		                        <div class="cardprice">
		                            <span><fmt:formatNumber value="${pvoList.p_price}" type="number" groupingUsed="true"></fmt:formatNumber> </span><span>원</span>
		                        </div>
		                    </a>
		                </li>
	                </c:forEach>
                </c:if>
                
                 <c:if test="${empty requestScope.pvoList}">
                	최근 본 향수가 없습니다.
           		 </c:if>
                <!-- === for문 대상 끝 === -->    
            </ul>
        </div>
           
		<%-- =============================================== --%>
		
		

<%-- 마이페이지푸터 include 받아옴 --%>
<jsp:include page="mypagefooter.jsp"></jsp:include>
<%-- 마이페이지푸터 include 받아옴 --%> 

<%-- 푸터 include 받아옴 --%>
<jsp:include page="../footer.jsp"></jsp:include>
<%-- 푸터 include 받아옴 --%>
    
    
</body>
</html>
