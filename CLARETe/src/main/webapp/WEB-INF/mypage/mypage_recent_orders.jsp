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
</style>

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
                    <span class="recent-orders-title">나의 주문 향수</span>
                    <span>
                        <div class="select-container">
                            <select class="select">
                                
                            </select>
                        </div>
                    </span>
                </div>

                <!-- === for문 대상 시작 === -->
 			<c:if test="${not empty requestScope.orderList}">
				<c:forEach var="ovo" items="${requestScope.orderList}"> 
	                <div class="recent-orders">
	                    <div>
	                        <ul>
	                            <li>
	                                <div class="recent-img">
	                                	<img>
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
	                                    <div>${ovo.deliveryvo.daddress}</div> <!-- 배달받는 사람 주소 넣는 자리입니다 -->
	                                </div>
	                                <div>
	                                    <span>${ovo.deliveryvo.d_name}</span> <!-- 배달받는 사람 이름 넣는 자리입니다 -->
	                                    <span>/</span>
	                                    <span>${ovo.deliveryvo.d_mobile}</span> <!-- 배달받는 사람 전화번호 넣는 자리입니다 -->
	                                </div>
	                            </li>
	                            <li>
	                                <div>
	                                    <span><fmt:formatNumber value="${ovo.o_price}" type="number" groupingUsed="true" /></span><span>원</span>
										 <!-- 상품 가격 넣는 자리입니다 -->
	                                </div>
	                            </li>
	                            <li>
	                                <div style="display: flex; justify-content: space-around;">
	                                    <div class="delivery-status">${ovo.dstatus}</div> <!-- 배송상태 넣는 자리입니다 -->
	                                </div>
	                            </li>
	                        </ul>
	                    </div>
	                </div>
	 			</c:forEach>
			</c:if> 
                <!-- === for문 대상 끝 === -->

                <c:if test="${empty requestScope.orderList}">
                	최근 주문 상품이 없습니다.
                </c:if>
                

              <div class="recent-orders">
			    <div>
			        <ul>
			            <li>
			                <div class="recent-img">img</div> <!-- 상품 이미지 넣는 자리입니다 -->
			            </li>
			            <li>
			                <div>
			                    <div>${pvo.name}</div> <!-- 상품명 넣는 자리입니다 -->
			                </div>
			                <div>
			                    <span>1</span><span>개</span> <!-- 상품 개수 넣는 자리입니다 -->
			                    <span>/</span>
			                    <span>50</span><span>ml</span> <!-- 상품 옵션 넣는 자리입니다 -->
			                </div>
			            </li>
			            <li>
			                <div>
			                    <div>이곳은 주소가 들어설 자리입니다. (행정동) 202호</div> <!-- 배달받는 사람 주소 넣는 자리입니다 -->
			                </div>
			                <div>
			                    <span>이름</span> <!-- 배달받는 사람 이름 넣는 자리입니다 -->
			                    <span>/</span>
			                    <span>010-2020-3030</span> <!-- 배달받는 사람 전화번호 넣는 자리입니다 -->
			                </div>
			            </li>
			            <li>
			                <div>
			                    <span>50,000</span><span>원</span> <!-- 상품 가격 넣는 자리입니다 -->
			                </div>
			            </li>
			            <li>
			                <div style="display: flex; justify-content: space-around; align-items: center;">
			                    <div class="delivery-status">배송중</div> <!-- 배송상태 넣는 자리입니다 -->
			                    <div class="arrow-container" style="cursor: pointer;">
			                        <span class="arrow"></span>
			                    </div>
			                </div>
			            </li>
			        </ul>
			    </div>
			    
			    <div class="addInfo" style="height: 100px; width: 100%; border: 1px solid red; background-color: #dbdbdb">
                      추가정보가 들어갈 자리입니다.
                </div>
			    
			</div>

          </div>
		<%-- =============================================== --%>
		
		

<%-- 마이페이지푸터 include 받아옴 --%>
<jsp:include page="mypagefooter.jsp"></jsp:include>
<%-- 마이페이지푸터 include 받아옴 --%> 

<%-- 푸터 include 받아옴 --%>
<jsp:include page="../footer.jsp"></jsp:include>
<%-- 푸터 include 받아옴 --%>
    
<script>

		//=== 년도 구해서 -5년도까지 option 태그에 넣기 === //
		let today = new Date();
		
		console.log(today);
		
		let year = today.getFullYear();
		let yearsAgo
		let html = '';
		
		// console.log(year-1);
		
		for(let i=0; i<5; i++){
			console.log(year - i);
			
			html += '<option name="option-year" value="' + (year - i) + '">' + (year - i) + '년</option>';
		    // 여기서 해당 셀랙터를 잡으려면 .on을 해야 잘 잡히겠죠..? 기억 하시죠?
		    	console.log(html);
		}
		
		$(".select").html(html);
		
	
		// === 년도 구해서 -5년도까지 option 태그에 넣기 === //

		$('.arrow').click(function(e){
         $(this).parent().parent().parent().parent().parent().find('.addInfo').slideToggle();
      })
</script><!-- 제이쿼리 이용해서 현재 년도의 -5년도까지 option으로 넣음 이거 클릭시 값 넘어가게 처리하세요 .on() 으로 해야합니다 참고! -->
</body>
</html>
