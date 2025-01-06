package mypage.controller;

import java.util.List;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import minkyu.product.model.ProductDAO;
import minkyu.product.model.ProductDAO_imple;
import product.domain.ProductVO;

public class Mypage_current_product extends AbstractController {

	private ProductVO pvo = new ProductVO();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		List pnumList = (List) session.getAttribute("pnumList");
		
		ProductDAO pdao = new ProductDAO_imple();
		
		// 최근 본 상품 조회하는 리스트
		List <ProductVO> pvoList = pdao.selectProduct(pnumList);
		
		System.out.println("pnumList사이즈 확인"+pnumList.size());
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/mypage_current_product.jsp");
		
	}

}
