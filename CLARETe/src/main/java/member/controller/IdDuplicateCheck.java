package member.controller;

import org.json.JSONObject;

import chaeeun.member.model.MemberDAO;
import chaeeun.member.model.MemberDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class IdDuplicateCheck extends AbstractController {

	private MemberDAO mdao = new MemberDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if ("POST".equalsIgnoreCase(method)) {
			
			String m_id = request.getParameter("m_id");
			boolean isExists = mdao.idDuplicateCheck(m_id);	// 리턴값 true or false
			
			JSONObject jsonObj = new JSONObject();		// {}
			jsonObj.put("isExists", isExists);	// {"isExists": true} 또는 {"isExists": false} 로 만들어준다.
			
			String json = jsonObj.toString();		// 문자열 형태인 "{"isExists": true}" 또는 "{"isExists": false}" 로 만들어준다.

			request.setAttribute("json", json);
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}

	}

}
