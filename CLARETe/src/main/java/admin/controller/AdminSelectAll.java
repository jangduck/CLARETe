package admin.controller;

import minkyu.admin.model.*;

import java.sql.SQLException;
import java.util.List;


import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import member.domain.MemberVO;

public class AdminSelectAll extends AbstractController {

   private AdminDAO adao = new AdminDAO_imple();

   
   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

      String method = request.getMethod();
      
      System.out.println(method);
      
      if("get".equalsIgnoreCase(method)) {
         
         // ㅎㅎ~
         String message = "";
         String loc= "";
         
         try {
            
            List<MemberVO> selectAll_list = adao.SelectAll_member();
            
            
            if(selectAll_list.size() != 0) {
               System.out.println(selectAll_list.size());
               request.setAttribute("selectAll_list", selectAll_list);
               
               message = "모든 회원 조회입니다.";
               loc = request.getContextPath() + "admin.cl";
            }
            
         } catch (SQLException e) {
            e.printStackTrace();
            message = "조회된 회원이 없습니다.";
            loc = "javascript:history.back";
            
         }
         request.setAttribute("message", message);
         request.setAttribute("loc", loc);

         // super.setRedirect(true);
         super.setViewPage("/WEB-INF/msg.jsp");
         
         // super.setRedirect(false);
         super.setViewPage("/WEB-INF/admin/adminSelectAll.jsp");
      }

      
   }


}
