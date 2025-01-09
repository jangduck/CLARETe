package mypage.controller;

import java.util.List;

import cart.domain.CartVO;
import chaeeun.cart.model.CartDAO;
import chaeeun.cart.model.CartDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public class MypageCart extends AbstractController {
	CartDAO cdao = new CartDAO_imple();
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String m_id = loginuser.getM_id();
			
			List<CartVO> cartList = cdao.cartListCount(m_id);
			
			//System.out.println("cartList 길이 " + cartList.size());
			
			request.setAttribute("cartList",cartList.size());
			
			// 채은 코드 추가함....... (장바구니 보여주기 위한 코드)
			List<CartVO> cartList2 = cdao.selectCart(m_id);
			request.setAttribute("cartList2",cartList2);
			
		} 
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/mypage_cart.jsp");
	}

}
