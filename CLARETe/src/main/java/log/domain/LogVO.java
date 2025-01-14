package log.domain;

import member.domain.MemberVO;

public class LogVO {
	private int l_num; // historyno
	private String fk_m_id; // fk_userid
	private String l_logindate; // logindate
	private String l_ip; // clientip
	private int login_count; // total
	
	public int getL_num() {
		return l_num;
	}
	public void setL_num(int l_num) {
		this.l_num = l_num;
	}
	public String getFk_m_id() {
		return fk_m_id;
	}
	public void setFk_m_id(String fk_m_id) {
		this.fk_m_id = fk_m_id;
	}
	public String getL_logindate() {
		return l_logindate;
	}
	public void setL_logindate(String l_logindate) {
		this.l_logindate = l_logindate;
	}
	public String getL_ip() {
		return l_ip;
	}
	public void setL_ip(String l_ip) {
		this.l_ip = l_ip;
	}
	
	
	
	
	// MemberVO 조인
	// 민규 로그인 인원 성별 알아오기
//	private MemberVO membervo;
//	public MemberVO getMembervo() {
//		return membervo;
//	}
//	public void setMembervo(MemberVO membervo) {
//		this.membervo = membervo;
//	}
//	
	// 민규 전체 로그인 인원 수 알아오는 용도
	public void setLogin_count(int login_count) {
		this.login_count = login_count;
	}
	public int getLogin_count() {
		return login_count;
	}
	
	int mLogin; // 남성회원 로그인
	
	public int getmLogin() {
		return mLogin;
	}
	public void setmLogin(int mLogin) {
		this.mLogin = mLogin;
	}
	
	
	int feLogin; // 여성회원 로그인
	
	public int getFeLogin() {
		return feLogin;
	}
	public void setFeLogin(int feLogin) {
		this.feLogin = feLogin;
	}
	
	
	
}
