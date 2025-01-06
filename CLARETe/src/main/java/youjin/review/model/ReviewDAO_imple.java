package youjin.review.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import delivery.domain.DeliveryVO;
import faq.domain.FaqVO;
import member.domain.MemberVO;
import order.domain.OrderVO;
import orderdetail.domain.orderdetailVO;
import product.domain.ProductVO;
import qna.domain.QnaVO;
import review.domain.ReviewVO;

public class ReviewDAO_imple implements ReviewDAO {

	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	

	 // 생성자
	   public ReviewDAO_imple() {
	      
	      try {
	         Context initContext = new InitialContext();
	         Context envContext  = (Context)initContext.lookup("java:/comp/env");
	         ds = (DataSource)envContext.lookup("jdbc/semioracle");
	          
				/* aes = new AES256(SecretMyKey.KEY); */
	          // SecretMyKey.KEY 은 우리가 만든 암호화/복호화 키이다.
	          
	      } catch(NamingException e) {
	         e.printStackTrace();
	      } 
	   }
	

		// 사용한 자원을 반납하는 close() 메소드 생성하기
		private void close() {
			try {
				if(rs    != null) {rs.close();	  rs=null;}
				if(pstmt != null) {pstmt.close(); pstmt=null;}
				if(conn  != null) {conn.close();  conn=null;}
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}// end of private void close()---------------

	   
	
	//리뷰 등록
	@Override
	public int ReviewUpload(ReviewVO rvo) throws SQLException {
		
		int Review = 0;
		try {
			  conn = ds.getConnection();
			  
			  String sql = " insert into tbl_review(R_NUM, FK_M_ID, FK_P_NUM, R_STAR, R_MSG) "
			  			+ " values(seq_review.nextval, ?, ?, ?, ?) "; 
			  
			  pstmt = conn.prepareStatement(sql);
			  
			  pstmt.setString(1, rvo.getFk_m_id());
			  pstmt.setInt(2, rvo.getFk_p_num());
			  pstmt.setInt(3, rvo.getR_star());
			  pstmt.setString(4, rvo.getR_msg());
			  
			
		  
			  Review = pstmt.executeUpdate();
		
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			
		} finally {
			close();
		}
			return Review;
		
	}//end of public int ReviewUpload(ReviewVO rvo) throws SQLException {}

	
	
	
	// 리뷰 작성 가능한 목록보기
	@Override
	public List<ReviewVO> myreviewUpList(String fk_m_id) throws SQLException {
		List<ReviewVO> myreviewUpList = new ArrayList<ReviewVO>();

		try {
			conn = ds.getConnection();
			System.out.println("리뷰작성가능게시판222!");
			String sql = " SELECT m_id "
					+ "     ,d_name, d_mobile, d_address, d_detail_address, d_extra"
					+ "     ,o_num, o_date "
					+ "     ,od_count, fk_op_num, od_price "
					+ "     ,p_image, p_name, p_num "
					+ " FROM tbl_member M "
					+ " join tbl_delivery D "
					+ " ON M.m_id = D.fk_m_id "
					+ " join tbl_order O "
					+ " ON D.fk_m_id = O.fk_m_id "
					+ " join tbl_orderdetail OD "
					+ " ON O.o_num = OD.fk_o_num "
					+ " join tbl_product P "
					+ " ON OD.fk_p_num = P.p_num "
					+ " WHERE m_id = ? and status = 2 "
					+ " order by o_num desc ";
			
			pstmt = conn.prepareStatement(sql);
				
			pstmt.setString(1,fk_m_id);	
			System.out.println("보여줄 아이디값 나 임플~ "+fk_m_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewVO rvo = new ReviewVO();
				
				// System.out.println("됨??");
				
				MemberVO mvo = new MemberVO();	
				mvo.setM_id("m_id");
				/*
				mvo.setM_address(rs.getString("m_address"));
				mvo.setM_detail_address(rs.getString("m_detail"));
				mvo.setM_detail_address(rs.getString("m_detail_address"));
				mvo.setM_extra(rs.getString("m_extra"));
				mvo.setM_mobile(rs.getString("m_mobile"));
				*/
				rvo.setMvo(mvo);
				
				DeliveryVO dvo = new DeliveryVO();
				dvo.setD_name(rs.getString("d_name"));
				dvo.setD_mobile(rs.getString("d_mobile"));
				dvo.setD_address(rs.getString("d_address"));
				dvo.setD_detail_address(rs.getString("d_detail_address"));
				dvo.setD_extra(rs.getString("d_extra"));
				rvo.setDvo(dvo);
				
				OrderVO ovo = new OrderVO();
				ovo.setO_num(rs.getInt("o_num"));
				ovo.setO_date(rs.getString("o_date"));				
				rvo.setOvo(ovo);
				
				orderdetailVO odvo = new orderdetailVO();
				odvo.setOd_count(rs.getInt("od_count"));
				odvo.setFk_op_num(rs.getInt("fk_op_num"));
				odvo.setOd_price(rs.getString("od_price"));
				rvo.setOdvo(odvo);
				
				ProductVO pvo = new ProductVO();
				pvo.setP_image(rs.getString("p_image"));
				pvo.setP_name(rs.getString("p_name"));
				pvo.setP_num(rs.getInt("p_num"));
				rvo.setPvo(pvo);
				
				myreviewUpList.add(rvo);
				
				// System.out.println(rvo.getMvo().getM_name());
				
				// System.out.println("myreviewUpList 에 담음");
			}
			
			} catch (SQLException e) {		
				e.printStackTrace();
				
			} finally {
				close();
			}
		
		return myreviewUpList;
	}

	
	// 작성한 리뷰 보기
	@Override
	public List<ReviewVO> myreviewList(String fk_m_id) throws SQLException {
		
		List<ReviewVO> myreviewList = new ArrayList<>();

		try {
			conn = ds.getConnection();
	
			String sql = " select M.m_id, R.r_register, R.r_msg, R.r_star, R.fk_p_num "
					+ "      ,P.p_image,P.p_name "
					+ "      ,od_count, fk_op_num "
					+ " from tbl_member M "
					+ " join tbl_review R "
					+ " on M.m_id = R.fk_m_id "
					+ " join tbl_product P "
					+ " on P.p_num = R.fk_p_num "
					+ " join tbl_orderdetail OD "
					+ " ON P.p_num = OD.fk_p_num "
					+ " where M.m_id = ? "
					+ " order by r_register desc ";
			
			pstmt = conn.prepareStatement(sql);
				
			pstmt.setString(1,fk_m_id);		
			System.out.println("보여줄 아이디값"+fk_m_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewVO rvo = new ReviewVO();
				rvo.setR_register(rs.getString("r_register"));
				rvo.setR_msg(rs.getString("r_msg"));
				rvo.setR_star(rs.getInt("r_star"));
				rvo.setFk_p_num(rs.getInt("fk_p_num"));
						
				MemberVO mvo = new MemberVO();	
				mvo.setM_id("m_id");			
				rvo.setMvo(mvo);
				
				orderdetailVO odvo = new orderdetailVO();
				odvo.setOd_count(rs.getInt("od_count"));
				odvo.setFk_op_num(rs.getInt("fk_op_num"));			
				rvo.setOdvo(odvo);
								
				ProductVO pvo = new ProductVO();				
				pvo.setP_image(rs.getString("p_image"));
				pvo.setP_name(rs.getString("p_name"));
				rvo.setPvo(pvo);
							
				myreviewList.add(rvo);						
				System.out.println("myreviewList 에 담음");
			}
			
			} catch (SQLException e) {		
				e.printStackTrace();
				
			} finally {
				close();
			}
		
		return myreviewList;
		
	}

	// 구매한 제품이 맞는지 확인하기
	@Override
	public boolean OderReviewCheck(String fk_m_id, String p_num) throws SQLException {
		boolean isEx = false;
		//List<ReviewVO> OderReviewCheck = new ArrayList<ReviewVO>();
		try {
			  conn = ds.getConnection();
			  
			  String sql = " select p_num, fk_m_id, o_num "
				  		 + " from tbl_order O "
				  		 + " join tbl_orderdetail OD "
				  		 + " on O.o_num = OD.fk_o_num "
				  		 + " join tbl_product P "
				  		 + " on  P.p_num = OD.fk_p_num "
				  		 + " where fk_m_id = ?  and p_num = ? and status = 2 "; 
				  
						  		  
			  pstmt = conn.prepareStatement(sql);
				
			  pstmt.setString(1,fk_m_id);
			  pstmt.setString(2,p_num);	
			  rs = pstmt.executeQuery();
			  
			  isEx = rs.next();
			  // n = pstmt.executeUpdate();
			  System.out.println("리뷰작성준비");
			  /*
			  if(rs.next()) {
					ReviewVO rvo = new ReviewVO();
										
					ProductVO pvo = new ProductVO();									
					pvo.setP_num(rs.getInt("p_num"));
					rvo.setPvo(pvo);
					System.out.println("주문번호"+rvo.getPvo().getP_num());
					
					//OderReviewCheck.add(rvo);	
					System.out.println("p_num 조회"+rvo.getPvo().getP_num());
			  }
			  */
			
		}
	    catch (SQLException e) {
			
			e.printStackTrace();
			
		} finally {
			close();
		}
			return isEx;

	}// end of public int OderReviewCheck(ReviewVO rvo) throws SQLException {}


	
	
	
	// 해당 제품에 달린 리뷰들을 불러온다
	@Override
	public List<ReviewVO> reviewList(int p_num) throws SQLException {
		
		List<ReviewVO> reviewList = new ArrayList<>();
	
		try {		
			conn = ds.getConnection();
			
			String sql = " select fk_p_num, fk_m_id, r_star, r_msg, r_register "
					   + " from tbl_review "
					   + " where fk_p_num = ? "
					   + " order by r_register desc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,p_num);			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewVO rvo = new ReviewVO();		
				rvo.setFk_m_id(rs.getString("fk_m_id"));
				rvo.setR_star(rs.getInt("r_star"));
				rvo.setR_msg(rs.getString("r_msg"));
				rvo.setR_register(rs.getString("r_register"));
			
				reviewList.add(rvo);
				
			}
					
		}   finally {
			close();
		}
		
		return reviewList;
	}



}
