package mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import minkyu.order.model.OrderDAO;
import minkyu.order.model.OrderDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import order.domain.OrderVO;

import java.util.List;

import cart.domain.CartVO;
import chaeeun.cart.model.CartDAO;
import chaeeun.cart.model.CartDAO_imple;

public class Mypage_recent_orders extends AbstractController {

	private OrderDAO odao = new OrderDAO_imple();
	CartDAO cdao = new CartDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginuser");
		String m_id = loginUser.getM_id();
	//	String select = request.getParameter("select");
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("m_id", m_id);

	//	int currentYear = Calendar.getInstance().get(Calendar.YEAR); // 현재 년도 가져오기
    //    System.out.println(currentYear);

		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String m_id2 = loginuser.getM_id();
		
		List<CartVO> cartList = cdao.cartListCount(m_id2);
		
		//System.out.println("cartList: " + cartList);
		
		request.setAttribute("cartList",cartList.size());
        
		// 로그인한 회원의 주문내역을 가져오는 메소드
		List<OrderVO> orderList = odao.recentOrder(paraMap);
		
//		System.out.println("orderListsize"+ orderList.size());
//		System.out.println("orderList: " + orderList);

        request.setAttribute("orderList", orderList);
	//	request.setAttribute("select", String.valueOf(currentYear));
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/mypage_recent_orders.jsp");
		
	}

}
