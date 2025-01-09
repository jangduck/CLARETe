package jihye.mypage.controller;

import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import youjin.qna.model.*;

public class UpdateQnaDeleteJSON extends AbstractController {
	
	private QnaDAO qdao = new QnaDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		String method = request.getMethod();
		
		if ("POST".equalsIgnoreCase(method)) {
			
			JSONObject jsonObj = new JSONObject();		// {}
			int result;
			
			String q_num = request.getParameter("q_num");	// 문의번호
			

			result = qdao.qnaDelete(q_num);
			
			
			jsonObj.put("result", result);	
			
			String json = jsonObj.toString();		// 문자열 형태인 "{"isExists": true}" 또는 "{"isExists": false}" 로 만들어준다.

			request.setAttribute("json", json);
			response.setContentType("application/json; charset=UTF-8");
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		

	}

}
