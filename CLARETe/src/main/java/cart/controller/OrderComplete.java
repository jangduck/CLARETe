package cart.controller;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import chaeeun.order.model.*;

public class OrderComplete extends AbstractController {

	private OrderDAO odao = new OrderDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if (!"POST".equals(method)) { // "GET"인 경우

			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setViewPage("/WEB-INF/msg.jsp");

			return; // execute(HttpServletRequest request, HttpServletResponse respone) 메소드 종료함.

		} else {
			
			// 주문 insert 하기
			// ajax에서 값 가져오기
			String fk_m_id = request.getParameter("fk_m_id");
			String fk_d_num = request.getParameter("fk_d_num");
			String o_price = request.getParameter("o_price");
			String o_cnt = request.getParameter("o_cnt");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_m_id", fk_m_id);
			paraMap.put("fk_d_num", fk_d_num);
			paraMap.put("o_price", o_price);
			paraMap.put("o_cnt", o_cnt);
			
			int n = odao.insertOrder(paraMap);
			
			if (n == 1) {
				
				JSONObject jsonOBJ = new JSONObject();
				jsonOBJ.put("n", n); 	
				
				String json = jsonOBJ.toString();
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
				
			} else {
				
				String message = "결제에 실패하였습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);

				super.setViewPage("/WEB-INF/msg.jsp");

				return;
				
			}
			
			
		}
 
	}

}
