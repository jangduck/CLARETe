package cart.controller;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Complete extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		String selectedDNum = request.getParameter("selectedDNum");
		System.out.println("배송지 번호~~" + selectedDNum);
		
		super.setRedirect(false);
	    super.setViewPage("/WEB-INF/cart/orderComplete.jsp");

	}

}