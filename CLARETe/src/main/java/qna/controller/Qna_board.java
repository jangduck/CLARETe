package qna.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.AbstractController;
import faq.domain.FaqVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.domain.MemberVO;
import qna.domain.QnaVO;
import youjin.qna.model.*;


public class Qna_board extends AbstractController {
	
	private QnaDAO qdao = new QnaDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String method = request.getMethod();
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if("get".equalsIgnoreCase(method)) {	
			
			
			
			String sizePerPage = request.getParameter("sizePerPage");
			String currentShowPageNo = request.getParameter("currentShowPageNo"); 
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			if(sizePerPage == null) {
				sizePerPage = "10";
			}
				
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("sizePerPage", sizePerPage);
			paraMap.put("currentShowPageNo", currentShowPageNo); 
			
			// 페이징 처리를 위한 총페이지수 알아오기 //
			int totalPage = qdao.getTotalPageA(paraMap);
			
			
			try {
				if(Integer.parseInt(currentShowPageNo) > totalPage || Integer.parseInt(currentShowPageNo) <= 0 ) {
					currentShowPageNo = "1";
					paraMap.put("currentShowPageNo",currentShowPageNo);
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo",currentShowPageNo);
			}
			
			String pageBar = "";
			
			int blockSize = 10;
	        // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
			
			int loop = 1;
	        // loop 는 1 부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다.
			
			// ==== !!! 다음은 pageNo 구하는 공식이다. !!! ==== // 
	        int pageNo  = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1; 
	        
	        // === !!! [맨처음][이전] 만들기 === *** //        
	        pageBar += "<li class='page-item'><a class='page-link' href='qna_board.cl?sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";
	        
	        if(pageNo != 1) {
	        	pageBar += "<li class='page-item'><a class='page-link' href='qna_board.cl?sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	        }
	        
	        while(!(loop > blockSize || pageNo > totalPage)) {
	        	if(pageNo == Integer.parseInt(currentShowPageNo)) {
	        		pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+ pageNo + "</a></li>";
	        	}
	        	else {
	        		pageBar += "<li class='page-item'><a class='page-link' href='qna_board.cl?sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+ pageNo + "</a></li>";
	        	}
	        	
	        	loop++; // 1 2 3 4 5 ...
	        	pageNo++; // 1 2 3 4 5 ...
			} // end of while
	        
	        // *** [다음][마지막] 만들기 *** //
			if (pageNo <= totalPage) { // 위의 while 문을 빠져나오면 pageNo 는 43으로 빠져나오기 때문에 <= 를 조건식으로 둔다.
				pageBar += "<li class='page-item'><a class='page-link' href='qna_board.cl?sizePerPage=" + sizePerPage + "&currentShowPageNo=" + pageNo
						+ "'>[다음]</a></li>";
			}

			pageBar += "<li class='page-item'><a class='page-link' href='qna_board.cl?sizePerPage=" + sizePerPage + "&currentShowPageNo=" + totalPage
					+ "'>[마지막]</a></li>";
			
			
			
			
			try {
				List<QnaVO> qnaList = qdao.qnaList(paraMap);
				
				request.setAttribute("qnaList", qnaList);
				request.setAttribute("sizePerPage", sizePerPage);
				request.setAttribute("pageBar", pageBar);
				
				/* >>> 뷰단(adminBoard.jsp)에서 "페이징 처리시 보여주는 순번 공식" 에서 사용하기 위해 게시물의 총개수 알아오기 시작 <<< */
				int totalMemberCount = qdao.getTotalQnaCount(paraMap);
				
				request.setAttribute("totalMemberCount", totalMemberCount);
				request.setAttribute("currentShowPageNo", currentShowPageNo);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/qna/qna_board.jsp");
				
			} catch(SQLException e) {
				e.printStackTrace();
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"index.cl");
			}
			
			 
			
		} // end of if("get".equalsIgnoreCase(method))--------
		
		
	}

}
