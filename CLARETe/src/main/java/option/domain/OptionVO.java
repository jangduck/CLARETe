package option.domain;

public class OptionVO {
	private int op_num; // �ɼǹ�ȣ
	private int fk_p_num; // ��ǰ������ȣ
	private String op_ml; // �뷮
	private String op_price; // �뷮������
	
	
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
	
	
	
	
	
	
	
	
	// 용량 변경 메소드
	public String getMl() {
		
		if("1".equals(op_ml)) {
			op_ml = "50";
		} else if("2".equals(op_ml)) {
			op_ml = "75";
		} else {
			op_ml = "100";
		}
		
		return op_ml;
		
	}
	
}
