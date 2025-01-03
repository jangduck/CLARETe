package jihye.mypage.controller;



import org.json.JSONObject;

import common.controller.AbstractController;

import delivery.model.DeliveryDAO;
import delivery.model.DeliveryDAO_imple;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public class DeleteDelivery extends AbstractController {

	DeliveryDAO ddao = new DeliveryDAO_imple();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		/*
		 * String method = request.getMethod();
		 * 
		 * if("POST".equalsIgnoreCase(method)) {
		 * 
		 * HttpSession session = request.getSession(); request.getSession(); MemberVO
		 * loginuser = (MemberVO) session.getAttribute("loginuser");
		 * 
		 * String m_id = loginuser.getM_id(); String d_num =
		 * request.getParameter("d_num");
		 * 
		 * int n = ddao.DeleteDelivery(m_id, d_num);
		 * 
		 * JSONObject jsobj = new JSONObject(); jsobj.put("n",n );//{n:1} String json =
		 * jsobj.toString();// ""<문자열
		 * 
		 * request.setAttribute("json", json);
		 * 
		 * }
		 * 
		 * else {
		 * 
		 * String message = "비정상적인 경로로 들어왔습니다"; String loc =
		 * "javascript:history.back()";
		 * 
		 * request.setAttribute("message", message); request.setAttribute("loc", loc);
		 * 
		 * super.setViewPage("/WEB-INF/msg.jsp"); return;
		 * 
		 * }
		 */
		

	
		  String method = request.getMethod(); // GET 또는 POST 확인
		  
		  if ("POST".equalsIgnoreCase(method)) { // POST 요청만 처리
		  HttpSession session =request.getSession(); MemberVO loginuser = (MemberVO)
		  session.getAttribute("loginuser"); // 세션에서 로그인 유저 가져오기
		  
		  if (loginuser != null) { // 로그인 유저 확인 
		  String m_id = loginuser.getM_id(); //m_id 가져오기
		  String d_num = request.getParameter("d_num"); // 요청 파라미터에서 d_num가져오기
		  
		  System.out.println(" 잘 들어왔니? " +d_num);
		  
		  // DB에서 삭제 작업 수행 
		   int n = ddao.DeleteDelivery(m_id, d_num); // 성공하면 1 반환
		  
		  // JSON 객체 생성 
		   JSONObject jsobj = new JSONObject(); jsobj.put("n", n); // 성공여부 포함 {n:1 또는 n:0}
		   String json = jsobj.toString(); // JSON 문자열로 변환
		
		  // JSON 결과를 요청에 설정하고 뷰 페이지 지정 
		  request.setAttribute("json", json);
		  super.setRedirect(false); super.setViewPage("/WEB-INF/jsonview.jsp"); 
		  } 
		  
		  else
		  { // 로그인 세션이 없을 경우 처리 
			  JSONObject jsobj = new JSONObject(); jsobj.put("n", 0);
		  // 실패 상태 전달 
			  String json = jsobj.toString();
		  
		  request.setAttribute("json", json); super.setRedirect(false);
		  super.setViewPage("/WEB-INF/jsonview.jsp"); } 
		  }
		
	}
}
