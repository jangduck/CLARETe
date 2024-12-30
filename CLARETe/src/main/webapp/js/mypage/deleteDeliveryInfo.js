$(document).ready(function(){

	$("div.delivery_delete").hide();
	$("button.delivery_info_delete").click(function(){
		$("div.delivery_delete").show();
		});
		
		$("input.btn_no_delete").click(function(){
			$("div.delivery_delete").hide();
	});
	
});//end of $(document).ready(function(){})===========================================

function goDeleteDelivery(){
	
	console.log("클릭됨");
	

	const deletefrm = document.frm;
	console.log("deletefrm : ",deletefrm);
	
	deletefrm.action = "deleteDelivery.cl";
	deletefrm.method = "post";
	deletefrm.submit();
	
}// end of function goDeleteDelivery()