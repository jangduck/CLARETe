package qna.controller;

import java.sql.SQLException;
import java.util.List;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import qna.domain.QnaVO;
import youjin.qna.model.QnaDAO;
import youjin.qna.model.QnaDAO_imple;

public class QnaAnswerBoard extends AbstractController {

	private QnaDAO qdao = new QnaDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		// == 관리자(admin)로 로그인 했을 때만 회원조회가 가능하도록 해야 한다. == //
				HttpSession session = request.getSession();

		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		if (loginuser != null && "admin".equals(loginuser.getM_id())) {
			// 관리자(admin) 로 로그인 했을 경우
		
			String method = request.getMethod(); // "GET" 또는 "POST"
			System.out.println(method);
		
			if("GET".equalsIgnoreCase(method)) {			
				// GET 방식이면 페이지 이동 안되게
						
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/qna/qnaAnswerBoard.jsp");
			
			} 
			try {
				List<QnaVO> qnaList = qdao.qnaList();
				request.setAttribute("qnaList", qnaList);
				
				super.setRedirect(false);		
				super.setViewPage("/WEB-INF/qna/qnaAnswerBoard.jsp");
				
			} catch(SQLException e) {
				e.printStackTrace();
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"index.cl");
			}
			
		}
		else {
			// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");

		}
		
		
	}

}
