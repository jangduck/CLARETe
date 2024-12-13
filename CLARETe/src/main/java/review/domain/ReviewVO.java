package review.domain;

public class ReviewVO {
	int r_num; // 리뷰번호
	String fk_m_id; // userid
	int fk_p_num; // 제품고유번호
	int r_update; // 리뷰수정일자
	String r_register; // 리뷰작성일자
	int r_star; // 별점
	String r_msg; // 리뷰내용
	
	public int getR_num() {
		return r_num;
	}
	public void setR_num(int r_num) {
		this.r_num = r_num;
	}
	public String getFk_m_id() {
		return fk_m_id;
	}
	public void setFk_m_id(String fk_m_id) {
		this.fk_m_id = fk_m_id;
	}
	public int getFk_p_num() {
		return fk_p_num;
	}
	public void setFk_p_num(int fk_p_num) {
		this.fk_p_num = fk_p_num;
	}
	public int getR_update() {
		return r_update;
	}
	public void setR_update(int r_update) {
		this.r_update = r_update;
	}
	public String getR_register() {
		return r_register;
	}
	public void setR_register(String r_register) {
		this.r_register = r_register;
	}
	public int getR_star() {
		return r_star;
	}
	public void setR_star(int r_star) {
		this.r_star = r_star;
	}
	public String getR_msg() {
		return r_msg;
	}
	public void setR_msg(String r_msg) {
		this.r_msg = r_msg;
	}
	
	
}
