package option.domain;

public class OptionVO {
	int op_num; // 옵션번호
	int fk_p_num; // 제품고유번호
	String op_ml; // 용량
	String op_price; // 용량별가격
	public int getOp_num() {
		return op_num;
	}
	public void setOp_num(int op_num) {
		this.op_num = op_num;
	}
	public int getFk_p_num() {
		return fk_p_num;
	}
	public void setFk_p_num(int fk_p_num) {
		this.fk_p_num = fk_p_num;
	}
	public String getOp_ml() {
		return op_ml;
	}
	public void setOp_ml(String op_ml) {
		this.op_ml = op_ml;
	}
	public String getOp_price() {
		return op_price;
	}
	public void setOp_price(String op_price) {
		this.op_price = op_price;
	}
	
	
	
}
