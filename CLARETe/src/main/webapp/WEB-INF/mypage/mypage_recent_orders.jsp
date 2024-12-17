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
    <title>금쪽이</title>

	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/mapage.css">
	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/media_nav.css">    
	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/recent_mypage.css">   
	
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
                    <span class="recent-orders-title">최근 주문 향수</span>
                    <span>
                        <div class="select-container">
                            <select class="select">
                                
                            </select>
                        </div>
                    </span>
                </div>

                <!-- === for문 대상 시작 === -->

                <div class="recent-orders">
                    <div>
                        <ul>
                            <li>
                                <div class="recent-img">img</div> <!-- 상품 이미지 넣는 자리입니다 -->
                            </li>
                            <li>
                                <div>
                                    <div>상품명이 들어설 자리입니다.</div> <!-- 상품명 넣는 자리입니다 -->
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
                                    <span>이순신</span> <!-- 배달받는 사람 이름 넣는 자리입니다 -->
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
                                <div style="display: flex; justify-content: space-around;">
                                    <div class="delivery-status">배송중</div> <!-- 배송상태 넣는 자리입니다 -->
                                    <span class="confirmed-btn">구매확정</span> <!-- 구매확정이 되어야 리뷰를 달 수 있게 처리해주세요 -->
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- === for문 대상 끝 === -->

                

                <div class="recent-orders">
                    <div>
                        <ul>
                            <li>
                                <div class="recent-img">img</div> <!-- 상품 이미지 넣는 자리입니다 -->
                            </li>
                            <li>
                                <div>
                                    <div>상품명이 들어설 자리입니다.</div> <!-- 상품명 넣는 자리입니다 -->
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
                                    <span>이순신</span> <!-- 배달받는 사람 이름 넣는 자리입니다 -->
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
                                <div style="display: flex; justify-content: space-around;">
                                    <div class="delivery-status">배송중</div> <!-- 배송상태 넣는 자리입니다 -->
                                    <span class="confirmed-btn">구매확정</span> <!-- 구매확정이 되어야 리뷰를 달 수 있게 처리해주세요 -->
                                </div>
                            </li>
                        </ul>
                    </div>
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
$(document).ready(function(){
	//=== 년도 구해서 -5년도까지 option 태그에 넣기 === //
	let today = new Date();
	
	console.log(today);
	
	let year = today.getFullYear();
	let yearsAgo
	let html = ``;
	
	// console.log(year-1);
	
	for(let i=0; i<5; i++){
		console.log(year - i);
		
	    html += `<option name="option-year" value="${year - i}">${year - i}년</option>`
	    	// console.log(html);
	    // 여기서 해당 셀랙터를 잡으려면 .on을 해야 잘 잡히겠죠..? 기억 하시죠?
	}
	
	$('select').html(html);
	// === 년도 구해서 -5년도까지 option 태그에 넣기 === //
});
</script><!-- 제이쿼리 이용해서 현재 년도의 -5년도까지 option으로 넣음 이거 클릭시 값 넘어가게 처리하세요 .on() 으로 해야합니다 참고! -->
</body>
</html>
