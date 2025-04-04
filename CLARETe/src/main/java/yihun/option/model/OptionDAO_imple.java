package yihun.option.model;

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
import product.domain.ProductVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class OptionDAO_imple implements OptionDAO {

	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
   
    private AES256 aes;
	
	// 생성자
	public OptionDAO_imple() {
	   
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
	
	
	
	// 상품 옵션 정보를 알아온다
	@Override
	public List<OptionVO> selectOption(int p_num) throws SQLException {
		
		List<OptionVO> ovoList = new ArrayList<>();
	      
        try {
        	conn = ds.getConnection();
        	
        	String sql = " select fk_p_num, op_num, op_ml, op_price "
        			   + " from tbl_option o join tbl_product p "
        			   + " on p_num = fk_p_num "
        			   + " where p_num = ? "
        			   + " order by op_ml asc ";
        	
        	pstmt = conn.prepareStatement(sql);
        	
        	pstmt.setInt(1, p_num);
        	
        	rs = pstmt.executeQuery();
        	
        	while (rs.next()) {
        	    OptionVO ovo = new OptionVO();
        	    
        	    ovo.setFk_p_num(rs.getInt("fk_p_num"));
        	    ovo.setOp_num(rs.getInt("op_num"));
        	    ovo.setOp_ml(rs.getString("op_ml"));
        	    ovo.setOp_price(rs.getString("op_price"));
        	    
        	    ovoList.add(ovo);
        	}
        	
        	// System.out.println("확인용 임플 리스트 사이즈 : " + ovoList.size());
        	
        } finally {
           close();
        }
      
      return ovoList;
	}



}
