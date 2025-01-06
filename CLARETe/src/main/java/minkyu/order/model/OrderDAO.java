package minkyu.order.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import order.domain.OrderVO;

public interface OrderDAO {

	
	// 로그인한 회원의 주문내역을 가져오는 메소드
	List<OrderVO> recentOrder(Map<String, String> paraMap) throws SQLException;
}
