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
	

		<%-- =============================================== --%>
        <div class="mypage_contants_bottom">
                <div style="height: auto; display: flex; align-items: center; gap: 4px;">
                    <span class="recent-orders-title">나의 주문 향수</span>
                    <span>
                        <div class="select-container">
                            <select class="select" >
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
                <!-- === for문 대상 끝 === -->

                <c:if test="${empty requestScope.orderList}">
                	최근 주문 상품이 없습니다.
                </c:if>

          </div>
		<%-- =============================================== --%>
		
		

<%-- 마이페이지푸터 include 받아옴 --%>
<jsp:include page="mypagefooter.jsp"></jsp:include>
<%-- 마이페이지푸터 include 받아옴 --%> 

<%-- 푸터 include 받아옴 --%>
<jsp:include page="../footer.jsp"></jsp:include>
<%-- 푸터 include 받아옴 --%>
    
<script>

$(document).ready(function() {
    // 초기 로드 시 "모든 연도"와 현재 연도부터 5년 전까지 추가
    let html = '';
    let currentYear = new Date().getFullYear(); // 현재 연도
    let allYears = ['모든 연도']; // "모든 연도"를 첫 번째 옵션으로 추가
    let yearsToShow = [];  // 현재 연도부터 5년 전까지 연도를 넣을 배열
    
    // 현재 연도부터 5년 전까지의 연도를 배열에 추가
    for (let i = currentYear; i > currentYear - 5; i--) {
        yearsToShow.push(i);
    }

    // "모든 연도"를 select 옵션에 추가
    html += '<option name="option-year" value="all">모든 연도</option>';

    // 현재 연도부터 5년 전까지의 연도를 select 옵션에 추가
    for (let i = 0; i < yearsToShow.length; i++) {
        html += '<option name="option-year" value="' + yearsToShow[i] + '">' + yearsToShow[i] + '년</option>';
    }
    
    $(".select").html(html); // 옵션을 select 태그 안에 추가

    // 초기 페이지 로드 시 "모든 연도"를 선택한 상태로 모든 주문을 보여주도록 설정
    filterOrdersByYear("all"); // 기본적으로 "모든 연도"가 선택되었을 때 모든 주문을 보여줌

    // === 년도가 선택될 때마다 해당 연도에 맞는 주문만 보이도록 처리 === //
    $(".select").on("change", function() {
        const selectedYear = $(this).val(); // 선택된 연도 값
        console.log("선택된 연도: ", selectedYear);

        // 주문일자에서 연도를 추출하여 비교
        filterOrdersByYear(selectedYear);  // 연도 선택 시 필터링
    });

    function filterOrdersByYear(year) {
        // 주문일자에서 연도를 추출하여 비교
        $("span[id^='orderDate']").each(function() {
            const orderDateText = $(this).text().trim();  // "주문일자: 2025-01-01" 또는 "주문일자: 2025"
            const orderYear = orderDateText.substring(6, 10);  // 주문일자에서 연도를 추출 (예: "2025")
            console.log("주문일자 연도: ", orderYear);
            
            // "모든 연도" 선택 시 모든 주문을 보여줌
            if (year === "all" || orderYear === year) {
                $(this).closest(".recent-orders").show(); // 연도가 맞거나 "모든 연도"를 선택하면 해당 주문을 표시
            } else {
                $(this).closest(".recent-orders").hide(); // 연도가 맞지 않으면 해당 주문을 숨김
            }
        });
    }

    // === 클릭시 화살표 토글 === //
    $('.arrow').click(function(e) {
        $(this).parent().parent().parent().parent().parent().next().toggle();
    });
});




</script><!-- 제이쿼리 이용해서 현재 년도의 -5년도까지 option으로 넣음 이거 클릭시 값 넘어가게 처리하세요 .on() 으로 해야합니다 참고! -->
</body>
</html>
