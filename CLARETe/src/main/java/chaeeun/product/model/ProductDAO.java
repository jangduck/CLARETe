package chaeeun.product.model;

import java.sql.SQLException;
import java.util.List;

import option.domain.OptionVO;
import product.domain.ProductVO;

public interface ProductDAO {

	public ProductVO selectProduct(String pnum) throws SQLException;
	
	public OptionVO selectOption(String op_num) throws SQLException;
	
	public List<OptionVO> selectOptionMl(String[] option) throws SQLException;
}
