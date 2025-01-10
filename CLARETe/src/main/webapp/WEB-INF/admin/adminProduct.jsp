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
div#pageBar {
      border: solid 0px red;
      width: 80%;
      margin: 3% auto 0 auto;
      display: flex;
   }
   
   div#pageBar > nav {
      margin: auto;
   }
   
   .aclass {
	color: gray;
	text-decoration: none;
	font-size: 13px;
	font-weight: bold;
}



.top-nav{
margin-bottom: 10px;
}

.nav-title {
	margin-bottom: 15px;
}

.blackbtn {  
	background-color: white;
	color:black;
	border: 2px solid gray;
}

.blackbtn:hover {
	background-color: white;
	color:black;
	border: 3px solid black;
	
}

.home {
	border: black 1px solid;
	color:black;
	text-decoration: none;
}

.first-div {
	border: 1px solid black;
}

.end {
	background-color: black;
}

.end:hover {
	background-color: gray;
}

.adeco {
	text-decoration: none;
}
	
.modalupdate {
	background-color: black;
	border: white 1px solid;
	color:white;
	text-decoration: none;
}

.modalupdate:hover {
	background-color: gray;
}


.modalclose {
	background-color: white;
	color:black;
	border: 1px solid black;
}

.modalclose:hover {
	border: 1px solid black;
}

.search {
	background-color: gray;
	border:black;
}

.search:hover {
	background-color: gray;
	border:black;
}


th {
    text-align: center; /* 텍스트를 가운데로 정렬 */
    vertical-align: middle; /* 수직 가운데 정렬 */
}

table td {
    text-align: center;
    vertical-align: middle;
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
<header class="side-header" style="padding-top: 30px;">
    <nav class="header-nav">
        <ul>
			<li>
				<div>회원관리</div>
				<ul>
					<li><a class="aclass" href="<%= request.getContextPath() %>/admin/admin.cl">회원조회</a></li>
					<li><a class="aclass" href="<%= request.getContextPath() %>/admin/adminMemberStatus.cl">탈퇴회원조회</a></li>
				</ul>
			</li>
			<li>
				<div class="nav-title">상품관리</div>
				<ul>
				
					<li><a class="aclass" href="<%= request.getContextPath() %>/admin/adminProduct.cl">상품조회</a></li>
					<li><a class="aclass" href="<%= request.getContextPath() %>/admin/adminProductInsertGo.cl">상품등록</li>
                 </ul>
             </li>
			<li style="margin-top:20px;">
                    <div style="color:black; font-weight: bold;" class="nav-title" >주문관리</div>
                    <ul>
                        <li><a class="aclass"
						href="<%=request.getContextPath()%>/admin/adminOrder.cl">주문회원조회</a></li>
                        <li><a class="aclass"
						href="<%=request.getContextPath()%>/admin/adminDelivery.cl">주문배송관리</a></li>
                    </ul>
            </li>
            
            <li>
                <div>문의관리</div>
                <ul>
                    <li><a class="aclass" href="<%=request.getContextPath()%>/faq/faq.cl">FAQ등록</a></li>
                    <li><a class="aclass" href="<%=request.getContextPath()%>/admin/adminBoard.cl">Q&A답변</a></li>
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
       <a class="adeco" href="<%=request.getContextPath()%>/index.cl"><div class="home-btn home">홈으로</div></a>
       <a class="adeco" href="<%=request.getContextPath()%>/login/logout.cl"><div class="end-btn end">종료</div></a>
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
					<button type="submit" class="btn btn-secondary search"
						onclick="goSearch()">검색</button>
				</form>

				<script>
						function goSearch() {
	
							const frm = document.product_search_frm;
							
							// 검색어 입력값
							const searchWord = frm.searchWord.value;
							
						    const searchType = document.querySelector("select[name='searchType']").value;
						    
						    if (searchType === "") {
					             alert("검색대상을 선택하세요 !!");
					             return; // goSearch() 함수를 종료
					        }
						   
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
			</div>
		</div>
	</div>

		<!-- 상품 조회 테이블 -->
		<div class="second-div">
			
			<h4
				style="font-weight: bold; text-align: center; margin-top: 50px; padding: 2% 0;">모든 상품 조회</h4>
				<div class="total-count" style="text-align: left; margin: 10px; font-weight: bold; font-size: 13pt;">
				    * 총 상품 수: ${totalProductCount}개
				</div>
				<span>
					<form name="allDeleteFrm">
						<input type="hidden" name="allPnumarr"/>
						<c:forEach var="product" items="${requestScope.productList}" varStatus="status">
							<input type="hidden" name="allPnum${product.p_num}" value="${product.p_num}"/>
						</c:forEach>
						<button style="width: 160px;" type="button" class=" w-160" id="checkDeleteGo">선택상품삭제</button>
					</form>
				</span>
			</div>
			<div class="table-container" stlye=" overflow-x: scroll;">
				<table style="width: 100% !important;" class="table table-hover table-bordered align-middle table-responsive" >
					<thead class="table-dark align-center">
						<tr>
					   		<th>일괄선택</th>
							<th>상품번호</th>
							<th>상품이미지</th>
							<th>계절</th>
							<th>제품명</th>
							<th>제품설명</th>
							<th>가격</th>
							<th>재고</th>
							<th>제품등록일</th>
							<th>할인률</th>
							<th>성별</th>
							<th style="text-align:center;" >수정</th>
							<th style="text-align:center;" class="delete-btn delete">삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty requestScope.productList}">
							<c:forEach var="product" items="${requestScope.productList}" varStatus="status">

								<tr class="productInfo">

									<fmt:parseNumber var="currentShowPageNo"
										value="${requestScope.currentShowPageNo}" />
									<fmt:parseNumber var="sizePerPage"
										value="${requestScope.sizePerPage}" />

	                           		<td>
	                           			<input type="checkbox" name="checkbox${product.p_num}"/>
	                           			<input type="hidden" name="allPnum${product.p_num}" value="${product.p_num}"/>
	                           			
	                           		</td>
									<td>${product.p_num}</td>
									<td>
										<span><img src="/CLARETe/images/${product.p_image}" style="width: 100" /></span>
									</td>
									<td><c:choose>
											<c:when test="${product.p_season == '1'}">봄</c:when>
											<c:when test="${product.p_season == '2'}">여름</c:when>
											<c:when test="${product.p_season == '3'}">가을</c:when>
											<c:otherwise>겨울</c:otherwise>
										</c:choose></td>
									<td>${product.p_name}</td>
									<td class="center">
										<span style="vertical-align:middle !important; box-sizing:border-box; overflow: hidden; white-space: normal; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; word-break: keep-all;">${product.p_ex}</span>
									</td>
									<td><fmt:formatNumber value="${product.p_price}"
											type="number" groupingUsed="true" /></td>
									<td>${product.p_inven}</td>
									<td>${product.p_register}</td>
									
									<td>${product.p_sale}</td>
									<td><c:choose>
											<c:when test="${product.p_gender == '0'}">공용</c:when>
											<c:when test="${product.p_gender == '1'}">남</c:when>
											<c:otherwise>여</c:otherwise>
										</c:choose></td>

									<td>
										<button style="width: 60px;" type="button"
												class="update w-160" data-toggle="modal"
												data-target="#exampleModal_centered"
												id="updateGo">
												수정
										</button>
										<input type="hidden" name="updatePnum" value="${product.p_num}"/>
										<input type="hidden" name="listSize" value="${requestScope.listSize}"/>
									</td>
									<td>
										<form name="deleteFrm">
											<input type="hidden" name="deletePnum" value="${product.p_num}"/>
											<button style="width: 60px;" type="button"
													class=" w-160" id="deleteGo">
													삭제
											</button> <!-- ${product.p_num} -->
										</form>
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
				
				<%-- 페이징 네비게이션 --%>
				<div id="pageBar">
					<nav>
						<ul class="pagination">${requestScope.pageBar}</ul>
					</nav>
				</div>
			</div>
			
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
	                <input id="btnRegister" type="button" class="btn btn-primary modalupdate" value="수정" />
	                <button id="btnclose" type="button" class="btn btn-dange modalclose" data-dismiss="modal">닫기</button>
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
// 진짜 ㄹㅇ로 수정하러 가보자 렛츠기릿.
$("input:button[id='btnRegister']").click(function(){
	const input_cnt = $('input:text');
	// alert('dasadsadsad')
			
	if($('input:text[name="p_name"]').val().trim() == ''){
		$('.p_name_error').show();
		alert('필수항목을 확인해주세요.')
		e.preventDefault(); // 이거 return false랑 같은 역할임
	}
	else if($('textarea[name="p_ex"]').val().trim() == ''){
		$('.p_ex_error').show();
		alert('필수항목을 확인해주세요.')
		e.preventDefault();
	}
	else if($('input:text[name="p_price"]').val().trim() == ''){
		$('.p_price_error').show();
		alert('필수항목을 확인해주세요.')
		e.preventDefault();
	}
	else if($('input:text[name="p_inven"]').val().trim() == ''){
		$('.p_inven_error').show();
		alert('필수항목을 확인해주세요.')
		e.preventDefault();
	}
	else{
		
		var formData = new FormData($("form[name='myFrm']").get(0));
		
		
		//////////////////////////////////////////////
        // 첨부한 파일의 총량이 20MB 초과시 //
        if(total_fileSize > 20*1024*1024) {
    	    alert("ㅋㅋㅋ 첨부한 파일의 총합의 크기가 20MB를 넘어서 제품등록을 할 수 없습니다.!!");
	        return; // 종료
        }
	    //////////////////////////////////////////////
	   
	    
	    
        $.ajax({
     	<%-- url : "<%= ctxPath%>/shop/admin/productRegister.up", --%>
             url : "${pageContext.request.contextPath}/admin/adminProductUpdateGo.cl",
             type : "post",
             data : formData,
             processData:false,  // 파일 전송시 설정 
             contentType:false,  // 파일 전송시 설정
             dataType:"json",
             success:function(json){
         	   	  console.log("~~~ 확인용 : " + JSON.stringify(json));
                 // ~~~ 확인용 : {"result":1}
                 
         	   	  if(json.result == 1) {
         	         alert('상품수정이 완료되었습니다.');
         	   		 location.href="${pageContext.request.contextPath}/admin/adminProduct.cl"; 
                 }
                 
             },
             error: function(request, status, error){
				    // alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				       alert("첨부된 파일의 크기의 총합이 20MB 를 초과하여 제품등록이 실패했습니다.ㅜㅜ");
		     }
             
      });
	   
	}
}); // end of $("input:button[id='btnRegister']").click(function()-----------




let total_fileSize = 0; // 첨부한 파일의 총량을 누적하는 용도
   
   
// ==>> 제품이미지 파일선택을 선택하면 화면에 이미지를 미리 보여주기 시작 <<== //
$(document).on("change", "input.img_file", function(e){
	
	const input_file = $(e.target).get(0);
	// jQuery선택자.get(0) 은 jQuery 선택자인 jQuery Object 를 DOM(Document Object Model) element 로 바꿔주는 것이다. 

	const fileReader = new FileReader();
	   
	fileReader.readAsDataURL(input_file.files[0]); 
	// FileReader.readAsDataURL() --> 파일을 읽고, result속성에 파일을 나타내는 URL을 저장 시켜준다.
	   
	fileReader.onload = function(){  // FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임.
	      
		document.getElementById("previewImg").src = fileReader.result; 
	
    }; 
	   
	////////////////////////////////////////////////
    // 첨부한 파일의 총량을 누적하는 용도
    total_fileSize += input_file.files[0].size;
	////////////////////////////////////////////////
}); 



$(document).on("change", "input.img_file2", function(e){
	
	const input_file = $(e.target).get(0);
	// jQuery선택자.get(0) 은 jQuery 선택자인 jQuery Object 를 DOM(Document Object Model) element 로 바꿔주는 것이다. 

	const fileReader = new FileReader();
	   
	fileReader.readAsDataURL(input_file.files[0]); 
	// FileReader.readAsDataURL() --> 파일을 읽고, result속성에 파일을 나타내는 URL을 저장 시켜준다.
	   
	fileReader.onload = function(){  // FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임.
	      
		document.getElementById("previewImg2").src = fileReader.result; 
	
    }; 
	   
	////////////////////////////////////////////////
    // 첨부한 파일의 총량을 누적하는 용도
    total_fileSize += input_file.files[0].size;
	////////////////////////////////////////////////
}); 
// ==>> 제품이미지 파일선택을 선택하면 화면에 이미지를 미리 보여주기 끝 <<== //




// 취소하기
$("input[type='reset']").click(function(){
	   $("span.error").hide();
	   $('.text-danger').hide();

	   //$("img#previewImg").hide();
	   //$("img#previewImg2").hide();
});





</script>

</body>
