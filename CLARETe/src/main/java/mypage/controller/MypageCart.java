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
import minkyu.product.model.ProductDAO;
import minkyu.product.model.ProductDAO_imple;
import product.domain.ProductVO;
public class MypageCart extends AbstractController {
	CartDAO cdao = new CartDAO_imple();
	private ProductVO pvo = new ProductVO();

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
			
			List<Integer> pnumList = (List<Integer>) session.getAttribute("pnumList");
			ProductDAO pdao = new ProductDAO_imple();
			List<ProductVO> pvoList = pdao.selectProduct(pnumList);
			Set<ProductVO> pvoSet = new HashSet<>(pvoList);
			pvoList = new ArrayList<>(pvoSet);
			request.setAttribute("pvoListCount", pvoList.size());
			
		} 
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/mypage_cart.jsp");
	}

}
