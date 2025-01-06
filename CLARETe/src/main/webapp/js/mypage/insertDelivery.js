$(document).ready(function(){
	$("div.delivery_Insert").hide(); 
	$("span.error").hide();
	
	$("button#toggleButton").click(function(){
		//console.log("~~~~확인용 클릭함.");
		$("div.delivery_Insert").show();
	});
	
	$("button.toggleColse").click(function(){
		$("div.delivery_Insert").hide();
	})
	
	
	 $("input.d_name").blur((e)=>{
		const d_name = $("input.d_name").val().trim();
			
			if(d_name == ""){
				
				$(".delivery_Insert :input").prop("disabled", true);
	            $(e.target).prop("disabled", false);
	            $(e.target).val("").focus();

				        //  $(e.target).next().show();
				        //  또는
				         $(e.target).parent().find("span.error").show();
			}
			
			else{
				$(".delivery_Insert :input").prop("disabled", false);
				  $(e.target).parent().find("span.error").hide();
			}
	 });
	
	 
	 
	
	//------------------- 이름 부분 ------------------------------- //
	
	///^[ㄱ-ㅎ가-힣a-zA-Z0-9]+$/
	
	$("input.d_monbile").blur((e)=>{
		
		const regExp__d_mobile = /^[ㄱ-ㅎ가-힣a-zA-Z]+$/ //한국어나 일본어가 들어갔을때
		const bool = regExp__d_mobile.test($(e.target).val());
		
		if(bool){
			
			$(e.target).prop("disabled", false);
			$(e.target).val("").focus();
			$(e.target).parent().find("span.error").show();
		}		
		
		else{
			$(".delivery_Insert :input").prop("disabled", false);
		    $(e.target).parent().find("span.error").hide();
		}
	
	});
	
	
	
	
	//----------------- 전화번호가 한국어나 영어 들어갔는지 확인----------------------------------//
	
	$("input.d_postcode").blur((e) => {
		
		
		const regExp_postcode = /^\d{5}$/;//우편번호가 5글자 
		const bool = regExp_postcode.test($(e.target).val());
		
		if(!bool){
			$(e.target).prop("disabled", true);
			$(e.target).val("").focus();
			$(e.target).parent().find("span.error").show();
		}
		
		else{
			$(".delivery_Insert :input").prop("disabled", false);
			$(e.target).parent().find("span.error").hide();
			}
		
	});
	
	//-------------------- 우편번호 -------------------------------//
	
	
	$("input.d_address").blur((e)=>{
		const d_addresss = $("input.d_address").val().trim();
		
		if(d_addresss == ""){
			
			$(".delivery_Insert :input").prop("disabled", true);
			            $(e.target).prop("disabled", false);
			            $(e.target).val("").focus();

						        //  $(e.target).next().show();
						        //  또는
						         $(e.target).parent().find("span.error").show();
					}
					
		else{
			$(".delivery_Insert :input").prop("disabled", false);
			  $(e.target).parent().find("span.error").hide();
		}
			
	});
	//--------------------------- 주소 공백 --------------------------//
	
	
	$("input.d_detailaddress").blur((e)=>{
		
		const d_detailaddress = $("input.d_detailaddress").val().trim();
		
		if(d_detailaddress == "")		{
					
		$(".delivery_Insert :input").prop("disabled", true);
		            $(e.target).prop("disabled", false);
		            $(e.target).val("").focus();

			        //  $(e.target).next().show();
			        //  또는
			         $(e.target).parent().find("span.error").show();
				}
				
		else{
			$(".delivery_Insert :input").prop("disabled", false);
			$(e.target).parent().find("span.error").hide();
		}
		
	});
	
	//------------------- 상세주소 공백 --------------------- //
	
	$("input.d_extra").blur((e)=>{
		
		const d_extra = $("input.d_extra").val().trim();
		
		if(d_extra == ""){
			$(e.target).prop("disabled",  true);
            $(e.target).val("").focus();

	        //  $(e.target).next().show();
	        //  또는
	         $(e.target).parent().find("span.error").show();
		}
							
		else{
			$(".delivery_Insert :input").prop("disabled", false);
			$(e.target).parent().find("span.error").hide();
		}
		
	});
	
	// ==== "우편번호찾기"를 클릭했을 때 이벤트 처리하기 ==== //
	       $(".PostCodeFind").click(function(){
	           new daum.Postcode({
	               oncomplete: function(data) {
	                   // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	       
	                   // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                   // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                   let addr = ''; // 주소 변수
	                   let extraAddr = ''; // 참고항목 변수
	       
	                   //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                   if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                       addr = data.roadAddress;
	                   } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                       addr = data.jibunAddress;
	                   }
	       
	                   // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                   if(data.userSelectedType === 'R'){
	                       // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                       // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                       if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                           extraAddr += data.bname;
	                       }
	                       // 건물명이 있고, 공동주택일 경우 추가한다.
	                       if(data.buildingName !== '' && data.apartment === 'Y'){
	                           extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                       }
	                       // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                       if(extraAddr !== ''){
	                           extraAddr = ' (' + extraAddr + ')';
	                       }
	                       // 조합된 참고항목을 해당 필드에 넣는다.
	                       document.getElementById("extra").value = extraAddr;
	                   
	                   } 
					   
					   else {
	                       document.getElementById("extra").value = '';
	                   }
	       
	                   // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                   document.getElementById("postcode").value = data.zonecode;
	                   document.getElementById("address").value = addr;
	                   // 커서를 상세주소 필드로 이동한다.
	                   document.getElementById("detailaddress").focus();
	               }
	           }).open();
	           
	        // 주소를 비활성화 로 만들기
	        //  $("input#address").attr("disabled", true);
	       
	        // 참고항목을 비활성화 로 만들기
	        //  $("input#extraAddress").attr("disabled", true);

	        // 주소를 쓰기가능 으로 만들기
		      //  $("input#address").removeAttr("readonly");
	       
	        // 참고항목을 쓰기가능 으로 만들기
	        //  $("input#extraAddress").removeAttr("readonly");
	       
	        // 주소를 활성화 시키기
	        //	$("input#address").removeAttr("disabled");
	       
	        // 참고항목을 활성화 시키기
	        //  $("input#extraAddress").removeAttr("disabled");    

	       });// end of $("img#zipcodeSearch").click(function(){})--------
		   	
		   
}); // end of (document).ready(function(){})=======================================



function goInsertDelivery(){

	  
	  // alert('das')
      //console.log("확인용 클릭");
  	   // ** == 문항들이 입력 되어있는지 확인 검사 시작. ==** //
      let d_deliveryInfo = true; // 입력된 값이 있다 true
  	   
  	   console.log($("input.d_deliveryInfo"));

      $("input.d_deliveryInfo").each(function(index, elmt){
          const data = $(elmt).val().trim();

          if(data==""){ //입력이 공백일 경우
              alert("표시 항목을 전부 입력 해주세요.");
              d_deliveryInfo = false; // 값이 없다.

              return false; // break 라는 뜻이다.
          }
      if(!d_deliveryInfo){ //d_deliveryInfo 가 참일 경우
              return;// 함수를 종료 시킨다.
      }
  	}); // end of ("input.d_deliveryInfo").each(function(index, elmt){})-------------------------------------------------------

  	// ** == 문항들이 입력 되어있는지 확인 검사 끝. ==** //

  	// *** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 *** //
  	let d_addressInfo = true;

  	const arr_addressInfo = [];
  	arr_addressInfo.push($("input[name='d_postcode']"));
  	arr_addressInfo.push($("input[name='d_address']"));
  	arr_addressInfo.push($("input[name='detail']"));
  	arr_addressInfo.push($("input[name='extra']"));


  	for(let i=0; i<arr_addressInfo.length; i++){
  	    if(arr_addressInfo==""){
  	        alert("주소를 입력하세요!")
  	        d_addressInfo = false;
  	        break;
  	    }//end of if(arr_addressInfo==""){}---------------------------------------------
  	}//end of for(let i=0; i<arr_addressInfo.length; i++){}-------------------------------------------------------

  	if(!arr_addressInfo){
  	    return;// 함수를 종료한다.
  	}
  	// *** 우편번호 및 주소에 값을 입력했는지 검사하기 끝 *** //

  	const frm = document.frm;
  	frm.action = "insertDelivery.cl";
  	frm.method = "post";
  	frm.submit();
	

	};
	
	

  
  
  
