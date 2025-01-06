package minkyu.product.model;

import java.sql.SQLException;
import java.util.List;

import product.domain.ProductVO;

public interface ProductDAO {

	// 최근 본 상품 조회하는 리스트
	List<ProductVO> selectProduct(List pnumList) throws SQLException;

}
