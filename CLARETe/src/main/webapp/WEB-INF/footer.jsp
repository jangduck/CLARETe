<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
    <link rel="stylesheet" href="./css/header_02.css">
    <link rel="stylesheet" href="./css/footer.css">
    <!-- Link Swiper's CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
</head>
<body> 
    <div id="container">


        <footer>
            <div>
                <div class="footer-logo">
                    FOOTER LOGO
                </div>
                <div class="footer-contants">
                    <div class="infobox">
                        <div class="contants-title">
                            Info.
                        </div>
                        <div class="footer-contant">
상호 : 금쪽이 캠퍼니  |  조장 : 장민규 |  이메일 : rmaWhrdl12@gmail.com <br>
사업자등록번호 : 000-11-22222  | <br>
주소 : 서울시 홍대입구역 내리면 있는 쌍용강북센터  |  개인정보보호책임자 : 강이훈 
                        </div>
                    </div>
                    <div class="infobox">
                        <div class="contants-title">
                            Guide.
                        </div>
                        <div class="footer-contant">
                            <div><a href="#">이용약관</a></div>
                            <div><a href="#">개인정보처리방침</a></div>
                            <div><a href="#">자주묻는질문</a></div>
                        </div>
                    </div>
                    <div class="infobox">
                        <div class="contants-title">
                            Contact us.
                        </div>
                        <div class="footer-contant">
                            <div>플러스친구 @장민규</div>
                            <div>※ 유선 상담은 진행하지 않습니다.</div>
                            <div>평일 10:00 - 17:00 (점심 12:00 - 13:00)<br>주말 및 공휴일 휴무</div>
                        </div>
                    </div>
                    <div>
                        Copyright ⓒ 2024. 금쪽이와 아이들.
                    </div>
                </div>
            </div>
        </footer>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script>
        // === 토글 되는 nav바 시작 === //
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
        // === 토글 되는 nav바 끝 === //
        

        // === --- 스크롤링 이벤트 시작 --- === //
        const section3_position = $('.section3').offset().top; // 색션2 위치

        $(window).scroll(()=>{
            let scroll_position = parseInt($(window).scrollTop()); // 스크롤 실시간 위치
            let y = 5/94*scroll_position;

            // === 스크롤 했을 때의 경우 === //
            if(scroll_position != 0){
                $('.section2').css({
                    'transform' : 'translateY(-100px)',
                    'opacity' : '1'
                    // 'transform' : `translateX(-${y}%)`
                });
                $('.forOpacity').css({
                    'opacity' : '1',
                    'top' : '0'
                })
            } // end of if(scroll_position != 0)------

            // === 스크롤을 가장 위로 올렸을 때의 경우 === //
            else if(scroll_position == 0){
                $('.section2').css({
                    'transform' : '',
                    'opacity' : ''
                });
            } // end of else if(scroll_position == 0)------



            if(scroll_position >= section3_position){ // 만약 스크롤이 색션2를 넘어섰을 때
                $('.header-container').css({
                    'background' : 'rgba(255, 255, 255, 0.7)',
                    'backdrop-filter' : 'blur(3px)',
                    '-webkit-backdrop-filter' : 'blur(3px)'
                })
                $('.section4').css({
                    'opacity' : '1',
                    'top' : '0'
                })
            }
            if(scroll_position <= section3_position){
                $('.header-container').css({
                    'background' : '',
                    'backdrop-filter' : '',
                    '-webkit-backdrop-filter' : ''
                })
            }


        });
        // === --- 스크롤링 이벤트 끝 --- === //


        $(document).ready(function(){
        
            const title = $('.title').text();

            // console.log(title.length);

            let sum_span=``;
            let html = ``;
            for(let i=0; i<title.length; i++){
                console.log(title.charAt(i));
                html+=`<span class="title${i} titleall style="left:${i}00px;">${title.charAt(i)}</span>`;
                
                setTimeout( function(){
                    $(`span.title${i}`).css({
                        'opacity': '1',
                        'top': '0px'
                    })
                }, i*50);
            }
            $('.title').html(html);
        })




        $(document).ready(function(){
        
        const title = $('.title2').text();

        // console.log(title.length);

        let sum_span=``;
        let html = ``;
        for(let i=0; i<title.length; i++){
            console.log(title.charAt(i));
            html+=`<span class="title${i} titleall style="left:${i}00px;">${title2.charAt(i)}</span>`;
            
            setTimeout( function(){
                $(`span.title${i}`).css({
                    'opacity': '1',
                    'top': '0px'
                })
            }, i*50);
        }
        $('.title2').html(html);
    })





    </script>    
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script>
        var swiper = new Swiper(".mySwiper", {
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        pagination : {
            el:".swiper-pagination",
            clickable:true,
        },
        mousewheel:false,
        keyboard:true,
        loop: true,
        autoplay:true,
        sildesPerView:1,
        spaceBetween:0,
        effect:'fade',
        speed:1000,
        
        });

        var swiper = new Swiper('.mySwiper',{
            sildesPerView: 1,
            breakpoints:{
                640:{
                    sildesPerView:2,
                },
                768:{
                    sildesPerView:3,
                },
                1024:{
                    sildesPerView:4,
                },
            }
        });
    </script>
</body>
</html>
