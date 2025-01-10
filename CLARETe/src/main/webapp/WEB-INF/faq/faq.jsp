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

.aclass {
	color: gray;
	text-decoration: none;
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

.search {
    width: 50px;
    height: 25px;
    font-size: 15px; 
    padding: 4px; 
    background-color: gray;
    border: black;
}

.search:hover {
	background-color: gray;
	border:black;
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

.modalclose {
	background-color: black;
	color: white;
	border: black 1px solid;
}

.modalclose:hover {
	background-color: gray;
	color: white;
	text-decoration: none;
	border: gray 1px solid;
}


th {
    text-align: center; 
    vertical-align: middle; /* 수직 가운데 정렬 */
}


table td {
    text-align: center;
    vertical-align: middle;
}

 ul, .nav-title{
   margin-left: 16px;}
</style>

    <header class="side-header" style="padding-top: 30px;">
        <nav class="header-nav" >
            <ul>
                <li>
                    <div class="nav-title">회원관리</div>
                    <ul>
                      <li><a class="aclass" href="<%= request.getContextPath() %>/admin/admin.cl">회원조회</a></li>
                        <li><a class="aclass" href="<%= request.getContextPath() %>/admin/adminMemberStatus.cl">탈퇴회원조회</a></li>
                    </ul>
                </li>
                <li>
                    <div class="nav-title">상품관리</div>
                    <ul>
						<li><a class="aclass" href="<%= request.getContextPath() %>/admin/adminProduct.cl">상품조회</a></li>
						<li><a class="aclass" href="<%= request.getContextPath() %>/admin/adminProductInsertGo.cl"></a>상품등록</li>
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
                <div class="nav-title">문의관리</div>
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