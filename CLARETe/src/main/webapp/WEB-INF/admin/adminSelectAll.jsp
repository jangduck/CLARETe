<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
function goSearch() {

	const frm = document.member_search_frm;
			    frm.action ="admin.cl";
			    frm.submit();
}
</script>

    <title>관리자 회원관리</title>
        <!-- 부트스트랩 CSS 파일 경로 -->




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
                <form name="member_search_frm">
                    <select name="searchType" >  <!-- required 속성이 있으면, 사용자가 값을 선택하지 않을 경우 브라우저가 기본적으로 유효성 검사를 수행 -->
                        <option value="">검색대상</option>
                        <option value="m_name">회원이름</option>
                        <option value="m_id">회원아이디</option>
                        <option value="m_email">이메일</option>
                    </select>
                    <input type="text" name="searchWord" placeholder="검색어 입력" required />
                    <button type="submit" class="btn btn-secondary" onclick="search()">검색</button>
                </form>
                
                
            </div>
        </div>

	<div class="second-div">
		<h4
			style="font-weight: bold; text-align: center; margin-top: 50px; padding: 2% 0;">모든회원조회</h4>

		<div class="table-container" style="overflow-x: auto">
			<table style="width: 100% !important;"
				class="table table-bordered text-center table-responsive">
				<thead class="thead-light">

					<tr>
					</tr>
					<tr>
						<th>회원이름</th>
						<th>회원아이디</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>주소</th>
						<th>성별</th>
						<th>생년월일</th>
						<th>포인트</th>
						<th>가입일자</th>
						<th>상세보기</th>
					</tr>
				</thead>
				
				<tbody id="selectAll">
					<c:if test="${not empty requestScope.memberList}">
					
						<c:forEach var="member" items="${requestScope.memberList}"
							varStatus="m_status">
							
							<c:set var="mobile" value="${member.m_mobile}" />  <%-- member.m_mobile 만 선언해서 하이픈 넣을 수 있게함 --%>
							
							<tr>
								<th>${member.m_name}</th>
								<th>${member.m_id}</th>
								<td>${member.m_email}</td>
								<td>${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</td>
								<td>${member.m_address}</td>
								<td><c:choose>
										<c:when test="${member.m_gender == '1'}">남</c:when>
										<c:otherwise>여</c:otherwise>
									</c:choose></td>
								<td>${member.m_birth}</td>
								<td>${member.m_point}</td>
								<td>${member.m_register}</td>
								<td><button style="width:90px;
				                    type="button" 
				                    class="btn btn-primary" 
				                    data-toggle="modal" 
				                    data-target="#exampleModal_centered"
				                    data-name="${member.m_name}"
				                    data-id="${member.m_id}"
				                    data-email="${member.m_email}"
				                    data-mobile="${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}"
				                    data-postcode="${member.m_postcode}"
				                    data-address="${member.m_address}"
				                    data-detail_address="${m.detail_address}"
				                    data-gender="<c:choose>
						                            <c:when test='${member.m_gender == "1"}'>남자</c:when>
						                            <c:otherwise>여자</c:otherwise>
					                         	</c:choose>"
									data-birth="${member.m_birth}"
				                    data-point="${member.m_point}"
				                    data-register="${member.m_register}"
				                    data-lastpwd="${member.m_lastpwd}"
				                    data-status="${member.m_status}"
				                    data-idle="${member.m_idle}">
				                    상세보기
				                </button>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>

			<%-- 페이징 네비게이션 --%>
    <nav aria-label="Page navigation">
    <ul class="pagination justify-content-center">
        <c:if test="${currentPage > 1}">
            <li class="page-item">
                <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
        </c:if>
        <c:forEach begin="1" end="${totalPages}" var="page">
            <li class="page-item ${page == currentPage ? 'active' : ''}">
                <a class="page-link" href="?page=${page}">${page}</a>
            </li>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <li class="page-item">
                <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </c:if>
    </ul>
</nav>

		</div>

 

	</div>
	<%-- 세컨 --%>

</section>




<!-- Modal -->
<div class="modal fade" id="exampleModal_centered" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
        
       		<!-- Modal header -->
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">회원 상세보기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            
            <!-- Modal body -->
            <div class="modal-body">
                <p><strong>이름:</strong> <span id="modal-name"></span></p>
                <p><strong>아이디:</strong> <span id="modal-id"></span></p>
                <p><strong>이메일:</strong> <span id="modal-email"></span></p>
                <p><strong>전화번호:</strong> <span id="modal-mobile"></span></p>
                <p><strong>우편번호:</strong> <span id="modal-postcode"></span></p>
                <p><strong>주소:</strong> <span id="modal-address"></span></p>
                <p><strong>상세주소:</strong> <span id="modal-detail_address"></span></p>
                <p><strong>참고항목:</strong> <span id="modal-extra"></span></p>
                <p><strong>성별:</strong> <span id="modal-gender"></span></p>
                <p><strong>생년월일:</strong> <span id="modal-birth"></span></p>
                <p><strong>포인트:</strong> <span id="modal-point"></span></p>
                <p><strong>가입일자:</strong> <span id="modal-register"></span></p>
                <p><strong>마지막비밀번호변경:</strong> <span id="modal-lastpwd"></span></p>
                <p><strong>회원탈퇴유무:</strong> <span id="modal-status"></span></p>
            	<p><strong>휴면유무:</strong> <span id="modal-idle"></span></p>
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
            const name = this.getAttribute("data-name");
            const id = this.getAttribute("data-id");
            const email = this.getAttribute("data-email");
            const mobile = this.getAttribute("data-mobile");
            const postcode = this.getAttribute("data-postcode");
            const address = this.getAttribute("data-address");
            const detail_address = this.getAttribute("data-detail_address");
            const extra = this.getAttribute("data-extra");
            const gender = this.getAttribute("data-gender");
            const birth = this.getAttribute("data-birth");
            const point = this.getAttribute("data-point");
            const register = this.getAttribute("data-register");
            const lastpwd = this.getAttribute("data-lastpwd");
            const status = this.getAttribute("data-status");
            const idle = this.getAttribute("data-idle");
            
            
            // 모달에 데이터 삽입
            document.getElementById("modal-name").textContent = name;
            document.getElementById("modal-id").textContent = id;
            document.getElementById("modal-email").textContent = email;
            document.getElementById("modal-mobile").textContent = mobile;
            document.getElementById("modal-postcode").textContent = postcode;
            document.getElementById("modal-address").textContent = address;
            document.getElementById("modal-detail_address").textContent = detail_address;
            document.getElementById("modal-extra").textContent = extra;
            document.getElementById("modal-gender").textContent = gender;
            document.getElementById("modal-birth").textContent = birth;
            document.getElementById("modal-point").textContent = point;
            document.getElementById("modal-register").textContent = register;
            document.getElementById("modal-lastpwd").textContent = lastpwd;
            document.getElementById("modal-status").textContent = status;
            document.getElementById("modal-idle").textContent = idle;
            
        });
    });
});
</script>





<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>



   
    
    