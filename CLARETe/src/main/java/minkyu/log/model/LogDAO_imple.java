package minkyu.log.model;

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

import log.domain.LogVO;
import member.domain.MemberVO;

public class LogDAO_imple implements LogDAO {
	
	private DataSource ds; 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	public LogDAO_imple() {

		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/semioracle");

		} catch (NamingException e) {
			e.printStackTrace();
		} 
	}

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

	
	// 로그인 기록 알아오기
	@Override
	public List<LogVO> totalLog() throws SQLException {
		
		List<LogVO> log_list = new ArrayList<>();
	      
	      try {
	         
	         conn = ds.getConnection();
	         
	         String sql = " select trunc(l_logindate) as l_logindate, "
		         		+ "       count(case when m.m_gender = '1' then 1 end) as m_login, "
		         		+ "       count(case when m.m_gender = '2' then 1 end) as fe_login, "
		         		+ "       count(*) as login_count "
		         		+ " from tbl_log l "
		         		+ " join tbl_member m "
		         		+ " on l.fk_m_id = m.m_id "
		         		+ " group by trunc(l_logindate) "
		         		+ " order by trunc(l_logindate) desc ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {

	        	LogVO lvo = new LogVO();
	        	lvo.setL_logindate(rs.getString("l_logindate").substring(0,10));
	        	lvo.setLogin_count(rs.getInt("login_count"));
	        	lvo.setFeLogin(rs.getInt("fe_login"));
	        	lvo.setmLogin(rs.getInt("m_login"));
	            
	        	log_list.add(lvo);
	         } // end of while(rs.next())--------------------------------------------
	         
	      } catch( SQLException e) {
	          e.printStackTrace();      
	      } finally {
	         close();
	      }
	      return log_list;
	}
	
	
}
