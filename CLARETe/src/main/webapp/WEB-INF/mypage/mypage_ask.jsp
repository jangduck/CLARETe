<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
 String ctxPath = request.getContextPath();
%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>금쪽이</title>


	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/mapage.css">
	<link rel="stylesheet" href="<%= ctxPath %>/css/mypage/media_nav.css">   
	 <link rel="stylesheet" href="<%= ctxPath %>/css/mypage/myPageAsk.css">
	
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


	<script type="text/javascript" src="<%= ctxPath %>/js/qna/myPageQna.js"></script>

	<%-- =============================================== --%>

<script type="text/javascript">

$(document).ready(function(){
	
	$("select[name='sizePerPage']").bind("change", function(){
	    const frm = document.qna_sizePerPage_frm;
	    // frm.action = "memberList.up"; // form 태그에 action 이 명기되지 않았으면 현재보이는 URL 경로로 submit 되어진다.
	    // frm.method="get"; // form 태그에 method 를 명기하지 않으면 "get" 방식이다.
	       frm.submit();
	 });





});

/* 
modal.addEventListener("click", e => {
    const evTarget = e.target
    if(evTarget.classList.contains("modal")) {
        modal.style.display = "none"
}
 */


function closeModal() {
    var modal = document.getElementById("myModal");
    modal.style.display = "none";
}

// 자식 창에서 메시지를 받을 이벤트 리스너 추가
window.addEventListener("message", function(event) {
    if (event.data === "closeModal") {
        closeModal();
    }
});




	



</script>


   <div class="table-div">
       <div class="tbl-title">
           <span class="qna-title">문의하기</span>
           <button class="qna-write">문의작성하기></button>
       </div>
       <table class="tbl-ask" >
       <thead>            
           <tr>
               <th class="tbl-ask-header">번호</th>
               <th class="tbl-ask-header">문의제목</th>
               <th class="tbl-ask-header">문의유형</th>
               <th class="tbl-ask-header">등록일자</th>
               <th class="tbl-ask-header">삭제</th>
           </tr>
           
       </thead>
       <tbody>
       <c:if test="${not empty requestScope.qnaList}">
       <c:forEach var="qnaList" items="${requestScope.qnaList}" varStatus="status">
      		 <tr>
               <fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
               <fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" /> 
               <%-- fmt:parseNumber 은 문자열을 숫자형식으로 형변환 시키는 것이다. --%>
     		   <td>${(requestScope.totalMemberCount) - (currentShowPageNo - 1) * sizePerPage - (status.index)}</td>
               <td class="tbl-ask-data">${qnaList.q_title}</td>

               <td class="tbl-ask-data">
					<c:choose>
						<c:when test="${qnaList.q_category==1}">결제/교환/환불</c:when>
						<c:when test="${qnaList.q_category==2}">상품문의</c:when>
						<c:when test="${qnaList.q_category==3}">매장문의</c:when>
						<c:when test="${qnaList.q_category==4}">배송문의</c:when>
					</c:choose>
				</td>
                     <td class="tbl-ask-data">${qnaList.q_register}</td> 
                     <td class="tbl-ask-data">
                     
	                     <input style="border:none; background-color: #000; color:#fff; cursor: pointer;" class="deleteOneGo" type="button" value="삭제" />
	                     <input type="hidden" value="${qnaList.q_num}" />
                     
                     </td>
                 </tr>
                 
		</c:forEach>
		</c:if>
		<c:if test="${empty requestScope.qnaList}">
			<tr><td colspan="4" style="height: 80px;">문의사항이 없습니다.</td></tr>
		</c:if>
                  </tbody>
              </table>
      		<div style="display: flex; justify-content: center">
				<ul class="pagination" style="display: flex; gap:8px; margin-top: 40px;">${requestScope.pageBar}</ul>
			</div>                      
                  
</div>


 <!-- --------------------- 문의하기 작성시 나오는 창 만들기 -------------------------- -->

         <div class="ask-write-div">
        
            <div class="ask-div">
                <form class="ask-frm" action="/CLARETe/qna/qna.cl" method="post">
                	<input type="hidden" name="fk_m_id" value="${requestScope.m_id}"/>
                    <div class="ask-write-main-title"><br>
                        <h4 class="wirte-font">1:1 문의 등록</h4> <span class="note"><span class="asterisk">*</span>은 필수입력</span>
                    </div>
                    <hr>
                    <div class="ask-write-contents">
                     <ul>
                     	<li>
                     		<span class="ask-write-title">문의제목<span class="asterisk">*</span></span><br>
                     		<input type="text" name="q_title" id="ask-title" class="input-ask-insert" style="width: 50%;" maxlength="20" placeholder="문의제목을 입력해주세요">
                     		<span class="errorMsg">*제목을 입력해주세요!</span>
                     	</li>
                     	<li>
                     		<span class="ask-write-title">문의유형<span class="asterisk">*</span></span><br>
                     		<select class="ask-select" name="q_category" id="ask-category-select">
                     		 <option value="" disabled selected> 문의 유형을 선택해주세요</option>
                     			<option value="1">결제/교환/환불</option>
                     			<option value="2">상품문의</option>
                     			<option value="3">매장문의</option>
                     			<option value="4">배송문의</option>
                     		</select>
                     		<span class="errorMsg">*유형을 선택해주세요!</span>
                     	</li>
                     	<li>
                     		<span class="ask-write-title">문의내용<span class="asterisk">*</span></span><br>
                     		<textarea name="q_ask" id="ask-detail" class="input-ask-insert" placeholder="문의내용을 입력해주세요"></textarea>
                     		<span class="errorMsg">*문의내용을 입력해주세요!</span>
                     	</li>
                     	
                     </ul>
                    <hr>
                    </div>
                    <div class="ask-button">
                        <input type="submit" id="btnSubmit" class="ask-submit" name="asksubmit" value="문의등록"> <!-- 누르면 전송 -->
                        <input type="reset" class="ask-cancel" name=askcancel" value="등록취소">  <!-- 누르면 넣은 값 없애도 창 닫기-->
                    </div>
                    
                    
                </form>
             </div> 
        </div>
                     

	<%-- =============================================== --%>
	
	
<script>
$(document).ready(function(){
	
	$("div.ask-write-div").hide();
	$("button.qna-write").click(()=>{//문의작성하기를 눌렀을 때
		$("div.ask-write-div").show();
	});
	
	$("input.ask-cancel").click(()=>{//문의등록을 취소했을 때
		$("div.ask-write-div").hide();
			$("span.errorMsg").hide();
	});
	
	$("td.tbl-ask-data").click(()=>{//문의 하기에 내용을 클릭하면 내가 쓴 문의가 보이도록 한다.
		
	});
	
	
	$("span.errorMsg").hide();
	
	
	
	const form = document.querySelector('.ask-frm');
	const titleInput = document.getElementById('ask-title');
	const categorySelect = document.getElementById('ask-category-select');
	const detailTextarea = document.getElementById('ask-detail');
	const errorMsgs = document.querySelectorAll('.errorMsg');

	// 에러 
	function clearErrorMessages() {
	    errorMsgs.forEach(msg => msg.style.display = 'none');
	}

	// 빈 공간이 나왔을 떄 에러메세지를 display inline을 이용하여 띄워준다
	function showError(input) {
	    const errorMsg = input.nextElementSibling;
	    if (errorMsg && errorMsg.classList.contains('errorMsg')) {
	        errorMsg.style.display = 'inline';
	    }
	}

	// 문의 등록하기를 눌렀을 때
	form.addEventListener('submit', function (event) {
	    let isValid = true;

	    
	    clearErrorMessages();

	    // 제목이 비었을 때
	    if (titleInput.value.trim() === '') {
	        showError(titleInput);
	        isValid = false;
	    }

	    // 카테고리 선택이 안 되어 있을 때 
	    if (!categorySelect.value) {
	        showError(categorySelect);
	        isValid = false;
	    }

	    // 문의 내용이 안 되어 있을 때 
	    if (detailTextarea.value.trim() === '') {
	        showError(detailTextarea);
	        isValid = false;
	    }

	    // 필드가 유효하지 않은 방식으로 제출 되어있을 때 방지
	    if (!isValid) {
	        event.preventDefault();
	    }
	});
	
	
	$('.deleteOneGo').click(function(){
		
		const q_num = $(this).next().val();
		
		if(confirm("해당 문의를 삭제하시겠습니까?")){
			
			$.ajax({
				url:"updateQnaDeleteJSON.cl",
				data:{"q_num":q_num},
				type: "post",
				dataType:"json",
				success:function(json){
					
					alert('해당 문의가 삭제되었습니다.');
					location.reload(true);
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			})
		}
	})
	
	
}); // end of $(document).ready(function(){});-------------------------------------------------------
</script>
	
<%-- 마이페이지푸터 include 받아옴 --%>
<jsp:include page="mypagefooter.jsp"></jsp:include>
<%-- 마이페이지푸터 include 받아옴 --%> 

<%-- 푸터 include 받아옴 --%>
<jsp:include page="../footer.jsp"></jsp:include>
<%-- 푸터 include 받아옴 --%>
    

