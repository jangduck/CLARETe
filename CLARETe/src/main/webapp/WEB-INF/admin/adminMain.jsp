<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 상품관리</title>
    <link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_header.css">
    <link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_section.css">
<style type="text/css">
#container {
	height: 400px;
}

.highcharts-figure, .highcharts-data-table table {
	min-width: 310px;
	max-width: 800px;
	margin: 1em auto;
}

#datatable {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #ebebeb;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}

#datatable caption {
	padding: 1em 0;
	font-size: 1.2em;
	color: #555;
}

#datatable th {
	font-weight: 600;
	padding: 0.5em;
}

#datatable td, #datatable th, #datatable caption {
	padding: 0.5em;
}

#datatable thead tr, #datatable tr:nth-child(even) {
	background: #f8f8f8;
}

#datatable tr:hover {
	background: #f1f7ff;
}

.second-div {
	margin: 20px;
	text-align: center;
}

.home {
	border: black 1px solid;
	color: black;
	text-decoration: none;
}

.end {
	background-color: black;
}

.end:hover {
	background-color: gray;
}

</style>



</head>
<body class="allbody" style="background-color: #F1F5F9 !important; width: 100% !important;">

 <header class="side-header" style="padding-top: 30px;">
        <nav class="header-nav" >
            <ul>
                <li>
                    <div>회원관리</div>
                    <ul>
                      <li><a class="aclass" href="<%=request.getContextPath()%>/admin/admin.cl">회원조회</a></li>
                        <li><a class="aclass" href="<%= request.getContextPath() %>/admin/adminMemberStatus.cl">탈퇴회원조회</a></li>
                    </ul>
                </li>
                <li>
                    <div class="nav-title">상품관리</div>
                    <ul>
						<a class="aclass" href="<%= request.getContextPath() %>/admin/adminProduct.cl">상품조회</a>
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
            </li>
                
            </ul>
        </nav>
    </header>

<nav class="top-nav">
    <div class="nav-logo">
        <div>LOGO</div>
    </div>
    <div class="nav-btn">
        <a href="<%=request.getContextPath()%>/index.cl"><div class="home-btn home">홈으로</div></a>
        <a href="<%=request.getContextPath()%>/login/logout.cl"><div class="end-btn end">종료</div></a>
    </div>
</nav>

<section>
   
    <div class="second-div">
    <script src="<%= ctxPath %>/Highcharts-10.3.1/code/highcharts.js"></script>
    <script src="<%= ctxPath %>/Highcharts-10.3.1/code/modules/data.js"></script>
    <script src="<%= ctxPath %>/Highcharts-10.3.1/code/modules/exporting.js"></script>
    <script src="<%= ctxPath %>/Highcharts-10.3.1/code/modules/accessibility.js"></script>

    <figure class="highcharts-figure">
        <div class="second-div">
            <div id="container"></div>
        </div>
        <p class="highcharts-description">
            일별 방문자 수
        </p>

        <table id="datatable">
            <thead>
                <tr>
                    <th></th>
                    <th>남성</th>
                    <th>여성</th>
                    <th>전체</th>
                </tr>
            </thead>
            <tbody>
	            <c:if test="${not empty requestScope.log_list}">
					<c:forEach var="lvo" items="${requestScope.log_list}"
						varStatus="status">
						<c:if test="${status.index < 7}">
							<tr>
								<th>${lvo.l_logindate}</th>
								<td>${lvo.mLogin}</td>
								<td>${lvo.feLogin}</td>
								<td>${lvo.login_count}</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:if>

            </tbody>
        </table>
    </figure>
    </div>
</section>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="<%= ctxPath %>/js/admin_header.js"></script>
<script type="text/javascript">
    Highcharts.chart('container', {
        data: {
            table: 'datatable'
        },
        chart: {
            type: 'column'
        },
        title: {
            text: '최근 일주일내'
        },
        subtitle: {
            text:
                'Source: <a href="https://www.ssb.no/en/statbank/table/04231" target="_blank">SSB</a>'
        },
        xAxis: {
            type: 'category'
        },
        yAxis: {
            allowDecimals: false,
            title: {
                text: '방문자수'
            }
        },
        tooltip: {
            formatter: function () {
                return '<b>' + this.series.name + '</b><br/>' +
                    this.point.y + ' ' + this.point.name.toLowerCase();
            }
        }
    });

</script>
</body>
</html>
