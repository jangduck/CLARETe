<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<%
   String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp"></jsp:include>

 <!-- 직접 만든 CSS -->
 <link rel="stylesheet" href="<%= ctxPath%>/css/faq/FAQ.css">
 
            
        <%-- 시작 --%>    
         <section class="section">
            <div class="board_container">
                <div class="board_top">
                    <div class="title">BOARD</div>
                    <div class="selectMenu">
                        <span><a href="#">FAQ</a></span><span><a href="#">1:1문의</a></span>
                    </div>
                </div>
                <div class="board_bottom">
                    <ul>
                     <c:if test="${not empty requestScope.faqList}">
        				 <c:forEach var="fvo" items="${requestScope.faqList}" varStatus="status">           
	                        <li>
	                        	<span class="imgbox"><img src="<%= ctxPath%>/images/q.png" height="100%"/></span>
	                         	<span class="board_title" data-target="#aa${status.count}">${fvo.ask}</span> 
	                        	<span class="allowimgbox"><img src="<%= ctxPath%>/images/allow.png" height="50%"/></span>
	                        </li>
	                        <li class="answer" id="aa${status.count}">
	                       		 <span class="board_title">${fvo.answer}</span>
	                        </li>
				     	</c:forEach>            
				      </c:if>
				      <c:if test="${empty requestScope.faqList}">
				      	
				      		<div class="board_container" style="text-align: center;">
				      			<div class="emptyBoard"> 
					      			<span class="emptyX">x</span><br>
					      			<div style="margin-top: 20px;"><%-- margin 용 div --%>
					      			<span class="emptySpan">1:1 문의가 없습니다</span>
					      			</div>
				      			</div>
				      		</div>
				      	
				      </c:if>
				                         
                    </ul>
                </div>
            </div>
        </section>
        
        <script type="text/javascript">
	        $(document).ready(function () {
	
		        $('.answer').hide();
		
		        $('.allowimgbox').click(function(e){
		            $(this).parent().next().slideToggle();
		        })
			})
        </script>
        
      <%-- 끝 --%>           
            
   
</div>     
 
 <jsp:include page="../footer.jsp"></jsp:include>