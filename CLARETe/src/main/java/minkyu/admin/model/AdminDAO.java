package minkyu.admin.model;

import java.sql.SQLException;
import java.util.List;

import member.domain.MemberVO;

public interface AdminDAO {

   // 모�?? ?????? 조�?????? �?????
   List<member.domain.MemberVO> SelectAll_member() throws SQLException;
   
}
