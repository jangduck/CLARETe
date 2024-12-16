package login.controller;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

import java.util.HashMap;
import java.util.Map;

import chaeeun.member.model.MemberDAO;
import chaeeun.member.model.MemberDAO_imple;

public class Login extends AbstractController {

	private MemberDAO mdao = new MemberDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    
	    String method = request.getMethod();
	    
	    if(!"POST".equalsIgnoreCase(method)) {	// "GET"
			
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return; // execute(HttpServletRequest request, HttpServletResponse respone) 메소드 종료함.  
		} 
	    
	    else {	// "POST"
			
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			String clientip = request.getRemoteAddr();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("id", id);
			paraMap.put("pwd", pwd);
			paraMap.put("clientip", clientip);
			
			MemberVO loginuser = mdao.login(paraMap); 
			
			if(loginuser != null) {
				System.out.println(id + "로그인 성공");
				
				super.setRedirect(false); 
		        super.setViewPage("/WEB-INF/index.jsp");
			} else {
				String message = "로그인 실패";
		        String loc = "javascript:history.back()";
		         
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		         
		        super.setRedirect(false); 
		        super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			
			
		}
	    
	}

}
