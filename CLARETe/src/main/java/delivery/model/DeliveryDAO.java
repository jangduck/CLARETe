package delivery.model;

import java.sql.SQLException;
/*import java.util.Map;*/
import java.util.List;

import delivery.domain.DeliveryVO;
import order.domain.OrderVO;

public interface DeliveryDAO {

	//배송지 입력을 위한 메소드
	int InsertDelivery(DeliveryVO delivery) throws SQLException;


	//배송지 조회를 위한 메소드 
	List<DeliveryVO> selectDeliveryList(String m_id) throws SQLException;


	// 최근 주문 조회 배송지를 위한 메소드
	List<OrderVO> recentOrderDelivery(String m_id) throws SQLException;


	//배송지 삭제
	int DeleteDelivery(String m_id, String d_num) throws SQLException;


	
	
	
	
	
	
	// 배송지 조회 (하나만)
	DeliveryVO selectOneDelivery(String d_num) throws SQLException;

}
