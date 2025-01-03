<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<%
	String ctxPath = request.getContextPath();
    //    /MyMVC
%>

 
<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 


<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/review/reviewUpload.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script> 

<%-- 직접 만든 JS --%>    
<script type="text/javascript" src="<%= ctxPath%>/js/review/reviewUpload.js"></script>



<div id="container">



	    <%-- 
	        <form name="reviewFrm">        
	               <table style="padding-top:50px" align=center border=0 cellpadding=2>
	                                        
	                            <table class="table2">    	                            
	                            <tr>
	                            	<td>	                            	
	                            		<select id="r_star" name="r_star">			                            	
			                            	<option value="1">★</option>
			                            	<option value="2">★★</option>
			                            	<option value="3">★★★</option>
			                            	<option value="4">★★★★</option>
			                            	<option value="5">★★★★★</option>	                            	                            			                            				               			                            	
			                            </select>			                         
			                        </td>
	                            </tr>
	                         	         
                                <tr>
                                    <td>리뷰 내용</td>
                                    <td><textarea name="r_msg" id="r_msg" placeholder="내용을 입력하세요"></textarea></td>
                                	
                                </tr>                              	                                                              
	                            </table>
	                             
	                            <div id=btn>                     
		                            <span><input type="button" id="btnSubmit" value="등록" class="btn btn-primary " onclick="ReviewUpload()" /></span>
	                 				<span><input type="reset"  class="btn" value="취소"/></span>
                 				</div>   
								
								<input type="text"  name="fk_m_id" value="<%=session.getAttribute("id")%>"/>						
								<input type="text"  name="p_num" value="<%=session.getAttribute("p_num")%>"/>
								
								<!-- style="display:none;"  -->
						       		          
	                        </td>
	                    </tr>
	                </table>         
	        </form>
	        --%>
	        
	        <!--리뷰 작성을 누르게 되면 나오는 부분 따로 잘라서 리뷰 쪽에 붙이시면 될 거 같습니다!--> 
    
	        
	        
	    </div>

