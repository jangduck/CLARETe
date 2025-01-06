<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/header.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/footer.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/main.css" />

    <!-- AOS 라이브러리 불러오기-->
    <link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css"> 
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script> 

    <!-- google font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lora:ital,wght@0,400..700;1,400..700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Parisienne&family=Pinyon+Script&family=Playball&display=swap" rel="stylesheet">

<jsp:include page="header.jsp"></jsp:include>

<section class="section">
    <div class="backfff"></div>
    <div class="sectionBack">
        <div class="title_container">
            <div class="black_title"><span>REVEAL</span><div class="subVideo_container" style="background-image: url(./images/148347.jpg);"></div></div>
            <div class="black_title"><span>THE BEAUTY</span></div>
            <div class="black_title"><span>of</span></div>
            <div class="black_title"><span>FOR YOU</span></div>

            <div class="drawsvg">
                <svg version="1.1" viewBox="0 0 2000 500">
                <symbol id="fade-text">
                    <text x="45%" y="40%" text-anchor="middle">Objet Perfume</text>
                    <!--<text x="55%" y="80%" text-anchor="middle">Brand</text> -->
                </symbol>
                <g>
                    <use class="stroke" xlink:href="#fade-text"/>
                    <use class="fill" xlink:href="#fade-text"/>
                </g>
                </svg>          
            </div>

            
        </div>
    </div>
    <div class="mainVideo_container">
        <video style="object-fit: cover;" src="./video/1471017_People_Fashion_3840x2160.mp4" height="100%" width="100%" loop muted autoplay></video>
    </div>
</section>

<section class="section2">
    <div class="most_love_container">
        <div class="lova_title">
            <div>
                <div class="section2_title"><div class="section2_ti">Most Loved scents</div></div>
            </div>
            <div class="section2_sub_box">
                <div class="section2_sub">
                    <a href="<%= ctxPath%>/shop/allProduct.cl?cname=0"><span>ㅡ</span> <span>All SCENTS</span></a>
                </div>
            </div>
        </div>

        <div class="cardBox">
            <ul class="cardcontainer">
                <!-- === for문 대상 시작 === -->
                
                <c:if test="${not empty requestScope.mainProductList}">
	                <c:forEach var="pvo" items="${requestScope.mainProductList}">
	                <li class="cardbox">
	                    <a href="/CLARETe/shop/prodView.cl?p_num=${pvo.p_num}" draggable="false">
	                        <div class="cardimg" draggable="false">
								<img src='/CLARETe/images/${pvo.p_image}' style='width: 100%' />
	                        </div>
	                        <div class="cardname" draggable="false">
	                            ${pvo.p_name}
	                        </div>
	                        <div class="cardprice" draggable="false">
	                            ${pvo.p_price}
	                        </div>
	                    </a>
	                </li>
	                </c:forEach>
                </c:if>
                
                <c:if test="${empty requestScope.mainProductList}">
                <div style="width: 100%; height: 100%; display: flex; justify-content: center; align-items: center;"><div>등록된 상품이 하나도 없습니다. 상품을 구매해보세요!</div></div>
                </c:if>
                <!-- === for문 대상 끝 === -->

                
            </ul>
        </div>
        <div class="controll_btn">
            <span id="left"></span><span id="right"></span>
        </div>
    </div>
</section>

<section class="section3">
    <div class="category_container">
        <div class="category_title">SHOP BY SCENT TYPE</div>
        <ul class="category_box">
            <li>
                <a href="<%= ctxPath%>/brand/brandStory.cl">
                    <div>ABOUT</div>
                    <div>About</div>
                </a>
            </li>
            <li>
                <a href="<%= ctxPath%>/shop/allProduct.cl?cname=0">
                    <div>PRODUCT</div>
                    <div>Product</div>
                </a>
            </li>
            <li>
                <a href="<%= ctxPath%>/category/productCategory.cl">
                    <div>CATEGORY</div>
                    <div>Category</div>
                </a>
            </li>
            <li>
                <a href="#">
                    <div>BOARD</div>
                    <div>Board</div>
                </a>
            </li>
        </ul>
        
        <div class="section3_topimg section3_img">
            <img src="./images/2148317591.jpg" style="object-fit: cover;" height="100%" width="100%"/>
        </div>
        <div class="section3_bottomimg section3_img">
            <img src="./images/2148547413.jpg" style="object-fit: cover;" height="100%" width="100%"/>
        </div>
    </div>
</section>

<section class="section4">
    <div class="section4_container">
        <div class="section_hide">
            <div class="section4_first_box secbox">
                <div class="section4_first_img">
                    <img src="./images/2149234359.jpg" style="object-fit: cover;" height="100%" width="100%"/>
                </div>
                <div>
                    <div class="section4_contant">
                        우리의 목표는 단순히 향기를 판매하는 것이 아니라, 각 계절의 이야기를 향기를 통해 전달하며, <br>
                        당신의 감각과 추억을 풍요롭게 만드는 것입니다. <br>
                        계절이 가져다주는 행복과 위로를 현대인의 삶에 녹여내는 것을 미션으로 삼습니다. <br>
                        당신이 원하는 계절의 순간을 언제든 꺼내어 느낄 수 있도록, 우리는 품질과 감각을 고집합니다.
                    </div>
                </div>
            </div>
        </div>

        <div class="section_hide">
            <div class="section4_se_box secbox">
                <div class="section4_first_img">
                    <video style="object-fit: cover;" src="./video/1799686_Gift Perfume_Gift Wrap_1920x1080.mp4" height="100%" width="100%" loop muted autoplay></video>
                </div>
                <div class="section4_se_po">
                    <div>BRAND STORY.</div>
                </div>
            </div>
        </div>

        <div class="section_hide">
            <div class="section4_tr_box secbox">
                <div class="section4_first_img">
                    <video style="object-fit: cover;" src="./video/1799669_Gift Wrap_Gift_1920x1080.mp4" height="100%" width="100%" loop muted autoplay></video>
                </div>
                <div class="section4_sub">
                    <a href="<%= ctxPath%>/brand/brandTimeLine.cl"><span>ㅡ</span> <span>READ MORE</span></a>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section5">
    <div class="section5_container">
        <div>
            <div><div>"Whatever your choose,</div></div>
            <div><div>we believe that each scent <span class="section5_img_box"></span>will always be </div></div>
            <div><div>sweet and seductive <span class="highlight">highlight</span> for you!"</div></div>
        </div>
    </div>
</section>

    <script>
        // === --- 스크롤링 이벤트 시작 --- === //
        $(window).scroll(() => {

            //console.log($(window).scrollTop()); 
            // console.log($('.section').outerHeight() / 2);

            const userScroll = $(window).scrollTop(); // 사용자 스크롤 위치

            const test = parseInt(Math.max(Math.min(userScroll / $('.section').outerHeight(), 100)* 100, 1)); // 섹션1의 백분율 값

            const spanOne = -1/1 * userScroll; // 스크롤 하면 REVEAL의 위치가 위로 이동하는 방정식


            $('#container > section.section > div.sectionBack > div > div:nth-child(1) > span').css({
                'top':spanOne
            })

            
            
            // ================== section2 스크롤 액션 ================== //
            const section1 = $('.section').outerHeight() / 2; // 섹션1의 절반 값

            if(userScroll > section1){
                // console.log('넘었쪙~!');
                let cardboxCnt = $('.cardbox').length;

                for(let i=0; i<cardboxCnt; i++){
                    setTimeout(function(){
                        $('.cardbox').eq(i).css({
                            'transform': 'translateY(0%)'
                        })
                    }, i*100)
                }

                $('.section2_ti').css({
                    'transform': 'translateY(0px)'
                })

                $('.section2_sub_box').css({
                    'height': 'var(--size24)'
                })
                
                setTimeout(function(){
                    $('div.section2_sub_box > div > a > span:nth-child(1)').css({
                    'width': 'var(--size22)'
                })
                }, 500)
                
                
            } // end of if(userScroll > section1)---------------

            if(userScroll < section1){
                // console.log('넘었쪙~!');
                let cardboxCnt = $('.cardbox').length;

                for(let i=0; i<cardboxCnt; i++){
                    setTimeout(function(){
                        $('.cardbox').eq(i).css({
                            'transform': ''
                        })
                    }, i*100)
                }


                $('.section2_ti').css({
                    'transform': ''
                })

                $('.section2_sub_box').css({
                    'height': ''
                })

                $('div.section2_sub_box > div > a > span:nth-child(1)').css({
                    'width': ''
                })
            } // end of if(userScroll < section1)---------------
            // ================== section2 스크롤 액션 ================== //



            


            // ================== section3 스크롤 액션 ================== //
            const section2 = $('.section').outerHeight() + $('.section2').outerHeight() / 2; // 섹션2의 절반 값

            if(userScroll > section2){
                // console.log('넘었다~~!')

                let imgCnt = $('.section3_img').length;
                
                for(let i=0; i<imgCnt; i++){
                    setTimeout(function(){
                        $('.section3_img').eq(i).css({
                            'width': '20%'
                        })
                    }, i*100)
                }

                let categoryCnt = $('.category_box li > a div').length;

                for(let i=0; i<categoryCnt; i++){
                    setTimeout(function(){
                        $('.category_box li > a  div').eq(i).css({
                            'transform': 'translateY(0px)'
                        })
                    }, i*100)
                }

                $('.category_title').fadeIn()
            }

            if(userScroll < section2){
                // console.log('넘었다~~!')

                let imgCnt = $('.section3_img').length;
                
                for(let i=0; i<imgCnt; i++){
                    setTimeout(function(){
                        $('.section3_img').eq(i).css({
                            'width': ''
                        })
                    }, i*100)
                }

                let categoryCnt = $('.category_box li > a div').length;

                for(let i=0; i<categoryCnt; i++){
                    setTimeout(function(){
                        $('.category_box li > a  div').eq(i).css({
                            'transform': ''
                        })
                    }, i*100)
                }

                $('.category_title').fadeOut()

            }
            // ================== section3 스크롤 액션 ================== //



            // ================== section4 스크롤 액션 ================== //
            const section3 = $('.section').outerHeight() + $('.section2').outerHeight() + $('.section3').outerHeight() / 2; // 섹션3의 절반 값

            if(userScroll > section3){

                let section_hide = $('.section_hide').length;

                for(let i=0; i<section_hide; i++){
                setTimeout(function(){
                            $('.section_hide').eq(i).css({
                                'height':'100%'
                            })
                    
                    }, i*100)
                }   

                setTimeout(function(){
                    $('.section4_se_po').css({
                        'transform': 'translateX(0%)'
                    })
                }, 1000)

            }
            

            if(userScroll < section3){

                let section_hide = $('.section_hide').length;

                setTimeout(function(){
                    $('.section4_se_po').css({
                        'transform': 'translateX(-100%)'
                    })
                }, 1000)

                for(let i=0; i<section_hide; i++){
                setTimeout(function(){
                            $('.section_hide').eq(i).css({
                                'height':''
                            })
                    
                    }, i*100)
                }
            }

            // ================== section4 스크롤 액션 ================== //



            // ================== section5 스크롤 액션 ================== //
            const section4 = $('.section').outerHeight() + $('.section2').outerHeight() + $('.section3').outerHeight() + $('.section4').outerHeight() / 2; // 섹션2의 절반 값

            if(userScroll > section4){
                // console.log('넘었다~~!')

                let endingMentCnt = $('.section5_container > div div').length;
                
                for(let i=0; i<endingMentCnt; i++){
                    setTimeout(function(){
                        $('.section5_container > div div > div').eq(i).css({
                            'transform': 'translateY(0%)'
                        })
                    }, i*100)
                }
                

            }

            if(userScroll < section4){
                // console.log('넘었다~~!')

                let endingMentCnt = $('.section5_container > div div').length;
                
                for(let i=0; i<endingMentCnt; i++){
                    setTimeout(function(){
                        $('.section5_container > div div > div').eq(i).css({
                            'transform': ''
                        })
                    }, i*100)
                }

                

            }

            // ================== section5 스크롤 액션 ================== //

        });
        // === --- 스크롤링 이벤트 끝 --- === //


        $(document).ready(function(){
        	$('.cardprice').html(Number($('.cardprice').html()).toLocaleString('en')+ "원"); // 가격 콤마표시
        	
            // ================== 맨 처음 로딩창 ================== //
            for(let i=0; i<$('.black_title').length; i++){
                setTimeout(function(){
                    $('.black_title span').eq(i).css({
                        'top': '0'
                    })
                }, i*120);
            }

            setTimeout(function(){
                $('.backfff').css({
                    'top': '0%'
                })
            }, 4000);

            setTimeout(function(){
                $('.section').css({
                    'top': '4.5rem'
                })
                $('.sectionBack').css({
                    'padding-top': '1%'
                })

                $('.header-container').css({
                    'z-index':'12'
                })

                $('.hamburgerbar').css({
                    'z-index':'11'
                })
                $('.nav-container').css({
                    'z-index':'10'
                })
                $('.nav_inner').css({
                    'z-index':'11'
                })
                

            }, 4500);

            setTimeout(function(){
                $('.mainVideo_container').css({
                    'height':'40%'
                })
                $('.subVideo_container').css({
                    'height':'100%'
                })
            }, 4600);


           
            // ================== 맨 처음 로딩창 ================== //




            $('#left').click((e)=>{
                $('.cardcontainer').css('transform', 'translateX(0%)');
            });
            $('#right').click((e)=>{
                $('.cardcontainer').css('transform', 'translateX(-50%)');
            });

        }) // end of $(document).ready(function(){ ----------------------------------------



        // ============================== 섹션3 ============================== //
        $('.category_box li').hover(function(){
            // alert();

            $('.category_box li > a').eq($(this).index()).css({
                'transform': 'translateY(-50%)'
            })

            

        }, function(){
            $('.category_box li > a').eq($(this).index()).css({
                'transform': 'translateY(0px)'
            })
            
        });
        // ============================== 섹션3 ============================== //



    </script>



    <!-- AOS 스크립트 시작 -->
    <script> 
        AOS.init(); // 자바스크립트로 init()을 해야 동작한다.
    </script>

<jsp:include page="footer.jsp"></jsp:include>