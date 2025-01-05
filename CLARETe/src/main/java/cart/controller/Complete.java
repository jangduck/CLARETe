package cart.controller;

import common.controller.AbstractController;
import delivery.domain.DeliveryVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import order.domain.OrderVO;
import orderdetail.domain.orderdetailVO;
import delivery.model.*;

import java.util.List;

import chaeeun.order.model.*;

public class Complete extends AbstractController {

	private DeliveryDAO ddao = new DeliveryDAO_imple();
	private OrderDAO odao = new OrderDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		HttpSession session = request.getSession();
		String d_num = (String) session.getAttribute("fk_d_num");		// 배송지번호
		String pnum = (String) session.getAttribute("pnum");		// 주문번호


		// 배송지 select
		DeliveryVO dvo = ddao.selectOneDelivery(d_num);
		request.setAttribute("dvo", dvo);
		
		
		// 주문 select
		OrderVO ovo = odao.selectOrder(pnum);
		request.setAttribute("ovo", ovo);
		
		
		// 주문상세 select
		//List<orderdetailVO> odvoList = odao.selectOrderDetail(pnum);
		//request.setAttribute("odvoList", odvoList);
		
		
		
		super.setRedirect(false);
	    super.setViewPage("/WEB-INF/cart/orderComplete.jsp");

	}

}