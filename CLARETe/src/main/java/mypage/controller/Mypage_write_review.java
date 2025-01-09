package mypage.controller;

import java.sql.SQLException;
import youjin.review.model.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cart.domain.CartVO;
import chaeeun.cart.model.CartDAO_imple;
import chaeeun.member.model.MemberDAO;
import chaeeun.member.model.MemberDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import review.domain.ReviewVO;
import youjin.review.model.ReviewDAO;
import youjin.review.model.ReviewDAO_imple;


public class Mypage_write_review extends AbstractController {
	private ReviewDAO rdao = new ReviewDAO_imple();
	CartDAO_imple cdao = new CartDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
			HttpSession session = request.getSession();
			
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String m_id = loginuser.getM_id();

			String method = request.getMethod();
			
			if("get".equalsIgnoreCase(method)) {
				
				// String fk_m_id = request.getParameter("fk_m_id");
				//System.out.println("나 서블릿!~ = "+m_id);
							
				try {
					List<ReviewVO> myreviewUpList = rdao.myreviewUpList(m_id);
					request.setAttribute("myreviewUpList", myreviewUpList);
					
					//System.out.println("리뷰작성 가능한 상품 몇개? "+ myreviewUpList.size());
					
					List<CartVO> cartList = cdao.cartListCount(m_id);
					
					//System.out.println("cartList: " + cartList);
					
					request.setAttribute("cartList",cartList.size());

					super.setRedirect(false);
					super.setViewPage("/WEB-INF/mypage/mypage_write_review.jsp");
				
					
					// System.out.println("아이디값 받옴"+fk_m_id);
				} catch(SQLException e) {
					e.printStackTrace();
					super.setRedirect(true);
					super.setViewPage(request.getContextPath()+"index.cl"); ///error.up 은 없어서 일단 메인
				
					
					
				}
			}

	
	}

}
