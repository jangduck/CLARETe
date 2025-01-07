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
		<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/recent_mypage.css">  
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    
    <!-- Optional JavaScript -->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>

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
		<div class="recent-orders-title">최근 주문 향수</div>
		<div class="recent-orders-box">
			<!-- 주문 내역이 있을 경우 -->
			<c:if test="${not empty requestScope.orderList}">
				<ul class="order-list">
					<c:forEach var="ovo" items="${requestScope.orderList}">
						<li class="order-item">
							<!-- 상품 이미지 --> <img
							src="/CLARETe/images/${ovo.productvo.p_image}" style="width: 10%;">
						</li>

						<!-- 주문 상세 정보 -->
						<li>
							<div class="order-details">
								<div>
									<div>${ovo.productvo.p_name}</div>
									<!-- 상품명 넣는 자리입니다 -->
								</div>
						</li>
						<li>
							<div>
								<span><fmt:formatNumber
										value="${ovo.orderdetailvo.od_price}" type="number"
										groupingUsed="true" /></span><span>원</span>
								<!-- 상품 가격 넣는 자리입니다 -->
							</div>
						</li>
					</c:forEach>
				</ul>
			</c:if>

			<!-- 주문 내역이 없을 경우 -->
			<c:if test="${empty requestScope.orderList}">
				<p>최근 주문 내역이 없습니다.</p>
			</c:if>
		</div>
	</div>


	<div class="recent-orders-title">방금 본 향수</div>
	<div class="recent-orders-box">
		<div>장바구니의 상품이 없습니다.</div>
	</div>
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
