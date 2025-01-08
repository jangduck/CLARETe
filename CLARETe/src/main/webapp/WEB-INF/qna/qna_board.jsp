<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
   
<%
	String ctxPath = request.getContextPath();
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/header.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/footer.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/qna/inquiry.css" />

    <!-- AOS 라이브러리 불러오기-->
    <link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css"> 
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script> 

    <!-- google font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lora:ital,wght@0,400..700;1,400..700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Parisienne&family=Pinyon+Script&family=Playball&display=swap" rel="stylesheet">

<jsp:include page="../header.jsp"></jsp:include>


<section class="section1">
            <div class="board_container">
                <div class="board_top">
                    <div class="title">BOARD</div>
                    <div class="selectMenu">
                        <span><a href="#">FAQ</a></span><span><a href="#">1:1문의</a></span>
                    </div>
                </div>

                <div class="inquiry_btn">문의하기</div>
                <table>
                    <thead>
                        <tr>
                            <td>문의 제목</td>
                            <td>문의날짜</td>
                            <td>문의내용</td>
                            <td>상세보기</td>
                        </tr>
                    </thead>
                </table>
                <div class="board_bottom">
                    <table>
                    <thead>
	                    <c:if test="${not empty requestScope.qnaList}">
	                    	<c:forEach var="qvo" items="${requestScope.qnaList}" varStatus="status">
		                        <tr>
		                            <td>
		                                <span class="board_title">${qvo.q_title}</span>
		                            </td>
		                            <td>${qvo.q_register}</td>
		                            <td>
		                            	<c:choose>
										    <c:when test="${qvo.q_category == 1}"><td class="category">결제/교환/환불</td></c:when>
										    <c:when test="${qvo.q_category == 2}"><td class="category">상품문의</td></c:when>
										    <c:when test="${qvo.q_category == 3}"><td class="category">매장문의</td></c:when>
										    <c:when test="${qvo.q_category == 4}"><td class="category">배송문의</td></c:when>      
										</c:choose>  
		                            </td>
		                            <td>
		                            	<span class="info">상세보기</span>
		                            	<div class="infoBox">
		                            	<div class="infoback"></div>
		                            	<div class="infocon">
		                            	
		                            		<div>질문</div>
		                            		<table border="1">
		                            			<tr>
		                            				<td>질문자</td><td>${qvo.fk_m_id}</td>
		                            			</tr>
		                            			<tr>
		                            				<td>등록일자</td><td>${qvo.q_register}</td>
		                            			</tr>
		                            			<tr>
		                            				<td>문의제목</td><td>${qvo.q_title}</td>
		                            			</tr>
		                            			<tr>
		                            				<td>문의내용</td><td>${qvo.q_ask}</td>
		                            			</tr>
		                            		</table>
		                            	
		                            		<div>답변</div>
											<table border="1">
		                            			<tr>
		                            				<td>답변일자</td><td>title</td>
		                            			</tr>
		                            			<tr>
		                            				<td>답변내용</td><td>${qvo.q_answer}</td>
		                            			</tr>
		                            		</table>
		                            		
		                            		<div class="closeB">닫기</div>
										</div>
		                            	</div>
		                            </td>
		                        </tr>
	                        </c:forEach>
						</c:if>
						<c:if test="${empty requestScope.qnaList}">
							<tr>등록된 문의가 없습니다.</tr>
						</c:if>
                    </thead>
                </table>
                </div>
            </div>
        </section>

<%--
<div id="container">
	 <div id="title">BOARD</div>
	 <div id="menu">
		<span><a href="/CLARETe/faq/faq_board.cl" id="a_faq">FAQ</a></span>
		<!-- &nbsp;&nbsp; -->
		<span id="span2"><a href="/CLARETe/qna/qna_board.cl" id="a_qna">1:1문의</a></span>
	 </div>
	
	

	
     <div class="container-fluid">
     <div id="searchbar">
     <input id="search" type="search" placeholder="키워드를 입력해주세요" /><input id="searchbtn" type="button" value="검색"/>
     </div>
      <div class="panel-group" id="accParent" role="tablist">
        <hr id="first">
        <span id="qnaSpan1">문의제목</span>
        <span id="qnaSpan2">문의날짜</span>
        <span id="qnaSpan3">문의유형</span> 
         <hr id="second">
         
       
       
            
       
        <div class="panel-group" id="accParent" role="tablist">
        
		<c:if test="${not empty requestScope.qnaList}">
			<c:forEach var="qvo" items="${requestScope.qnaList}" varStatus="status">
			
				
					 <div class="panel panel-default">
         			 	<div class="panel-heading" role="tab">
           				    <a role="button" data-toggle="collapse" data-parent="#accParent" data-target="#aa${status.count}" aria-constrols="addEx2">
				              
				     		
				      
				      					    
								<span id="qnaSpan1">${qvo.q_title}</span>
								<span id="qnaSpan2">${qvo.q_register}</span>
								<c:choose>
									    <c:when test="${qvo.q_category == 1}"><td class="category">결제/교환/환불</td></c:when>
									    <c:when test="${qvo.q_category == 2}"><td class="category">상품문의</td></c:when>
									    <c:when test="${qvo.q_category == 3}"><td class="category">매장문의</td></c:when>
									    <c:when test="${qvo.q_category == 4}"><td class="category">배송문의</td></c:when>      
								</c:choose>        		                       
				   	            
				            </a>
				        </div>
      						
					     <div id="aa${status.count}" class="panel-collapse collapse" role="tabpanel">
					      
							  <div class="panel-body">  
							  		<div id="qnaAsk">${qvo.q_ask}</div>           
							  		<hr>				       		
							    	<span id="qnaSpan1">${qvo.q_answer}</span>			    	
							  </div>      		
						 </div>
					 </div>
							  <hr>		 					 
			  </c:forEach>            
		</c:if>
			                  
		</div> <!-- id=accParent --> 
		
       
       
       
	
	
	
	
	
</div>	  
 --%>
<script>

	$('.info').click(function(e){
		$(this).next().toggle()
	})
	
	$('.closeB').click(function(){
		$(this).parent().parent().toggle()
	})

</script>                  

<jsp:include page="../footer.jsp"></jsp:include>     