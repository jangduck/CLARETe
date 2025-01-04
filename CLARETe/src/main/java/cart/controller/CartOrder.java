package cart.controller;

import java.util.List;

import chaeeun.cart.model.CartDAO;
import chaeeun.cart.model.CartDAO_imple;
import common.controller.AbstractController;
import delivery.domain.DeliveryVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;

public class CartOrder extends AbstractController {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String method = request.getMethod();

        if (!"POST".equals(method)) { // "GET"인 경우

            String message = "비정상적인 경로로 들어왔습니다.";
            String loc = "javascript:history.back()";

            request.setAttribute("message", message);
            request.setAttribute("loc", loc);

            super.setViewPage("/WEB-INF/msg.jsp");
            return; // execute(HttpServletRequest request, HttpServletResponse response) 메서드 종료
        }

        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

        if (loginuser == null) {
            String message = "로그인 후 이용해주세요.";
            String loc = "javascript:history.back()";

            request.setAttribute("message", message);
            request.setAttribute("loc", loc);

            super.setViewPage("/WEB-INF/msg.jsp");
            return;
        }

        String shipping = request.getParameter("input_total_shipping");
        session.setAttribute("shipping", shipping);
	    
        // 로그인 사용자 정보를 JSP에 전달
        request.setAttribute("m_name", loginuser.getM_name());
        request.setAttribute("m_mobile", loginuser.getM_mobile());
        request.setAttribute("m_email", loginuser.getM_email());
        request.setAttribute("m_point", loginuser.getM_point());

        // input 태그 값 받아오기 (향수 정보들)
        String[] index = request.getParameterValues("index");
        if (index == null || index.length == 0) {
            String message = "선택된 상품이 없습니다. 상품을 선택해주세요.";
            String loc = "javascript:history.back()";

            request.setAttribute("message", message);
            request.setAttribute("loc", loc);

            super.setViewPage("/WEB-INF/msg.jsp");
            return;
        }

        String[] perfumeName = request.getParameterValues("perfumeName");
        String[] quantity = request.getParameterValues("quantity");
        String[] price = request.getParameterValues("price");
        String[] priceQuantity = request.getParameterValues("priceQuantity");
        String[] option = request.getParameterValues("option");
        String[] selectedCNum = request.getParameterValues("selectedCNum");
        String[] p_num = request.getParameterValues("p_num");
        String[] productprice = request.getParameterValues("productprice");
        
        
        session.setAttribute("index", index);
        session.setAttribute("perfumeName", perfumeName);
        session.setAttribute("quantity", quantity);
        session.setAttribute("price", price);
        session.setAttribute("priceQuantity", priceQuantity);
        session.setAttribute("option", option);
        session.setAttribute("selectedCNum", selectedCNum);
        session.setAttribute("p_num", p_num);
        session.setAttribute("productprice", productprice);
        
        
        // input 태그 값 받아오기 (가격)
        String totalProduct = request.getParameter("totalProduct");
        String totalShipping = request.getParameter("totalShipping");
        String totalTotal = request.getParameter("totalTotal");

        session.setAttribute("totalProduct", totalProduct);
        
        // 배송 정보 조회하기
        CartDAO cdao = new CartDAO_imple();
        List<DeliveryVO> deliveryList = cdao.selectDeliveryList(loginuser.getM_id());
        request.setAttribute("deliveryList", deliveryList);

        request.setAttribute("index", index);
        request.setAttribute("perfumeName", perfumeName);
        request.setAttribute("quantity", quantity);
        request.setAttribute("price", price);
        request.setAttribute("priceQuantity", priceQuantity);
        request.setAttribute("option", option);
        request.setAttribute("selectedCNum", selectedCNum);
        request.setAttribute("p_num", p_num);

        request.setAttribute("totalProduct", totalProduct);
        request.setAttribute("totalShipping", totalShipping);
        request.setAttribute("totalTotal", totalTotal);

        super.setRedirect(false);
        super.setViewPage("/WEB-INF/cart/cart_order.jsp");
    }
}
