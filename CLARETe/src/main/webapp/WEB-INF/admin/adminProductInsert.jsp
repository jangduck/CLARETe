<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
    String ctxPath = request.getContextPath();
%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 상품관리</title>
    <link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_header.css">
    <link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_section.css">
    <link rel="stylesheet" href="<%= ctxPath%>/css/admin/admin_insert.css">
    
    <!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 
	
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

</head>
<body class="allbody" style="background-color: #F1F5F9 !important; width: 100% !important;">
    
    <jsp:include page="adminheader.jsp"></jsp:include>
    
    <section>
        <div style="display: flex; flex-wrap: wrap;">
	        
	            <div class="first-div">
	            <%-- 
	            	<div style="display: flex; gap: 8px; flex-wrap: wrap;">
                        <div class="input-box">
                            <div><label for="userid">유저 아이디</label></div>
                            <div>
                                <input type="text" id="userid" name="userid" placeholder="유저 아이디를 입력하세요">
                            </div>
                        </div>
                        <div class="input-box">
                            <div><label for="userid">유저명</label></div>
                            <div>
                                <input type="text" id="userid" name="userid" placeholder="유저명을 입력하세요">
                            </div>
                        </div>
                    </div>
	            --%>
	            
		            <form name="myFrm" method="post" action="<%= ctxPath%>/admin/adminProductInsertGo.cl">
			            <table class="table">
			            	<tr>
			            		<th><label>상품명</label></th>
			            		<td><input type="text" name="p_name" placeholder="상품명" /></td>
			            	</tr>
			            	<tr>
			            		<th><label>카테고리</label></th>
			            		<td>
									<select name="p_season">
									   <option value="" selected disabled hidden style="color: #7B7B7B; !important">- 카테고리를 선택해 주세요 -</option>
									   <option value="1">봄</option>
									   <option value="2">여름</option>
									   <option value="3">가을</option>
									   <option value="4">겨울</option>
									</select>
								</td>
			            	</tr>
			            	
			            	<tr >
			            		<td>
			            		    <label id="optionadd">옵션추가하기</label>
			            		    <input type="text" name="option_select_name" />
			            		</td>		
			            		<td id="add"></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>제품설명</label></th>
			            		<td><input type="text" name="p_ex" placeholder="제품설명" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>가격</label></th>
			            		<td><input type="text" name="p_price" placeholder="가격" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>재고</label></th>
			            		<td><input type="text" name="p_inven" placeholder="재고" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>발매일</label></th>
			            		<td><input type="text" name="p_release" placeholder="발매일" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>할인률</label></th>
			            		<td><input type="text" name="p_sale" placeholder="할인률" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>성별</label></th>
			            		<td>
									<select name="p_gender">
									   <option value="" selected disabled hidden style="color: #7B7B7B; !important">- 성별을 선택해 주세요 -</option>
									   <option value="1">남자</option>
									   <option value="2">여자</option>
									</select>
								</td>
			            		
			            		
			            	</tr>
			            	
			            	<tr>
			            		<th><label>상품이미지</label></th>
			            		<td><input type="text" name="p_image" placeholder="상품이미지" /></td>
			            	</tr>
			            	
			            	<tr>
			            		<th><label>상품상세이미지</label></th>
			            		<td><input type="text" name="p_detail_image" placeholder="상품상세이미지" /></td>
			            	</tr>
			            </table>
			            <input type="submit" value="등록"/> <input type="reset" value="취소"/>
			            
			            
			            <input type="hidden" name="p_num" value="${requestScope.p_num}" />
			        </form>
	            
	            	
	            </div>
	            	
        </div>
        
    </section>

<script>

  $(document).ready(function(){
	
	let op_cnt = 0;
	let div_opt_length = 0;
	
	$('label#optionadd').click(function(e) {
		
		op_cnt++;  // 1  2  3  4
		
		if(div_opt_length < 3) {
			$('td#add').append(
					"<div class='opt'>"+
						"<label>옵션</label>" +
		        		"<span>" +
		        		"<select class='op_ml' name='op_ml"+op_cnt+"'>" +
						   "<option value='0' selected disabled hidden style='color: #7B7B7B; !important'>- 옵션을 선택해 주세요 -</option>" +
						   "<option value='1'>50ml</option>" +
						   "<option value='2'>75ml</option>" +
						   "<option value='3'>100ml</option>" +
						"</select>" +
						"<input type='text' name='op_price' placeholder='옵션 별 가격' />" +
						"<span class='op_close'>닫기</span>" +
						"</span>" +
					"</div>"
			);
			
			div_opt_length = $("td#add").find("div.opt").length; // 1  2  3
			
            ////////////////////////////////////////////////////////////////////////
			const select_list = $("td#add").find("div.opt").find("select.op_ml");
			
			let arr_select_name = [];
			
			select_list.each(function(idx, elmt){
				arr_select_name.push($(elmt).attr("name"));
			});
			
		//	alert(arr_select_name.join(","));
            ////////////////////////////////////////////////////////////////////////
		    
			$("input:text[name='option_select_name']").val(arr_select_name.join(","));
            
		} // end of if(div_opt_length < 3)--------------------------------	
	
		
		
	}); // end of $('.optionadd').click(function(e)--------
	
	$(document).on('click', 'span.op_close', function(e){
	 //	op_cnt--;
	 //	const idx = $('.op_close').index(this);
		//alert(idx)
		// $('div.opt').eq(idx).remove();
		// alert(op_cnt)
		
		$(e.target).parent().parent().remove();
		div_opt_length = $("td#add").find("div.opt").length; // 1  2  3
		
		////////////////////////////////////////////////////////////////////////
		const select_list = $("td#add").find("div.opt").find("select.op_ml");
		
		let arr_select_name = [];
		
		select_list.each(function(idx, elmt){
			arr_select_name.push($(elmt).attr("name"));
		});
		
	//	alert(arr_select_name.join(","));
        ////////////////////////////////////////////////////////////////////////
		
		$("input:text[name='option_select_name']").val(arr_select_name.join(","));
		
	}); // end of $(document).on('click', '.op_close', function(e)-------
	
   });// end of $(document).ready(function(){})------------------------------------
	
</script>
</body>
</html>