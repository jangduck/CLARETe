package minkyu.admin.model;

import java.sql.SQLException;
import java.util.List;

import member.domain.MemberVO;
import order.domain.OrderVO;

public interface AdminDAO {

   // 紐⑨옙?? ?????? 議곤옙?????? 占 ?????
   List<MemberVO> SelectAll_member() throws SQLException;

// 주문 회원 조회
	List<OrderVO> SelectOrderMember() throws SQLException;
}
