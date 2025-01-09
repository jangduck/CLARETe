package mypage.controller;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cart.domain.CartVO;
import chaeeun.cart.model.CartDAO;
import chaeeun.cart.model.CartDAO_imple;
import common.controller.AbstractController;
import faq.domain.FaqVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import qna.domain.QnaVO;
import youjin.qna.model.QnaDAO;
import youjin.qna.model.QnaDAO_imple;

public class Mypage_ask extends AbstractController {

	private QnaDAO qdao = new QnaDAO_imple();
	CartDAO cdao = new CartDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String m_id = loginuser.getM_id();
		
		
		/*
		 * String method = request.getMethod(); // "GET" 또는 "POST"
		 * System.out.println(method);
		 * 
		 * if("GET".equalsIgnoreCase(method)) { // GET 방식이면 페이지 이동 안되게
		 * 
		 * // super.setRedirect(false);
		 * super.setViewPage("/WEB-INF/mypage/mypage_ask.jsp");
		 * 
		 * }
		 */
	
		
		try {
			request.setAttribute("m_id", m_id);
			
			
			
			List<CartVO> cartList = cdao.cartListCount(m_id);
			
			System.out.println("cartList: " + cartList);
			
			request.setAttribute("cartList",cartList);
			
			
//			=== 페이징 처리해주기 =============================================================
			
			String sizePerPage = request.getParameter("sizePerPage");
			String currentShowPageNo = request.getParameter("currentShowPageNo"); 
			
			
		//	아래에 있는 건 안 해도 됨!!!!!!!!
		//	List<QnaVO> qnaList = qdao.select_qna_nopaging();// 페이징 처리가 안 되어있는 모든 문의목록 보여주기
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			if(sizePerPage == null) {
				sizePerPage = "5";
			}
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("m_id", m_id);
			paraMap.put("sizePerPage", sizePerPage); 
			paraMap.put("currentShowPageNo", currentShowPageNo);
			
			
			int totalPage = qdao.getTotalPage(paraMap);//모든 1대1문의 총 페이지수
			
			try {
				if(Integer.parseInt(currentShowPageNo) > totalPage || Integer.parseInt(currentShowPageNo) <= 0 ) {
					currentShowPageNo = "1";
					paraMap.put("currentShowPageNo",currentShowPageNo);
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo",currentShowPageNo);
			}
			
			
			String pageBar ="";
			int blockSize = 5;
			//블럭당 보여지는 페이지의 번호 개수
			
			int loop = 1;
			// loop 는 1부터 증가하여 1개 블럭을 이루는 페이비번호의 개수까지만 증가하는 용도이다.
			
			int pageNo  = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1; 
			//pageNo 는 페이지바에서 보여지는 첫번째 번호이다
			
			
			// === !!! [맨처음][이전] 만들기 === *** //        
	        pageBar += "<li class='page-item'><a class='page-link' href='adminBoard.cl?sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";
	        
	        if(pageNo != 1) {
	        	pageBar += "<li class='page-item'><a class='page-link' href='adminBoard.cl?sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	        }
	        
	        while(!(loop > blockSize || pageNo > totalPage)) {
	        	if(pageNo == Integer.parseInt(currentShowPageNo)) {
	        		pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+ pageNo + "</a></li>";
	        	}
	        	else {
	        		pageBar += "<li class='page-item'><a class='page-link' href='mypage_ask.cl?sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+ pageNo + "</a></li>";
	        	}
	        	
	        	loop++; // 1 2 3 4 5 ...
	        	pageNo++; // 1 2 3 4 5 ...
			} // end of while
	        
	        // *** [다음][마지막] 만들기 *** //
			if (pageNo <= totalPage) { // 위의 while 문을 빠져나오면 pageNo 는 43으로 빠져나오기 때문에 <= 를 조건식으로 둔다.
				pageBar += "<li class='page-item'><a class='page-link' href='mypage_ask.cl?sizePerPage=" + sizePerPage + "&currentShowPageNo=" + pageNo
						+ "'>[다음]</a></li>";
			}

			pageBar += "<li class='page-item'><a class='page-link' href='mypage_ask.cl?sizePerPage=" + sizePerPage + "&currentShowPageNo=" + totalPage
					+ "'>[마지막]</a></li>";
			
			
	
				
			List<QnaVO> qnaList = qdao.select_qna_paging(paraMap);
			
			request.setAttribute("qnaList", qnaList);
			request.setAttribute("sizePerPage", sizePerPage);
			request.setAttribute("pageBar", pageBar);
			
			/* >>> 뷰단(adminBoard.jsp)에서 "페이징 처리시 보여주는 순번 공식" 에서 사용하기 위해 게시물의 총개수 알아오기 시작 <<< */
			int totalMemberCount = qdao.getTotalQnaCount(paraMap);
			
			request.setAttribute("totalMemberCount", totalMemberCount);
			request.setAttribute("currentShowPageNo", currentShowPageNo);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/mypage/mypage_ask.jsp");
			
		} catch(SQLException e) {
			e.printStackTrace();
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"index.cl"); ///error.up 은 없어서 일단 메인
		}
		
	
	}

}
