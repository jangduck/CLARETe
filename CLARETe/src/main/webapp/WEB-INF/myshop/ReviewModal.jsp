 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%
	String ctxPath = request.getContextPath();
    //    /MyMVC
%>
 
<!-- Bootstrap CSS 
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > -->


<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<!-- Optional JavaScript 
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> -->

<style>

body{
    margin: 0;
    padding: 0;
}


/* .reveiwContainer{
    border: solid 1px gray;
} */

.reviewHeader{
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    margin: 10px 0;
}

.reviewWrite{
    display: inline-block;
    font : 20pt;
    color: rgb(53, 53, 156);
    text-decoration: none;
}


.reviewTitle >span {
    font : 20pt;
    display: inline-block;
    padding: 3px;
}

hr{
    color: 3px solid black;  
}

ul{
  list-style: none; 
  margin: 30px 0;
  padding: 0; 
  
}

.review-div{
    width: 100%;
    display: flex;
    justify-content: flex-start; /* 왼쪽 정렬 */
    align-items: center;
    margin-bottom: 10px;
}

.review-div span {
    display: inline-block;
}

li.reveiwDetail{
    padding: 30px 0;
    border-top: 1px solid gray;
    font-size: 16px;
}

li.reveiwDetail:last-child{
    border-bottom: 1px solid gray;
}

.review-img{
    width: 50px;
    height: 50px;
    border: 1px solid gray;
    margin-top: 20px;
    background-color: gray;
    padding: 10px;
    margin-right: 10px;
}


.review-bottom{
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;

    margin: 20px 0;
}


/*  아래부턴 리뷰 작성  css 입니다!  */

#click{
    position: fixed;
	z-index: 99;
	top: 0;
	left: 0;
	width:100%;
	height:100vh;
	background-color: black;
	opacity: 0.2;
}


#review-frm{
	width: 733px;
	height: auto;
	background-color: white; 
	padding : 17.4%;
}

#reviewFrm{
    position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%,-50%);
	
	z-index: 199;
}

.essential{
    font-weight: bold;
    color: rgb(224, 10, 2);
}

#infotitle{
    display: inline-block;
    width: 140px;
    height: 48px;
    background-color: rgba(217, 217, 217, 1);
    line-height: 48px;
}


#review-input{
    display: inline-block;
    width: 333px;
    height: 48px;
    border-radius: 5px;
    border: 1px solid gray
}

#reveiwInsertStar{
    display: inline-block;
    font-size: 20pt;

}

.success,.cancel{
    display: inline-block;
    width: 100px; 
    padding: 10px;
    background-color: #ffff;
    border: #ffff;
    font-size: 16pt;
}

.success:hover{
    border-radius: 5px;
    background-color: rgb(71, 218, 127);
}
.cancel:hover{
    border-radius: 5px;
    background-color: rgb(233, 101, 101);
}

.info-li{
    margin-top: 15px;
}


</style>

<script type="text/javascript">
$(document).ready(function(){

    $("div.review_Insert").hide();

    $("button.reviewWrite").click(function(){
        $("div.review_Insert").show();

      
    });

    $("button.toggleColse").click(function(){
        $("div.review_Insert").hide();
    });

	
	
	
	
	
	$("a#ReviewUpload").click( e => {
		 	    
		   const p_num = $(e.target).parent().find("input.p_num").val();  
		   /*const p_num = $(e.target).closest("div").find("input.p_num").val(); */
		   /*  const p_num = $(e.target).parent().children("#p_numvalue").text(); */	 
		   const frm = document.reviewUpload_frm;
		   frm.p_num.value = p_num;
		   alert(p_num);

		   
		   window.open('',form.target,'width=300,height=200,scrollbars=yes');
		  /*  frm.target = "blankifr";*/	   
		   frm.action = "<%= ctxPath%>/review/reviewUpload.cl";
		   frm.method = "post";
		   frm.submit();		   		   
	  });
	 
	<%--  
	  
	  function ReviewUpload(){
			
		  $("a#ReviewUpload").click( e => {
			var pop_title = "ReviewUpload" ;
			
			const p_num = $(e.target).parent().find("input.p_num").val();  
			window.open("", ReviewUpload);
			frm.p_num.value = p_num;
			 
			 
			var frmData = document.reviewUpload_frm;
			frm.target = ReviewUpload;
			frm.action = "<%= ctxPath%>/review/reviewUpload.cl";
			frm.method = "post";
			frm.submit();
		  });
			
			  --%>
		}
	



	
});// end of $(document).ready(function(){})------------


</script>

<form name="reviewUpload_frm">
		<input class="p_num" name="p_num" value="${requestScope.pvo.p_num}" />
		<input type="hidden" name="goBackURL"  value="${requestScope.currentURL}"/>
		<input type="submit" id="ReviewUpload" href="<%= ctxPath%>/review/reviewUpload.cl" onClick="ReviewUpload()" value="제출">
</form>    

 <iframe name='blankifr' style='display:none;'></iframe>

 

						 <%-- ****** 리뷰작성하기 Modal 시작 ******
						<div class="modal fade" id="ReviewUpload" data-backdrop="static">
						<div class="modal-dialog">
						      <div class="modal-content" style="width: 600px !important;">
						      
						        <!-- Modal header -->
						        <div class="modal-header">
						       
						       
						       
						          <h4 class="modal-title">리뷰등록</h4>
						          <div><input class="p_num" name="p_num" value="${requestScope.pvo.p_num}" /></div>
						          
						          
						          
						          <button type="button" class="close ReviewUploadClose" data-dismiss="modal">&times;</button>
						        </div>
						        
						        <!-- Modal body -->
						        <div class="modal-body">
						          <div id="askUpload">
						             <iframe id="iframe_ReviewUpload" src="<%= ctxPath%>/review/reviewUpload.cl"> 
						             </iframe>
						          </div>
						        </div>
						        
						        <!-- Modal footer -->
						        <div class="modal-footer">
						          <button type="button" class="btn btn-danger askUploadClose" data-dismiss="modal">Close</button>
						        </div>
						      </div>
						      
						    </div>
						  </div>
						
						<%-- ****** 리뷰작성하기 Modal 끝 ****** --%>
						
 
    <div class = "reveiwContainer"><!-- 리뷰 목록을 감싸주는 컨테이너 -->
        <div class = "reviewHeader"><!--향수리뷰(제목)와 리뷰 작성이 들어가는 곳 -->
            <div class="reviewTitle"><span>향수리뷰</span></div><!--리뷰시작-->
            <button type="button" class="reviewWrite">리뷰작성</a></div><!-- 클릭시 리뷰 작성 토글이 켜짐-->
           
        </div>

        <hr>
        <div class="reveiwInventory">
        
        <ul class="reviewcontent"><!-- 리뷰 목록-->

            <li class="reveiwDetail"><!-- 리뷰 내용-->
                <div class="review-div">
                    <span calss="reviewRank">[★★★☆☆]</span>
                    <span style="color:gray; font-size: 10pt;">작성일자 2025.01.01</span><br><!--별점이 들어가는 곳-->
                </div>
                <div style="display: flex; align-items: center;">
                     <div class="review-img">img</div><!-- 리뷰 이미지 --> <span class = "detail" >리뷰가 들어가는 곳...</span><div class="moreReview">[더보기]</div><!--리뷰내용-->
                </div>
                <!-- 더보기를 누르면 더 자세한 리뷰가 나오게 한다.-->
            </li>

            <li class="reveiwDetail"><!-- 리뷰 내용-->
                <div class="review-div">
                    <span calss="reviewRank">[★★★★☆]</span>
                    <span style="color:gray; font-size: 10pt;">작성일자 2025.01.01</span><br><!--별점이 들어가는 곳-->
                </div>
                <div style="display: flex; align-items: center;">
                    <div class="review-img">img</div><!-- 리뷰 이미지 -->   <span class = "detail" >리뷰가 들어가는 곳...</span><div class="moreReview">[더보기]</div><!--리뷰내용-->
                </div>
                 <!-- 더보기를 누르면 더 자세한 리뷰가 나오게 한다.-->
            </li>

            <li class="reveiwDetail"><!-- 리뷰 내용-->
                <div class="review-div">
                    <span calss="reviewRank">[★★☆☆☆]</span>
                    <span style="color:gray; font-size: 10pt;">작성일자 2025.01.01</span><br><!--별점이 들어가는 곳-->
                </div>
                <div style="display: flex; align-items: center;">
                    <div class="review-img">img</div><!-- 리뷰 이미지 -->  <span class = "detail" >리뷰가 들어가는 곳... </span><div class="moreReview">[더보기]</div><!--리뷰내용--> 
                </div>
                 <!-- 더보기를 누르면 더 자세한 리뷰가 나오게 한다.-->
            </li>


            <li class="reveiwDetail"><!-- 리뷰 내용-->
                <div class="review-div">
                    <span calss="reviewRank">[★☆☆☆☆]</span>
                    <span style="color:gray; font-size: 10pt;">작성일자 2025.01.01</span><br><!--별점이 들어가는 곳-->
                </div>
                <div style="display: flex; align-items: center;">
                <div class="review-img">img</div><!-- 리뷰 이미지 -->  <span class = "detail" >리뷰가 들어가는 곳...</span><div class="moreReview">[더보기]</div><!--리뷰내용--> 
                </div> 
                 <!-- 더보기를 누르면 더 자세한 리뷰가 나오게 한다.-->
            </li>

            <li class="reveiwDetail"><!-- 리뷰 내용-->
                <div class="review-div">
                    <span calss="reviewRank">[★★★★★]</span>
                    <span style="color:gray; font-size: 10pt;">작성일자 2025.01.01</span><br><!--별점이 들어가는 곳-->
                </div>
                <div style="display: flex; align-items: center;">
                    <div class="review-img"> img </div><!-- 리뷰 이미지 -->   <span class = "detail" >리뷰가 들어가는 곳...</span><div class="moreReview">[더보기]</div><!--리뷰내용-->
                </div>    
                <!-- 더보기를 누르면 더 자세한 리뷰가 나오게 한다.-->
            </li>
                
        </ul>

        <hr>
        
        <div class="review-bottom"><!-- 페이징이 들어갈 곳 -->
            <div class="page-start"><span>처음</span></div>
            <div class = "page-num"><span> 1  2  3  4  5....20</span></div>
            <div class="page-last"><span>끝</span></div>
        </div>
        </div>


        

   </div>
   <!--리뷰 작성을 누르게 되면 나오는 부분 따로 잘라서 리뷰 쪽에 붙이시면 될 거 같습니다!--> 
   <div class="review_Insert">
    <div id="click"></div>
    <div id="reviewFrm">
        <form id="review-frm" name="frm">
            <div style="text-align: right;">
                <h4>
                    <!-- 해당 버튼을 누르면 토글창이 닫힙니다 JS에서 hide와  show를 사용하면 됩니다 -->
                    <button type="button" class="toggleColse" style="border:#ffff; background-color:#ffff; color:black; font-size: 30px;">
                    x
                    </button>
                </h4>
            </div>
            <div class="review_info_title" style="margin-bottom: 15px;">
                <h2>리뷰 작성하기</h2>
            </div>
        
            <ul style="margin-top: 5%;">
                <li class="info-li">
                    <label id="infotitle">별점<label class="essential">*</label></label>
                    <span id="reveiwInsertStar">☆☆☆☆☆</span><!--리뷰별점을 넣는 곳-->
                </li>

                <li class="info-li">
                    <label id="infotitle">리뷰작성<label class="essential">*</label></label>
                    <input type="text" name="eview-text" class="review-text" id="review-input"><!--리뷰 내용을 작성하는 곳-->
                </li>

                <li class="info-li">
                    <label id="infotitle">사진첨부<label class="essential">*</label></label>
                    <input input type="file" name="pimage1" class="infoData img_file" accept='image/*' /><!--리뷰 사진을 첨부하는 곳-->
                </li>
                <li class="info-li">
                    <label  id="infotitle">이미지 미리 보기</label>
                    <div id="review-input" style="position: relative; top:16px;"></div>
                    <!-- 사진 첨부에서 넣은 파일을 미리보기 하는 부분입니다. MyMVC에 있는 productRegister 부분을 참고해주세요 -->
                </li>
                <li class="info-li" style="margin-top: 20px;">
                    <input type="button" class="success" value="작성">
                    <input type="reset" class="cancel" value="취소">
                </li>
            </ul>
        </form>
    </div>
</div>				
						
						 
                        <div style="display: flex; justify-content: space-between; margin-top: 60px;">
                            <span>처음</span>  <span>1  2  3  ... 19</span>  <span>끝</span>
                        </div>
                        
      						  					
      						  					
      						  					      
						  
						                        