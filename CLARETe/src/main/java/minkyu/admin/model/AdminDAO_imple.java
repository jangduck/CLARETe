package minkyu.admin.model;

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

import cart.domain.CartVO;
import delivery.domain.DeliveryVO;
import member.domain.MemberVO;
import option.domain.OptionVO;
import order.domain.OrderVO;
import product.domain.ProductVO;
import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class AdminDAO_imple implements AdminDAO {

   private DataSource ds;  // DataSource ds ?? ????占 ??占쎌베?? ??怨듸옙???? DBCP(DB Connection Pool)?占쏙옙??. 
   private Connection conn;
   private PreparedStatement pstmt;
   private ResultSet rs;
   
   private AES256 aes;
   
   // ???占쏙옙??
   public AdminDAO_imple() {
      
      try {
         Context initContext = new InitialContext();
          Context envContext  = (Context)initContext.lookup("java:/comp/env");
          ds = (DataSource)envContext.lookup("jdbc/semioracle");
          
          aes = new AES256(SecretMyKey.KEY);
          // SecretMyKey.KEY ?? ?占쎈━占 ? 占 ??? ???占쏙옙??/蹂듸옙?占쏙옙?? ?占쏙옙?占쏙옙??.
          
      } catch(NamingException e) {
         e.printStackTrace();
      } catch(UnsupportedEncodingException e) {
         e.printStackTrace();
      }
   }
   
   
   // ?占쏙옙?占쏙옙?? ?????? 占 ??占쏙옙???? close() 占 ????? ???占쏙옙??占 ?
   private void close() {
      try {
         if(rs    != null) {rs.close();     rs=null;}
         if(pstmt != null) {pstmt.close(); pstmt=null;}
         if(conn  != null) {conn.close();  conn=null;}
      } catch(SQLException e) {
         e.printStackTrace();
      }
   }// end of private void close()---------------
   
   @Override
   public List<MemberVO> SelectAll_member() throws SQLException {
       List<MemberVO> memberList = new ArrayList<>();

       try {
           conn = ds.getConnection();

           String sql = " SELECT m_id, m_name, m_email, m_mobile, m_postcode, m_address, " +
                        " m_detail_address, m_extra, m_gender, m_birth, m_point, " +
                        " m_register, m_lastpwd, m_status, m_idle " +
                        " FROM tbl_member ";

           pstmt = conn.prepareStatement(sql);
           rs = pstmt.executeQuery();

           while (rs.next()) {
               MemberVO member = new MemberVO();
               member.setM_id(rs.getString("m_id"));
               member.setM_name(rs.getString("m_name"));
               member.setM_email(rs.getString("m_email"));
               member.setM_mobile(rs.getString("m_mobile"));
               member.setM_postcode(rs.getString("m_postcode"));
               member.setM_address(rs.getString("m_address"));
               member.setM_detail_address(rs.getString("m_detail_address"));
               member.setM_extra(rs.getString("m_extra"));
               member.setM_gender(rs.getString("m_gender"));
               member.setM_birth(rs.getString("m_birth"));
               member.setM_point(rs.getInt("m_point"));
               member.setM_register(rs.getString("m_register"));
               member.setM_lastpwd(rs.getString("m_lastpwd"));
               member.setM_status(rs.getInt("m_status"));
               member.setM_idle(rs.getInt("m_idle"));

               memberList.add(member);
           }
       } finally {
           close();
       }

       return memberList;
   }

   
   
   // 주문회원조회
   @Override
   public List<OrderVO> SelectOrderMember() throws SQLException {
	   
       List<OrderVO> orderList = new ArrayList<>(); // 주문 정보를 담을 리스트

       try {
           conn = ds.getConnection(); 

           String sql = " SELECT " +
	                   " o_num, " +
	                   " o_date, " +
	                   " p_name, " +
	                   " c_count, " +
	                   " o_price, " +
	                   " status " +
	                   " FROM tbl_order o " +
	                   " JOIN tbl_cart c ON o.o_num = c.fk_op_num " +
	                   " JOIN tbl_product p ON c.fk_p_num = p.p_num " +
	                   " JOIN tbl_member m ON o.fk_m_id = m.m_id " +
	                   " WHERE m.m_id = ? " +
	                   " ORDER BY o.o_date DESC";


	      pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1, "user_id"); // 특정 사용자 아이디 바인딩
	      rs = pstmt.executeQuery();



	      while (rs.next()) {
	    	    OrderVO order = new OrderVO();
	    	    MemberVO member = new MemberVO();
	    	    CartVO cart = new CartVO();
	    	    ProductVO product = new ProductVO();

	    	    // 주문 정보 설정
	    	    order.setO_num(rs.getInt("o_num"));
	    	    order.setO_date(rs.getString("o_date"));
	    	    order.setO_price(rs.getString("o_price"));
	    	    order.setStatus(rs.getInt("status"));

	    	    // 장바구니 정보 설정
	    	    cart.setC_count(rs.getInt("c_count"));
	    	    order.setCartvo(cart);

	    	    // 제품 정보 설정
	    	    product.setP_name(rs.getString("p_name"));
	    	    order.setProductvo(product);

	    	    // 회원 정보 설정
	    	    member.setM_name(rs.getString("m_name"));
	    	    member.setM_email(rs.getString("m_email"));
	    	    member.setM_mobile(rs.getString("m_mobile"));
	    	    order.setMembervo(member);

	    	    // 리스트에 추가
	    	    orderList.add(order);
	    	}

       } catch (SQLException e) {
           e.printStackTrace();
       } finally {
           close(); 
       }

       return orderList;
   }

	


}







