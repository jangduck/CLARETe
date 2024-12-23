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
			
			System.out.println("id : " + id);
			System.out.println("pwd : " + pwd);
			
			String clientip = request.getRemoteAddr();
			
			request.setAttribute("id", id); // 로그인 한 아이디 값 알아오기 위해 추가
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("id", id);
			paraMap.put("pwd", pwd);
			paraMap.put("clientip", clientip);
			
			MemberVO loginuser = mdao.login(paraMap); 
			
			if(loginuser != null) {
				System.out.println(id + "로그인 성공");
				System.out.println("Logged-in User: " + loginuser.getM_id());
				/*
				 	여기에 휴면 코드 추가
				 */
				
				HttpSession session = request.getSession();
				session.setAttribute("loginuser", loginuser);
				
				/*
			 		여기에비밀번호 변경 3개월 코드 추가
				 */
				
				if(!("admin".equals(loginuser.getM_id())) ) {
					super.setRedirect(true);
					super.setViewPage(request.getContextPath()+"/index.cl");
				}
				else {
					super.setRedirect(true);
					super.setViewPage(request.getContextPath()+"/admin/adminMain.cl");
				}
			} // end of if(loginuser != null) {}
			
			else {
				String message = "탈퇴하신 회원입니다.";
		        String loc = "javascript:history.back()";
		         
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		         
		        super.setRedirect(false); 
		        super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			
			
		}
	    
	}

}
