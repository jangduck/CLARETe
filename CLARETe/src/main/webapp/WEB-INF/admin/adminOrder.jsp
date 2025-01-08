<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>   

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/admin_section.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/admin_header.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js"></script>

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script> 

<jsp:include page="adminheader.jsp" />

<style type="text/css">
div#pageBar {
	border: solid 0px red;
	width: 80%;
	margin: 3% auto 0 auto;
	display: flex;
}

div#pageBar>nav {
	margin: auto;
}

button.btn.btn-primary {
    width: 50px; /* 너비를 줄임 */
    height: 25px; /* 높이를 줄임 */
    font-size: 10px; /* 텍스트 크기 축소 */
    padding: 3px; /* 내부 여백 축소 */
}

button.btn.btn-secondary {
        width: 60px; /* 너비 조정 */
        height: 30px; /* 높이 조정 */
        font-size: 12px; /* 텍스트 크기 */
        padding: 5px; /* 내부 여백 */
}
</style>


<script type="text/javascript">

$(document).ready(function() {
    
    $("select[name='searchType']").val("${requestScope.searchSelect}");
    $("input:text[name='searchWord']").val("${requestScope.searchWord}");
    
    $("select[name='sizePerPage']").val("${requestScope.sizePerPage}");
    
    $("input:text[name='searchWord']").bind("keydown", function(e){
       
       if(e.keyCode == 13) {
          goSearch();
       }
    });
    
    // **** select 태그에 대한 이벤트는 click 이 아니라 change 이다. **** // 
    $("select[name='sizePerPage']").bind("change", function(){
       const frm = document.order_search_frm;
       // frm.action = "memberList.up"; // form 태그에 action 이 명기되지 않았으면 현재보이는 URL 경로로 submit 되어진다.
       // frm.method="get"; // form 태그에 method 를 명기하지 않으면 "get" 방식이다.
          frm.submit();
    });
</script>




<title>주문 회원 조회</title>

<header class="side-header">
    <nav class="header-nav">
        <ul>
			<li>
				<div>회원관리</div>
				<ul>
					<li><a href="<%= request.getContextPath() %>/admin/admin.cl">회원조회</a></li>
					<li><a href="<%= request.getContextPath() %>/admin/adminMemberStatus.cl">탈퇴회원조회</a></li>
				</ul>
			</li>
			<li>
				<div>상품관리</div>
                    <ul>
						<a href="<%= request.getContextPath() %>/admin/adminProduct.cl">상품조회</a>
						<li><a href="<%= request.getContextPath() %>/admin/adminProductInsertGo.cl">상품등록</li>
                    </ul>
			</li>
			<li>
				<div>주문관리</div>
				<ul>
					<li><a
						href="<%=request.getContextPath()%>/admin/adminOrder.cl">주문회원조회</a></li>
					<li><a
						href="<%=request.getContextPath()%>/admin/adminDelivery.cl">주문배송관리</a></li>
				</ul>
			</li>
		</ul>
    </nav>
</header>

<nav class="top-nav">
    <div class="nav-logo">
        <div>LOGO</div>
    </div>
    <div class="nav-btn">
        <a href="<%=request.getContextPath()%>/index.cl"><div class="home-btn">홈으로</div></a>
        <a href="<%=request.getContextPath()%>/login/logout.cl"><div class="end-btn">종료</div></a>
    </div>
</nav>

<section>
	<div style="display: flex; flex-wrap: wrap;">
		<div class="first-div">
			<div style="margin: 30px 0px 0px 30px;">
				<form name="order_search_frm">
					<select name="searchType">
						<!-- required 속성이 있으면, 사용자가 값을 선택하지 않을 경우 브라우저가 기본적으로 유효성 검사를 수행 -->
						<option value="">검색대상</option>
						<option value="m_name">회원이름</option>
						<option value="m_id">회원아이디</option>
					</select> <input type="text" name="searchWord" placeholder="검색어 입력" required />
					<button type="submit" class="btn btn-secondary"
						onclick="goSearch()">검색</button>
				</form>

				<script>
						function goSearch() {
					        const searchType = document.querySelector("select[name='searchType']").value;
					
					        if (searchType === "") {
					            alert("검색대상을 선택하세요 !!");
					            return; // goSearch() 함수를 종료
					        }

							const frm = document.order_search_frm;
							frm.action ="adminOrder.cl";
							frm.submit();
						}
					</script>
			</div>
		</div>
	</div>
	<%-- first --%>



	<!-- 주문 회원 테이블 -->
	<div class="second-div">
		<h4
			style="font-weight: bold; text-align: center; margin-top: 50px; padding: 2% 0;">주문회원조회</h4>
		<div class="table-container">
			<table style="width: 100% !important;" class="table">
				<thead class="thead-light">
					<tr>
						<th>번호</th>
						<th>주문번호</th>
						<th>주문날짜</th>
						<th>회원아이디</th>
						<th>회원명</th>
						<th>상품명</th>
						<th>용량</th>
						<th>제품수량</th>
						<th>주문금액</th>
						<th>배송현황</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty requestScope.orderList}">
						<c:forEach var="order" items="${requestScope.orderList}"
							varStatus="m_status">

							<c:set var="mobile" value="${order.membervo.m_mobile}" />
							<%-- member.m_mobile 만 선언해서 하이픈 넣을 수 있게함 --%>

							<tr class="orderInfo">

								<fmt:parseNumber var="currentShowPageNo"
									value="${requestScope.currentShowPageNo}" />
								<fmt:parseNumber var="sizePerPage"
									value="${requestScope.sizePerPage}" />
								<%-- fmt:parseNumber 은 문자열을 숫자형식으로 형변환 시키는 것이다. --%>

								<td>${(currentShowPageNo - 1) * sizePerPage + (m_status.index + 1)}</td>
								<td>${order.o_num}</td>
								<td>${order.o_date}</td>
								<td>${order.fk_m_id}</td>
								<td>${order.membervo.m_name}</td>
								<td>${order.productvo.p_name}</td>
								<td><c:choose>
										<c:when test="${order.optionvo.op_ml == 1}">50ml</c:when>
										<c:when test="${order.optionvo.op_ml == 2}">75ml</c:when>
										<c:when test="${order.optionvo.op_ml == 3}">100ml</c:when>
								</c:choose></td>
								<td>${order.orderdetailvo.od_count}</td>
								<td>
									<fmt:formatNumber value="${order.o_price}" pattern="#,###" />
								</td>
								<td><c:choose>
										<c:when test="${order.status == 0}">배송전</c:when>
										<c:when test="${order.status == 1}">배송중</c:when>
										<c:when test="${order.status == 2}">배송완료</c:when>
										<c:otherwise>배송취소</c:otherwise>
									</c:choose></td>

								<td><button style="width: 90px;" type="button"
										class="btn btn-primary" data-toggle="modal"
										data-target="#exampleModal_centered" 
										data-num="${order.o_num}"
<%-- 										data-date="${order.o_date}" --%>
										data-id="${order.fk_m_id}"
										data-name="${order.membervo.m_name}"
										data-email="${order.membervo.m_email}"
										data-pname="${order.productvo.p_name}"
										data-odcount="${order.orderdetailvo.od_count}"
										data-opml="${order.optionvo.op_ml}"
										data-mobile="${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}"
										data-date="${order.o_date}" 
										data-opnum="${order.orderdetailvo.fk_op_num}" 
										data-dnum="${order.fk_d_num}"
										<%-- data-dname="${delivery.d_name}" --%>
										data-price=<fmt:formatNumber value="${order.o_price}" pattern="#,###" />>
										상세보기</button></td>
							</tr>
						</c:forEach>
					</c:if>

					<c:if test="${empty requestScope.orderList}">
						<tr>
							<td colspan="12" style="text-align: center; font-weight: bold;">
								주문 회원 정보가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<%-- 페이징 네비게이션 --%>
			<div id="pageBar">
				<nav>
					<ul class="pagination">${requestScope.pageBar}</ul>
				</nav>
			</div>
		</div>
	</div>   <!-- 세컨 -->
</section>



<!-- Modal -->
<div class="modal fade" id="exampleModal_centered" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
        
       		<!-- Modal header -->
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">주문회원 상세보기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            
            <!-- Modal body -->
            <div class="modal-body">
                <p><strong>주문번호:</strong> <span id="modal-num"></span></p>
<!--                 <p><strong>주문날짜:</strong> <span id="modal-date"></span></p> -->
				<p><strong>회원아이디:</strong> <span id="modal-id"></span></p>
                <p><strong>회원명:</strong> <span id="modal-name"></span></p>
                <p><strong>이메일:</strong> <span id="modal-email"></span></p>
                <p><strong>전화번호:</strong> <span id="modal-mobile"></span></p>
                <p><strong>상품명:</strong> <span id="modal-pname"></span></p>
                <p><strong>상품용량:</strong> <span id="modal-opml"></span></p>
                <p><strong>제품수량:</strong> <span id="modal-odcount"></span></p>
                <p><strong>주문일자:</strong> <span id="modal-date"></span></p>
                <p><strong>주문금액:</strong> <span id="modal-price"></span></p> 
                <p><strong>옵션번호:</strong> <span id="modal-opnum"></span></p> 
                <p><strong>배송지번호:</strong> <span id="modal-dnum"></span></p> 
<!--                 <p><strong>받는사람이름:</strong> <span id="modal-dname"></span></p>  -->
            </div>
            
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>



<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
    const detailButtons = document.querySelectorAll('.btn[data-toggle="modal"]');

    detailButtons.forEach(button => {
        button.addEventListener("click", function () {
        	const num = this.getAttribute("data-num");
/*         	const date = this.getAttribute("data-date"); */
            const id = this.getAttribute("data-id");
            const name = this.getAttribute("data-name");
            const email = this.getAttribute("data-email");
            const pname = this.getAttribute("data-pname");
            let opml = this.getAttribute("data-opml");
            const odcount = this.getAttribute("data-odcount");
            const mobile = this.getAttribute("data-mobile");
            const date = this.getAttribute("data-date");
            const price = this.getAttribute("data-price");
            const opnum = this.getAttribute("data-opnum");
            const dnum = this.getAttribute("data-dnum");
//            const dname = this.getAttribute("data-dname");
            
            console.log(this.getAttribute("data-dname"));
            
         	// data-opml 값
            if (opml === "1") {
                opml = "50ml";
            } else if (opml === "2") {
                opml = "75ml";
            }  else {
                opml = "100ml"; 
            }

            
            
            // 모달에 데이터 삽입
            document.getElementById("modal-num").textContent = num;
/*             document.getElementById("modal-date").textContent = date; */
            document.getElementById("modal-id").textContent = id;
            document.getElementById("modal-name").textContent = name;
            document.getElementById("modal-email").textContent = email;
            document.getElementById("modal-pname").textContent = pname;
            document.getElementById("modal-opml").textContent = opml;
            document.getElementById("modal-odcount").textContent = odcount;
            document.getElementById("modal-mobile").textContent = mobile;
            document.getElementById("modal-date").textContent = date;
            document.getElementById("modal-price").textContent = price;
            document.getElementById("modal-opnum").textContent = opnum;
            document.getElementById("modal-dnum").textContent = dnum;
//            document.getElementById("modal-dname").textContent = dname;
            
        });
    });
});
</script>
