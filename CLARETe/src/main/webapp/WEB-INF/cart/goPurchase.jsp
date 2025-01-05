<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctxPath = request.getContextPath();
    //    /CLARETe
%> 

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/header.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/footer.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/cart/goPurchase.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script> 

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/cart/goPurchase.js"></script>

<jsp:include page="../header.jsp"></jsp:include>

<section style="width: 100%; height: auto; margin-bottom: 100px; padding-top: 4.5rem">

<form name="order_form" method="POST" action="<%= ctxPath %>/cart/goPurchaseOrder.cl">
	<div id="all_container">
		<div id="fistDiv">
			<a class="cart">상품 구매</a>
			<a class="step"><strong>1.상품 구매</strong>&nbsp;&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;&nbsp;2.주문서 작성&nbsp;&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;&nbsp;3.주문완료</a>
		</div>	
		
		<div id="productList">
			<div class="cart_container" style="border-top: none; border-bottom: 1px solid black; border-left: none; border-right: none;">
				
				<div class="menuDiv" style="border-top: 1px solid black; border-bottom: none; border-left: none; border-right: none;">
					<a class="a_cart">구매 상품</a>
				</div>
				
					
					<div class="product" data-index="${status.index}"> <!-- product 하나 시작 -->
						<div class="upDiv">
							
								<img src="/CLARETe/images/${requestScope.pvo.p_image}" />
								
								<div class="infoDiv">
									${requestScope.pvo.p_name}	<!-- 향수 이름 -->							
									<br>
									<fmt:formatNumber value="${requestScope.pvo.p_price - (requestScope.pvo.p_price * requestScope.pvo.p_sale / 100) + requestScope.opvo.op_price}" pattern="#,###,###"/>	<!-- 향수 가격 -->		
								</div>	
								<span class="priceSpan" data-price="${requestScope.pvo.p_price - (requestScope.pvo.p_price * requestScope.pvo.p_sale / 100) + requestScope.opvo.op_price}">
								    <fmt:formatNumber value="${(requestScope.pvo.p_price - (requestScope.pvo.p_price * requestScope.pvo.p_sale / 100) + requestScope.opvo.op_price) }" pattern="#,###,###"/>	<!-- 구매수량 얻어와야 함 -->	
								</span>
						</div>
						<div class="downDiv">
							<span class="optionSpan"> <!-- 향수 용량 -->	
								-옵션 	
								<c:choose>	
									<c:when test="${requestScope.opvo.op_ml == 1}">50ml</c:when>
									<c:when test="${requestScope.opvo.op_ml == 2}">75ml</c:when>
									<c:when test="${requestScope.opvo.op_ml == 3}">100ml</c:when>
								</c:choose>	
							</span>
							
							<div>		
								<div class="counter-container">
							        <div class="counter-button decrease" id="decrease${cvo.c_num}">-</div>
							        <div class="counter-value" data-count="1">1</div> <!-- 기본값을 1로 설정 -->
							        <div class="counter-button increase">+</div>
							    </div>
							</div>
	  
						</div>
						
						<!-- 값 넘기는 용도 -->
						<input type="hidden" name="index" value="${status.index}">
						<input type="text" name="perfumeName" value="${requestScope.pvo.p_name}">
						<input type="text" id="quantity" name="quantity" value="${cvo.c_count}">	<!-- 구매 개수 -->
						<input type="hidden" name="price" value="${cvo.opvo.op_price}">
						<input type="hidden" id="priceQuantity${status.index}" name="priceQuantity" value="${cvo.opvo.op_price * cvo.c_count}">
						<input type="text" name="option" value="${requestScope.opvo.op_num}">
						<input type="hidden" name="cartNum" value="${cvo.c_num}">
						<input type="text" name="p_num" value="${requestScope.pvo.p_num}">
						<input type="text" name="productprice" value="">
						
					</div> <!-- product 하나 끝 -->
				

			</div>
			
			<div class="payment_go_box">
			
    			<div class="payment_info">
        			<a class="order_product">주문상품</a>
        			<hr>

        			<!-- 총 상품 금액 -->
        			<div style="display: flex; justify-content: space-between; margin: 10px 0;">
            			<span class="product_amount">총 상품 금액</span>
            			<span class="product_price"></span>		<!-- 향수 가격 * 구매 수량 -->	
        			</div>

        			<!-- 총 할인 금액 -->
        			<div style="display: flex; justify-content: space-between; margin: 10px 0;">
            			<span class="shipping">배송비</span>
            			<span class="shipping_price">0</span>	<!-- 배송비 -->
        			</div>
        			<hr>

        			<!-- 결제 예정 금액 -->
        			<div style="display: flex; justify-content: space-between; font-weight: bold; margin: 20px 0;">
            			<span class="total">결제 예정 금액</span>
            			<span class="total_price"></span>	<!-- 총 구매 금액 -->
        			</div>
    			</div>

	    		<!-- 주문하기 버튼 -->
	    		<button type="submit" id="btn-order">주문하기</button>
			</div>

		</div>
		
		<div class="totalDiv">
			<div class="totalA">
				<a>[배송]</a> <br> <hr class="totalHr">
				<a>상품구매금액 : </a>
				<a id="total_product"></a>		<!-- 향수 가격 * 구매 수량 -->	
				<a> + 배송비 </a>
				<a id="total_shipping"></a>
				<a>(10만원 이상 구매 시 무료배송)</a> <br> <hr class="totalHr">	<!-- 배송비 -->	
				<a>합계 : </a> 
				<a id="total_total"></a>	<!-- 총 구매 금액 -->
			</div>	
			
			<input type="hidden" id="input_total_product" name="totalProduct" value=""> 
			<input type="hidden" name="input_total_shipping" id="input_total_shipping" name="totalShipping" value="">
			<input type="hidden" id="input_total_total" name="totalTotal" value="">
			
		</div>
			
	</div>

</form>
</section>

<jsp:include page="../footer.jsp"></jsp:include>
