package member.controller;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import chaeeun.member.model.MemberDAO;
import chaeeun.member.model.MemberDAO_imple;

public class EmailDuplicateCheck extends AbstractController {

	private MemberDAO mdao = new MemberDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		
		if ("POST".equalsIgnoreCase(method)) {
			
			String email = request.getParameter("m_email");
			boolean isExists = mdao.emailDuplicateCheck(email);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("isExists", isExists);
			
			String json = jsonObj.toString();
			
			request.setAttribute("json", json);
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		} 

	}

}
