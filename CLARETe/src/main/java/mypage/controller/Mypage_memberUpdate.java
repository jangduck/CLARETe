package mypage.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import cart.domain.CartVO;
import chaeeun.cart.model.CartDAO;
import chaeeun.cart.model.CartDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import product.domain.ProductVO;
import minkyu.product.model.ProductDAO;
import minkyu.product.model.ProductDAO_imple;

public class Mypage_memberUpdate extends AbstractController {
	
	
	CartDAO cdao = new CartDAO_imple();
	private ProductVO pvo = new ProductVO();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		if (super.checkLogin(request)) {

			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			// Get m_id from the request or fallback to the session
			String m_id = request.getParameter("m_id");
			if (m_id == null || m_id.trim().isEmpty()) {
				m_id = loginuser != null ? loginuser.getM_id() : null;
			}
			
			request.setAttribute("m_id", m_id);
			System.out.println("로그인유저: " + (loginuser != null ? loginuser.getM_id() : "null"));
			System.out.println("m_id 확인: " + m_id);
			if (loginuser != null && loginuser.getM_id().equals(m_id)) {
				// User ID matches
				super.setViewPage("/WEB-INF/mypage/mypage_memberUpdate.jsp");
			} else {
				// User ID mismatch or loginuser is null
				String message = "다른 회원의 정보는 변경이 불가합니다!";
				String loc = "javascript:history.back()";

				request.setAttribute("message", message);
				request.setAttribute("loc", loc);

				super.setViewPage("/WEB-INF/msg.jsp");
			}

		} else {
			// Not logged in
			String message = "로그인 후 정보변경이 가능합니다.";
			String loc = request.getContextPath() + "/login/loginView.cl";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
		String method = request.getMethod();// Get 또는 Post
		
		if("GET".equalsIgnoreCase(method)) {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String m_id = loginuser.getM_id();
			
			List<CartVO> cartList = cdao.cartListCount(m_id);
			
			//System.out.println("cartList: " + cartList);
			
			request.setAttribute("cartList",cartList.size());
			
			List<Integer> pnumList = (List<Integer>) session.getAttribute("pnumList");
			ProductDAO pdao = new ProductDAO_imple();
			List<ProductVO> pvoList = pdao.selectProduct(pnumList);
			Set<ProductVO> pvoSet = new HashSet<>(pvoList);
			pvoList = new ArrayList<>(pvoSet);
			request.setAttribute("pvoListCount", pvoList.size());
			
		} 
	}
}