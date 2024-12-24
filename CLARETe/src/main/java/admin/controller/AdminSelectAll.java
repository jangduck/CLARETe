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

public class AdminSelectAll extends AbstractController {

    private AdminDAO adao = new AdminDAO_imple();

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	HttpSession session = request.getSession();
    	
        // 파라미터 값 처리
        String searchType = request.getParameter("searchType");
        String searchWord = request.getParameter("searchWord");
        String sizePerPage = request.getParameter("sizePerPage"); 
        String currentShowPageNo = request.getParameter("currentShowPageNo");

        // 기본값 설정
        if(searchType == null ||
                (!"m_name".equals(searchType) &&
                !"m_id".equals(searchType) &&
                !"m_email".equals(searchType) ) ) {
                searchType = "";
              }
              
       if(searchWord == null) {
          searchWord = "";
       } 
       
       if(sizePerPage == null || 
         (!"10".equals(sizePerPage) &&
          !"5".equals(sizePerPage) &&
          !"3".equals(sizePerPage) ) ) {
           sizePerPage = "10";
        }
    	        
        if(currentShowPageNo == null) {
           currentShowPageNo = "1";
        }

        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("searchType", searchType);
        paraMap.put("searchWord", searchWord);
        paraMap.put("currentShowPageNo", currentShowPageNo);
        paraMap.put("sizePerPage", sizePerPage); // 한페이지당 보여줄 행의 개수

//        System.out.println("나 서블릿 ~ " + paraMap.get("searchType"));
//        System.out.println("ㅎㅇㅎㅇ " + paraMap.get("searchWord"));       
//        System.out.println(paraMap.get(searchType));
        
        
        
        // **** 페이징 처리를 한 모든 회원목록 또는 검색되어진 회원목록 보여주기 **** //
        // 페이징 처리를 위한 검색이 있는 또는 검색이 없는 회원에 대한 총페이지수 알아오기 //
        int totalPage = adao.getTotalPage(paraMap);
        // System.out.println("~~~~ 확인용 totalPage => " + totalPage);
        
        try {
            // 회원 목록 가져오기
            List<MemberVO> memberList = adao.searchMembers(paraMap);

            // 뷰에 데이터 전달
            request.setAttribute("memberList", memberList);
            request.setAttribute("searchType", searchType);
            request.setAttribute("searchWord", searchWord);

            super.setRedirect(false);
            super.setViewPage("/WEB-INF/admin/adminSelectAll.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            super.setRedirect(true);
//            super.setViewPage(request.getContextPath() + "/error.up");
        }
        
        
    } 

    
}


