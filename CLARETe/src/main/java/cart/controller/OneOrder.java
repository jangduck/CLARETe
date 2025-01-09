package cart.controller;

import java.io.BufferedReader;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import chaeeun.order.model.OrderDAO;
import chaeeun.order.model.OrderDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class OneOrder extends AbstractController {

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
			
			StringBuilder sb = new StringBuilder();
			BufferedReader br = request.getReader();
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			
			JSONObject jsonObject = new JSONObject(sb.toString());
			
			String m_id = jsonObject.getString("fk_m_id");
		    String d_num = jsonObject.getString("fk_d_num");
		    int o_price = jsonObject.getInt("o_price");
		    int m_point = jsonObject.getInt("m_point");
		    int p_num = jsonObject.getInt("p_num");
		    int op_num = jsonObject.getInt("op_num");
		    int od_count = jsonObject.getInt("od_count");
		    int od_price = jsonObject.getInt("od_price");

		    // 1. tbl_order에 insert 하기 위한 데이터들
		    // o_num(채번), fk_m_id, fk_d_num, o_date(sysdate), status(0), o_price, o_cnt(1)
		    Map<String, String> paraMap = new HashMap<>();
		    paraMap.put("m_id", m_id);
		    paraMap.put("d_num", d_num);
		    paraMap.put("o_price", String.valueOf(o_price));
		    
		    
		    // 2. tbl_orderdetail에 insert 하기 위한 데이터들
		    // od_num(시퀀스), fk_p_num, fk_o_num(채번), od_count, od_price, fk_op_num
		    Map<String, String> paraMap2 = new HashMap<>();
		    paraMap2.put("p_num", String.valueOf(p_num));
		    paraMap2.put("od_count", String.valueOf(od_count));
		    paraMap2.put("od_price", String.valueOf(od_price));
		    paraMap2.put("op_num", String.valueOf(op_num));

		    
		    // 3. tbl_member에 update 하기 위한 데이터들 (포인트 사용액 차감)
		    Map<String, String> paraMap3 = new HashMap<>();
		    paraMap3.put("m_id", m_id);
		    paraMap3.put("m_point", String.valueOf(m_point));	// 포인트 사용액
		    
		    
		    // 4. tbl_member에 update 하기 위한 데이터들 (구매금액의 1% 추가)
		    Map<String, String> paraMap4 = new HashMap<>();
		    paraMap4.put("m_id", m_id);
		    paraMap4.put("o_price", String.valueOf(o_price));
		    
		    
		    // 주문하기 ~~
		    int pnum = odao.oneOrderTransaction(paraMap, paraMap2, paraMap3, paraMap4);
		    		
		    if (pnum > 0) {
		    	
		    	int n = 1;
		    	
		    	HttpSession session = request.getSession();
		    	session.setAttribute("one_d_num", d_num);
		    	session.setAttribute("one_pnum", p_num);	
		    	session.setAttribute("one_m_point", m_point);
		    	session.setAttribute("pnumpnum", pnum);	//채번쓰
		    	session.setAttribute("op_num", op_num);	//채번쓰
		    	session.setAttribute("one_o_price", o_price);
		    	
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
