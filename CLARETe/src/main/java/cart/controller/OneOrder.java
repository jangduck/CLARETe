package cart.controller;

import java.io.BufferedReader;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class OneOrder extends AbstractController {

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
			
			StringBuilder sb = new StringBuilder();
			BufferedReader br = request.getReader();
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			
			JSONObject jsonObject = new JSONObject(sb.toString());
			
			String fk_m_id = jsonObject.getString("fk_m_id");
		    String fk_d_num = jsonObject.getString("fk_d_num");
		    int o_price = jsonObject.getInt("o_price");
		    int m_point = jsonObject.getInt("m_point");
		    int p_num = jsonObject.getInt("p_num");
		    int op_num = jsonObject.getInt("op_num");
		    int od_count = jsonObject.getInt("od_count");
		    int od_price = jsonObject.getInt("od_price");
		    
		    System.out.println("fk_m_id : " + fk_m_id);
		    System.out.println("fk_d_num : " + fk_d_num);
		    System.out.println("o_price : " + o_price);
		    System.out.println("m_point : " + m_point);
		    System.out.println("p_num : " + p_num);
		    System.out.println("op_num : " + op_num);
		    System.out.println("od_count : " + od_count);
		    System.out.println("od_price : " + od_price);
		    
		    int n = 1;
		    
		    JSONObject jsonOBJ = new JSONObject();
			jsonOBJ.put("n", n); 	
			
			String json = jsonOBJ.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		

	}

}
