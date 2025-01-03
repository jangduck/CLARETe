package admin.controller;

import java.io.File;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import member.domain.MemberVO;
import product.domain.ProductVO;
import yihun.prodect.model.*;

public class AdminProductUpdateGo extends AbstractController {

	ProductDAO pdao = new ProductDAO_imple();
	
	private String extractFileName(String partHeader) {
		for(String cd : partHeader.split("\\;")) {
			if(cd.trim().startsWith("filename")) {
				String fileName = cd.substring(cd.indexOf("=") + 1).trim().replace("\"", ""); 
				int index = fileName.lastIndexOf(File.separator); // File.separator 란? OS가 Windows 이라면 \ 이고, OS가 Mac, Linux, Unix 이라면 / 을 말하는 것이다.       
				return fileName.substring(index + 1);
			}
		}
		return null;
	}// end of private String extractFileName(String partHeader)-------------------
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// System.out.println("수정하러 들어옴");
		
		String method = request.getMethod();

		// == 관리자(admin)로 로그인 했을 때만 제품등록이 가능하도록 한다. == //
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser != null && "admin".equals(loginuser.getM_id()) ) {
		
			if("post".equalsIgnoreCase(method)) {
				// 상품수정 가보자잇 레츠기릿!
				
					
				// 1. 첨부되어진 파일을 디스크의 어느 경로에 업로드 할 것인지 그 경로를 설정해야 한다.  
				ServletContext svlCtx = session.getServletContext();
				String uploadFileDir = svlCtx.getRealPath("/images");
					
					
				String p_image = null;
			    String p_detail_image = null;
			    
			    
			    int idx_attach = 0;
			    
			    Collection<Part> parts = request.getParts();
			    
			    for(Part part : parts) {
			    	
			    	if(part.getHeader("Content-Disposition").contains("filename=")) {
			    		
			    		String fileName = extractFileName(part.getHeader("Content-Disposition"));
			    		
			    		if(part.getSize() > 0) {
			    			String newFilename = fileName.substring(0, fileName.lastIndexOf(".")); // 확장자를 뺀 파일명 알아오기  
				    		newFilename += "_"+String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance()); 
				    		newFilename += System.nanoTime();
				    		newFilename += fileName.substring(fileName.lastIndexOf(".")); // 확장자 붙이기 
				    		
				    		part.write(uploadFileDir + File.separator + newFilename);	
				    		
				    		part.delete();
						     
						    if("p_image".equals(part.getName())) {
						    	p_image = newFilename;
							}
							     
							else if("p_detail_image".equals(part.getName())) {
								p_detail_image = newFilename;
							}
						     
			    		} // end of if(part.getSize() > 0)--------
			    		
			    	} // end of if(part.getHeader("Content-Disposition").contains("filename="))-----
			    	
			    	else { // form 태그에서 전송되어온 것이 파일이 아닐 경우
					       String formValue = request.getParameter(part.getName());
					//     System.out.printf("파일이 아닌 경우 파라미터(name)명 : %s, value : %s \n"
					//		                 , part.getName(), formValue);
				    }
			    }// end of for(Part part : parts)---------------	
					
					
				//////////////////////////////////////////// 파일 받기 끝
					
					
					
				int p_num = Integer.parseInt(request.getParameter("p_num"));
				String p_season = request.getParameter("p_season");
				String p_name = request.getParameter("p_name");
				int p_price = Integer.parseInt(request.getParameter("p_price"));
				int p_inven = Integer.parseInt(request.getParameter("p_inven"));
				String p_ex = request.getParameter("p_ex");
				String p_sale = request.getParameter("p_sale");
				int p_gender = Integer.parseInt(request.getParameter("p_gender"));
				
				// 입력받은 이미지가 null일 경우(걍 입력 안 했을 경우) 기존 이미지를 넣을 거임 //
				String or_p_image = request.getParameter("or_p_image");
				String or_p_detail_image = request.getParameter("or_p_detail_image");
				// 입력받은 이미지가 null일 경우(걍 입력 안 했을 경우) 기존 이미지를 넣을 거임 //
				
				// System.out.println(p_gender+" 성별 넘버 "+p_num);
				
				ProductVO pvo = new ProductVO();
				
				pvo.setP_num(p_num);
				pvo.setP_name(p_name);
				pvo.setP_season(p_season);
				pvo.setP_ex(p_ex);
				pvo.setP_price(p_price);
				pvo.setP_inven(p_inven);
				pvo.setP_sale(p_sale);
				pvo.setP_gender(p_gender);
				pvo.setP_image(p_image);
				pvo.setP_detail_image(p_detail_image);	
				
				try {
				// 상품을 수정해주는 메소드
				int n = pdao.productUpdate(pvo, or_p_image, or_p_detail_image);
				
				int result = 0;
				
				if(n == 1) {
					// 삽입 성공
					System.out.println("성공");
					result = 1;
					
					//super.setRedirect(false);
					//super.setViewPage("/WEB-INF/admin/adminProductList.jsp"); 
					
					JSONObject jsonObj = new JSONObject();  // {}
					jsonObj.put("result", result);
					
					String json = jsonObj.toString(); // 문자열로 변환 
					request.setAttribute("json", json);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/jsonview.jsp");
				}
				
				if(n == -1) {
					String message = "옵션등록에 오류가 발생하였습니다.";
					String loc = "javascript:history.back()";  // 자바스크립트를 이용한 이전페이지로 이동하는 것. 
				
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				
				
				} catch (SQLException e) {
					e.printStackTrace();
					
					String message = "상품등록에 실패하였습니다.";
					String loc = "javascript:history.back()";  // 자바스크립트를 이용한 이전페이지로 이동하는 것. 
				
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
			
			}
		}
		else {
			// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우 
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
