package yihun.prodect.model;

import java.sql.SQLException;
import java.util.List;

import product.domain.ProductVO;

public interface ProductDAO {

	// 상품등록을 해주는 메소드
	int insertProduct(ProductVO pvo) throws SQLException;

	// 상품 아이디를 알아오는 메소드
	ProductVO selectSeq() throws SQLException;

	// 수정하기 위한 해당 상품을 불러오는 메소드
	boolean selectUpdateOne(String p_num) throws SQLException;

	// 상품을 수정해주는 메소드
	int productUpdate(ProductVO pvo, String or_p_image, String or_p_detail_image) throws SQLException;

	// 상품을 삭제해주는 메소드
	int productDelete(String p_num) throws SQLException;

	// 선택한 상품들을 일괄삭제해주는 메소드
	int deleteAll(List<Object> list) throws SQLException;

}
