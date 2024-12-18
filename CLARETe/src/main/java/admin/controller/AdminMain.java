package admin.controller;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public class AdminMain extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String id = (String)request.getAttribute("id");
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String loginuser2 = loginuser.getM_id();
		

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/adminMain.jsp");

		
	}

}
