package jihye.mypage.controller;

import java.util.List;

import common.controller.AbstractController;
import delivery.domain.DeliveryVO;
import delivery.model.DeliveryDAO;
import delivery.model.DeliveryDAO_imple;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public class DeleteDelivery extends AbstractController {

	DeliveryDAO ddao = new DeliveryDAO_imple();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();// GET 또는 POST

		if ("POST".equalsIgnoreCase(method)) {

			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			//DeliveryVO dvo = new DeliveryVO();
			

			String m_id = loginuser.getM_id(); 
			String d_address = request.getParameter("d_address");
			String d_num = request.getParameter("d_num");
			
			//dvo.setD_address("d_address");
			
			int n = ddao.DeleteDelivery(m_id, d_address);


			super.setRedirect(false);
			super.setViewPage("/WEB-INF/mypage/mypage_delivery_detail.jsp");

		}

	}

}
