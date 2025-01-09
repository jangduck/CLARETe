package cart.controller;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
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
		    int o_cnt = jsonObject.getInt("o_cnt");
		    JSONArray selectedCNumArray = jsonObject.getJSONArray("selectedCNumValues");
		    int m_point = jsonObject.getInt("m_point");
		    
		    JSONArray fk_p_numArray = jsonObject.getJSONArray("fk_p_numValues");
		    JSONArray od_countArray = jsonObject.getJSONArray("od_countValues");
		    JSONArray fk_op_numArray = jsonObject.getJSONArray("fk_op_numValues");
		    JSONArray od_priceArray = jsonObject.getJSONArray("od_priceValues");
    
		    
			// tbl_order 테이블에 insert
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_m_id", fk_m_id);
			paraMap.put("fk_d_num", fk_d_num);
			paraMap.put("o_price", String.valueOf(o_price));
			paraMap.put("o_cnt", String.valueOf(o_cnt));
			
			
			// 주문번호 리스트 얻어오기
			List<Map<String, String>> orderList = new ArrayList<>();
			for (int i = 0; i < fk_p_numArray.length(); i++) {
				Map<String, String> paraMap2 = new HashMap<>();
				
				paraMap2.put("fk_p_num", fk_p_numArray.getString(i));
				paraMap2.put("od_count", od_countArray.getString(i));
				paraMap2.put("fk_op_num", fk_op_numArray.getString(i));
				paraMap2.put("od_price", od_priceArray.getString(i));	// 이거 수정
				
				orderList.add(paraMap2);
			}
			
			
			// 장바구니 번호 리스트 얻어오기
			List<String> CNumList = new ArrayList<>();
			for (int i = 0; i < selectedCNumArray.length(); i++) {
				CNumList.add(selectedCNumArray.getString(i)); 
			}

			
			// 포인트 사용금액 얻어오기
			paraMap.put("fk_m_id", fk_m_id);
			paraMap.put("m_point", String.valueOf(m_point));
				
				
			// 구매금액 얻어오기 (1% 포인트로~)
			paraMap.put("fk_m_id", fk_m_id);
			paraMap.put("o_price", String.valueOf(o_price));
				
				
			// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
			// 진짜로 주문 (수동커밋)
			int pnum = odao.orderTransaction(paraMap, orderList, CNumList);
				
			if (pnum > 0) {
				
				int n = 1;
				
				// 세션에 정보 저장
			    HttpSession session = request.getSession();
			    session.setAttribute("fk_d_num", fk_d_num);		// 배송지 번호
			    session.setAttribute("pnum", pnum);				// 주문번호
			    session.setAttribute("o_cnt", o_cnt);			// 한 주문에 제품 몇개인지?
			    session.setAttribute("m_point", m_point);		// 사용된 포인트
			    
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