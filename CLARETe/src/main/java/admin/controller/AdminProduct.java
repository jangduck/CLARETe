package admin.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import minkyu.admin.model.AdminDAO;
import minkyu.admin.model.AdminDAO_imple;
import product.domain.ProductVO;

public class AdminProduct extends AbstractController {
	
	private AdminDAO adao = new AdminDAO_imple();

	   @Override
	    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		   
		   String method = request.getMethod();
		   
		   if("GET".equalsIgnoreCase(method)) {

	        String searchType = request.getParameter("searchType");
	        String searchWord = request.getParameter("searchWord");

	        if (searchType == null ||
	                (!"p_name".equals(searchType) &&
	                !"p_season".equals(searchType) &&
	                !"p_gender".equals(searchType))) {
	            searchType = "";
	        }

	        if (searchWord == null) {
	            searchWord = "";
	        }

	        Map<String, String> paraMap = new HashMap<>();
	        paraMap.put("searchType", searchType);
	        paraMap.put("searchWord", searchWord);
	        
	        // 카테고리(계절)을 검색할 때 계절이름으로 검색하게 함
	        if ("p_season".equals(searchType)) {
	            // searchWord 값이 숫자인 경우 (1, 2, 3, 4로 매핑)
	            if (!searchWord.matches("\\d+")) {   // ("\\d+") : 숫자표현 패턴
	                searchWord = switch (searchWord) {
	                    case "봄" -> "1";
	                    case "여름" -> "2";
	                    case "가을" -> "3";
	                    case "겨울" -> "4";
	                    default -> "";
	                };
	            }
	        }
	        
	     // 성별을 검색할 때 남,여만 검색하게 함
	        if ("p_gender".equals(searchType)) {
	            // searchWord 값이 숫자인 경우 (1, 2로 매핑)
	            if (!searchWord.matches("\\d+")) {
	                searchWord = switch (searchWord) {
	                    case "남" -> "1";
	                    case "여" -> "2";
	                    default -> "";
	                };
	            }
	        }
	        
//	        System.out.println("나 서블릿 ~ " + paraMap.get("searchType"));
//	        System.out.println("ㅎㅇㅎㅇ " + paraMap.get("searchWord"));
	        
//	        System.out.println(paraMap.get("searchType"));

	        try {
	            // 상품 목록 가져오기
	            List<ProductVO> productList = adao.searchProduct(paraMap);

	            
//	            System.out.println("하하하" + productList.size());
	            
	            
	            request.setAttribute("productList", productList);
	            request.setAttribute("searchType", searchType);
	            request.setAttribute("searchWord", searchWord);

	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/admin/adminProduct.jsp");

	        } catch (SQLException e) {
	            e.printStackTrace();
	            super.setRedirect(true);
//	            super.setViewPage(request.getContextPath() + "/error.jsp");
	        }
		   }
	    }
	}