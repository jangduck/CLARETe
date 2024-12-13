package faq.domain;

public class FaqVO {
	int FAQ_num; // 자주묻는질문번호
	String ask; // 질문
	String answer; // 답변
	
	
	public int getFAQ_num() {
		return FAQ_num;
	}
	public void setFAQ_num(int fAQ_num) {
		FAQ_num = fAQ_num;
	}
	public String getAsk() {
		return ask;
	}
	public void setAsk(String ask) {
		this.ask = ask;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	
}
