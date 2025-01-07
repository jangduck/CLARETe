package cart.controller;

import chaeeun.order.model.OrderDAO;
import chaeeun.order.model.OrderDAO_imple;
import chaeeun.product.model.ProductDAO_imple;
import common.controller.AbstractController;
import delivery.domain.DeliveryVO;
import delivery.model.DeliveryDAO;
import delivery.model.DeliveryDAO_imple;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import option.domain.OptionVO;
import order.domain.OrderVO;
import product.domain.*;

public class OneOrderComplete extends AbstractController {

	private DeliveryDAO ddao = new DeliveryDAO_imple();
	private OrderDAO odao = new OrderDAO_imple();
	private ProductDAO_imple pdao = new ProductDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();

		String d_num = String.valueOf(session.getAttribute("one_d_num"));
		String p_num = String.valueOf(session.getAttribute("one_pnum"));
		String pnum = String.valueOf(session.getAttribute("pnumpnum"));	//채번 (주문번호)
		String op_num = String.valueOf(session.getAttribute("op_num"));
		
		// 배송지 select
		DeliveryVO one_dvo = ddao.selectOneDelivery(d_num);
		request.setAttribute("dvo", one_dvo);
		
		// 주문 select
		OrderVO one_ovo = odao.selectOrder(pnum);
		request.setAttribute("ovo", one_ovo);

		// 주문상세 select
		//orderdetailVO odvo = odao.selectOrdrDetail(pnum);
		
		// 상품 select
		ProductVO one_pvo = pdao.selectProduct(p_num);
		request.setAttribute("pvo", one_pvo);
		
		// 옵션 select
		OptionVO one_opvo = pdao.selectOption(op_num);
		request.setAttribute("opvo", one_opvo);
		
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		System.out.println("세션 포인트 : " + loginuser.getM_point());
		System.out.println("차감 포인트 : " + session.getAttribute("one_m_point"));
		System.out.println("증가 포인트(1%) : " + session.getAttribute("one_o_price"));
		
		loginuser.setM_point(loginuser.getM_point() - Integer.parseInt(String.valueOf(session.getAttribute("one_m_point"))));	// 사용한 포인트만큼 차감
		
		super.setRedirect(false);
	    super.setViewPage("/WEB-INF/cart/oneOrderComplete.jsp");

	}

}
