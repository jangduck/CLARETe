package minkyu.admin.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

//import admin.controller.Member;
import member.domain.MemberVO;
import order.domain.OrderVO;
import product.domain.ProductVO;

public interface AdminDAO {

   // 전체 회원 조회
   List<MemberVO> SelectAll_member() throws SQLException;

   // 주문 회원 조회
	List<OrderVO> SelectOrderMember() throws SQLException;

	// 상품 조회
	List<ProductVO> ProductAll_member() throws SQLException;

	// 모든회원조회 검색기능
	List<MemberVO> searchMembers(Map<String, String> paraMap)  throws SQLException;

	// 상품조회 검색기능
	List<ProductVO> searchProduct(Map<String, String> paraMap) throws SQLException;

	// 주문회원조회 검색기능
	List<OrderVO> searchOrder(Map<String, String> paraMap) throws SQLException;
	
	// 모든회원조회 페이지기능
	int getTotalPage(Map<String, String> paraMap) throws SQLException;














	

}
