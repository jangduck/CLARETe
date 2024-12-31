package cart.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import chaeeun.cart.model.*;

public class CartUpdate extends AbstractController {

	private CartDAO cdao = new CartDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); // "GET" 또는 "POST" 
		
		if("POST".equalsIgnoreCase(method)) {
			
			String cartNum = request.getParameter("cartNum");
			String action = request.getParameter("action");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("cartNum", cartNum);
			
			int n = 0;
			
			if ("increase".equalsIgnoreCase(action)) {
				// 수량 증가
				n = cdao.increaseQuantity(paraMap);
			} else if ("decrease".equalsIgnoreCase(action)) {
				// 수량 감소
				n = cdao.decreaseQuantity(paraMap);
			} else if ("delete".equalsIgnoreCase(action)) {
				// 장바구니에서 삭제
				n = cdao.deleteCart(paraMap);
			}


			JSONObject jsonOBJ = new JSONObject();
			jsonOBJ.put("n", n); 	
			
			String json = jsonOBJ.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		
		}
		
	}

}
