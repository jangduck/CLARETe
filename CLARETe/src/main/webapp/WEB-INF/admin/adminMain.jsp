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

        .highcharts-figure,
        .highcharts-data-table table {
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

        #datatable td,
        #datatable th,
        #datatable caption {
            padding: 0.5em;
        }

        #datatable thead tr,
        #datatable tr:nth-child(even) {
            background: #f8f8f8;
        }

        #datatable tr:hover {
            background: #f1f7ff;
        }

        .second-div {
            margin: 20px;
            text-align: center;
        }

</style>
</head>
<body>

<header class="side-header">
    <nav class="header-nav">
        <ul>
            <li>
                <div>회원관리</div>
                <ul>
                    <li><a href="<%= ctxPath %>/admin/admin.cl">회원조회</a></li>
                    <li><a href="<%= ctxPath %>/admin/adminRemove.cl">탈퇴회원조회</a></li>
                </ul>
            </li>
            <li>
                <div>상품관리</div>
                <ul>
                    <li><a href="<%= ctxPath %>/admin/adminProduct.cl">상품조회</a></li>
                    <li><a href="<%= ctxPath %>/admin/adminCategory.cl">상품 카테고리 별 조회</a></li>
                    <li><a href="<%= ctxPath %>/admin/adminAddProduct.cl">상품등록</a></li>
                    <li><a href="<%= ctxPath %>/admin/adminStock.cl">상품 재고 관리</a></li>
                    <li><a href="<%= ctxPath %>/admin/adminDeleteProduct.cl">상품 삭제</a></li>
                </ul>
            </li>
            <li>
                <div>주문관리</div>
                <ul>
                    <li><a href="<%= ctxPath %>/admin/adminOrder.cl">주문회원조회</a></li>
                    <li><a href="<%= ctxPath %>/admin/adminDelivery.cl">주문배송관리</a></li>
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
        <a href="<%=request.getContextPath()%>/index.cl"><div class="home-btn">홈으로</div></a>
        <a href="<%=request.getContextPath()%>/login/logout.cl"><div class="end-btn">종료</div></a>
    </div>
</nav>

<section>
    <div style="display: flex; flex-wrap: wrap;">
        <div class="first-div">
            <div style="margin: 30px 0px 0px 30px;">
                <form>
                    <div style="display: flex; gap: 8px; flex-wrap: wrap;">
                        <div class="input-box">
                            <div><label for="userid">유저 아이디</label></div>
                            <div>
                                <input type="text" id="userid" name="userid" placeholder="유저 아이디를 입력하세요">
                            </div>
                        </div>
                        <div class="input-box">
                            <div><label for="username">유저명</label></div>
                            <div>
                                <input type="text" id="username" name="username" placeholder="유저명을 입력하세요">
                            </div>
                        </div>
                    </div>
                    <div style="display: flex; gap: 8px; flex-wrap: wrap;">
                        <div class="input-box">
                            <div><label for="deleteStatus">삭제여부</label></div>
                            <div>
                                <input type="text" id="deleteStatus" name="deleteStatus" placeholder="전체">
                            </div>
                        </div>
                        <div class="input-box">
                            <div><label for="dormantStatus">휴면여부</label></div>
                            <div>
                                <input type="text" id="dormantStatus" name="dormantStatus" placeholder="전체">
                            </div>
                        </div>
                    </div>
                </form>
                <div class="form-btn-box">
                    <input type="submit" class="btn search" value="검색"/>
                    <input type="reset" class="btn reset" value="초기화"/>
                </div>
            </div>
        </div>
    </div>
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
