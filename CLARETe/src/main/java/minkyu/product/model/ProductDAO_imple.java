package minkyu.product.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import product.domain.ProductVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class ProductDAO_imple implements ProductDAO {

	private DataSource ds; // DataSource ds �� ����ġ��Ĺ�� �����ϴ� DBCP(DB Connection Pool)�̴�.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private AES256 aes;

	// ������
	public ProductDAO_imple() {

		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/semioracle");

			aes = new AES256(SecretMyKey.KEY);
			// SecretMyKey.KEY �� �츮�� ���� ��ȣȭ/��ȣȭ Ű�̴�.
			//

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	// ����� �ڿ��� �ݳ��ϴ� close() �޼ҵ� �����ϱ�
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
	
	// �ֱ� �� ��ǰ ��ȸ�ϴ� ����Ʈ
	@Override
	public List<ProductVO> selectProduct(List<Integer> pnumList) throws SQLException {
	    List<ProductVO> pvoList = new ArrayList<>();
	    
	    

	    try {
	        conn = ds.getConnection();

	        String sql = " select p_num, p_name, p_price, p_sale, p_image "
	                   + " from tbl_product "
	                   + " where p_num = ? ";

	        pstmt = conn.prepareStatement(sql);
	        if(pnumList != null) {
		    	
		        for (int p_num : pnumList) {
		            pstmt.setInt(1, p_num);
		            rs = pstmt.executeQuery();
	
		            if (rs.next()) {
		            	
		                ProductVO pvo = new ProductVO();
		                pvo.setP_num(rs.getInt("p_num"));
		                pvo.setP_name(rs.getString("p_name"));
		                pvo.setP_price(rs.getInt("p_price"));
		                pvo.setP_sale(rs.getString("p_sale"));
		                pvo.setP_image(rs.getString("p_image"));
	
		                pvoList.add(pvo);
		            }
		        }
	        }
	    } finally {
	        close();
	    }

	    return pvoList;
	}


}
