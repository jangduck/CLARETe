package cart.controller;

import common.controller.AbstractController;
import delivery.domain.DeliveryVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import delivery.model.*;

public class Complete extends AbstractController {

	private DeliveryDAO ddao = new DeliveryDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		HttpSession session = request.getSession();
		String d_num = (String) session.getAttribute("fk_d_num");
		String shipping = (String) session.getAttribute("shipping");
		//String p_num = (String) session.getAttribute("p_num");
		//String o_cnt = (String) session.getAttribute("o_cnt");
		
		System.out.println("배송지번호 과연~~~~~" + d_num);
		System.out.println("배송비 과연~~~~~" + shipping);
		//System.out.println("주문번호 과연~~~" + p_num);
		//System.out.println("주문개수 과연~~~" + p_num);
		
		
		
		// 배송지 출력하기
		DeliveryVO dvo = ddao.selectOneDelivery(d_num);
		request.setAttribute("dvo", dvo);
		
		
		super.setRedirect(false);
	    super.setViewPage("/WEB-INF/cart/orderComplete.jsp");

	}

}