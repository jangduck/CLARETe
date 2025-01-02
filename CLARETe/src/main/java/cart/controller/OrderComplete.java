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
		    
		    System.out.println("fk_p_numArray 길이 : " + fk_p_numArray.length());		//ok
		    System.out.println("od_countArray 길이 : " + od_countArray.length());		//ok
		    System.out.println("fk_op_numArray 길이 : " + fk_op_numArray.length());	//ok
		    
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_m_id", fk_m_id);
			paraMap.put("fk_d_num", fk_d_num);
			paraMap.put("o_price", String.valueOf(o_price));
			paraMap.put("o_cnt", String.valueOf(o_cnt));
			
			// 채번하기
			int pnum = odao.getPnum();
			System.out.println("채번채번" + pnum);
			
			// tbl_order 테이블에 insert
			int n = odao.insertOrder(paraMap);
			System.out.println("tbl_order 테이블에 insert ; " + n);
			
			//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡtbl_order, tbl_orderdetail 테이블에 insertㅡㅡㅡㅡㅡㅡㅡ
			List<Map<String, String>> orderList = new ArrayList<>();
			for (int i = 0; i < fk_p_numArray.length(); i++) {
				Map<String, String> paraMap2 = new HashMap<>();
				
				paraMap2.put("fk_p_num", fk_p_numArray.getString(i));
				paraMap2.put("od_count", od_countArray.getString(i));
				paraMap2.put("fk_op_num", fk_op_numArray.getString(i));
				
				orderList.add(paraMap2);
			}
			
			
			//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ---
			if (n == 1) {
				
				//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ결제한 거 장바구니 테이블에서 삭제ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
				List<String> CNumList = new ArrayList<>();
				for (int i = 0; i < selectedCNumArray.length(); i++) {
					CNumList.add(selectedCNumArray.getString(i)); 
				}
				
				odao.deleteCart(CNumList);		
				//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
				
				
				//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ포인트 사용액 차감하기 (테이블 업데이트)ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
				paraMap = new HashMap<>();
				paraMap.put("fk_m_id", fk_m_id);
				paraMap.put("m_point", toString().valueOf(m_point));
				
				odao.updatePoint(paraMap);
				//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
				
				
				//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ구매금액의 1% 포인트로 추가 (테이블 업데이트)ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
				paraMap = new HashMap<>();
				paraMap.put("fk_m_id", fk_m_id);
				paraMap.put("o_price", String.valueOf(o_price));
				
				odao.addPurchasePoints(paraMap);
				//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
				
				
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