package jihye.mypage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import cart.domain.CartVO;
import chaeeun.cart.model.CartDAO;
import chaeeun.cart.model.CartDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import minkyu.order.model.OrderDAO;
import minkyu.order.model.OrderDAO_imple;
import minkyu.product.model.ProductDAO;
import minkyu.product.model.ProductDAO_imple;
import order.domain.OrderVO;
import product.domain.ProductVO;

public class MyPage extends AbstractController {
	
	CartDAO cdao = new CartDAO_imple();
	private OrderDAO odao = new OrderDAO_imple();
	private ProductVO pvo = new ProductVO();
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();// Get 또는 Post
		
		if("GET".equalsIgnoreCase(method)) {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String m_id = loginuser.getM_id();
			
			List<CartVO> cartList = cdao.cartListCount(m_id);
			
			
			//System.out.println("dddddddcartList: " + cartList.size()); 
			
			request.setAttribute("cartList",cartList.size());
			
			
			// === 민규 코드 마이페이지 메인 최근 주문 상품코드 === //
			// 로그인한 회원의 주문내역을 가져오는 메소드
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("m_id", m_id);
			List<OrderVO> orderList = odao.recentOrder(paraMap);
			
			// 4개만 전송하도록 처리
			List<OrderVO> mypageMainOrder = new ArrayList<>();
			for (int i = 0; i < Math.min(4, orderList.size()); i++) {
				mypageMainOrder.add(orderList.get(i));
			}
			request.setAttribute("orderList", mypageMainOrder);
			
			
			
			// === 민규 코드 마이페이지 메인 최근 본 상품 코드 === //
			List<Integer> pnumList = (List<Integer>) session.getAttribute("pnumList");

			ProductDAO pdao = new ProductDAO_imple();
			// 최근 본 상품 조회하는 리스트
			List<ProductVO> pvoList = pdao.selectProduct(pnumList);

			// Set을 사용하여 중복 제거
			Set<ProductVO> pvoSet = new HashSet<>(pvoList);

			// Set을 다시 List로 변환
			pvoList = new ArrayList<>(pvoSet);

			// 4개만 전송하도록 처리
			List<ProductVO> mypageMainshow = new ArrayList<>();
			for (int i = 0; i < Math.min(4, pvoList.size()); i++) {
			    mypageMainshow.add(pvoList.get(i));
			}

			// 4개만 담은 리스트를 request에 설정
			request.setAttribute("pvoList", mypageMainshow);

			// === 민규 코드 마이페이지 메인 최근 본 상품 코드 === //
			
			request.setAttribute("pvoListCount", pvoList.size());
			//System.out.println("최근본상품 개수 : " + pvoList.size());
		} 
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/mypage_main.jsp");
		
		}
}
	


