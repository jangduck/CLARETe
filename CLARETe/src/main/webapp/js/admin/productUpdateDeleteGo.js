/**
 * 
 */

$(document).ready(function(){

	// const p_num = $('input.update').val();
	// const listSize = $('input[name="listSize"]').val();
	
	
	// ====================== 수정 버튼 ====================== //
	$('button#updateGo').click(function(e){
		// 클릭했을 때 해당 상품의 정보를 읽어옴
		
		$('select#season').empty();
		$('select#season').selectpicker('destroy');
		
		$('select#gender').empty();
		$('select#gender').selectpicker('destroy');
		
		const p_num = $(e.target).next().val()
		
		$.ajax({
			url:"updateProductJSON.cl",
			data:{"p_num":p_num},
			type: "post",
			dataType:"json",
			success:function(json){
				
				// ===== 값 변환 ===== //
				let season;
				let gender;
				
				if((json.p_season) == 1){
					season = "봄"
				}
				else if((json.p_season) == 2){
					season = "여름"
				}
				else if((json.p_season) == 3){
					season = "가을"
				}
				else if((json.p_season) == 4){
					season = "겨울"
				}			
				
				if((json.p_gender) == 0){
					gender = "공용"
				}
				else if((json.p_gender) == 1){
					gender = "남성"
				}
				else if((json.p_gender) == 2){
					gender = "여성"
				}
				// ===== 값 변환 ===== //
				

				$('input#pnum').val(`${json.p_num}`);
				$('span#pnum').html(`${json.p_num}`);
				$('select#season').selectpicker();
				
				
				// 모든 옵션 제거 후 초기화
				$('select#season').empty();

				// 기본 옵션 추가
				$('select#season').append(`
				  <option value="" selected disabled style="color: #7B7B7B;">- 카테고리를 선택해 주세요 -</option>
				  <option value="1">봄</option>
				  <option value="2">여름</option>
				  <option value="3">가을</option>
				  <option value="4">겨울</option>
				`);

				// 새 값 설정
				$('select#season').val(`${json.p_season}`).selectpicker('refresh');

				
				//$('select#season').val(`${json.p_season}`).selectpicker('refresh');
				// $('#season').selectpicker('refresh');
				$('input#name').val(`${json.p_name}`);
				$('input#price').val(`${json.p_price}`);
				$('input#inven').val(`${json.p_inven}`);
				$('td#register').html(`${json.p_register}`);
				$('td#release').html(`${json.p_release}`);
				$('input#sale').val(`${json.p_sale}`);
				$('td#gender').html(gender);
				
				
				$('select#gender').selectpicker();
				
				// 모든 옵션 제거 후 초기화
				$('select#gender').empty();

				// 기본 옵션 추가
				$('select#gender').append(`
				  <option value="" selected disabled style="color: #7B7B7B;">- 성별 선택해 주세요 -</option>
				   <option value="0">공용</option>
				   <option value="1">남자</option>
				   <option value="2">여자</option>
				`);

				// 새 값 설정
				$('select#gender').val(`${json.p_gender}`).selectpicker('refresh');
				
				
				$('textarea#ex').val(`${json.p_ex}`);
				$('img#previewImg').attr('src', "/CLARETe/images/"+`${json.p_image}`);
				
				$('input[name="or_p_image"]').val(`${json.p_image}`);
				
				$('img#previewImg2').attr('src', "/CLARETe/images/"+`${json.p_detail_image}`);
				
				$('input[name="or_p_detail_image"]').val(`${json.p_detail_image}`);
			},
			complete: function() {
				// 로딩 애니메이션 종료
				$('#loading').hide();
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}

		})
		
	}) // end of $('button#updateGo').click(function(e)--------------------
	// ====================== 수정 버튼 ====================== //
	
	
	
	
	
	
	//====================== 삭제 버튼 ====================== //
	$('button#deleteGo').click(function (e) {
	    // 폼 찾기
	    let myFrm = $(e.target).closest('form')[0]; // document.deleteFrm 안 먹힘,, 물어보니 form이 많아서 그렇다고 함
	    let p_num = $(myFrm).find('input[name="deletePnum"]').val(); 

	    if (confirm("정말로 상품번호 " + p_num + "번을 삭제하시겠습니까?")) {
	        if (myFrm) {
	            // alert("폼 찾음");

	            // 폼 속성 설정
	            myFrm.method = "POST";
	            myFrm.action = "adminProductDeleteGo.cl"; // 서버 URL
	            myFrm.submit(); // 폼 제출
	        } else {
	            alert("폼을 찾을 수 없습니다. 삭제를 진행할 수 없습니다.");
	        }
	    } else {
	        alert("삭제를 취소하셨습니다.");
	    }
	});
	// ====================== 삭제 버튼 ====================== //
	
	
	
	// ====================== 일괄삭제 버튼 ====================== //
	$('button#checkDeleteGo').click(function (e) {
		// alert('일괄삭제~');
		
		let arr_check_name = [];
		
		const ch = $('input:checkbox');
		
		// alert(ch.parent().next().html())
		
		ch.each(function(idx, elmt){
			// console.log($(elmt).prop('checked'));
			// console.log($(elmt).attr('name'));
			
			const chName = $(elmt).next().attr('name');
			
			if($(elmt).prop('checked')){
				arr_check_name.push(chName);
			}
			
			
		}); // end of ch.each(function(idx, elmt)--------
		
		const s_check_name = arr_check_name.join(",");
		// alert(s_check_name);
		
		$('input[name="allPnumarr"]').val(s_check_name);
		
		if($('input[name="allPnumarr"]').val() != ''){
			alert('값 넘깁니다!?')
			
			const Frm = document.allDeleteFrm;
			
			Frm.action = "adminProductDeleteAllGo.cl";
			Frm.method = "post"
			Frm.submit();
			
		}
		else{
			alert('삭제할 상품의 체크박스를 체크해주세요.')
		}
		
		
	});
	// ====================== 일괄삭제 버튼 ====================== //
	
	
	
	
	
	
	
	// ======================== 유효성 검사 ======================== //
	// 상품명 유효성 검사 //
	$('.p_name_error').hide();
	let name_bool = false;
	
	$('input:text[name="p_name"]').blur(function(){
		if($(this).val().trim() == ''){
			$('.p_name_error').show();
			$(this).focus();
			$(this).val('');
		}
		else{
			$('.p_name_error').hide();
			name_bool = true;
		}
	});
	// 상품명 유효성 검사 //
	
	
	
	// 상품설명 유효성 검사 //	
	$('.p_ex_error').hide();
	let ex_bool = false;
	
	$('textarea[name="p_ex"]').blur(function(){
		if($(this).val().trim() == ''){
			$('.p_ex_error').show();
			$(this).focus();
			$(this).val('');
		}
		else{
			$('.p_ex_error').hide();
			ex_bool = true;
		}
	});
	// 상품설명 유효성 검사 //	
	
	
	
	// 상품금액 유효성 검사 //	
	$('.p_price_error').hide();
	let price_bool = false;
	
	$('input:text[name="p_price"]').blur(function(){
		if($(this).val().trim() == '' || !(solution($(this).val()))){
			$('.p_price_error').show();
			$(this).focus();
			$(this).val('');
		}
		else{
			$('.p_price_error').hide();
			price_bool = true;
		}
	});
	// 상품금액 유효성 검사 //
		
		
		
	// 상품재고 유효성 검사 //	
	$('.p_inven_error').hide();
	let inven_bool = false;
	
	$('input:text[name="p_inven"]').blur(function(){
		if($(this).val().trim() == '' || !(solution($(this).val()))){
			$('.p_inven_error').show();
			$(this).focus();
			$(this).val('');
		}
		else{
			$('.p_inven_error').hide();
			inven_bool = true;
		}
	});
	// 상품재고 유효성 검사 //
	// ======================== 유효성 검사 ======================== //
		
	
}); // end of $(document).ready(function()-----------



// 숫자만 있는지 체크하는 함수
function solution(s) {
	 var regex = /^[0-9]*$/; // 숫자만 체크
	 if(regex.test(s)){
	     return true;
	 }else{
	     return false;
	 }
}