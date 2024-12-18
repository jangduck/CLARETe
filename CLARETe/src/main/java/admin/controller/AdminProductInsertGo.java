package admin.controller;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.domain.ProductVO;
import yihun.prodect.model.*;

public class AdminProductInsertGo extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();

		if("post".equalsIgnoreCase(method)) {
			
			ProductDAO pdao = new ProductDAO_imple();
			
			String p_name = request.getParameter("p_name");
			String p_season = request.getParameter("p_season");
			String p_ex = request.getParameter("p_ex");
			String p_price = request.getParameter("p_price");
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
			
			// 상품등록을 해주는 메소드
			int n = pdao.insertProduct(pvo);
			
			if(n == 1) {
				// 삽입 성공
				System.out.println("성공");
			}
			else {
				// 삽입 실패
				System.out.println("실패");
			}
			
		}
		else {
			System.out.println("get으로는 들어오면 안됨!");
		}
		
	}

}
