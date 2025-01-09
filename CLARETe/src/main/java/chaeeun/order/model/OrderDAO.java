package chaeeun.order.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import option.domain.OptionVO;
import order.domain.OrderVO;
import orderdetail.domain.orderdetailVO;
import product.domain.ProductVO;

public interface OrderDAO {

	// 채번하기
	int getPnum() throws SQLException;

	// 주문 select
	OrderVO selectOrder(String pnum) throws SQLException;

	// 주문상세 select
	List<orderdetailVO> selectOrderDetail(String pnum) throws SQLException;

	// 주문 수동커밋
	int orderTransaction(Map<String, String> paraMap, List<Map<String, String>> orderList, List<String> cNumList) throws SQLException;

	// 상품정보 뿌리기 위한 용도
	ProductVO purchaseProduct(String p_num) throws SQLException;

	// 옵션 뿌리기 위한 용도
	OptionVO purchaseProductOption(String op_num, String p_num) throws SQLException;

	// 제품 하나 구매 (바로 구매하기)
	int oneOrderTransaction(Map<String, String> paraMap, Map<String, String> paraMap2, Map<String, String> paraMap3, Map<String, String> paraMap4) throws SQLException;




}