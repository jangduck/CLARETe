package cart.controller;

import java.util.List;

import cart.domain.CartVO;
import chaeeun.cart.model.CartDAO;
import chaeeun.cart.model.CartDAO_imple;
import chaeeun.order.model.OrderDAO;
import chaeeun.order.model.OrderDAO_imple;
import common.controller.AbstractController;
import delivery.domain.DeliveryVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import option.domain.OptionVO;
import product.domain.ProductVO;

public class GoPurchaseOrder extends AbstractController {

	OrderDAO odao = new OrderDAO_imple();
	
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
        
        // 배송지 정보 전달쓰
        CartDAO cdao = new CartDAO_imple();
        List<DeliveryVO> deliveryList = cdao.selectDeliveryList(loginuser.getM_id());
        request.setAttribute("deliveryList", deliveryList);
    	
        
        // 뿌려줄 정보들 받아오기
        String p_num = (String) request.getParameter("p_num");
        ProductVO pvo = odao.purchaseProduct(p_num);
    	request.setAttribute("pvo", pvo);

    	String op_num = (String) request.getParameter("option");
    	OptionVO opvo = odao.purchaseProductOption(op_num, p_num);
    	request.setAttribute("opvo", opvo);
  
    	String quantity = (String) request.getParameter("quantity");	// 구매 개수
    	request.setAttribute("quantity", quantity);
    	
    	String productprice = (String) request.getParameter("productprice");
    	request.setAttribute("productprice", productprice);
    	
    	String input_total_shipping= (String) request.getParameter("input_total_shipping");
    	request.setAttribute("input_total_shipping", input_total_shipping);
    	
        super.setRedirect(false);
        super.setViewPage("/WEB-INF/cart/goPurchaseOrder.jsp");

	}

}
