<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
String ctxPath = request.getContextPath();
//    /CLARETe
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/css/index/header.css" />
<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/css/index/footer.css" />
<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/css/cart/orderComplete.css" />

<!-- Optional JavaScript -->
<script type="text/javascript"
	src="<%=ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript"
	src="<%=ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js"></script>

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript"
	src="<%=ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<%-- 직접 만든 JS --%>
<script type="text/javascript"
	src="<%=ctxPath%>/js/cart/orderComplete.js"></script>


<jsp:include page="../header.jsp"></jsp:include>


<section
	style="width: 100%; height: auto; margin-bottom: 100px; padding-top: 4.5rem">

	<div id="all_container">

		<div id="fistDiv">
			<a class="cart">장바구니</a> <a class="step">1.장바구니&nbsp;&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;&nbsp;2.주문서
				작성&nbsp;&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;&nbsp;<strong>3.주문완료</strong>
			</a>
		</div> <!-- div#fistDiv -->

		<div id="secondDiv">

			<div id="orderImg">
				<img src="../images/shoppingbag.png" />
			</div>

			<div id="ordernum">
				<span>${fn:substring(requestScope.ovo.o_date, 0, 10)} 주문하신 향수의</span><br> <span>주문번호는 <span
					id="num">C${fn:replace(fn:substring(requestScope.ovo.o_date, 0, 10), '-', '')}${sessionScope.pnum}</span> 입니다
				</span>
				<!-- 주문번호형식 : C + 주문날짜 + 주문번호 -->
				
			</div> <!-- div#ordernum -->
			
			
		</div> <!-- div#secondDiv -->

		<div id="thirdDiv">

			<div id="productInfoDiv">

				<div id="menu1">
					<strong>주문 상품 정보 (${requestScope.ovo.o_cnt}건)</strong>
				</div>
				
				<div id="productList">

					<div id="productInfo">
						<img src="/CLARETe/images/${requestScope.pvo.p_image}" />
						<div class="perfume">
							${requestScope.pvo.p_name}  <br> <fmt:formatNumber value="${requestScope.pvo.p_price - (requestScope.pvo.p_price * requestScope.pvo.p_sale / 100) + requestScope.opvo.op_price}" pattern="#,###,###"/>	
						</div>
						<div class="option">
							<c:choose>
									<c:when test="${requestScope.opvo.op_ml == '1'}">50ml</c:when>
									<c:when test="${requestScope.opvo.op_ml == '2'}">75ml</c:when>
									<c:when test="${requestScope.opvo.op_ml == '3'}">100ml</c:when>
							</c:choose>
							/ 1개
						</div>
					</div>


				</div> <!-- div#productList -->

			</div> <!-- div#productInfoDiv -->

		</div> <!-- div#thirdDiv -->
	
		<div id="fourth">
			
			<div id="leftDiv">
				
				<div id="menu2">
					<strong>배송정보</strong>
				</div>
				
				<table>
					<tr>
						<td class="infoTd">이름</td>
						<td>${requestScope.dvo.d_name}</td>
					</tr>
					<tr>
						<td class="infoTd">전화번호</td>
						<td>
							${fn:substring(requestScope.dvo.d_mobile, 0, 3)} - ${fn:substring(requestScope.dvo.d_mobile, 3, 7)} - ${fn:substring(requestScope.dvo.d_mobile, 7, 11)}
						</td>
					</tr>
					<tr>
						<td class="infoTd">상세주소</td>
						<td>(${requestScope.dvo.d_postcode}) ${requestScope.dvo.d_address}</td>
					</tr>
				</table>
				
			</div> <!-- div#leftDiv -->
			
			<div id="rightDiv">
				
				<div id="menu3">
					<strong>결제정보</strong>
				</div>
				
				<table>
					<tr>
						<td class="priceTd">상품금액</td>
						<td><fmt:formatNumber value="${requestScope.pvo.p_price - (requestScope.pvo.p_price * requestScope.pvo.p_sale / 100) + requestScope.opvo.op_price}" pattern="#,###,###"/></td>
					</tr>
					<tr>
						<td class="priceTd">포인트 사용금액</td>
						<td><fmt:formatNumber value="${sessionScope.one_m_point}" pattern="#,###,###"/></td>
					</tr>
					<tr>
						<td class="priceTd">배송비</td>
						<td><fmt:formatNumber value="${sessionScope.input_total_shipping}" pattern="#,###,###"/></td>
					</tr>
					<tr>
						<td class="priceTd total">최종 결제 금액</td>
						<td class="total"><fmt:formatNumber value="${requestScope.ovo.o_price}" pattern="#,###,###"/></td>
					</tr>
				</table>
				
			</div> <!-- div#rightDiv -->
			
		</div> <!-- div#fourth -->
		
		<div id="continueShopping"><a href="<%= ctxPath%>/">주문 계속하기</a></div>
	</div> <!-- div#all_container -->

</section>

<jsp:include page="../footer.jsp"></jsp:include>




