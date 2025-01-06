package common.controller;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.domain.ProductVO;
import yihun.prodect.model.*;

public class IndexController extends AbstractController {

	private ProductDAO pdao = new ProductDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<ProductVO> mainProductList = pdao.mainSelectProduct(); // 메인페이지에서 상품을 보여주는 메소드
		
		request.setAttribute("mainProductList", mainProductList);
		
		super.setRedirect(false);
	    super.setViewPage("/WEB-INF/index.jsp");

	}

}
