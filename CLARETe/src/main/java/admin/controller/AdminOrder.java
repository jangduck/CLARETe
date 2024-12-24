package admin.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import member.domain.MemberVO;
import minkyu.admin.model.AdminDAO;
import minkyu.admin.model.AdminDAO_imple;
import order.domain.OrderVO;

public class AdminOrder extends AbstractController {

    private AdminDAO adao = new AdminDAO_imple();

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
        String method = request.getMethod(); // 요청 메서드 확인
        
        if ("GET".equalsIgnoreCase(method)) {

        	String searchType = request.getParameter("searchType");
	        String searchWord = request.getParameter("searchWord");
        	
	        if (searchType == null ||
	                (!"m_id".equals(searchType) &&
	                !"m_name".equals(searchType))) {
	            searchType = "";
	        }

	        if (searchWord == null) {
	            searchWord = "";
	        }

	        Map<String, String> paraMap = new HashMap<>();
	        paraMap.put("searchType", searchType);
	        paraMap.put("searchWord", searchWord);
	        
	        try {
	            // 회원 목록 가져오기
	            List<OrderVO> orderList = adao.searchOrder(paraMap);

	            // 뷰에 데이터 전달
	            request.setAttribute("orderList", orderList);
	            request.setAttribute("searchType", searchType);
	            request.setAttribute("searchWord", searchWord);

	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/admin/adminOrder.jsp");

	        } catch (SQLException e) {
	            e.printStackTrace();
	            super.setRedirect(true);
//	            super.setViewPage(request.getContextPath() + "/error.up");
	        }
	        
	        
	    } 

	    
	}

}
