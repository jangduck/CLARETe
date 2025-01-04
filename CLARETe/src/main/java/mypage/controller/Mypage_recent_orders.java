package mypage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import chaeeun.order.model.OrderDAO;
import chaeeun.order.model.OrderDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import order.domain.OrderVO;
import orderdetail.domain.orderdetailVO;

public class Mypage_recent_orders extends AbstractController {

	private OrderDAO odao = new OrderDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginuser");
		String m_id = loginUser.getM_id();
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("m_id", m_id);

		// 로그인한 회원의 주문내역을 가져오는 메소드
		List<OrderVO> orderList = odao.recentOrder(paraMap);
		
		System.out.println("orderListsize"+ orderList.size());
		
        request.setAttribute("orderList", orderList);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/mypage_recent_orders.jsp");
		
		
		
		
	}

}
