
$(document).ready(function(){

    $("div.review_Insert").hide();

    $("button.reviewWrite").click(function(){
        $("div.review_Insert").show();
    
    });

    $("button.toggleColse").click(function(){
        $("div.review_Insert").hide();
    });

   
	function ReviewUpload(){
   		$("input.success").click( e => {             
	         const p_num = $(e.target).parent().find("input.p_num").val();  
	         /*const p_num = $(e.target).closest("div").find("input.p_num").val(); */
	         /*  const p_num = $(e.target).parent().children("#p_numvalue").text(); */    
	         const frm = document.reviewUpload_frm;
	         frm.p_num.value = p_num;
	         /*alert(p_num);*/
	
	         
	         //window.open('',form.target,'width=300,height=200,scrollbars=yes');
	        /*  frm.target = "blankifr";*/      
	         frm.action = "<%= ctxPath%>/review/reviewUpload.cl";
	         frm.method = "post";
	         frm.submit();                  
     	});
	 };
 /*
     
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
         
          
      }
	  */



   
});// end of $(document).ready(function(){})------------


