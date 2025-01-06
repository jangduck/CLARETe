<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
    
    String cname = "";
%>

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/header.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/footer.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/shop/productDetail.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<script type="text/javascript" src="<%= ctxPath%>/js/myshop/goCartJson.js"></script>

<jsp:include page="../header.jsp"></jsp:include>

<section class="section1">
            <div class="product_all_container">
                <div class="product_img_container">
                    <div style="display: flex; gap: calc(2vw); width: var(--size930); height: auto; margin-bottom: 60px;">
                        <div class="product_main_img" style="background-image:url('/CLARETe/images/<c:out value="${requestScope.pvo.p_image}" />');"></div>
                        <ul class="product_sub_imgs">
                            <!-- 서브 이미지 -->
                            <li></li>
                            <li></li>
                            <!-- 서브 이미지 -->
                        </ul>
                    </div>

                    
               
                    <aside>
                        <div style="width: var(--size700); background-color: #D9D9D9;">
                   <img src="/CLARETe/images/<c:out value='${requestScope.pvo.p_detail_image}' />" 
                        alt="상세 이미지" 
                        style="width: 100%; height: auto;" />
               </div> <!-- 상품상세이미지가 들어설 자리입니다. -->

                        <div class="payment_info_box">
                            <div>상품 결제 정보</div>
                            <div style="line-height: 26px; font-size: 14px; margin-top: 20px; color: #6D6D6D; box-sizing: border-box; padding: 0px 15px;">
                     고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나 타인 명의의 주문 등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.<br>
                     <br>
                     무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.<br>
                     주문시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금, 입금되지 않은 주문은 자동으로 취소됩니다.
                            </div>
                        </div>
                        <div class="payment_info_box">
                            <div>교환 및 반품정보</div>
                            <div style="line-height: 26px; font-size: 14px; margin-top: 20px; color: #6D6D6D; box-sizing: border-box; padding: 0px 15px;">
                     교환 및 반품 주소<br>
                     -서울시 홍대입구역에서 내리면 바로 있는 쌍용강북센터 gclass<br>
                     <br>
                     교환 및 반품이 가능한 경우<br>
                     -상품을 공급받으신 날로부터 7일 이내, 트러블이나 제품 하자에 의한 교환, 반품은 20일 이내에 고객센터로 연락을 주셔야 합니다.<br>
                     -공급받으신 상품 및 용역의 내용이 표시, 광고의 내용과 다르거나 계약내용과 다르게 이행된 경우에는 그 재화 등 공급받은 날부터
                     3개월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.<br>
                     
                     교환 및 반품이 불가능한 경우<br>
                     -배송완료 후 7일이 지난 경우<br>
                     -포장을 개봉했거나 포장이 췌손되어 상품가치가 상실된 경우<br>
                     -고객님의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우 단, 향수 등의 경우 시용제품을 제공한 경우에 한 합니다.<br>
                     -시간의 경과에 의하여 재판매가 곤란한 정도로 상품 등의 가치가 현저히 감소한 경우<br>
                     -복제가 가능한 상품 등의 포장을 훼손한 경우<br>
                     (자세한 내용은 1대1 문의하기 게시판을 이용해 주시기 바랍니다.)<br>
                     <br>
                     *고객님의 마음이 바뀌어 교환, 반품을 하실 경우 상품 반송 비용은 고객님께서 부담하셔야 합니다.<br>
                     (색상 교환, 용량 교환 등 포함)
                            </div>
                        </div>
                        
                        
                        
                        <%-- ======================== 유진 작성함 ======================== --%>
                        <%-- 리뷰modal include 받아옴 --%>
                  <%-- <jsp:include page="./ReviewModal.jsp"></jsp:include> --%>                                        
                        <!-- 가능하면 include 해서 따로 뺀 후에 보기 좋게 구현 해주세요 -->
                       <div class="review_container"> 
                            <div>
                                <div>향수리뷰</div>
                                <div id="reviewWi">리뷰작성</div>
                            </div>
                                                        
                            <div class="review_box">
                                <ul class="reviewcontent"><!-- 리뷰 목록-->
                                
                                  <c:if test="${not empty requestScope.rvo}">
                           <c:forEach var="rvo" items="${requestScope.rvo}" varStatus="status">
                                       <li class="reveiwDetail">
                                          <div class="review-div">
                                             <span style="color:gray; font-size: 10pt; ">${rvo.fk_m_id}</span>                                        
                                         <span style="color:gray; font-size: 10pt;">작성일자 ${rvo.r_register}</span><br><!--별점이 들어가는 곳-->
                                         
                                         <c:choose>                                         
                                            <c:when test="${rvo.r_star == 1}"><span calss="reviewRank">★☆☆☆☆</span></c:when>
                                            <c:when test="${rvo.r_star == 2}"><span calss="reviewRank">★★☆☆☆</span></c:when>
                                            <c:when test="${rvo.r_star == 3}"><span calss="reviewRank">★★★☆☆</span></c:when>
                                            <c:when test="${rvo.r_star == 4}"><span calss="reviewRank">★★★★☆</span></c:when>
                                            <c:when test="${rvo.r_star == 5}"><span calss="reviewRank">★★★★★</span></c:when>                                         
                                         </c:choose>
                                                                                 
                                     </div>
                                     <div style="display: flex; align-items: center;">
                                          <div class="review-img"></div> <span class = "detail" >${rvo.r_msg}</span><div class="moreReview"></div><!--리뷰내용 [더보기]-->
                                     </div>
                                  <!-- 더보기를 누르면 더 자세한 리뷰가 나오게 한다.-->                            
                                  </li> <!-- 리뷰 내용 for문 돌려주시고 페이징처리 잊지마세요 -->
                                   </c:forEach>            
                        </c:if>  
                               <c:if test="${empty requestScope.rvo}">
                                      <li>등록된 리뷰가 없습니다.</li> <!-- 리뷰 없을 때 없다고 처리 꼭 해주세요 -->
                               </c:if>
                                                                      
                                </ul>
                            </div>
                        </div> <%-- <div class="review_container">  --%>
                        
                        <div style="display: flex; justify-content: space-between; margin-top: 60px;">
                            <span>처음</span>  <span>1  2  3  ... 19</span>  <span>끝</span>
                        </div>
                        <!-- 가능하면 include 해서 따로 뺀 후에 보기 좋게 구현 해주세요 -->
                    </aside>                    
                </div>
               <div class="toggleBack">
                  
               </div>
               <div class="toggleCon">
                  <div class="toggleinner">
                  <span id="x">&times;</span>
                  
                  <c:if test="${empty sessionScope.loginuser.m_id}">리뷰를 작성하시려면 로그인 해주세요.</c:if>
                   <c:if test="${!empty sessionScope.loginuser.m_id  or sessionScope.loginuser.m_id == 'admin' }"> 
                     <form name="reviewFrm"> 
                        <div class="toRow">
                            <span>작성자</span>
                            <span>
                            <%=session.getAttribute("id")%>
                            <input type="hidden"  name="fk_m_id" value="<%=session.getAttribute("id")%>"/> <%-- 작성자 id --%>
                            </span>
                        </div>    
                        <div class="toRow">
                            <span>리뷰 작성 상품</span>
                            <span>
                            <%=session.getAttribute("p_num")%>
                            <input type="hidden"  name="p_num" value="<%=session.getAttribute("p_num")%>"/> <%-- 작성 상품 id --%>
                            </span>
                        </div>  
                        <div class="toRow"> 
                           <span>별점을 선택해주세요</span>
                           <span>
                           <input type="hidden"  name="r_star" />  
                                <div class ="star_rating"> <%-- 작성 상품 별점 --%>                                 
                             <span class="star on" id="1"></span>
                             <span class="star" id="2"></span>
                             <span class="star" id="3"></span>
                             <span class="star" id="4"></span>
                             <span class="star" id="5"></span>                                                                                                             
                             <input type="hidden" name="r_star" value="1"></input>                                                 
                           </div>
                           </span>
                        </div>  
                        <div class="toRow">
                            <span>리뷰내용</span>
                            <textarea name="r_msg" id="r_msg" placeholder="리뷰내용을 입력하세요"></textarea>
                        </div>
                        <div id=btn>                     
                             <span><input type="button" id="btnSubmit" value="작성" class="btn btn-primary " onclick="ReviewUpload()" /></span>
                             <span><input type="reset" id="btnReset" class="btn" value="취소"/></span>
                         </div>                     
                    </form>
                  </c:if>                  
                 </div>
               </div><%-- <div class="toggleCon"> --%>
                <%-- ======================== 유진 작성함 ======================== --%>
            
            
            
                   <div class="productInfo_contaienr">
                   <form name="productFrm"> 
                   <input type="hidden" name="p_num" value="${requestScope.pvo.p_num}"/> <%-- === 상품 번호 input 자리 === --%>
                   <input type="hidden" name="m_id" value="${requestScope.m_id}"/> <%-- === 로그인한 사람 input 자리 비로그인시 0으로 나옴 === --%>
                       <div class="product_title"><c:out value="${requestScope.pvo.p_name}" /></div> <!-- 상품명이 들어설 자리입니다. -->
                       <div class="product_price"> 
                          <div class="consumerPrice">
                             <span>소비자가</span> <span>${requestScope.pvo.p_price}</span><span>원</span>
                          </div>
                           <span id="p_price">
                              <c:out value="${requestScope.pvo.discountPrice}" />
                           </span>
                           <span><input name="p_price" type="hidden" value="${requestScope.pvo.p_price}"/></span> <%-- === 상품 가격 input 자리 === --%>
                           <span>원</span> <!-- 상품가격이 들어설 자리입니다. -->
                           <span class="sale">-<c:out value="${requestScope.pvo.p_sale}" />%</span>
                       </div>
                       <div class="product_info">
                           <div>
                               <span>국내 · 해외배송</span><span>국내배송</span>
                           </div>
                           <div>
                               <span>배송방법</span><span>택배</span>
                           </div>
                           <div>
                               <span>배송비</span><span>3,000(20,000원 이상 구매 시 무료)</span>
                           </div>
                           <div>
                               <span>사용후기</span><span>116</span> <!-- 리뷰개수가 들어설 자리입니다. -->
                           </div>
                           <div>
                               <span>향수문의</span><span>67</span> <!-- 보류 -->
                           </div>
                           <div>
                               <span>예상 적립금</span><span>상품의 1%</span>
                           </div>
                       </div>
                       <div class="option_container">
                           <div>옵션 (용량)</div>
                           <div class="select-container">
                               <select name="selectOption"> <%-- === 상품 옵션 select 자리 === --%>
                                   <option value="" selected disabled hidden style="color: #7B7B7B;">- [필수] 옵션을 선택해 주세요 -</option> 
                                      <c:forEach var="ovo" items="${requestScope.ovo}">
                                         <c:choose>
                                            <c:when test="${ovo.op_ml eq '1'}">
                                               <option class="${ovo.op_price}" value="${ovo.op_num}">50ml / +${ovo.op_price}원</option>
                                            </c:when>
                                            <c:when test="${ovo.op_ml eq '2'}">
                                               <option class="${ovo.op_price}" value="${ovo.op_num}">75ml / +${ovo.op_price}원</option>
                                            </c:when>
                                            <c:otherwise>
                                               <option class="${ovo.op_price}" value="${ovo.op_num}">100ml / +${ovo.op_price}원</option>
                                            </c:otherwise>
                                         </c:choose>
                                      </c:forEach>
                               </select>
                           </div>
                       </div>
                       <div class="product_pricebox">
                           <span>TOTAL</span>
                           <span>
                               <span id="totalPrice">0<input type="hidden" name="totalPrice"/></span><!-- 전체 합산금액 -->
                               <span>원</span> 
                               <span>
                                   <span>(</span><span id="totalCnt">0</span><span>개)</span> <!-- 전체 개수 -->
                               </span>
                           </span>
                       </div>
                       <div class="product_btn_container">
                           <div onClick="goPurchaseProduct()">바로 구매하기</div>
                           <div onClick="goCart()">장바구니</div> <!-- 버튼 -->
                       </div>
                       
                       </form>
                   </div>
            
                
            </div>
        </section>
        
        <form name="goPurchase">
           <input type="hidden" name="p_num" value="${requestScope.pvo.p_num}" />
           <input type="hidden" name="op_num" value="" />
        </form>

<script>
    $(document).ready(function() {
       // === 가격 콤마처리 === //
        const priceElement = $('span#p_price');
        const consumer = $('body > section > div > div.productInfo_contaienr > form > div.product_price > div > span:nth-child(2)');
        
        let price = parseInt(priceElement.html());
        let numerconsumer = parseInt(consumer.html());
        
        priceElement.html(price.toLocaleString('en'));
        consumer.html(numerconsumer.toLocaleString('en'));
        // === 가격 콤마처리 === //
        
        
        // === select 태그 변경시 + 옵션가격 된 금액 표출 === //
        $('select[name="selectOption"]').change(function(){
           // console.log($(this).val());
           
           const selectOp = $('select[name="selectOption"] option:selected'); // 선택자 select태그 아래의 option 중 선택된 녀석을 잡음
           
           const classPrice = selectOp.attr('class'); // 위에서 선택된 녀석의 attr의 class를 불러옴
           
           const totalPrice = price + Number(classPrice); // 클래스가 매칭된 값이 즉 옵션의 가격이니 더해서 넣으면 끝
           
           // alert(totalPrice);
           $('input[name="totalPrice"]').val(totalPrice);
           
           $('span#totalPrice').html(totalPrice.toLocaleString('en')); // 대 ㅡ 시 ㅡ 진   
           $('span#totalCnt').html("1")
        }) // end of $('select[name="selectOption"]').change(function()------------
        // === select 태그 변경시 + 옵션가격 된 금액 표출 === //
        
        
        $('.star_rating > .star').click(function() {
        $(this).parent().children('span').removeClass('on');
        $(this).addClass('on').prevAll('span').addClass('on');
      })

        // 선택한 별점을 name에 담아주자 //
        $('.star_rating > .star').click(function(e) {
           const selectStar = $('.star');
           
           // alert(selectStar)
           // alert($(this).attr('id'));
            $('input[name="r_star"]').val($(this).attr('id'));
           
        $(this).parent().children('span').removeClass('on');
        $(this).addClass('on').prevAll('span').addClass('on');

      })      
        // 선택한 별점을 name에 담아주자 //
        
            
       $('div#reviewWi').click(function(){
            // alert('확인~');
                        
               $('.toggleBack').css({
                  'display': 'block'
               });
               
               $('.toggleCon').css({
                  'display': 'block'
               });                        
       });
    });
</script>
<jsp:include page="../footer.jsp"></jsp:include>