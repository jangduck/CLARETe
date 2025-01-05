package chaeeun.product.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import option.domain.OptionVO;
import product.domain.ProductVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class ProductDAO_imple implements ProductDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private AES256 aes;

	// 생성자
	public ProductDAO_imple() {

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
	
	
	// 상품 정보 셀렉트쓰
	public ProductVO selectProduct(String pnum) throws SQLException {

		ProductVO pvo = new ProductVO();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select p_num, p_name, p_sale, p_image, p_price "
					   + " from tbl_product where p_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(pnum));
			
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

	public OptionVO selectOption(String op_num) throws SQLException {

		OptionVO opvo = new OptionVO();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select op_num, op_ml, op_price "
					   + " from tbl_option where op_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(op_num));
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				opvo.setOp_num(rs.getInt("op_num"));
				opvo.setOp_ml(rs.getString("op_ml"));
				opvo.setOp_price(rs.getString("op_price"));
				
			}
			
		} finally {
			close();
		}
		
		return opvo;
	}

	
}
