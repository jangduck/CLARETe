package order.domain;

public class OrderVO {
	int o_num; // 주문번호
	String fk_m_id; // fk_userid
	int fk_d_num; // 배송지번호
	int fk_op_num; //  옵션번호
	String o_date; // 주문날짜
	int status; // 배송현황 배송전0, 배송중1, 배송후2
	String o_price; // 주문금액
	
	
	public int getO_num() {
		return o_num;
	}
	public void setO_num(int o_num) {
		this.o_num = o_num;
	}
	public String getFk_m_id() {
		return fk_m_id;
	}
	public void setFk_m_id(String fk_m_id) {
		this.fk_m_id = fk_m_id;
	}
	public int getFk_d_num() {
		return fk_d_num;
	}
	public void setFk_d_num(int fk_d_num) {
		this.fk_d_num = fk_d_num;
	}
	public int getFk_op_num() {
		return fk_op_num;
	}
	public void setFk_op_num(int fk_op_num) {
		this.fk_op_num = fk_op_num;
	}
	public String getO_date() {
		return o_date;
	}
	public void setO_date(String o_date) {
		this.o_date = o_date;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getO_price() {
		return o_price;
	}
	public void setO_price(String o_price) {
		this.o_price = o_price;
	}
	
	
	
}
