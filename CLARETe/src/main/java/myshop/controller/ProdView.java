package myshop.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

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
	List<Integer> pnumList = new ArrayList<>();
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
			
			pnumList.add(p_num);
			
			session.setAttribute("pnumList", pnumList);
			// 민규코드 끝 //
			
			//System.out.println(p_num); 
			session.setAttribute("p_num", p_num);
			
			ProductVO pvo = pdao.selectProductOne(p_num); // 상품 상세페이지의 정보를 알아온다
			List<OptionVO> ovo = odao.selectOption(p_num); // 상품 옵션 정보를 알아온다
			
			
			// =========================== 유진작성 =========================== //
			
			boolean orderCheck = rdao.OderCheck(m_id, p_num); // 구매확정된 제품이면 리뷰입력창 보여주기
			int reviewCnt = rdao.reviewCnt(p_num); // 해당 제품의 리뷰 개수를 불러옴
			System.out.println("orderCheck = "+orderCheck);
			
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			String sizePerPage = "3";
			if (sizePerPage == null || !"3".equals(sizePerPage)) {
				sizePerPage = "3";
			}
			if (currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			//String str_p_num =
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage); // 한페이지당 보여줄 행의 개수
			paraMap.put("p_num",String.valueOf(p_num));
	
			int totalReview = rdao.getReviewCnt(paraMap); // 페이징처리된 리뷰
			List<ReviewVO> rvo = rdao.reviewList(paraMap); // 해당 제품에 달린 리뷰들을 불러온다
			
			try {
				if (Integer.parseInt(currentShowPageNo) > totalReview || Integer.parseInt(currentShowPageNo) <= 0) {
					currentShowPageNo = "1";
					paraMap.put("currentShowPageNo", currentShowPageNo);
				}
			} catch (NumberFormatException e) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}
			
			
			String pageBar = "";
			int blockSize = 3;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.

			int loop = 1;
			// loop 는 1 부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다.

			// ==== !!! 다음은 pageNo 구하는 공식이다. !!! ==== //
			int pageNo = ((Integer.parseInt(currentShowPageNo) - 1) / blockSize) * blockSize + 1;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
			
			// *** [맨처음] 만들기 *** //
						
						if(totalReview != 0) {
							pageBar += "<li class='page-item'><a class='page-link' href='/CLARETe/shop/prodView.cl?p_num="+p_num
									+ "&sizePerPage=" + sizePerPage +"&currentShowPageNo=1#review_box'>처음</a></li>";
						}
										
						if (pageNo != 1) {
							pageBar += "<li class='page-item'><a class='page-link' href='/CLARETe/shop/prodView.cl?p_num=" +p_num
									+ "&sizePerPage=" +sizePerPage + "&currentShowPageNo="
									+ (pageNo - 1) + "#review_box'>이전</a></li>";
						}
						
					
						while (!(loop > blockSize || pageNo > totalReview)) {

							if (pageNo == Integer.parseInt(currentShowPageNo)) {
								pageBar += "<li class='page-item active'><a class='page-link' href='#'>" + pageNo + "</a></li>";

							} else {
								pageBar += "<li class='page-item'><a class='page-link' href='/CLARETe/shop/prodView.cl?p_num="+p_num
										+ "&sizePerPage=" + sizePerPage+"&currentShowPageNo="
										 + pageNo + "#review_box'>" + pageNo + "</a></li>";
							}

							loop++; // 1 2 3 4 5 6 7 8 9 10 11 12 13 ...

							pageNo++; // 1 2 3 4 5 6 7 8 9 10 ...
										// 11 12 13 14 15 16 17 18 19 20 ...
										// 21 22 23 24 25 26 27 28 29 30 ...
										// 31 32
						} // end of while()-----------------------------

						// *** [다음][마지막] 만들기 *** //
						// pageNo ==> 11
						
						
						
						if (pageNo <= totalReview) {
							pageBar += "<li class='page-item'><a class='page-link' href='/CLARETe/shop/prodView.cl?p_num="+p_num
									+ "&sizePerPage=" + sizePerPage + "&currentShowPageNo=" + pageNo
									+ "'>다음</a></li>";
						}
						if(totalReview != 0) {
						pageBar += "<li class='page-item'><a class='page-link' href='/CLARETe/shop/prodView.cl?p_num="+p_num
								+ "&sizePerPage=" + sizePerPage +"&currentShowPageNo=" + totalReview
								+ "'>마지막</a></li>";
						}
						
					  
						
						
					
						
						// ==== 페이지바 만들기 끝 ==== //
			
			// =========================== 유진작성 =========================== //
			
			
			// System.out.println("리스트 사이즈 : "+ovo.size());
			
			request.setAttribute("pvo", pvo);
			request.setAttribute("ovo", ovo);
			request.setAttribute("m_id", m_id);
			
			
			// =========================== 유진작성 =========================== //
			request.setAttribute("rvo", rvo);
			request.setAttribute("orderCheck", orderCheck);
			request.setAttribute("pageBar", pageBar);
			request.setAttribute("totalReview", totalReview);
			request.setAttribute("sizePerPage", sizePerPage);
			request.setAttribute("reviewCnt", reviewCnt);				
			// =========================== 유진작성 =========================== //
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/myshop/prodView.jsp");
			
		}
		else { // post 로 들어온 경우
			
			
			// 해당 로직에서 즉시 구매하기의 경우가 발생하면 됩니다! 다른 서블릿 받아도 되긴함
			
			
			
			
			
			// =========================== 리뷰작성 =========================== //
			
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
				//여기boolean isExist = rdao.OderReviewCheck(fk_m_id, p_num);
				//System.out.println("OderReviewCheck = "+isExist);
							
				/*
				for(int i=0;i<OderReviewCheck.size();i++) {
					int listP = OderReviewCheck.get(i).getFk_p_num();
					
					if(listP == Integer.parseInt(p_num)) {
						isExist=  true;
					}
				}
				*/					
				/*
				if (!isExist) {
					System.out.println("구매후 배송완료된 이력에 없는 제품입니다.");
					message = "구매후 배송완료된 이력에 없는 제품입니다.";
					loc = request.getContextPath()  + "/index.cl";
					return;
				}
				else {	*/				
					int Review = rdao.ReviewUpload(rvo);
					
					if (Review == 1) {	
						System.out.println("리뷰가 등록되었습니다.");
						message = "리뷰가 등록되었습니다.";
						loc = request.getContextPath()  + "/index.cl";			   		    
					}
					else {
						message = "리뷰 등록에 실패했습니다.";
					}										
					/* } */
				
			} catch (SQLException e) {
				e.printStackTrace();
				loc = "javascript:history.back()";		// JS를 이용한 이전페이지로 이동하는 것
			}
						
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// =========================== 리뷰작성 =========================== //
			
			
		}
		
		

	}

}
