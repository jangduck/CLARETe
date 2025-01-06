package chaeeun.cart.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import cart.controller.Cart;
import cart.domain.CartVO;
import delivery.domain.DeliveryVO;

public interface CartDAO {

	// 장바구니 조회
	List<CartVO> selectCart(String m_id) throws SQLException;

	// 배송 정보 조회
	List<DeliveryVO> selectDeliveryList(String m_id) throws SQLException;

	// 장바구니 수량 감소
	int decreaseQuantity(Map<String, String> paraMap) throws SQLException;

	// 장바구니 수량 증가
	int increaseQuantity(Map<String, String> paraMap) throws SQLException;

	// 장바구니에서 삭제
	int deleteCart(Map<String, String> paraMap) throws SQLException;

	//마이페이지 장바구니 갯수 
	List<CartVO> cartListCount(String m_id) throws SQLException;

}