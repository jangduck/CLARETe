package cart.controller;

import java.util.List;

import cart.domain.CartVO;
import chaeeun.cart.model.CartDAO;
import chaeeun.cart.model.CartDAO_imple;
import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import option.domain.OptionVO;
import product.domain.ProductVO;
import chaeeun.order.model.*;

public class GoPurchase extends AbstractController {

	OrderDAO odao = new OrderDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
	    if (loginuser.getM_id() == null) {
	    	
	    	super.setRedirect(true);
            super.setViewPage("/login/login.jsp");
            return;
            
	    } else {
	    	
	    	String p_num = (String) request.getParameter("p_num");
	    	String op_num = (String) request.getParameter("op_num");
	    	String productprice = (String) request.getParameter("productprice");
	    	
	    	ProductVO pvo = odao.purchaseProduct(p_num);
	    	request.setAttribute("pvo", pvo);
	    	session.setAttribute("pvo", pvo);
	    	
	    	OptionVO opvo = odao.purchaseProductOption(op_num, p_num);
	    	request.setAttribute("opvo", opvo);
	    	session.setAttribute("opvo", opvo);
	    	
	    	request.setAttribute("productprice", productprice);
	    	
	    	super.setRedirect(false);
		    super.setViewPage("/WEB-INF/cart/goPurchase.jsp");
		    
	    }
		

	}

}
