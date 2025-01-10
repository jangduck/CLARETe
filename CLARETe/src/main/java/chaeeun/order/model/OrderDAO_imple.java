package chaeeun.order.model;

import java.io.UnsupportedEncodingException;
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

import option.domain.OptionVO;
import order.domain.OrderVO;
import orderdetail.domain.orderdetailVO;
import product.domain.ProductVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class OrderDAO_imple implements OrderDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private AES256 aes;

	// 생성자
	public OrderDAO_imple() {

		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/semioracle");

			aes = new AES256(SecretMyKey.KEY);
			// SecretMyKey.KEY 은 우리가 만든 암호화/복호화 키이다.
			//

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	// 사용한 자원을 반납하는 close() 메소드 생성하기
	private void close() {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// end of private void close()---------------

	// 채번하기
	@Override
	public int getPnum() throws SQLException {

		int pnum = 0;

		try {

			conn = ds.getConnection();

			String sql = " select seq_order.nextval as pnum " + " from dual ";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			rs.next();
			pnum = rs.getInt("pnum");

		} finally {
			close();
		}

		return pnum;

	}

	
	// 주문 select
	@Override
	public OrderVO selectOrder(String pnum) throws SQLException {
		
		OrderVO ovo = new OrderVO();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select o_num, fk_m_id, fk_d_num, o_date, status, o_price, o_cnt "
					   + " from tbl_order "
					   + " where o_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, Integer.parseInt(pnum));
	        
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	        	ovo.setO_num(rs.getInt("o_num"));
	        	ovo.setFk_m_id(rs.getString("fk_m_id"));
	        	ovo.setFk_d_num(rs.getInt("fk_d_num"));
	        	ovo.setO_date(rs.getString("o_date"));
	        	ovo.setStatus(rs.getInt("status"));
	        	ovo.setO_price(rs.getString("o_price"));
	        	ovo.setO_cnt(rs.getInt("o_cnt"));
	        }
			
	        
		} finally {
			close();
		}
		
		return ovo;
		
	}

	// 주문상세 select
	@Override
	public List<orderdetailVO> selectOrderDetail(String pnum) throws SQLException {
		
		List<orderdetailVO> odvoList = new ArrayList<>();
		
		try {

			conn = ds.getConnection();

			String sql = " SELECT od.od_num, od.fk_p_num, od.fk_o_num, od.od_count, od.od_price, od.fk_op_num, "
			           + " op.op_num, op.op_ml, op.op_price "
			           + " FROM tbl_orderdetail od "
			           + " JOIN tbl_option op "
			           + " ON od.fk_op_num = op.op_num "
			           + " WHERE od.fk_o_num = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				orderdetailVO odvo = new orderdetailVO();
				
				odvo.setOd_num(rs.getInt("od_num"));
				odvo.setFk_p_num(rs.getInt("fk_p_num"));
				odvo.setFk_o_num(rs.getInt("fk_o_num"));
				odvo.setOd_count(rs.getInt("od_count"));
				odvo.setOd_price(rs.getString("od_price"));

				OptionVO opvo = new OptionVO();
				opvo.setOp_num(rs.getInt("op_num")); 
	            opvo.setOp_ml(rs.getString("op_ml"));
	            opvo.setOp_price(rs.getString("op_price")); 
				odvo.setOptionvo(opvo);
				
				odvoList.add(odvo);
			}

		} finally {
			close();
		}
		
		return odvoList;
	}

	// 주문 수동커밋
	@Override
	public int orderTransaction(Map<String, String> paraMap, List<Map<String, String>> orderList, List<String> cNumList) throws SQLException {

		int pnum = 0;
		
		try {
			
			conn = ds.getConnection();
			conn.setAutoCommit(false);	// 수동 커밋쓰
			
			// 1. 채번하기 (뭐를? 주문번호를)
			String sql = " select seq_order.nextval as pnum from dual ";
			try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
				rs = pstmt.executeQuery();
				if (rs.next()) {
					pnum = rs.getInt("pnum");
				}
			}
			
			
			// 2. tbl_order에 insert
			sql = " insert into tbl_order (o_num, fk_m_id, fk_d_num, o_date, status, o_price, o_cnt) "
				+ "	values(?, ?, ?, sysdate, 0, ?, ?) ";
			try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
				
				pstmt.setInt(1, pnum);
				pstmt.setString(2, paraMap.get("fk_m_id"));
				pstmt.setInt(3, Integer.parseInt(paraMap.get("fk_d_num")));
				pstmt.setString(4, paraMap.get("o_price"));		// o_price 컬럼 NVARCHAR2임
				pstmt.setInt(5, Integer.parseInt(paraMap.get("o_cnt")));
				
				pstmt.executeUpdate(); 
			}
			
			
			// 3. tbl_orderdetail에 insert
			sql = " insert into tbl_orderdetail (od_num, fk_p_num, fk_o_num, od_count, od_price, fk_op_num) "
				+ " values (seq_orderdetail.nextVal, ?, ?, ?, ?, ?) ";
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) { 
				
				for (int i = 0; i < orderList.size(); i++) {
					Map<String, String> orderDetail = orderList.get(i);
					pstmt.setInt(1, Integer.parseInt(orderDetail.get("fk_p_num")));
					pstmt.setInt(2, pnum);
					pstmt.setInt(3, Integer.parseInt(orderDetail.get("od_count")));
					pstmt.setString(4, orderDetail.get("od_price"));
					pstmt.setInt(5, Integer.parseInt(orderDetail.get("fk_op_num")));

					pstmt.executeUpdate(); 
				}
				
			}

			
			// 4. tbl_cart에서 delete
			sql = " delete from tbl_cart where c_num = ? ";
			try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
				for (String cNum : cNumList) {
		            pstmt.setString(1, cNum); 
		            pstmt.executeUpdate(); 
		        }
			}
			
			
			// 5. 포인트 사용액 차감 update
			sql = " update tbl_member set m_point = m_point - ? "
				+ " where m_id = ? ";
			try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
				pstmt.setInt(1, Integer.parseInt(paraMap.get("m_point")));
				pstmt.setString(2, paraMap.get("fk_m_id"));
				pstmt.executeUpdate(); 
			}
			
			
			// 6. 구매금액의 1% 포인트로 update
			int pointsToAdd = (int) Math.floor(Integer.parseInt(paraMap.get("o_price")) * 0.01);
			sql = " update tbl_member set m_point = m_point + ? " 
			    + " where m_id = ? ";
			try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
				pstmt.setInt(1, pointsToAdd);
				pstmt.setString(2, paraMap.get("fk_m_id"));
				pstmt.executeUpdate();
			}
			
			
			conn.commit();		// 다 성공해야 커밋쓰
			
		} catch (SQLException e) {
			
			if (conn != null) {
				conn.rollback();	// 하나라도 실패시 롤백~~
				pnum = 0;
			}
			e.printStackTrace();
			
		} finally {
			
			if (conn != null) {
	            conn.setAutoCommit(true); // 자동 커밋 복구
	            conn.close();
	        }
			
		}
		
		return pnum;
	}

	
	@Override
	public ProductVO purchaseProduct(String p_num) throws SQLException {

		ProductVO pvo = new ProductVO();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select p_num, p_name, p_sale, p_image, p_price "
					   + " from tbl_product "
					   + " where p_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(p_num));

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				pvo.setP_num(rs.getInt("p_num"));
				pvo.setP_name(rs.getString("p_name"));
				pvo.setP_sale(rs.getString("p_sale"));
				pvo.setP_image(rs.getString("p_image"));
				pvo.setP_price(rs.getInt("p_price"));
				
			}
			
		} finally {
			close();
		}
		
		return pvo;
	}

	
	@Override
	public OptionVO purchaseProductOption(String op_num, String p_num) throws SQLException {
		
		OptionVO opvo = new OptionVO();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select op_num, fk_p_num, op_ml, op_price "
				       + " from tbl_option "
				       + " where op_num = ? and fk_p_num = ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(op_num));
		pstmt.setInt(2, Integer.parseInt(p_num));
		
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			
			opvo.setOp_num(rs.getInt("op_num"));
			opvo.setFk_p_num(rs.getInt("fk_p_num"));
			opvo.setOp_ml(rs.getString("op_ml"));
			opvo.setOp_price(rs.getString("op_price"));
			
		}
		
		} finally {
			close();
		}
		
		return opvo;
			
	}

	
	// 제품 하나 구매 (바로 구매하기)
	@Override
	public int oneOrderTransaction(Map<String, String> paraMap, Map<String, String> paraMap2, Map<String, String> paraMap3, Map<String, String> paraMap4) throws SQLException {

		int pnum = 0;
		
		try {
			
			conn = ds.getConnection();
			conn.setAutoCommit(false);	// 수동 커밋쓰

			// 1. 채번하기
			String sql = " select seq_order.nextval as pnum from dual ";
			try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
				rs = pstmt.executeQuery();
				if (rs.next()) {
					pnum = rs.getInt("pnum");
				}
			}

			
			// 2. tbl_order에 insert
			sql = " insert into tbl_order (o_num, fk_m_id, fk_d_num, o_date, status, o_price, o_cnt) "
				+ "	values(?, ?, ?, sysdate, 0, ?, 1) ";
			try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
				
				pstmt.setInt(1, pnum);
				pstmt.setString(2, paraMap.get("m_id"));
				pstmt.setInt(3, Integer.parseInt(paraMap.get("d_num")));
				pstmt.setString(4, paraMap.get("o_price"));		// o_price 컬럼 NVARCHAR2임
				
				pstmt.executeUpdate(); 
				
			}
			
			
			// 3. tbl_orderdetail에 insert
			sql = " insert into tbl_orderdetail (od_num, fk_p_num, fk_o_num, od_count, od_price, fk_op_num) "
				+ " values (seq_orderdetail.nextVal, ?, ?, ?, ?, ?) ";
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) { 
				
				pstmt.setInt(1, Integer.parseInt(paraMap2.get("p_num")));
				pstmt.setInt(2, pnum);
				pstmt.setInt(3, Integer.parseInt(paraMap2.get("od_count")));
				pstmt.setString(4, paraMap2.get("od_price"));
				pstmt.setInt(5, Integer.parseInt(paraMap2.get("op_num")));
				
				pstmt.executeUpdate(); 
				
			}
			
			
			// 4. 포인트 사용액 차감 update
			sql = " update tbl_member set m_point = m_point - ? "
				+ " where m_id = ? ";
			try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
				
				pstmt.setInt(1, Integer.parseInt(paraMap3.get("m_point")));
				pstmt.setString(2, paraMap.get("m_id"));
				
				pstmt.executeUpdate(); 

			}
			
			
			// 5. 구매금액의 1% 포인트로 update
			int pointsToAdd = (int) Math.floor(Integer.parseInt(paraMap4.get("o_price")) * 0.01);
			sql = " update tbl_member set m_point = m_point + ? " 
			    + " where m_id = ? ";
			try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
				
				pstmt.setInt(1, pointsToAdd);
				pstmt.setString(2, paraMap4.get("m_id"));
				
				pstmt.executeUpdate();
			}
			
			conn.commit();		// 다 성공해야 커밋쓰
			
		} catch (SQLException e) {
			
			if (conn != null) {
				conn.rollback();	// 하나라도 실패시 롤백~~
				pnum = 0;
			}
			e.printStackTrace();
			
		} finally {
			
			if (conn != null) {
	            try {
	                conn.setAutoCommit(true); 
	                conn.close(); // 반드시 연결 닫기
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
		}
		
		return pnum;
	}

	// 주문상세 뿌리기용
	@Override
	public orderdetailVO selectOrdrDetail(String pnum) throws SQLException {

		orderdetailVO odvo = new orderdetailVO();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select fk_o_num, od_count from tbl_orderdetail where fk_o_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(pnum));
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				odvo.setFk_o_num(rs.getInt("fk_o_num"));
				odvo.setOd_count(rs.getInt("od_count"));
			}
			
		} finally {
			close();
		}
		
		return odvo;
	
	}


}