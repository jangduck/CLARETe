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
	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/product_mypageMain.css">
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    
    <!-- Optional JavaScript -->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>

</head>

<style>
body {
.arrow {
        display: inline-block;
        width: 8px;
        height: 8px;
        border: solid #333;
        border-width: 0 2px 2px 0;
        transform: rotate(45deg);
        transition: transform 0.2s ease;
    }

    .arrow-container.active .arrow {
        transform: rotate(-135deg);
    }

    .additional-info {
        transition: max-height 0.3s ease, padding 0.3s ease;
        max-height: 0;
    }
    

    .additional-info.show {
        display: block;
        max-height: 200px; /* 충분히 큰 값 설정 (추가 정보의 최대 높이) */
        padding: 10px 0;   /* 애니메이션 시 여백 추가 */
    }
    
	    /* 커스텀 스크롤바 스타일 */
	.scrollbar {
	    overflow-y: auto; /* 세로 스크롤 활성화 */
	}
	
	.scrollbar::-webkit-scrollbar {
	    width: 4px; /* 스크롤바 폭 */
	}
	
	.scrollbar::-webkit-scrollbar-thumb {
	    background: black; /* 스크롤바 색상 (크림슨) */
	    border-radius: 10px; /* 둥근 모서리 */
	}
	
	.scrollbar::-webkit-scrollbar-track {
	    background: white; /* 스크롤바 트랙 배경색 */
	}
    
</style>

<body> 
	<%-- 해더 include 받아옴 --%>
    <jsp:include page="../header.jsp"></jsp:include>
	<%-- 해더 include 받아옴 --%>
	
	<%-- 마이페이지해더 include 받아옴 --%>
    <jsp:include page="mypageheader.jsp"></jsp:include>    
	<%-- 마이페이지해더 include 받아옴 --%>
	<c:if test="${not empty requestScope.orderList}">
	 <div class="recent-orders-title">나의 주문 향수</div>
	 <c:forEach var="ovo" items="${requestScope.orderList}">
	 	<div class="recent-orders">
                 <div>
                      <ul>
                          <li>
                              <div class="recent-img">
                              	<img src="/CLARETe/images/${ovo.productvo.p_image}" style="width: 100%;">
                              </div> <!-- 상품 이미지 넣는 자리입니다 -->
                          </li>
                          <li>
                              <div>
                                  <div>${ovo.productvo.p_name}</div> <!-- 상품명 넣는 자리입니다 -->
                              </div>
                              <div>
                                  <span>${ovo.orderdetailvo.od_count}</span><span>개</span> <!-- 상품 개수 넣는 자리입니다 -->
                                  <span>/</span>
                                  <span>${ovo.optionvo.ml}</span><span>ml</span> <!-- 상품 옵션 넣는 자리입니다 -->
                              </div>
                          </li>
                          <li>
                             <div>
                             	<span id="orderDate">주문일자: ${ovo.o_date}</span>
                             </div>
                          </li>
                          <li>
                              <div>
                                  <span><fmt:formatNumber value="${ovo.orderdetailvo.od_price}" type="number" groupingUsed="true" /></span><span>원</span>
							 <!-- 상품 가격 넣는 자리입니다 -->
                              </div>
                          </li>
                          <li>
                              <div style="display: flex; justify-content: space-around;">
                                  <div class="delivery-status">${ovo.dstatus}</div> <!-- 배송상태 넣는 자리입니다 -->
                            		<div class="arrow-container" style="cursor: pointer;">
                        				<span class="arrow"></span>
                   					</div>
                              </div>
                          </li>
                      </ul>
                   </div>
                   
                   
                   <div class="addInfo scrollbar"
						style="height: 100px; width: 100%; border: 1px solid #D9D9D9; background-color: white; color: black; display: none;">
						<div>
							<span>주문번호: ${ovo.o_num}</span>
						</div>
						<div>
							<span>계절: ${ovo.productvo.pseason}</span>
						</div>
						<div>
							<span>성별: ${ovo.productvo.gender}</span>
						</div>
						<div>
							<div>배송지: ${ovo.deliveryvo.daddress}</div>
							<!-- 배달받는 사람 주소 넣는 자리입니다 -->
						</div>
						<div>
							<span>받는사람: ${ovo.deliveryvo.d_name}</span>
							<!-- 배달받는 사람 이름 넣는 자리입니다 -->
						</div>
						<div>
							<span>받는사람 전화번호: ${ovo.deliveryvo.d_mobile}</span>
							<!-- 배달받는 사람 전화번호 넣는 자리입니다 -->
						</div>
					</div>
                   
        	</div>
	 </c:forEach>
	</c:if>
		<%-- =============================================== --%>
		<c:if test="${empty requestScope.orderList}">
		            <div class="recent-orders-title">나의 주문 향수</div>
		            <div class="recent-orders-box">
		                <div>최근 주문 내역이 없습니다.</div>
		            </div>
		</c:if>
		
		<br>
	 	
		<div class="recent-orders-title">최근 본 향수</div>
		<ul class="cardcontainer">
		<c:if test="${not empty requestScope.pvoList}">
			<c:forEach var="pvoList" items="${requestScope.pvoList}">
		 			<li class="cardbox" style="width: 100%; list-style: none;">
	                   <a href="/CLARETe/shop/prodView.cl?p_num=${pvoList.p_num}">
	                       <div class="cardimg">
	                       	<img src="/CLARETe/images/${pvoList.p_image}" style="width: 100%;  display: block;">
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
		</ul>
		
		
		<c:if test="${empty requestScope.pvoList}">
			<div class="mypage_contants_bottom">
	            <div class="recent-orders-box">
	                <div>최근 본 상품이 없습니다.</div>
	            </div>
	        </div>
        </c:if>
		<%-- =============================================== --%>
		
		

<%-- 마이페이지푸터 include 받아옴 --%>
<jsp:include page="mypagefooter.jsp"></jsp:include>
<%-- 마이페이지푸터 include 받아옴 --%> 

<%-- 푸터 include 받아옴 --%>
<jsp:include page="../footer.jsp"></jsp:include>
<%-- 푸터 include 받아옴 --%>
<script>
$(document).ready(function() {
	//=== 클릭시 화살표 토글 === //
	$('.arrow').click(function(e) {
	    $(this).parent().parent().parent().parent().parent().next().toggle();
	});
});
</script>
    
</body>
</html>
