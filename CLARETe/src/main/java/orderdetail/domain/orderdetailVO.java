package orderdetail.domain;

public class orderdetailVO {
	int od_num; // 주문상세일련번호
	int fk_o_num; // 주문번호
	int fk_p_num; // 제품고유번호
	int od_count; // 주문수
	String od_price; // 가격
	
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
