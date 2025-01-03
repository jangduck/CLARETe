package delivery.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
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
import option.domain.OptionVO;
import order.domain.OrderVO;
import product.domain.ProductVO;





public class DeliveryDAO_imple implements DeliveryDAO {
	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public DeliveryDAO_imple(){
		
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	
	
}
	
	private void close() {
		try {
			if(rs    != null) {rs.close();	  rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn  != null) {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}// end of private void close()---------------

	
	
	// == --------- 배송지 입력을 위한 메소드 --------- == //
	@Override
	public int InsertDelivery(DeliveryVO delivery) throws SQLException {
		
		int result = 0;
		
		//2024_12_16 수정 중
		try {
			
				conn = ds.getConnection();
		
			 
			String sql= " insert into tbl_delivery(d_num,   d_name, d_address, d_detail_address, d_postcode, d_extra, d_mobile, fk_m_id) "
					  + "       values(seq_delivery.NEXTVAL,?,?,?, ?, ?,?,?) ";
			
			pstmt=conn.prepareStatement(sql);
			//System.out.println(delivery.getD_postcode());

			pstmt.setString(1, delivery.getD_name());
			pstmt.setString(2, delivery.getD_address());
			pstmt.setString(3, delivery.getD_detail_address());
			pstmt.setString(4, delivery.getD_postcode());
			pstmt.setString(5, delivery.getD_extra());
			pstmt.setString(6, delivery.getD_mobile());
			pstmt.setString(7, delivery.getFk_m_id());
			
			
			result = pstmt.executeUpdate();
			
			
		} catch(SQLException e) {
		 e.printStackTrace();
		} finally {
			close();
		}
		
		
		return result;
	}
	
	
	//배송지 조회를 위한 메소드 
	@Override
	public List<DeliveryVO> selectDeliveryList(String m_id) throws SQLException {
		
		List<DeliveryVO> selectDeliveryList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "  select d_num, d_address, d_detail_address, d_postcode, d_extra, d_mobile, d_name "
					   + "  from tbl_delivery "
					   + "  where fk_m_id = ? and d_status = 0 ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DeliveryVO dvo = new DeliveryVO();
				
				dvo.setD_num(rs.getInt(1));
				dvo.setD_address(rs.getString(2));
				dvo.setD_detail_address(rs.getString(3));
				dvo.setD_postcode(rs.getString(4));
				dvo.setD_extra(rs.getString(5));
				dvo.setD_mobile(rs.getString(6));
				dvo.setD_name(rs.getString(7));
				
				selectDeliveryList.add(dvo);
				
			}// end of while(rs.next());----------------------------------------
			
		} catch(SQLException e) {
			 e.printStackTrace();	
		}finally {close();}
		
		return selectDeliveryList;
	}


	
	// 최근 주문 조회 배송지를 위한 메소드
	@Override
	public List<OrderVO> recentOrderDelivery(String m_id) throws SQLException {
		List<OrderVO> recentOrderDelivery = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " Select P.p_name as 제품명, "
					+ "       O.o_price as 주문금액, "
					+ "       count(O.o_num) as 주문수량, "
					+ "       OP.op_ml as 용량, "
					+ "       D.d_name as 받는사람, "
					+ "       D.d_address as 받는사람주소, "
					+ "       D.d_detail_address as 상세주소, "
					+ "       D.d_mobile as 전화번호, "
					+ "       O.o_date as 주문날짜 "
					+ " FROM tbl_order O left join tbl_product P ON O.o_num = P.p_num "
					+ "   left join tbl_delivery D on O.o_num = D.d_num "
					+ "   left join tbl_option OP on O.o_num = OP.op_num "
					+ "   where O.fk_m_id = ? "
					+ "   GROUP BY "
					+ "    P.p_name, O.o_price, OP.op_ml, D.d_name, D.d_address, D.d_detail_address, D.d_mobile,O.o_date "
					+ "    order by O.o_date  "; 
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, m_id); // 조건

			rs=pstmt.executeQuery(); // sql select 문을 실행.
			
			while(rs.next()) {// 한 행씩 처리하기
				
				OrderVO ovo = new OrderVO();
				
				ovo.setO_price(rs.getString("o_price"));
				ovo.setO_num(rs.getInt("o_num"));
				ovo.setO_date(rs.getString("o_date"));
				
			   OptionVO opvo = new OptionVO();
			   opvo.setOp_ml(rs.getString("op_ml"));
			   ovo.setOptionvo(opvo);
			   
			   ProductVO pvo = new ProductVO();
			   pvo.setP_name(rs.getString("p_name"));
			   ovo.setProductvo(pvo);
			   
			   DeliveryVO dvo = new DeliveryVO();
			   dvo.setD_name(rs.getString("d_name"));
			   dvo.setD_address(rs.getString("d_address"));
			   dvo.setD_detail_address(rs.getString("d_detail_address"));
			   ovo.setDeliveryvo(dvo);
			   
			   recentOrderDelivery.add(ovo);
			
			  
			} // end of while(rs.next())--------------------------------------------
			
		} catch(SQLException e) {
			 e.printStackTrace();		
		}finally {close();}
		return recentOrderDelivery;
	}

	//배송지 삭제
	@Override
	public int DeleteDelivery(String m_id, String d_num) throws SQLException {
		int n = 0 ;
	    
	    try {
	        conn = ds.getConnection();
	        
	        // DELETE 쿼리
	        String sql = " update tbl_delivery set d_status = 1  "
	        		   + " where fk_m_id =? and d_num = ? ";
	        
	        pstmt = conn.prepareStatement(sql);
	        
	        
	        pstmt.setString(1, m_id);
	        pstmt.setString(2, d_num);
	        
	        n = pstmt.executeUpdate();
	        
	        if (n > 0) {
	            System.out.println("삭제 성공: " + n + "개의 행이 삭제되었습니다.");
	            
	               
	        } else {
	            System.out.println("삭제 실패: 해당하는 배송지가 존재하지 않습니다.");
	        }   
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close();  
	        }
	    
	    return n;
	    
	    
	}

	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//---------------------------------------------------- 좀 빌려쓸게요 (채은)
	// 배송지 조회 하나만
	@Override
	public DeliveryVO selectOneDelivery(String d_num) throws SQLException {

		DeliveryVO dvo = new DeliveryVO();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select d_num, fk_m_id, d_address, d_detail_address, d_postcode, d_extra, d_mobile, d_name, d_status "
					   + " from tbl_delivery "
					   + " where d_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, d_num);
	        
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	        	dvo.setD_num(rs.getInt("d_num"));
	        	dvo.setFk_m_id(rs.getString("fk_m_id"));
	        	dvo.setD_address(rs.getString("d_address"));
	        	dvo.setD_detail_address(rs.getString("d_detail_address"));
	        	dvo.setD_postcode(rs.getString("d_postcode"));
	        	dvo.setD_extra(rs.getString("d_extra"));
	        	dvo.setD_mobile(rs.getString("d_mobile"));
	        	dvo.setD_name(rs.getString("d_name"));
	        }
			
			
		} finally {
			close();
		}
		
		return dvo;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
	
	
	

