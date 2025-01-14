package review.domain;

import java.lang.StackWalker.Option;

import delivery.domain.DeliveryVO;
import member.domain.MemberVO;
import option.domain.OptionVO;
import order.domain.OrderVO;
import orderdetail.domain.orderdetailVO;
import product.domain.ProductVO;

public class ReviewVO {
	private int r_num; // �����ȣ
	private String fk_m_id; // userid
	private int fk_p_num; // ��ǰ������ȣ
	private int r_update; // �����������
	private String r_register; // �����ۼ�����
	private int r_star; // ����
	private String r_msg; // ���䳻��
	
	private MemberVO mvo;
	private OrderVO ovo;
	private orderdetailVO odvo;
	private ProductVO pvo;
	private DeliveryVO dvo;
	private OptionVO opvo;
	
	public OptionVO getOpvo() {
		return opvo;
	}
	public void setOpvo(OptionVO opvo) {
		this.opvo = opvo;
	}
	public DeliveryVO getDvo() {
		return dvo;
	}
	public void setDvo(DeliveryVO dvo) {
		this.dvo = dvo;
	}
	public MemberVO getMvo() {
		return mvo;
	}
	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	public OrderVO getOvo() {
		return ovo;
	}
	public void setOvo(OrderVO ovo) {
		this.ovo = ovo;
	}
	public orderdetailVO getOdvo() {
		return odvo;
	}
	public void setOdvo(orderdetailVO odvo) {
		this.odvo = odvo;
	}
	public ProductVO getPvo() {
		return pvo;
	}
	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}
	
	
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
