package myshop.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import option.domain.OptionVO;
import yihun.option.model.*;
import youjin.review.model.ReviewDAO;
import youjin.review.model.ReviewDAO_imple;
import product.domain.ProductVO;
import review.domain.ReviewVO;
import yihun.myshop.model.*;

public class ProdView extends AbstractController {

	ProductDAO pdao = new ProductDAO_imple();
	OptionDAO odao = new OptionDAO_imple();
	private ReviewDAO rdao = new ReviewDAO_imple();
	// 민규코드 시작 //
	List<String> pnumList = new ArrayList<>();
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("get".equalsIgnoreCase(method)) { // get 으로 들어온 경우
			
			String m_id;
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if (loginuser == null) {
		        // 로그인하지 않은 경우
		        m_id = "0";
		    }
			else {
				m_id = loginuser.getM_id(); // 세션값 아이디를 알아온다
			}

			///////////////////////////////////////////////////////////
			
			
			int p_num = Integer.parseInt(request.getParameter("p_num"));
			
			pnumList.add(String.valueOf(p_num));
			
			session.setAttribute("pnumList", pnumList);
			
			// 민규코드 끝 //
			
			System.out.println(p_num); 
			session.setAttribute("p_num", p_num);
			
			ProductVO pvo = pdao.selectProductOne(p_num); // 상품 상세페이지의 정보를 알아온다
			List<OptionVO> ovo = odao.selectOption(p_num); // 상품 옵션 정보를 알아온다
			
			// System.out.println("리스트 사이즈 : "+ovo.size());
			
			request.setAttribute("pvo", pvo);
			request.setAttribute("ovo", ovo);
			request.setAttribute("m_id", m_id);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/myshop/prodView.jsp");
			
		}
		else { // post 로 들어온 경우
			
			
			// 해당 로직에서 즉시 구매하기의 경우가 발생하면 됩니다! 다른 서블릿 받아도 되긴함
			
			
			
			
			
			// 리뷰작성
			
			String p_num = request.getParameter("p_num");
			String fk_m_id = request.getParameter("fk_m_id");
			String r_star = request.getParameter("r_star");					
			String r_msg = request.getParameter("r_msg");
			System.out.println("p_num"+p_num);
			System.out.println("fk_m_id"+fk_m_id);
			System.out.println("r_star"+r_star);
			System.out.println("r_msg"+r_msg);
			
			ReviewVO rvo = new ReviewVO(); 
			rvo.setFk_m_id(fk_m_id);
			rvo.setFk_p_num(Integer.parseInt(p_num));			
			rvo.setR_star(Integer.parseInt(r_star));
			rvo.setR_msg(r_msg);
				
			String message = "";
			String loc = "";
			try {				
				
				//boolean isExist= false;
				int n = rdao.OderReviewCheck(fk_m_id, p_num);
				System.out.println("OderReviewCheck = "+n);
				/*
				for(int i=0;i<OderReviewCheck.size();i++) {
					int listP = OderReviewCheck.get(i).getFk_p_num();
					
					if(listP == Integer.parseInt(p_num)) {
						isExist=  true;
					}
				}
				*/					
				
				if (n == 0) {
					System.out.println("구매 이력에 없는 제품입니다.");
					message = "구매 이력에 없는 제품입니다.";
					loc = request.getContextPath()  + "/index.cl";
					return;
				}
				else {					
					int Review = rdao.ReviewUpload(rvo);
					
					if (Review == 1) {	
						System.out.println("리뷰가 등록되었습니다.");
						message = "리뷰가 등록되었습니다.";
						loc = request.getContextPath()  + "/index.cl";			   		    
					}
					else {
						message = "리뷰 등록에 실패했습니다.";
					}										
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
				loc = "javascript:history.back()";		// JS를 이용한 이전페이지로 이동하는 것
			}
						
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			
			
			
		}
		
		

	}

}
