<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 채은 코드 추가하겠씁니다요~~~~~~~~~~~~~~~~~~~~~~~ --%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 채은 코드 추가하겠씁니다요~~~~~~~~~~~~~~~~~~~~~~~ --%>

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
            <div style="height: auto; display: flex; align-items: center; gap: 4px;">
                <span class="recent-orders-title">장바구니</span>
            </div>

            <ul class="cardcontainer">
            	<%-- 채은 코드 추가하겠씁니다요~~~~~~~~~~~~~~~~~~~~~~~ --%>
            	<c:if test="${fn:length(cartList2) != 0}">
	                <c:forEach var="cvo" items="${cartList2}">
	                	<li class="cardbox">
		                    <a href="/CLARETe/shop/prodView.cl?p_num=${cvo.fk_p_num}">
		                        <div class="cardimg">
									<img src="/CLARETe/images/${cvo.pvo.p_image}" style="width: 100%; display: block;" />
		                        </div>
		                        <div class="cardname">
		                            ${cvo.pvo.p_name}
		                        </div>
		                        <div class="cardprice">
		                            <fmt:formatNumber value="${cvo.pvo.p_price - (cvo.pvo.p_price * cvo.pvo.p_sale / 100) + cvo.opvo.op_price}" pattern="#,###,###"/>
		                        </div>
		                    </a>
		                </li>
	                </c:forEach>
                </c:if>
                <%-- 채은 코드 추가하겠씁니다요~~~~~~~~~~~~~~~~~~~~~~~ --%>
				
				<c:if test="${fn:length(cartList2) == 0}">
                	장바구니가 비어있습니다.
           		 </c:if>
				
            </ul>
        </div>
        <div class="cartbox">
			<c:if test="${fn:length(cartList2) != 0}">
			    <div>
			        <div class="cartgo"><a href="<%= ctxPath%>/cart/cart.cl">모두 구매하기</a></div>
			    </div>
			</c:if>
        </div>
		
		

<%-- 마이페이지푸터 include 받아옴 --%>
<jsp:include page="mypagefooter.jsp"></jsp:include>
<%-- 마이페이지푸터 include 받아옴 --%> 

<%-- 푸터 include 받아옴 --%>
<jsp:include page="../footer.jsp"></jsp:include>
<%-- 푸터 include 받아옴 --%>
    
    
</body>
</html>
