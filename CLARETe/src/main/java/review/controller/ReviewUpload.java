package review.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import qna.domain.QnaVO;
import review.domain.ReviewVO;
import youjin.review.model.*;
	

public class ReviewUpload extends AbstractController {
	
	private ReviewDAO rdao = new ReviewDAO_imple();
		
		@Override
		public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			String method = request.getMethod(); // "GET" 또는 "POST"
			System.out.println(method);
			
			
			/* ReviewVO rvo = rdao.ReviewUploadview(p_num); */
			
			/*
			  String p_num = request.getParameter("p_num"); 
			  ReviewVO rvo = new ReviewVO();
			  rvo.setFk_p_num(Integer.parseInt(p_num));
			  System.out.println("p_num = "+p_num);
			  
			  
			 */
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/review/reviewUpload.jsp");
			
			if("POST".equalsIgnoreCase(method)) {	
				// GET 방식이면 페이지 이동 안되게
				
				
				
				/* int p_num = Integer.parseInt(request.getParameter("p_num")); */
				
							
				String goBackURL = request.getParameter("goBackURL");
											
				/*
				  String p_num = request.getParameter("p_num");
				 int r_star = Integer.parseInt(request.getParameter("r_star"));
				 */
				
				String p_num = request.getParameter("p_num");
				String fk_m_id = request.getParameter("fk_m_id");
				/* int p_num = Integer.parseInt(request.getParameter("p_num")); */		
			    System.out.println("p_num = "+p_num);
				String r_star = request.getParameter("r_star");					
				String r_msg = request.getParameter("r_msg");
				
				

				ReviewVO rvo = new ReviewVO(); 
				rvo.setFk_m_id(fk_m_id);
				rvo.setFk_p_num(Integer.parseInt(p_num));
				/* rvo.setFk_p_num(p_num); */
				rvo.setR_star(Integer.parseInt(r_star));
				rvo.setR_msg(r_msg);
				
				/*   
				
				
				rvo.setR_star(r_star);
				*/
				  
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/review/reviewUpload.jsp");
				
				
				String message = "";
				String loc = "";
				
				try {
					int n = rdao.ReviewUpload(rvo);
					
					if (n == 1) {	
						message = "리뷰가 등록되었습니다.";
						loc = request.getContextPath()  + "/index.cl";			   		    
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
					message = "리뷰 등록에 실패했습니다.";
					loc = "javascript:history.back()";		// JS를 이용한 이전페이지로 이동하는 것
				}
			
				//super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");	
			}
				
				
				
				
				
				
				
				
				
				
				
			
		}
}
