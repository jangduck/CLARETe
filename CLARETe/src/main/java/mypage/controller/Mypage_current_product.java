package mypage.controller;

import java.util.ArrayList;
import java.util.List;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Mypage_current_product extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      HttpSession session = request.getSession();
      
      // 세션에서 최근 본 상품 목록 가져오기
      List<String> pnumList = (List<String>) session.getAttribute("pnumList");
      
      if (pnumList == null) {
         // 세션에 pnumList가 없으면 새로 생성
         pnumList = new ArrayList<>();
         session.setAttribute("pnumList", pnumList);
      }

      // 테스트용으로 임시 상품 번호 추가 (실제 구현에서는 다른 로직으로 추가)
      String currentPnum = request.getParameter("pnum"); // URL 또는 파라미터에서 상품 번호 가져오기
      if (currentPnum != null && !pnumList.contains(currentPnum)) {
         // 중복 방지 후 추가
         pnumList.add(currentPnum);
      }
      
      // 최근 본 상품 목록을 JSP에 전달
      request.setAttribute("pnumList", pnumList);

      super.setRedirect(false);
      super.setViewPage("/WEB-INF/mypage/mypage_current_product.jsp");
   }

}
