package admin.controller;

import java.sql.SQLException;
import java.util.List;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import minkyu.admin.model.AdminDAO;
import minkyu.admin.model.AdminDAO_imple;
import qna.domain.QnaVO;
import youjin.qna.model.QnaDAO;
import youjin.qna.model.QnaDAO_imple;

public class AdminBoard extends AbstractController {
	
	private QnaDAO qdao = new QnaDAO_imple();

	private AdminDAO adao = new AdminDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		if( loginuser != null && "admin".equals(loginuser.getM_id()) ) {
			
			if("get".equalsIgnoreCase(method)) {	
			
				try {
					List<QnaVO> qnaList = qdao.qnaList();
					request.setAttribute("qnaList", qnaList);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/admin/adminBoard.jsp");
					
				} catch(SQLException e) {
					e.printStackTrace();
					super.setRedirect(true);
					super.setViewPage(request.getContextPath()+"index.cl");
				}
				
				 
				
			} // end of if("get".equalsIgnoreCase(method))--------
			
			
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
