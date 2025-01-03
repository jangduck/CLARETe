$(document).ready(function(){

	$("div.delete_toggle_on").hide();
	
	$(".delivery_info_delete").click(function(){
		$("div.delete_toggle_on").show();
		});
		
		$("input.deleteBtncancel").click(function(){
			$("div.delete_toggle_on").hide();
	});
	
});//end of $(document).ready(function(){})===========================================



function goDeliveryDel() {
    // 삭제 버튼이 포함된 div에서 d_num 값을 가져오기
    const parentDiv = event.target.closest('.delivery-content-box');
    const dNumInput = parentDiv.querySelector('.deliveryD_num');
    const d_num = dNumInput.value;

    // AJAX를 사용해 삭제 요청 보내기
	if(confirm(`배송지를 삭제하시겠습니까?`)){
	    fetch('deleteDelivery.cl', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/x-www-form-urlencoded',
	        },
	        body: `d_num=${encodeURIComponent(d_num)}`
	    })
	    .then(response => response.json())
	    .then(data => {
	        if (data.n == 1) {
	            alert('삭제가 성공적으로 완료되었습니다.');
	            location.reload(); // 페이지 새로고침으로 리스트 갱신
	        } 
			
			else {
	            alert('삭제에 실패했습니다.');
				location.reload();
	        }
	    })
	    .catch(error => {
	        console.error('삭제 요청 중 오류 발생:', error);
	        alert('오류가 발생했습니다.');
	    });
	}
	
}
