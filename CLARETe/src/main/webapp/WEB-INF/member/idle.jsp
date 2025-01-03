<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- css--%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/find.css" > 

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<script type="text/javascript">
  $(document).ready(function(){
     const method = "${requestScope.method}";
     
     console.log("~~~확인용 method : "+method);
     /*
        ~~~확인용 method : GET
        ~~~확인용 method : POST
     */
     
     if(method == "GET"){
     }
     
     if(method == "POST"){
        $('input:text[name="m_name"]').val("${requestScope.m_name}");
        $('input:text[name="m_mobile"]').val("${requestScope.m_mobile}");
        
     }
     
 	// 전화번호 입력 keydown 이벤트 처리
     $('input:text[name="m_name"]').bind("keydown", (e) => {

         if (e.keyCode == 13) {  // 암호입력란에 엔터를 했을 경우
         	goFind();  // 로그인 시도
         }
     });
 	
  // 성명 입력 keydown 이벤트 처리
     $('input:text[name="m_mobile"]').bind("keydown", (e) => {

         if (e.keyCode == 13) {  // 암호입력란에 엔터를 했을 경우
         	goFind();  // 로그인 시도
         }
     });
 	
     
     $('div.find_go').click(function(){
        goFind();
        const m_mobile = $("input[name='m_mobile']").val().trim(); // 입력된 휴대폰 번호 가져오기
        const m_name = $("input[name='m_name']").val().trim(); // 입력된 휴대폰 번호 가져오기
          dataObj = {"m_name":m_name,
        		"m_mobile":m_mobile,
               "certification_code":"${sessionScope.certification_code}"};
          console.log(dataObj);
      $.ajax({
         url:"smsSend.cl",
         type:"post",
         data:dataObj,
         dataType: "json",
         success:function(json) { 
        	 console.log(json);
              if(json.success_count == 1) {
                 alert("인증번호가 전송되었습니다.!!");   
              }
              else {
                 alert("인증번호 발송 실패!!");
              }
         },
         error: function(request, status, error) {
             alert("입력하신 이름과 전화번호가 일치하지 않습니다!!");
             location.href = "javascript:history.back()";
         }
      });
      
	     console.log("${sessionScope.certification_code}");

     }); // end of $('div.find_go').click(function(){})
     
     
  }); // end of $(document).ready(function(){})--------------- 
  
  // Function Declaration
  
  function goFind() {
     const m_name = $("input:text[name='m_name']").val().trim();
        
      if(m_name == "") {
         alert("성명을 입력하세요!!");
         return; // 종료
      }
      const m_mobile = $("input:text[name='m_mobile']").val();
      
      const regExp_m_mobile = new RegExp(/^010\d{8}$/i);  
      // 이메일 정규표현식 객체 생성 
         
      const bool = regExp_m_mobile.test(m_mobile);
      
      if(!bool) {
         // 전화번호가 정규표현식에 위배된 경우
         alert("전화번호를 올바르게 입력하세요!!");
       return; // 종료
      }    
      
      
      const frm = document.idFindFrm;
      frm.action = "<%= ctxPath%>/member/idle.cl";
      frm.method = "post";
      frm.submit();
      
  } // end of function goFind() {})---------------- 
  

</script>

<form name="idFindFrm">
   <div class="find_check_container">
           <div class="find_logo">
               LOGO
           </div>
           <div class="find_title">
               휴면 해제하기
           </div>
           <div class="input_box">
   
                   <input type="hidden" name="m_id"/>
               <div class="input_container">
                   <input type="text" name="m_name" placeholder="이름을 입력해주세요" />
                   <input type="text" name="m_mobile" placeholder="전화번호를 입력해주세요" />
               </div>

		<div class="Certification_number">
				<br>
				<input type="hidden" name="certification" placeholder="인증번호를 입력해주세요" />
			</div>
	
			<div class="find_go">
                   확인
               </div>
    <%--          <div class="find_go2" style="width: 333px; height: 48px; margin: 0 auto; margin-top: 28px;">
     			인증번호확인
   			</div> 
    --%>      </div>
       </div>
</form>






