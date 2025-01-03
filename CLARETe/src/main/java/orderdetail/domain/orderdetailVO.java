package orderdetail.domain;

import option.domain.OptionVO;

public class orderdetailVO {
	int od_num; // �ֹ����Ϸù�ȣ
	int fk_o_num; // �ֹ���ȣ
	int fk_p_num; // ��ǰ������ȣ
	int od_count; // �ֹ���
	int fk_op_num; //  �ɼǹ�ȣ

	// OptionVO 조인
	private OptionVO optionvo;

	public OptionVO getOptionvo() {
		return optionvo;
	}
	public void setOptionvo(OptionVO optionvo) {
		this.optionvo = optionvo;
	}
	
	
	
	
	
	public int getFk_op_num() {
		return fk_op_num;
	}
	public void setFk_op_num(int fk_op_num) {
		this.fk_op_num = fk_op_num;
	}
	String od_price; // ����
	
	public int getOd_num() {
		return od_num;
	}
	public void setOd_num(int od_num) {
		this.od_num = od_num;
	}
	public int getFk_o_num() {
		return fk_o_num;
	}
	public void setFk_o_num(int fk_o_num) {
		this.fk_o_num = fk_o_num;
	}
	public int getFk_p_num() {
		return fk_p_num;
	}
	public void setFk_p_num(int fk_p_num) {
		this.fk_p_num = fk_p_num;
	}
	public int getOd_count() {
		return od_count;
	}
	public void setOd_count(int od_count) {
		this.od_count = od_count;
	}
	public String getOd_price() {
		return od_price;
	}
	public void setOd_price(String od_price) {
		this.od_price = od_price;
	}
	

	
	
}
