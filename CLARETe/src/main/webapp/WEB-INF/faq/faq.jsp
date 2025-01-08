<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
    //    /CLARETe
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_header.css">
<link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_section.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/faq/faqq.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>


<body class="allbody" style="background-color: #F1F5F9 !important; width: 100% !important;">
	<jsp:include page="../admin/adminheader.jsp"></jsp:include>
</body>


<section>

	<div style="display: flex; flex-wrap: wrap;">
	<div style="margin-left: 10px; color:#999;"><span class="text-danger">*</span>은 필수입력항목입니다.</div>
		<div class="first-div" style="margin-right: 10px;">
			<form name="faqFrm">        
			
				<table style="padding-top:50px; align=center; width=auto; border=0; cellpadding=2;">
				
					<tr>
						<td><p><b>FAQ 등록</b></p></td>				
					</tr>
					
					<tr>
						<td>
                            <table class="table2">                            
                                <tr>
                                    <td style="padding-left: 60px;">질문<span class="text-danger">*</span></td>
                                    <td><input type="text" name="ask" id="title" placeholder="질문을 입력하세요" maxlength=20 /></td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 60px;">답변<span class="text-danger">*</span></td>
                                    <td><textarea name="answer" id="content" placeholder="내용을 입력하세요"></textarea></td>
                                </tr>
                            </table>           
                            
                            <div id="btn">                 
	                            <span><input type="button" value="등록" class="btn btn-primary btn-round" onclick="FAQupload()" /></span>	                      
	                            <span><input type="reset" class="btn " value="취소"/></span>
                            </div> <!-- div#btn -->
                        </td>
					</tr>
				
				</table>			
			
			</form>
		</div>	<!-- first-div -->
	</div>
	
</section>