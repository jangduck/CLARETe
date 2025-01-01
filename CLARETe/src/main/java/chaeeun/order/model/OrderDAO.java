package chaeeun.order.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface OrderDAO {

	// tbl_order에 주문 insert
	int insertOrder(Map<String, String> paraMap) throws SQLException;

	// 결제 완료되면 장바구니꺼 delete
	int deleteCart(List<String> cNumList) throws SQLException;

}
