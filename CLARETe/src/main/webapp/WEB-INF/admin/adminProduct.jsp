<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>

<link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_section.css">
<link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_header.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script> 



<script type="text/javascript">
function search() {

	const frm = document.product_search_frm;
	// 검색어 입력값
    const searchType = frm.searchType.value;
    const searchWord = frm.searchWord.value;

    // 계절 검색일 경우 매핑
    if (searchType === 'p_season') {
        switch (searchWord.trim()) {
            case '봄': frm.searchWord.value = '1'; break;
            case '여름': frm.searchWord.value = '2'; break;
            case '가을': frm.searchWord.value = '3'; break;
            case '겨울': frm.searchWord.value = '4'; break;
            default:
                alert("봄, 여름, 가을, 겨울 중 하나를 입력해주세요.");
                return;
        }
    }
    
 	// 성별 검색일 경우 매핑
    if (searchType === 'p_gender') {
        switch (searchWord.trim()) {
            case '남': frm.searchWord.value = '1'; break;
            case '여': frm.searchWord.value = '2'; break;
            default:
                alert("남,여를 입력해주세요.");
                return;
        }
    }
			    frm.action ="adminProduct.cl";
			    frm.submit();
}
</script>


<title>상품 회원 조회</title>

<header class="side-header">
    <nav class="header-nav">
        <ul>
			<li>
				<div>회원관리</div>
				<ul>
					<li><a href="<%= request.getContextPath() %>/admin/admin.cl">회원조회</a></li>
					<li><a
						href="<%=request.getContextPath()%>/admin/adminOrder.cl">주문회원조회</a></li>
					<li>탈퇴회원조회</li>
				</ul>
			</li>
			<li>
				<div>상품관리</div>
				<ul>
					<a href="<%= request.getContextPath() %>/admin/adminProduct.cl">상품조회</a>
					<li>상품 카테고리 별 조회</li>
					<li>상품등록</li>
					<li>상품 재고 관리</li>
					<li>상품 삭제</li>
				</ul>
			</li>
			<li>
				<div>주문관리</div>
				<ul>
					<li>주문상세조회</li>
					<li>배송상태변경</li>
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
        <a href="#"><div class="home-btn">홈으로</div></a>
        <a href="#"><div class="end-btn">종료</div></a>
    </div>
</nav>

<section>
    <div style="display: flex; flex-wrap: wrap;">
        <div class="first-div">
            <div style="margin: 30px 0px 0px 30px;">
					<form name="product_search_frm">
						<select name="searchType">
							<option value="">검색대상</option>
							<option value="p_name">제품명</option>
							<option value="p_season">카테고리</option>
							<option value="p_gender">성별향수</option>
						</select> 
						<input type="text" name="searchWord" placeholder="검색어 입력" required />
						<button type="submit" class="btn btn-secondary" onclick="search()">검색</button>
					</form>
			</div>

        </div>
        
<!-- 상품 조회 테이블 -->
            <div class="second-div">
                <h4 style="font-weight: bold; text-align: center; margin-top: 50px; padding: 2% 0;">상품조회</h4>
				<div class="table-container" stlye=" overflow-x: scroll;">
					<table style="width: 100% !important;" class="table">
						<thead class="thead-light">
							<tr>  
								<th>상품번호</th>
								<th>카테고리(계절)</th>
								<th>제품명</th>
								<th>제품설명</th>
								<th>가격</th>
								<th>재고</th>
								<th>제품등록일</th>
								<th>발매일</th>
								<th>할인률</th>
								<th>성별향수</th>
								<th>상세보기</th>
<!-- 								<th>상품이미지</th>
								<th>상품상세이미지</th> -->
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty requestScope.productList}">
								<c:forEach var="product" items="${requestScope.productList}">
									<tr>
										<td>${product.p_num}</td>
										<td><c:choose>
												<c:when test="${product.p_season == '1'}">봄</c:when>
												<c:when test="${product.p_season == '2'}">여름</c:when>
												<c:when test="${product.p_season == '3'}">가을</c:when>
												<c:otherwise>겨울</c:otherwise>
											</c:choose></td>
										<td>${product.p_name}</td>
										<td>${product.p_ex}</td>
										<td>
									    	<fmt:formatNumber value="${product.p_price}" type="number" groupingUsed="true" />
										</td>
										<td>${product.p_inven}</td>
										<td>${product.p_register}</td>
										<td>${product.p_release}</td>
										<td>${product.p_sale}</td>
										<td><c:choose>
												<c:when test="${product.p_gender == '1'}">남</c:when>
												<c:otherwise>여</c:otherwise>
											</c:choose></td>
<%-- 										<td>${product.p_image}</td>
										<td>${product.p_detail_image}</td> --%>
										
<%-- 									<td>${order.membervo.m_name}</td>
										<td>${order.membervo.m_email}</td>
										<td>${order.membervo.m_mobile}</td> --%>
										<td><button style="width:90px;"
						                    type="button" 
						                    class="btn btn-primary" 
						                    data-toggle="modal" 
						                    data-target="#exampleModal_centered"
						                    >
						                    상세보기
						                </button>
										</td>
										
										
									</tr>
								</c:forEach>	
							</c:if>
							<c:if test="${empty requestScope.productList}">
								<tr>
									<td colspan="12" style="text-align: center; font-weight: bold;">
										상품 정보가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<nav aria-label="Page navigation example">
                    <ul class="pagination" style="justify-content: center;">
                        <li class="page-item"><a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                    </ul>
                </nav>
            </div> <!-- 세컨 -->
        
    </div>
</section>


<!-- Modal -->
<div class="modal fade" id="exampleModal_centered" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
        
       		<!-- Modal header -->
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">상품 상세보기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            
            <!-- Modal body -->
            <div class="modal-body">
                <p><strong>상품번호:</strong> 
                <p><strong>카테고리:</strong> 
                <p><strong>제품명:</strong> 
                <p><strong>제품설명:</strong> 
                <p><strong>가격:</strong> 
                <p><strong>재고:</strong> 
                <p><strong>재품등록일:</strong> 
                <p><strong>발매일:</strong> 
                <p><strong>할인률:</strong> 
                <p><strong>성별향수:</strong> 
            </div>
            
            <!-- Modal footer -->
            <div class="modal-footer">
            	<button type="button" class="btn btn-primary" data-dismiss="modal">수정</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
