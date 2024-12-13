package log.domain;

public class LogVO {
	int l_num; // historyno
	String fk_m_id; // fk_userid
	String l_logindate; // logindate
	String l_ip; // clientip
	
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
	
	
}
