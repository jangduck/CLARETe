<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>금쪽이</title>
    
    <!-- Link Swiper's CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    
    <!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

	<!-- Font Awesome 6 Icons -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
    
    <!-- 직접 만든 CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/template/template.css" />
    
    <!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 
    
    <!-- 해더, 푸터 css -->
    <link rel="stylesheet" href="<%= ctxPath %>/css/index/header.css">
	<link rel="stylesheet" href="<%= ctxPath %>/css/index/footer.css">
	
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
</head>
<body> 
    <div id="container">
        <div class="header-container">
            <header>
                <div class="hamburgerbar" id="hamburger">
                    <ul>
                        <li class="hamburger"></li>
                        <li class="hamburger"></li>
                        <li class="hamburger"></li>
                    </ul>
                </div>
                <div class="header-logo">
                    <a href="<%= ctxPath%>/">
                        
                    </a>
                </div>
                <div>
                    <div class="header-icon-wrapper">
                        <ul>
                        	<c:if test="${not empty sessionScope.loginuser}">
                        		<li><a href="<%= ctxPath%>/login/logout.cl">Logout</a></li>
                        		<li><a href="<%= ctxPath%>/mypage/mypage.cl">My Page</a></li>
                        	</c:if>
                        	
                        	<c:if test="${empty sessionScope.loginuser}">
                        		<li><a href="<%= ctxPath%>/login/loginView.cl">Login</a></li>
                            	<li><a href="<%= ctxPath%>/member/memberRegister.cl">Sign Up</a></li>
                            	<li><a href="<%= ctxPath%>/login/loginView.cl">My Page</a></li>
                        	</c:if>

							<c:if
								test="${not empty sessionScope.loginuser and sessionScope.loginuser.m_id == 'admin' }">
								<!-- admin 으로 로그인 했으면 -->
								<li class="nav-item dropdown">
									<a class="nav-link dropdown-toggle menufont_size text-primary"
									   href="#" id="navbarDropdown" data-toggle="dropdown"> 관리자전용
									</a>
									<div class="dropdown-menu" aria-labelledby="navbarDropdown">
										<a class="dropdown-item text-primary" href="<%=ctxPath%>/admin/admin.cl">회원목록</a>
										<a class="dropdown-item text-primary" href="<%=ctxPath%>/admin/adminProductInsertGo.cl">제품등록</a>
										<div class="dropdown-divider"></div>
										<a class="dropdown-item text-primary" href="<%=ctxPath%>/admin/adminOrder.cl">전체주문내역</a>
									</div>
								</li>
							</c:if>

						</ul>
						
						
						
                    </div>
                </div>
            </header>
        </div>

        <div class="nav-container">
            <nav>
                <div class="nav_inner">
                    <ul class="nav_list">
                        <li class="menu">
                            <a href="<%= ctxPath%>/brand/brandStory.cl">ABOUT</a>
                            <div class="depth">
                                <ul>
                                    <li><a href="<%= ctxPath%>/brand/brandStory.cl">BRAND STORY</a></li>
                                    <li><a href="<%= ctxPath%>/brand/brandTimeLine.cl">BRAND TIMELINE</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="menu">
                            <a href="<%= ctxPath%>/shop/allProduct.cl?cname=0">PRODUCT</a>
                            <div class="depth">
                                <ul>
                                    <li><a href="<%= ctxPath%>/shop/allProduct.cl?cname=1">SPRING</a></li>
                                    <li><a href="<%= ctxPath%>/shop/allProduct.cl?cname=2">SUMMER</a></li>
                                    <li><a href="<%= ctxPath%>/shop/allProduct.cl?cname=3">AUTUMN</a></li>
                                    <li><a href="<%= ctxPath%>/shop/allProduct.cl?cname=4">WINTER</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="menu">
                            <a href="<%= ctxPath%>/category/productCategory.cl">CATEGORY</a>
                            <div class="depth">
                                <ul>
                                    <li><a href="<%= ctxPath%>/shop/allProduct.cl?cname=5">For Him</a></li>
                                    <li><a href="<%= ctxPath%>/shop/allProduct.cl?cname=6">For Her</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="menu">
                            <a>BOARD</a>
                            <div class="depth">
                                <ul>
                                    <li><a href="#">FAQ</a></li>
                                    <li><a href="#">INQUIRY</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>

        
    </div>
    <script>
        // === 토글 되는 nav바 시작 === //
        $(document).ready(function(){
        	let hamburger_cnt=0;

            $('#hamburger').click(()=>{
                hamburger_cnt++;

                if(hamburger_cnt%2!=0){
                    $('.nav-container').css({
                        'left': '0'
                    });
                }
                else if(hamburger_cnt%2==0){
                    $('.nav-container').css({
                        'left': ''
                    });
                }
            });
        })
        // === 토글 되는 nav바 끝 === //
        

        // === --- 스크롤링 이벤트 끝 --- === //




    </script>
</body>
</html>
