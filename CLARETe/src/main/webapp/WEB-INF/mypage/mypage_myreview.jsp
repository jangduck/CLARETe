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
    <title>금쪽이</title>

	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/mapage.css">
	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/media_nav.css">    
	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/recent_mypage.css">   
	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/review_mypage.css">  
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
	
<form name="mypageFrm" action="/CLARETe/mypage/mypage_myreview.cl" method="get">
	<input type="text" name="fk_m_id" value="<%=session.getAttribute("id")%>"/>
	<button>보내기</button>
</form>

		<%-- =============================================== --%>
        <div class="mypage_contants_bottom">
            <div style="height: auto; display: flex; align-items: center; gap: 4px;">
                <span class="recent-orders-title">내가 쓴 리뷰</span>
                <span>
                    <div class="select-container">
                        <select>
                            <!-- 제이쿼리 이용해서 현재 년도의 -5년도까지 option으로 넣음 이거 클릭시 값 넘어가게 처리하세요 .on() 으로 해야합니다 참고! -->
                        </select>
                    </div>
                </span>
            </div>

            
            <div class="review_container">




                <!-- === for문 대상 시작 === -->
            <c:if test="${not empty requestScope.myreviewList}">
			<c:forEach var="rvo" items="${requestScope.myreviewList}">
                <a href="#">
                    <div class="review_box">
                        <div>
                            <div class="review_img"></div>
                            <div class="review_info_box">
                                <div class="reviw_info">
                                    <div>${rvo.pvo.p_name}</div> <!-- 상품명 넣는 자리입니다 -->
                                </div>
                                <div>
                                    <span>${rvo.odvo.od_count}</span><span>개</span> <!-- 상품 개수 넣는 자리입니다 -->
                                    <span>/</span>
                                    <span>50</span><span>ml</span> <!-- 상품 옵션 넣는 자리입니다 -->
                                </div>
                            </div>
                        </div>
                        <div class="review_contants"> <!-- 리뷰내용을 넣는 자리입니다. -->
                            ${rvo.r_msg}
                        </div>
                    </div>
                </a>
                </c:forEach>            
			</c:if>
                <!-- === for문 대상 끝 === -->
			
			
			 <%--
                <a href="#">
                
                    <div class="review_box">
                        <div>
                            <div class="review_img"></div>
                            <div class="review_info_box">
                                <div class="reviw_info">
                                    <div> 상품명이 들어설 자리입니다.</div> <!-- 상품명 넣는 자리입니다 -->
                                </div>
                                <div>
                                    <span>1</span><span>개</span> <!-- 상품 개수 넣는 자리입니다 -->
                                    <span>/</span>
                                    <span>50</span><span>ml</span> <!-- 상품 옵션 넣는 자리입니다 -->
                                </div>
                            </div>
                        </div>
                        <div class="review_contants"> <!-- 리뷰내용을 넣는 자리입니다. -->
                            향수 너무 향이 좋아서 이번에 또 구매했네요 클라르테 봄, 여름, 가을, 겨울 별로 할인 판매 해주셔서 항상 감사합니다.
                        </div>
                    </div>
             
	         
                </a>
  					--%>
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
