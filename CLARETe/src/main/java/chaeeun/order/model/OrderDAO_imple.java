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

	
	// tbl_order에 주문 insert
	@Override
	public int insertOrder(Map<String, String> paraMap) throws SQLException {

		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			// status 배송현황 (0: 배송전, 1: 배송중, 2: 배송완료)
			String sql = " insert into tbl_order (o_num, fk_m_id, fk_d_num, o_date, status, o_price, o_cnt) "
					   + " values(seq_order.nextVal, ?, ?, sysdate, 0, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("fk_m_id"));
			pstmt.setInt(2, Integer.parseInt(paraMap.get("fk_d_num")));
			pstmt.setString(3, paraMap.get("o_price"));
			pstmt.setInt(4, Integer.parseInt(paraMap.get("o_cnt")));
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}

	// 결제 완료되면 장바구니꺼 delete
	@Override
	public int deleteCart(List<String> cNumList) throws SQLException {

		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " delete from tbl_cart where c_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			for (String cNum : cNumList) {
	            pstmt.setString(1, cNum); 
	            n += pstmt.executeUpdate(); 
	        }
			
		} finally {
			close();
		}
		
		return n;
	}

}
