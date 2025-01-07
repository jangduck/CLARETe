package minkyu.order.model;

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

import delivery.domain.DeliveryVO;
import option.domain.OptionVO;
import order.domain.OrderVO;
import orderdetail.domain.orderdetailVO;
import product.domain.ProductVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class OrderDAO_imple implements OrderDAO {

   private DataSource ds; // DataSource ds        ġ  Ĺ        ϴ  DBCP(DB Connection Pool) ̴ .
   private Connection conn;
   private PreparedStatement pstmt;
   private ResultSet rs;

   private AES256 aes;

   //       
   public OrderDAO_imple() {

      try {
         Context initContext = new InitialContext();
         Context envContext = (Context) initContext.lookup("java:/comp/env");
         ds = (DataSource) envContext.lookup("jdbc/semioracle");

         aes = new AES256(SecretMyKey.KEY);
         // SecretMyKey.KEY     츮          ȣȭ/  ȣȭ Ű ̴ .
         //

      } catch (NamingException e) {
         e.printStackTrace();
      } catch (UnsupportedEncodingException e) {
         e.printStackTrace();
      }
   }

   //        ڿ     ݳ  ϴ  close()  ޼ҵ       ϱ 
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
   
   
   //  α      ȸ      ֹ                  ޼ҵ 
      @Override
      public List<OrderVO> recentOrder(Map<String, String> paraMap) throws SQLException {
         
         List<OrderVO> orderList = new ArrayList<>();
         
         try {
            
            conn = ds.getConnection();
            
            String sql = " select d.d_name, d.d_address, d.d_detail_address, d.d_extra, d.d_mobile "
                  + " , p.p_image, p.p_name, od.od_count, op.op_ml, od.od_price, o.status, p.p_gender, p.p_season, o.o_date, o.o_num "
                  + " from tbl_order o join tbl_delivery d "
                  + " on o.fk_d_num = d.d_num "
                  + " join tbl_orderdetail od "
                  + " on o.o_num = od.fk_o_num "
                  + " join tbl_product p "
                  + " on od.fk_p_num = p.p_num "
                  + " join tbl_option op "
                  + " on od.fk_op_num = op.op_num "
                  + " where o.fk_m_id = ?"
                  + " order by o.o_date desc ";
            
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, paraMap.get("m_id")); //  α       ȸ     ̵ 

            
            rs = pstmt.executeQuery();
            
            while(rs.next()) {//     ྿ ó   ϱ 
               
               OrderVO ovo = new OrderVO();
               ovo.setStatus(rs.getInt("status"));
               ovo.setO_date(rs.getString("o_date"));
               ovo.setO_num(rs.getInt("o_num"));

               OptionVO opvo = new OptionVO();
               opvo.setOp_ml(rs.getString("op_ml"));
               ovo.setOptionvo(opvo);

               ProductVO pvo = new ProductVO();
               pvo.setP_name(rs.getString("p_name"));
               pvo.setP_image(rs.getString("p_image"));
               pvo.setP_gender(rs.getInt("p_gender"));
               pvo.setP_season(rs.getString("p_season"));
               ovo.setProductvo(pvo);

               DeliveryVO dvo = new DeliveryVO();
               dvo.setD_name(rs.getString("d_name"));
               dvo.setD_address(rs.getString("d_address"));
               dvo.setD_detail_address(rs.getString("d_detail_address"));
               dvo.setD_extra(rs.getString("d_extra"));
               dvo.setD_mobile((rs.getString("d_mobile")));
               ovo.setDeliveryvo(dvo);

               orderdetailVO odvo = new orderdetailVO();
               odvo.setOd_count(rs.getInt("od_count"));
               odvo.setOd_price(rs.getString("od_price"));
               ovo.setOrderdetailvo(odvo);
               
               orderList.add(ovo);
            
              
            } // end of while(rs.next())--------------------------------------------
            
         } catch( SQLException e) {
             e.printStackTrace();      
         } finally {
            close();
         }
         return orderList;
      }
}
