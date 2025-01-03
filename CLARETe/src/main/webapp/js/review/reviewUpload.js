function ReviewUpload(){

	const frm = document.reviewFrm;
		frm.action = "/CLARETe/review/reviewUpload.cl";
		frm.method = "post";
		frm.submit();
		
}
