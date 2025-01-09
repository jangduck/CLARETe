package admin.controller;

import java.sql.SQLException;

import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import minkyu.admin.model.AdminDAO;
import minkyu.admin.model.AdminDAO_imple;


public class AdminUpdateDeliveryStatus extends AbstractController {

    private AdminDAO adao = new AdminDAO_imple();

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
       
    	
    	
        String method = request.getMethod();
        
        // 요청 방식 확인
        if ("POST".equalsIgnoreCase(method)) { // POST 요청일 경우 처리
        	System.out.println("나 ajax~~~~");
        	
            // 전달받은 파라미터 처리
            String o_num = request.getParameter("d_num");
            String statusStr = request.getParameter("status");

            
            //System.out.println("확인 : " + statusStr);

            try {
                // 상태값 변환
                int status = Integer.parseInt(statusStr);

                // 배송 상태 업데이트
                int isUpdated = adao.updateDeliveryStatus(o_num, status);
                

                if(isUpdated == 1) {
                	JSONObject jsonObj = new JSONObject();
                    jsonObj.put("isUpdated", isUpdated); // {"isUpdated":true} 또는 {"isUpdated":false}, JSON 객체 생성
                    
                    String json = jsonObj.toString(); 
                    System.out.println(">> 확인용 json " + json);
                    
                    request.setAttribute("json", json);
                    //response.setContentType("application/json; charset=UTF-8");
                    
                    super.setRedirect(false);
                    super.setViewPage("/WEB-INF/jsonview.jsp"); // JSON 응답을 반환하는 JSP 경로 설정
                }
                
                
                
                
            } catch (NumberFormatException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
                
            }
        } 
        
    }
}
