package member.controller;

import java.util.HashMap;
import java.util.Map;

import chaeeun.member.model.MemberDAO;
import chaeeun.member.model.MemberDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class IdleEnd extends AbstractController {

	private MemberDAO mdao = new MemberDAO_imple();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); // "GET" 풔 "POST"

		request.setAttribute("method", method);

		HttpSession session = request.getSession();

		String message = "";
        String loc = "";
		
		if("get".equalsIgnoreCase(method)) {
			String auth =  (String) session.getAttribute("auth");

			if(auth != null) {
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/idleEnd.jsp");
				session.removeAttribute("auth");
			} else {
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/index.cl");
			}
			
		}
		if ("POST".equalsIgnoreCase(method)) {

			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("m_name", (String) session.getAttribute("m_name"));
			paraMap.put("m_mobile", (String) session.getAttribute("m_mobile"));

		//	System.out.println("paramap: m_name = " + paraMap.get("m_name"));
			
			String certification = request.getParameter("certification"); // ? 媛� ��泥닿� ����
		//	System.out.println("uuuuuuuuuuuuuuuuuuuu" + certification);

			
			String certification_code = (String) session.getAttribute("certification_code");
			
		//	System.out.println("certification_code          " + certification_code);

			if (certification.equals(certification_code)) {
				
				int n = mdao.idleUpdate(paraMap);
				
				if(n==1) {
					message = "휴면해제가 완료되었습니다.";
			        loc = request.getContextPath()+"/login/loginView.cl";
			        
			        request.setAttribute("message", message);
			        request.setAttribute("loc", loc);
			        
			        super.setViewPage("/WEB-INF/msg.jsp");
			        return;
				}
				
			} // end of if(certification == certification_code)
			else {
				message = "인증번호가 일치하지 않습니다!!";
		        loc = "javascript:history.back()";
		        
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		        
		        super.setViewPage("/WEB-INF/msg.jsp");
		        return;
			}

		} // end of if("POST".equalsIgnoreCase(method))
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/member/idleEnd.jsp");
	}

}