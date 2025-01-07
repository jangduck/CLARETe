package jihye.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cart.domain.CartVO;
import chaeeun.cart.model.CartDAO;
import chaeeun.cart.model.CartDAO_imple;
import minkyu.order.model.OrderDAO;
import minkyu.order.model.OrderDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import order.domain.OrderVO;

public class MyPage extends AbstractController {
	
	CartDAO cdao = new CartDAO_imple();
	OrderDAO odao = new OrderDAO_imple();
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();// Get 또는 Post
		
		if("GET".equalsIgnoreCase(method)) {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String m_id = loginuser.getM_id();
			
			List<CartVO> cartList = cdao.cartListCount(m_id);
			
			System.out.println("cartList: " + cartList);
			
			request.setAttribute("cartList",cartList);
			
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("m_id", m_id);
			// 로그인한 회원의 주문내역을 가져오는 메소드
			List<OrderVO> orderList = odao.recentOrder(paraMap);
			request.setAttribute("orderList", orderList);
		} 
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/mypage_main.jsp");
		
		
		}
}
	


