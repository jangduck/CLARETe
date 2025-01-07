package minkyu.product.model;

import java.sql.SQLException;
import java.util.List;

import product.domain.ProductVO;

public interface ProductDAO {

	// �ֱ� �� ��ǰ ��ȸ�ϴ� ����Ʈ
	List<ProductVO> selectProduct(List<Integer> pnumList) throws SQLException;

}
