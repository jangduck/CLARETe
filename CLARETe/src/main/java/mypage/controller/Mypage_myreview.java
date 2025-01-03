package mypage.controller;

import java.sql.SQLException;
import java.util.List;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import review.domain.ReviewVO;
import youjin.review.model.ReviewDAO;
import youjin.review.model.ReviewDAO_imple;

public class Mypage_myreview extends AbstractController {
	private ReviewDAO rdao = new ReviewDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		String fk_m_id = request.getParameter("fk_m_id");
		System.out.println("fk_m_id = "+fk_m_id);
		

		try {
			List<ReviewVO> myreviewList = rdao.myreviewList(fk_m_id);
			request.setAttribute("myreviewList", myreviewList);
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/mypage/mypage_myreview.jsp");
		
			
			System.out.println("아이디값 받옴"+fk_m_id);
		} catch(SQLException e) {
			e.printStackTrace();
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"index.cl"); ///error.up 은 없어서 일단 메인
		
			
			
		}
		
	}

}
