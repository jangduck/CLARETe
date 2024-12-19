<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //    /CLARETe
%> 

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/header.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/footer.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/cart/cart_order.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script> 

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/cart/cart_order.js"></script>


<jsp:include page="../header.jsp"></jsp:include>

<section style="width: 100%; height: auto; margin-bottom: 100px; padding-top: 4.5rem">


	<div id="all_container">
	
		<div id="fistDiv">
			<a class="cart">장바구니</a>
			<a class="step">1.장바구니&nbsp;&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;&nbsp;<strong>2.주문서 작성</strong>&nbsp;&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;&nbsp;3.주문완료</a>
		</div>	
		
		<div id="secondDiv">
		
			<div id="infoDiv">
			
				<div id="memberInfoDiv">
					
					<div id="menu1">
						<strong>주문고객</strong>
						<span>&#9660;</span>
					</div>
					
					<div id="memberInfo">
						<p>이름: 강이훈</p>
	                	<p>전화번호: 010-2121-3131</p>
					</div>
	   
	            </div> <!-- memberInfoDiv -->
	
	            <div id="orderInfoDiv">
	            
	            	<div id="menu2">
						<strong>배송정보</strong>
						<span>&#9660;</span>
					</div>
					
					<div id="orderInfo">
						<p>이름: 장민규</p>
	                	<p>전화번호: 010-1234-1234</p>
	                	<p>상세주소: (12345) 주소입니다.</p>
					</div>
	           		
	            </div> <!-- orderInfoDiv -->
				
				<div id="productInfoDiv">
	            
	            	<div id="menu3">
						<strong>주문 상품 정보 (2건)</strong>
						<span>&#9660;</span>
					</div>
					
					<div id="productList">
					
						<div id="productInfo">
							<p>이름: 장민규</p>
		                	<p>전화번호: 010-1234-1234</p>
		                	<p>상세주소: (12345) 주소입니다.</p>
						</div>

					</div> <!-- productList -->
					
	           		
	            </div> <!-- productInfoDiv -->
	            
			</div> <!-- infoDiv -->
			
			<div class="payment_go_box">
				<div class="payment_info">
        			<a class="order_product">주문상품</a>
        			<hr>

        			<!-- 총 상품 금액 -->
        			<div style="display: flex; justify-content: space-between; margin: 10px 0;">
            			<span class="product_amount">총 상품 금액</span>
            			<span class="product_price">76,000</span>
        			</div>

        			<!-- 총 할인 금액 -->
        			<div style="display: flex; justify-content: space-between; margin: 10px 0;">
            			<span class="shipping">배송비</span>
            			<span class="shipping_price">0</span>
        			</div>
        			<hr>

        			<!-- 결제 예정 금액 -->
        			<div style="display: flex; justify-content: space-between; font-weight: bold; margin: 20px 0;">
            			<span class="total">결제 예정 금액</span>
            			<span class="total_price">76,000</span>
        			</div>
    			</div>
				
				<!-- 주문하기 버튼 -->
	    		<button id="btn-order">결제하기</button>
	    		
			</div> <!-- payment_go_box -->
			
			
		</div>
		
		
		
		
		
	</div>

</div>


</section>

<jsp:include page="../footer.jsp"></jsp:include>