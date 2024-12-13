package qna.domain;

public class QnaVO {
	int q_num; // Q&A번호
	String fk_m_id; // userid
	int fk_p_num; // 제품고유번호
	String q_title; // 제목
	String q_ask; // 질문
	String q_register; // 질문등록일자
	int q_category; // 문의유형
	String q_answer; // 답변
	String q_answerdate; // 답변등록일자
	
	public int getQ_num() {
		return q_num;
	}
	public void setQ_num(int q_num) {
		this.q_num = q_num;
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
	public String getQ_title() {
		return q_title;
	}
	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}
	public String getQ_ask() {
		return q_ask;
	}
	public void setQ_ask(String q_ask) {
		this.q_ask = q_ask;
	}
	public String getQ_register() {
		return q_register;
	}
	public void setQ_register(String q_register) {
		this.q_register = q_register;
	}
	public int getQ_category() {
		return q_category;
	}
	public void setQ_category(int q_category) {
		this.q_category = q_category;
	}
	public String getQ_answer() {
		return q_answer;
	}
	public void setQ_answer(String q_answer) {
		this.q_answer = q_answer;
	}
	public String getQ_answerdate() {
		return q_answerdate;
	}
	public void setQ_answerdate(String q_answerdate) {
		this.q_answerdate = q_answerdate;
	}
	
	
}
