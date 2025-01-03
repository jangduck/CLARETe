package yihun.prodect.model;

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

import option.domain.OptionVO;
import product.domain.ProductVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class ProductDAO_imple implements ProductDAO {

	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    private AES256 aes;
	
    // 생성자
    public ProductDAO_imple() {
       
       try {
          Context initContext = new InitialContext();
           Context envContext  = (Context)initContext.lookup("java:/comp/env");
           ds = (DataSource)envContext.lookup("jdbc/semioracle");
           
           aes = new AES256(SecretMyKey.KEY);
           // SecretMyKey.KEY 은 우리가 만든 암호화/복호화 키이다.
           
       } catch(NamingException e) {
          e.printStackTrace();
       } catch(UnsupportedEncodingException e) {
          e.printStackTrace();
       }
    }
    
    
    // 사용한 자원을 반납하는 close() 메소드 생성하기
    private void close() {
       try {
          if(rs    != null) {rs.close();     rs=null;}
          if(pstmt != null) {pstmt.close(); pstmt=null;}
          if(conn  != null) {conn.close();  conn=null;}
       } catch(SQLException e) {
          e.printStackTrace();
       }
    }// end of private void close()---------------
    
    
    
	// 상품등록을 해주는 메소드
	@Override
	public int insertProduct(ProductVO pvo) throws SQLException {
		int result = 0;
		// System.out.println("임플" + pvo.getP_detail_image());

		try {
			conn = ds.getConnection();
			

			String sql = " insert into tbl_product(p_num, p_season, p_name, p_ex, p_price, p_inven, p_sale, p_gender, p_release, p_image, p_detail_image, p_register) "
			           + " values(?, ?, ?, ?, ?, ?, ?, ?, to_date(?, 'yyyy-mm-dd'), ?, ?, sysdate) ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, pvo.getP_num());
			pstmt.setString(2, pvo.getP_season()); 
			pstmt.setString(3, pvo.getP_name());
			pstmt.setString(4, pvo.getP_ex());
			pstmt.setInt(5, pvo.getP_price());
			pstmt.setInt(6, pvo.getP_inven());
			pstmt.setString(7, pvo.getP_sale());
			pstmt.setInt(8, pvo.getP_gender());
			pstmt.setString(9, pvo.getP_release());  
			pstmt.setString(10, pvo.getP_image());
			pstmt.setString(11, pvo.getP_detail_image());

			// SQL 실행
			result = pstmt.executeUpdate();
			
			
			if(result == 1) { // 상품등록에 성공했다면 옵션등록
				conn = ds.getConnection();
				conn.setAutoCommit(false); // 고생길 시작 수동커밋...
				
				Map <String, String> paraMap = pvo.getOpMap();
				
				sql = " insert into tbl_option(op_num, fk_p_num, op_ml, op_price) values(seq_option.nextval, ?, ?, ?) ";
				
				pstmt = conn.prepareStatement(sql);
					
				if(!(paraMap.size() == 0)) {
					int yongyang=0;
					int price=0;
					for(int i=0; i<paraMap.size()/2; i++) {
						
						pstmt.setInt(1, pvo.getP_num());
						
						switch (i) {
						case 0:
							yongyang = Integer.parseInt(paraMap.get("yongyang0"));
							price = Integer.parseInt(paraMap.get("price0"));
							break;
							
						case 1:
							yongyang = Integer.parseInt(paraMap.get("yongyang1"));
							price = Integer.parseInt(paraMap.get("price1"));
							break;
							
						case 2:
							yongyang = Integer.parseInt(paraMap.get("yongyang2"));
							price = Integer.parseInt(paraMap.get("price2"));
							break;
						}
						
						pstmt.setInt(2, yongyang);
						pstmt.setInt(3, price);
						

						// SQL 실행
						result = pstmt.executeUpdate();
					}
					
				}
				else {
					// 옵션선택을 하지 않은 경우 기본값인 50ml, 0원이 들어감
					pstmt.setInt(1, pvo.getP_num());
					pstmt.setInt(2, 1);
					pstmt.setInt(3, 0);
					
					// SQL 실행
					result = pstmt.executeUpdate();
				}
				
				if(result == 1) {
					conn.commit();
				}
				else {
					conn.rollback();
					result = -1;
				}
				
			}
			
			
		} finally {
			close();
		}
		
		
		return result;
	} // end of public int insertProduct(ProductVO pvo) throws SQLException-------------------


	// 상품 아이디를 알아오는 메소드
	@Override
	public ProductVO selectSeq() throws SQLException {
		
		ProductVO pvo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select seq_product.nextval as p_id "
					   + " from dual ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				pvo = new ProductVO();
				
				pvo.setP_num(rs.getInt("p_id"));
				
				// System.out.println(pvo.getP_num());
				
			}
			
		} finally {
			close();
		}
		
		return pvo;
	}


	// 수정하기 위한 해당 상품을 불러오는 메소드
	@Override
	public boolean selectUpdateOne(String p_num) throws SQLException {
		
		boolean isE = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select p_num, p_season, p_name, p_ex, p_price, p_inven, p_sale, p_gender, p_release, p_image, p_detail_image, p_register "
					   + " from tbl_product "
					   + " where p_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isE = true;
			}
			
		} finally {
			close();
		}
		
		return isE;
	}


	// 상품을 수정해주는 메소드
	@Override
	public int productUpdate(ProductVO pvo, String or_p_image, String or_p_detail_image) throws SQLException {
		// System.out.println("여기까지 잘 흘러왔습니다~ "+ pvo.getP_detail_image());
		int result = 0;
		
		try {
			conn = ds.getConnection();
			

			String sql = " update tbl_product set p_season = ?, p_ex = ?, p_price = ?, p_inven = ?, p_sale = ?, p_gender = ?, p_name = ?, p_image = ?, p_detail_image = ? "
					   + " where p_num = ? ";

			pstmt = conn.prepareStatement(sql);

			
			pstmt.setString(1, pvo.getP_season()); 
			pstmt.setString(2, pvo.getP_ex());
			pstmt.setInt(3, pvo.getP_price());
			pstmt.setInt(4, pvo.getP_inven());
			pstmt.setString(5, pvo.getP_sale());
			pstmt.setInt(6, pvo.getP_gender());
			pstmt.setString(7, pvo.getP_name());
			
			// ============ 이미지를 입력받지 못 했다면 기존 이미지를 재활용 ============ //
			if(pvo.getP_image() != null) {
				pstmt.setString(8, pvo.getP_image());
			}
			else {
				pstmt.setString(8, or_p_image);
			}
			
			if(pvo.getP_detail_image() != null) {
				pstmt.setString(9, pvo.getP_detail_image());
			}
			else {
				pstmt.setString(9, or_p_detail_image);
			}
			// ============ 이미지를 입력받지 못 했다면 기존 이미지를 재활용 ============ //
			
			pstmt.setInt(10, pvo.getP_num());

			// SQL 실행
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	} // end of public int productUpdate(ProductVO pvo) throws SQLException------------


	// 상품을 삭제해주는 메소드
	@Override
	public int productDelete(String p_num) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_product set is_delete = 1 where p_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_num);
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
		return result;
	} // end of public int productDelete(String p_num) throws SQLException--------------


	// 선택한 상품들을 일괄삭제해주는 메소드
	@Override
	public int deleteAll(List<Object> list) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_product set is_delete = 1 where p_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			for(int i=0; i<list.size(); i++) {
				pstmt.setInt(1, Integer.parseInt((String) list.get(i)));
				
				result += pstmt.executeUpdate();
			}
			
		} finally {
			close();
		}
		
		
		return result;
	} // end of public int deleteAll(List<Object> list) throws SQLException--------------

}
