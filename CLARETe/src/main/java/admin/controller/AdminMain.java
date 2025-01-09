package admin.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import log.domain.LogVO;
import member.domain.MemberVO;
import minkyu.log.model.LogDAO;
import minkyu.log.model.LogDAO_imple;

public class AdminMain extends AbstractController {

	private LogDAO ldao = new LogDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser != null && "admin".equals(loginuser.getM_id()) ) {
			// 관리자로 로그인 한 경우
			
			
			// ==== 민규 adminMain 시작 ==== //
			// 로그인 기록 알아오기
			List<LogVO> log_list = ldao.totalLog();
			
			request.setAttribute("log_list", log_list);
	        
			// ==== 민규 adminMain 끝 ==== //
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/adminMain.jsp");

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