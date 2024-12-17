package login.controller;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Logout extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession(); // 세션불러오기
		
		session.invalidate();	// 세션 삭제
		
		super.setRedirect(true);
		super.setViewPage(request.getContextPath()+"/index.cl");
	}

}
