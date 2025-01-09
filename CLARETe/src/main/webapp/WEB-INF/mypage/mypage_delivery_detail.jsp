<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
 String ctxPath = request.getContextPath();
	
%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>금쪽이</title>

	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/mapage.css">
	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/media_nav.css">   
	 <link rel="stylesheet" href="<%= ctxPath %>/css/mypage/delivery_detail.css">
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    
    <!-- Optional JavaScript -->


	<%-- 해더 include 받아옴 --%>
	<%-- <jsp:include page="<%= ctxPath %>/WEB-INF/header.jsp"> --%>
    <jsp:include page="../header.jsp"></jsp:include>
	<%-- 해더 include 받아옴 --%>
	
	<%-- 마이페이지해더 include 받아옴 --%>
    <jsp:include page="mypageheader.jsp"></jsp:include>    
	<%-- 마이페이지해더 include 받아옴 --%>
	
	 <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
	
	  <script type="text/javascript" src="<%= ctxPath %>/js/mypage/deleteDeliveryInfo.js"></script> 
	   <script type="text/javascript" src="<%= ctxPath %>/js/mypage/insertDelivery.js"></script> 


	<%-- =============================================== --%>
	
		
        <div class="mypage_contants_bottom">
        
	    <div class="content-flex" >
	    	<form id="deliveryDeletFrm" name="deliveryDeletFrm" action="deleteDelivery.cl" method="post" style="display:flex;">
      			<c:forEach var="dvo" items="${requestScope.deliveryList}">
	        		<div class="delivery-content-box">
		        		<ul class="delivery-info">
			           		<li><span id="info_title">받는 사람 주소</span>${dvo.d_address}</li>
		                    <li><span id="info_title">받는 사람 상세 주소</span>${dvo.d_detail_address}</li>
		                    <li><span id="info_title">받는 우편 번호</span>${dvo.d_postcode}</li>
		                    <li><span id="info_title">받는 사람 참고 항목</span>${dvo.d_extra}</li>
		                    <li><span id="info_title">받는 사람 전화번호</span>${dvo.d_mobile}</li>
		                    <li><span id="info_title">받는 사람 이름</span>${dvo.d_name}</li>
			           	</ul>
		           <div class="deletebutton">
		           		<input type="hidden" name="d_num" class="deliveryD_num" value="${dvo.d_num}">
	                    <input type="button" class="delivery_info_delete" value="삭제" onclick="goDeliveryDel()" >
                    </div>
		           	</div>
	        	</c:forEach>	        	
	          </form>
			</div>
 
	         <div class="delivery_info_insert" style="text-align: center; margin-top:10%;">
	          <button type="button" id="toggleButton" style="display:inline-block; background-color:#ffff; border:#ffff; font-size:30px;">
	          배송지 추가하기
	          </button>
	        </div>
	        
        </div>		
				
             <div class="delivery_Insert">
             	<div id="clickOk"></div>
             	<div id="deliveryFrm">
             		<form id="frm" name="frm">
             			<div style="text-align: right;">
	             			<h4>
	             				<button type="button" class="toggleColse" style="border:#ffff; background-color:#ffff; color:black; font-size: 30px;">
	             				x
	             				</button>
	             			</h4>
             			</div>
             			<div class="delivery_info_title" style="margin-top: 20px;" >
             				<h4 style="text-align: center; font-size: 1.5rem;">배송지를 입력해주세요</h4>
             				<span id="mandatoryNote"><span class="asterisk">*</span> 필수입력사항</span>
             				<hr class="divider">
             			</div>
             			
             			<ul style="margin-top: 5%;">
	             			<li style="margin-top:10px; margin-left: 20px;" class="formDiv">
		             			<label id="infotitle">받는 사람<span class="asterisk">*</span></label><br>
		             			<input type="text" name="d_name" id="userinfo" class="d_deliveryInfo d_name" placeholder="이름을 입력해주세요"></input>
		             			<span class = "error"> 이름을 입력해주세요!</span>
	             			</li>
	             			
	             			<li style="margin-top:10px; margin-left: 20px;" class="formDiv">
		             			<label id="infotitle">받는 사람 전화번호<span class="asterisk">*</span></label><br>
		             			<input type="text" name="d_mobile" id="userinfo" class="d_deliveryInfo d_mobile" maxlength="11" placeholder="' - '를 빼고 숫자만 입력해주세요"></input>
		             			<span class = "error"> 숫자로 입력하세요!</span>
		             			<span class="none-text">전화번호를 입력해주세요!</span><!-- 유효성 검사로 span 태그에 클래스 하나 추가함 -->
	             			</li>
	             			
	             			<li style="margin-top:10px; margin-left: 20px;" class="formDiv">
		             			<label id="infotitle">받는 사람 우편번호<span class="asterisk">*</span></label><br>
		             			<input type="text" name="d_postcode" id="postcode" class="d_deliveryInfo d_postcode" value="" style="width:215px;" placeholder="우편번호를 입력해주세요."></input>
		             			<input type="button" name="postCodeButton" id="postCodeButton"  class="PostCodeFind " value="우편번호검색"/>
		             			<span class = "error"> 5자리의 숫자로 적어주세요!</span>
	             			</li>
	             			
	             			<li style="margin-top:10px; margin-left: 20px;" class="formDiv">
		             			<label id="infotitle">받는 사람 주소<span class="asterisk">*</span></label><br>
		             			<input type="text" name="d_address" id="address" class="d_deliveryInfo d_address" value="" placeholder="주소" style="width:350px;"></input>
		             			<span class="error">주소를 입력해주세요!</span>
		             			
	             			</li>
	             			
	             			<li style="margin-top:10px; margin-left: 20px;" class="formDiv">
		             			<label id="infotitle">받는 사람 상세주소<span class="asterisk">*</span></label><br>
		             			<input type="text" name="d_detail_address" id="detailaddress" class="d_deliveryInfo d_detailaddress" value="" placeholder="상세주소"></input>
		             			<input type="text" name="d_extra" id="extra" class="d_deliveryInfo d_extra" placeholder="참고항목"></input>
		             			<span class="error">상세주소를 입력해주세요!</span>
	             			</li>
	             	
	             			 <li style="margin-top: 30px; text-align: center; padding-bottom: 30px;"  >
	             			 	
		             				<input type="button" class="btn_success" value="배송지 입력" id="insertBtn" onclick="goInsertDelivery()" />
		             				<input type="reset"  class="btn_reset" value="취소하기" id="insertBtn" />
		             				<input type="hidden" name="fk_m_id" id="userinfo" class="d_deliveryInfo" value="<%= session.getAttribute("id")%>"></input>
	             			
	             			</li>
             			</ul>
             		</form>
             	</div>
             </div> 
             
<%-- =============================================== --%>

<%-- 마이페이지푸터 include 받아옴 --%>
<jsp:include page="mypagefooter.jsp"></jsp:include>
<%-- 마이페이지푸터 include 받아옴 --%> 

<%-- 푸터 include 받아옴 --%>
<jsp:include page="../footer.jsp"></jsp:include>
<%-- 푸터 include 받아옴 --%>
    
    

