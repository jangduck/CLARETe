package chaeeun.order.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import order.domain.OrderVO;

public interface OrderDAO {

	// 채번하기
	int getPnum() throws SQLException;
		
	// tbl_order 테이블에 insert
	int insertOrder(Map<String, String> paraMap, int pnum) throws SQLException;

	// tbl_orderdetail 테이블에 insert
	int insertOrderDetail(List<Map<String, String>> orderList, int pnum) throws SQLException;

	// 결제 완료되면 장바구니꺼 delete
	void deleteCart(List<String> cNumList) throws SQLException;

	// 포인트 사용액 update
	void updatePoint(Map<String, String> paraMap) throws SQLException;

	// 구매금액의 1% 포인트로 추가 update
	void addPurchasePoints(Map<String, String> paraMap) throws SQLException;

	// 주문 select
	OrderVO selectOrder(String pnum) throws SQLException;



}