package admin.controller;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import product.domain.ProductVO;
import yihun.option.model.OptionDAO;
import yihun.option.model.OptionDAO_imple;
import yihun.prodect.model.ProductDAO;
import yihun.prodect.model.ProductDAO_imple;

public class AdminProductDeleteGo extends AbstractController {

	ProductDAO pdao = new ProductDAO_imple();
	OptionDAO odao = new OptionDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();

		// == 관리자(admin)로 로그인 했을 때만 제품삭제가 가능하도록 한다. == //
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser != null && "admin".equals(loginuser.getM_id()) ) {
			
			if("post".equalsIgnoreCase(method)) {
				
				String p_num = request.getParameter("deletePnum");
				// System.out.println("어서와~ " + p_num);
				
				// 상품을 삭제해주는 메소드
				int n = pdao.productDelete(p_num);
				
				if(n == 1) {
					String message = "삭제가 완료되었습니다.";
					String loc = request.getContextPath() + "/admin/adminProduct.cl";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				else {
					String message = "삭제에 실패하였습니다.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				
			}
			else {
				// get으로 들어올 경우 페이지 이동
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/admin/adminProduct.jsp"); 
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
