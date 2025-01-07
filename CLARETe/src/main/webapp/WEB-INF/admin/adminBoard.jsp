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

<!-- Bootstrap Select CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/css/bootstrap-select.min.css">
	
<script type="text/javascript" src="<%= ctxPath%>/js/admin/productUpdateDeleteGo.js" ></script> 


<style type="text/css">
:root{
    font-family: "Noto Sans KR", sans-serif;
    font-optical-sizing: auto;
    /* cursor: none; */
    --size2  : clamp(2px, 0.1042vw, 200px);
    --size8  : clamp(6px, 0.4167vw, 200px);
    --size12 : clamp(10px, 0.6250vw, 200px);
    --size14 : clamp(12px, 0.7292vw, 200px);
    --size15 : clamp(14px, 0.7813vw, 200px);
    --size16 : clamp(16px, 0.8333vw, 200px);
    --size18 : clamp(17px, 0.9375vw, 200px);
    --size20 : clamp(18px, 1.0417vw, 200px);
    --size22 : clamp(22px, 1.1458vw, 200px);
    --size24 : clamp(24px, 1.2500vw, 200px);
    --size30 : clamp(28px, 1.5625vw, 200px);
    --size32 : clamp(30px, 1.6667vw, 200px);
    --size40 : clamp(40px, 2.0833vw, 200px);
    --size52 : clamp(48px, 2.7083vw, 200px);
    --size60 : clamp(50px, 3.1250vw, 200px);
    --size65 : clamp(60px, 3.3854vw, 200px);

    --size70  : clamp(50px, 3.6458vw, 2000px);

    --size80  : clamp(50px, 4.1667vw, 2000px);

    --size98  : clamp(60px, 5.1042vw, 2000px);
    --size100 : clamp(60px, 5.2083vw, 2000px);
    --size120 : clamp(80px, 6.2500vw, 2000px);
    --size180 : clamp(100px, 9.3750vw, 2000px);
    --size200 : clamp(100px, 10.4167vw, 1000px);
    --size220 : clamp(100px, 11.4583vw, 1000px);
    --size240 : clamp(100px, 12.5000vw, 2000px);
    --size300 : clamp(280px, 15.6250vw, 2000px);
    --size400 : clamp(320px, 20.8333vw, 2000px);
    --size670 : clamp(650px, 34.8958vw, 2000px);
    --size700 : clamp(680px, 36.4583vw, 3000px);
    --size930 : clamp(900px, 48.4375vw, 10000px);
}

div#pageBar {
      border: solid 0px red;
      width: 80%;
      margin: 3% auto 0 auto;
      display: flex;
   }
   
   div#pageBar > nav {
      margin: auto;
   }
   
.infoBox{
	display: none;
	position: relative;
}

.info {
	cursor: pointer;
}

.infoback{
	display: inline-block;
	position:fixed;
	top:50%;
	left:50%;
	transform: translate(-57%, -50%);
	width: 100vw;
	height: 100vh;
	background-color: #000;
	opacity: 0.2;
	z-index: 20;
}

.infocon{
	display: inline-block;
	position:fixed;
	top:50%;
	left:50%;
	transform: translate(-50%, -50%);
	width: 70%;
	height: auto;
	background-color: #fff;
	border-radius: var(--size14);
	z-index: 30;
	box-sizing: border-box;
	padding: var(--size20);
	overflow: scroll;
}

.infocon table tr td:first-child{
	width: 30%;
	height: var(--size60);
	font-size: var(--size16);
}

.infocon table tr td:last-child{
	width: 60%;
	height: var(--size60);
	font-size: var(--size16);
}

div.infocon > table:nth-child(2) {
	box-sizing:border-box;
	margin-bottom: var(--size40);
}

.closeB{
	font-size: var(--size16);
	width: var(--size80);
	height: var(--size40);
	border-radius: var(--size8);
	background-color: #000;
	color: #fff;
	text-align: center;
	line-height: var(--size40);
	margin: var(--size40) auto 0px auto;
	cursor: pointer;
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
       const frm = document.member_search_frm;
       // frm.action = "memberList.up"; // form 태그에 action 이 명기되지 않았으면 현재보이는 URL 경로로 submit 되어진다.
       // frm.method="get"; // form 태그에 method 를 명기하지 않으면 "get" 방식이다.
          frm.submit();
    });

</script>


<title>상품 회원 조회</title>
<body class="allbody" style="background-color: #F1F5F9 !important; width: 100% !important;">
<header class="side-header">
    <nav class="header-nav">
        <ul>
			<li>
				<div>회원관리</div>
				<ul>
					<li><a href="<%= request.getContextPath() %>/admin/admin.cl">회원조회</a></li>
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
					</select> <input type="text" name="searchWord" placeholder="검색어 입력" required />
					<button type="submit" class="btn2 btn-secondary2"
						onclick="goSearch()">검색</button>
				</form>

				
			</div>
		</div>
	</div>

		<!-- 상품 조회 테이블 -->
		<div class="second-div">
			
			<table class="table table-hover table-bordered align-middle table-responsive">
				<thead>
					<tr>
						<th>문의번호</th>
						<th>문의제목</th>
						<th>문의날짜</th>
						<th>문의유형</th>
						<th>답변상태</th>
						<th>상세보기/답변</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="qvo" items="${requestScope.qnaList}" varStatus="status">
					<tr>
						<td>${qvo.q_num}</td>
						<td>${qvo.q_title}</td>
						<td>${qvo.q_register}</td>
						
						<c:choose>
						    <c:when test="${qvo.q_category == 1}"><td class="category">결제/교환/환불</td></c:when>
						    <c:when test="${qvo.q_category == 2}"><td class="category">상품문의</td></c:when>
						    <c:when test="${qvo.q_category == 3}"><td class="category">매장문의</td></c:when>
						    <c:when test="${qvo.q_category == 4}"><td class="category">배송문의</td></c:when>      
						</c:choose> 
						
						<c:choose>
						    <c:when test="${qvo.q_answer eq null}"><td style="color:red;">답변대기</td></c:when>
						    <c:otherwise><td style="color:blue;">답변완료</td></c:otherwise>
						</c:choose>
						
						<td>
							<span class="info">상세보기</span>
							<div class="infoBox">
                           	<div class="infoback"></div>
                           	<div class="infocon">
                           	
                           		<div>질문</div>
                           		<table class="table table-hover table-bordered align-middle table-responsive">
                           			<tr>
                           				<th>질문자</th><td>${qvo.fk_m_id}</td>
                           			</tr>
                           			<tr>
                           				<th>등록일자</th><td>${qvo.q_register}</td>
                           			</tr>
                           			<tr>
                           				<th>문의제목</th><td>${qvo.q_title}</td>
                           			</tr>
                           			<tr>
                           				<th>문의내용</th><td>${qvo.q_ask}</td>
                           			</tr>
                           		</table>
                           		
                           		<div>답변달기</div>
				   				<form name="faqFrm">        
		               <table class="table table-hover table-bordered align-middle table-responsive" style="padding-top:50px" align=center border=0 cellpadding=2>
		   
	                        <tr>
	                       	<td>문의유형</td>
	                       	<td>
	                           <select>
	                           	<option id="1">결제/교환/환불</option>
	                           	<option id="2">상품문의</option>
	                           	<option id="3">매장문의</option>
	                           	<option id="4">배송문의</option>
	                           	<!-- <option id="5">기타</option> -->
	                           </select>
	                          </td>
	                        </tr>
	                        
	
	                            <tr>
	                                <td>문의 제목</td>
	                                <td><input type="text" name="q_title" id="q_title" placeholder="질문을 입력하세요" maxlength=20 ${qvo.q_ask} /></td>
	                            </tr>
	                            <tr>
	                                <td>문의 내용</td>
	                                <td><textarea name="q_ask" id="q_ask" placeholder="내용을 입력하세요">${qvo.q_ask}</textarea></td>
	                            	
	                            </tr>
	                              
	                            <tr>
	                             	<td> 답변 수신 여부 (선택)	</td>	                                   
		                            <td>  
			                           <ul>
				                           <li>     			                           				                         		
				                         		<input id="SMS" class="form-check-input" type="checkbox" value=""/>
				                         		<label for="SMS">SMS</label>
				                         		<input type="text" name="hp1" id="hp1" size="6 maxlength="3" value="010" readonly/>	&nbsp;-&nbsp;
				                         		<input type="text" name="hp2" id="hp2" size="6 maxlength="4" />	&nbsp;-&nbsp;
				                         		<input type="text" name="hp3" id="hp3" size="6 maxlength="4" />	
				                         					                       
				                           </li>
				                           
				                           <li>       			                           			                         		
				                         		<input id="E-mail" class="form-check-input" type="checkbox" value=""/>
				                         		<label for="E-mail">E-mail</label>
				                         		<input type="text" name="email" id="email1" size="6 maxlength="4"/>
				                         		&nbsp;@&nbsp;
				                         		<input type="text" name="email" id="email2" />
				                         		 <select>
				                         		    <option>직접입력</option>	
					                            	<option name="email2" value="gmail">gmail.com</option>
					                            	<option name="email2" value="naver">naver.com</option>
					                            	<option name="email2" value="daum">daum.net</option>					                            						                            	
					                            </select>
				                            </li>
		                                </ul>
		                             </td>                           	                                   
	                             </tr>
	                              
							       
		                </table>         
	        		</form>
                           		
                           		<div class="closeB">닫기</div>
							</div>
                           	</div>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			
			
		</div>
		<!-- 세컨 -->
</section>


<!-- Modal -->
<div class="modal fade" id="exampleModal_centered" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 1000px; width: 100%;">
        <div class="modal-content">
        
            <!-- Modal header -->
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">상품 수정하기</h5>
                    <span style="cursor: pointer;" class="close" data-dismiss="modal" aria-label="Close" aria-hidden="true">&times;</span>
            </div>
            
            <!-- Modal body -->
            <div class="modal-body">
            <form name="myFrm" enctype="multipart/form-data">
                <table class="table table-bordered align-middle table-responsive">
                	<tr>
                		<th class="w-5">상품번호</th>
                		<td>
                			<span id="pnum"></span>
                			<input type="hidden" id="pnum" name="p_num"/>
                		</td>
                	</tr>
                	<tr>
                		<th class="w-5">카테고리</th>
                		<td>
                		<select id="season" name="p_season" class="selectpicker show-tick ">

						</select>
                		</td>
                	</tr>
                	<tr>
                		<th class="w-5">상품명</th><td>
                			<input id="name" class="form-control w-50 p-3" type="text" name="p_name" placeholder="상품명" />
                			<div class="text-danger p_name_error">상품명은 필수 입력사항입니다.</div>
                		</td>
                	</tr>
                	<tr>
                		<th class="w-5">가격(원)</th><td>
                			<input id="price" class="form-control w-50 p-3" type="text" name="p_price" placeholder="가격" />
                			<div class="text-danger p_price_error">가격은 숫자만 입력 가능하며, 필수 입력사항입니다.</div>	
                		</td>
                	</tr>
                	<tr>
                		<th class="w-5">재고</th><td>
                			<input id="inven" class="form-control w-50 p-3" type="text" name="p_inven" placeholder="재고" />
                			<div class="text-danger p_inven_error">재고는 숫자만 입력 가능하며, 필수 입력사항입니다.</div>
                		</td>
                	</tr>
                	<tr>
                		<th class="w-5">설명</th>
                		<td>
                			<textarea id="ex" class="form-control" type="text" name="p_ex" placeholder="제품설명" rows="5"/></textarea>
                			<div class="text-danger p_ex_error">제품설명은 필수 입력사항입니다.</div>	
                		</td>
                	</tr>
                	<tr>
                		<th class="w-5">재품등록일</th><td id="register"></td>
                	</tr>
                	<tr>
                		<th class="w-5">발매일</th><td id="release"></td>
                	</tr>
                	<tr>
                		<th class="w-5">할인률(%)</th>
                		<td>
                			<input id="sale" class="form-control w-50 p-3" type="text" name="p_sale" placeholder="할인률" />
                		</td>
                	</tr>
                	<tr>
                		<th class="w-5">성별향수</th>
                		<td>
                			<select id="gender" name="p_gender" class="selectpicker show-tick">

							</select>
                		</td>
                	</tr>
                	<tr>
                		<th class="w-5">이미지</th>
                		<td>
                			<img id="previewImg" style='width: 300px' />
                			<input class="w-50 p-3 infoData img_file" type="file" name="p_image" placeholder="상품이미지" />
                			<input type="hidden" name="or_p_image" placeholder="상품이미지" />
                		</td>
                	</tr>
                	<tr>
                		<th class="w-5">상세이미지</th>
                		<td>
                			<img id="previewImg2" style='width: 300px' />
                			<input class="w-50 p-3 infoData img_file2" type="file" name="p_detail_image" placeholder="상품상세이미지" />
                			<input type="hidden" name="or_p_detail_image" placeholder="상품이미지" />
                		</td>
                	</tr>
                	
                </table>
                <div style="display: flex; justify-content: center; gap: 1%;">
	                <input id="btnRegister" type="button" class="btn btn-primary" value="수정" />
	                <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </form>
            
            </div>
            
            <!-- Modal footer -->
            <div class="modal-footer">
                
            </div>
        </div>
    </div>
</div>


<!-- Bootstrap Select JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/js/bootstrap-select.min.js"></script>
<script>

	$('.info').click(function(e){
		$(this).next().toggle()
	})
	
	$('.closeB').click(function(){
		$(this).parent().parent().toggle()
	})

</script> 

</body>
