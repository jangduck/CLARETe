package chaeeun.order.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

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
	
	// tbl_order 테이블에 insert
	@Override
	public int insertOrder(Map<String, String> paraMap) throws SQLException {

		int n = 0;		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_order (o_num, fk_m_id, fk_d_num, o_date, status, o_price, o_cnt) "
					   + " values(o_num, 'gold12', 54, sysdate, 0, '5', 2) ";
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}

	// 결제 완료되면 장바구니꺼 delete
	@Override
	public void deleteCart(List<String> cNumList) throws SQLException {

		try {
			
			conn = ds.getConnection();
			
			String sql = " delete from tbl_cart where c_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			for (String cNum : cNumList) {
	            pstmt.setString(1, cNum); 
	            pstmt.executeUpdate(); 
	        }
			
		} finally {
			close();
		}
	}

	// 포인트 사용액 update
	@Override
	public void updatePoint(Map<String, String> paraMap) throws SQLException {

		try {

			conn = ds.getConnection();

			String sql = " update tbl_member set m_point = m_point - ? "
					   + " where m_id = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(paraMap.get("m_point")));
			pstmt.setString(2, paraMap.get("fk_m_id"));

			pstmt.executeUpdate(); 

		} finally {
			close();
		}
		
	}

	
	// 구매금액의 1% 포인트로 추가 update
	@Override
	public void addPurchasePoints(Map<String, String> paraMap) throws SQLException {

		try {

			conn = ds.getConnection();

			int pointsToAdd = (int) Math.floor(Integer.parseInt(paraMap.get("o_price")) * 0.01);
			
			String sql = " update tbl_member set m_point = m_point + ? " 
			           + " where m_id = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pointsToAdd);
			pstmt.setString(2, paraMap.get("fk_m_id"));

			pstmt.executeUpdate();

		} finally {
			close();
		}
		
	}

	

}