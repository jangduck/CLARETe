package admin.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

import youjin.qna.model.*;

public class AdminAnswer extends AbstractController {

	private QnaDAO qdao = new QnaDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();

		// == 관리자(admin)로 로그인 했을 때만 제품등록이 가능하도록 한다. == //
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser != null && "admin".equals(loginuser.getM_id()) ) {
		
			if("post".equalsIgnoreCase(method)) {
				
				String q_num = request.getParameter("q_num");
				String q_answer = request.getParameter("q_answer");
				
				Map<String, String> paraMap = new HashMap<>();
				
				paraMap.put("q_num", q_num);
				paraMap.put("q_answer", q_answer);
				
				
				try {
					int n = qdao.updateAnswer(paraMap); // 답변등록하기

					if(n == 1) {
						String message = q_num + "번 문의에 답변을 등록하였습니다.";
						String loc = request.getContextPath() + "/admin/adminBoard.cl";  // 자바스크립트를 이용한 이전페이지로 이동하는 것. 
					
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
						super.setRedirect(false);
						super.setViewPage("/WEB-INF/msg.jsp");
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
					
					String message = "상품등록에 실패하였습니다.";
					String loc = "javascript:history.back()";  // 자바스크립트를 이용한 이전페이지로 이동하는 것. 
				
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
			 	
			}
			else {
				String message = "현재 get 방식으로 접속하셨습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
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
