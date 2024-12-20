package admin.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import option.domain.OptionVO;
import product.domain.ProductVO;
import yihun.prodect.model.*;

public class AdminProductInsertGo extends AbstractController {

	ProductDAO pdao = new ProductDAO_imple();
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();

		if("post".equalsIgnoreCase(method)) {	
			
			
			/////////////////////////////////////////////////////////////////////////////////
			OptionVO opVO = new OptionVO();
			Map<String, String> paraMap = new HashMap<>();
			
			String option_select_name = request.getParameter("option_select_name");
			
			if(option_select_name != null && !option_select_name.isBlank() ) {
				
				String[] arr_option_select_name = option_select_name.split(",");
				
				for(int i=0; i<arr_option_select_name.length; i++) {
				//	System.out.println(arr_option_select_name[i]);
					
					String yongyang = request.getParameter(arr_option_select_name[i]);
					System.out.println(yongyang);
					
					paraMap.put("yongyang", yongyang);
					
				}// end of for-------------------------
				
			}
			//////////////////////////////////////////////////////////////////////////////////
			
			String p_name = request.getParameter("p_name");
			String p_season = request.getParameter("p_season");
			String p_ex = request.getParameter("p_ex");
			int p_price = Integer.parseInt(request.getParameter("p_price"));
			int p_inven = Integer.parseInt(request.getParameter("p_inven"));
			String p_release = request.getParameter("p_release");
			String p_sale = request.getParameter("p_sale");
			int p_gender = Integer.parseInt(request.getParameter("p_gender"));
			String p_image = request.getParameter("p_image");
			String p_detail_image = request.getParameter("p_detail_image");
			
			ProductVO pvo = new ProductVO();
			
			pvo.setP_name(p_name);
			pvo.setP_season(p_season);
			pvo.setP_ex(p_ex);
			pvo.setP_price(p_price);
			pvo.setP_inven(p_inven);
			pvo.setP_release(p_release);
			pvo.setP_sale(p_sale);
			pvo.setP_gender(p_gender);
			pvo.setP_image(p_image);
			pvo.setP_detail_image(p_detail_image);	
			
			try {
				// 상품등록을 해주는 메소드
				int n = pdao.insertProduct(pvo);
				
				if(n == 1) {
					// 삽입 성공
					// System.out.println("성공");
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/admin/adminProductList.jsp"); 
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
		else {
			// get으로 들어올 경우 insert페이지로 이동
			ProductVO pvo = new ProductVO();
			
			pvo = pdao.selectSeq();
			
			int p_num = pvo.getP_num();
			
			request.setAttribute("p_num", p_num);
			
			super.setViewPage("/WEB-INF/admin/adminProductInsert.jsp"); 
		}
		
	}

}
