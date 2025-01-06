<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<%
   String ctxPath = request.getContextPath();
%>


<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css"> 

<%-- 직접 만든 CSS -%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/faq/faq_board.css" /> 

 
<%-- jQueryUI CSS 및 JS --%>
 

  





<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" >
<jsp:include page="../header.jsp"></jsp:include>



<div id="faq_container" > <!-- style="width: 70%; margin: 5% auto;" -->
    <div id="faq_title" >BOARD</div> <!-- style="font-size: 25pt; width: 10%; height: 5%; margin: 5% auto;" -->
    <div id="menu">
      <span><a href="/CLARETe/faq/faq_board.cl" id="a_fna">FAQ</a></span>
      <!-- &nbsp;&nbsp; -->
      <span id="span2"><a href="/CLARETe/qna/qna_board.cl" id="a_qna">1:1문의</a></span>
    </div>
   
     <div class="container-fluid">
     <div id="searchbar">
     <input id="search" type="search" placeholder="키워드를 입력해주세요" /><input id="searchbtn" type="button" value="검색"/>
     </div>     
            
        <%-- 시작 --%>    
        <div class="panel-group" id="accParent" role="tablist">
        
      <c:if test="${not empty requestScope.faqList}">
         <c:forEach var="fvo" items="${requestScope.faqList}" varStatus="status">            
                <div class="panel panel-default">
                      <div class="panel-heading" role="tab">
                           <a role="button" data-toggle="collapse" data-parent="#accParent" data-target="#aa${status.count}" aria-constrols="addEx2">                          
                         <hr>               
                        <%-- <span>${status.count}</span> --%>
                        <%-- <span>${fvo.faq_num}</span> --%>
                        <span>${fvo.ask}</span>                                                                    
                        </a>
                    </div>
                        
                    <div id="aa${status.count}" class="panel-collapse collapse" role="tabpanel">
                     <hr>
                       <div class="panel-body">                                      
                            <span>${fvo.answer}</span>
                       </div>            
                   </div>
                </div>             
           </c:forEach>            
      </c:if>
                           
      </div> <!-- id=accParent --> 
      <%-- 끝 --%>           
            
   
</div>     
 
 <jsp:include page="../footer.jsp"></jsp:include>