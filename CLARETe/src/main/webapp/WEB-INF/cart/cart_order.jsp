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
		
		<div id="infoDiv">
			<div class="cart_container" style="border-top: none; border-bottom: 1px solid black; border-left: none; border-right: none;">
		
			<div class="menuDiv" style="border-top: 1px solid black; border-bottom: none; border-left: none; border-right: none;">
				<a class="a_cart">주문고객</a>
			</div>
		</div>
		
		
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
    		<button id="btn-order">주문하기</button>
		</div>
		
	</div>



</section>

<jsp:include page="../footer.jsp"></jsp:include>