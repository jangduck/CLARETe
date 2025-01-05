package chaeeun.product.model;

import java.sql.SQLException;

import option.domain.OptionVO;
import product.domain.ProductVO;

public interface ProductDAO {

	public ProductVO selectProduct(String pnum) throws SQLException;
	
	public OptionVO selectOption(String op_num) throws SQLException;
}
