package member.domain;

public class MemberVO {

   private String m_id;             // 회원아이디
   private String m_pwd;                // 비밀번호 (SHA-256 암호화 대상)
   private String m_name;               // 회원명
   private String m_email;              // 이메일 (AES-256 암호화/복호화 대상)
   private String m_mobile;             // 연락처 (AES-256 암호화/복호화 대상) 
   private String m_postcode;           // 우편번호
   private String m_address;            // 주소
   private String m_detail_address;      // 상세주소
   private String m_extra;       // 참고항목
   private String m_gender;             // 성별   남자:1  / 여자:2
   private String m_birth;           // 생년월일  
   private int m_point;                 // 포인트 
   private String m_register;        // 가입일자 
   private String m_lastpwd;  // 마지막으로 암호를 변경한 날짜  
   private int m_status;                // 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
   private int m_idle;                  // 휴면유무      1: 활동중  /  0: 휴면중
                                      // 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정  
   
   /////////////////////////////////////////////////////////////////////
   
   private boolean requirePwdChange = false;
   // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
   // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false

   /////////////////////////////////////////////////////////////////////
   public String getM_id() {
      return m_id;
   }

   public void setM_id(String m_id) {
      this.m_id = m_id;
   }

   public String getM_pwd() {
      return m_pwd;
   }

   public void setM_pwd(String m_pwd) {
      this.m_pwd = m_pwd;
   }

   public String getM_name() {
      return m_name;
   }

   public void setM_name(String m_name) {
      this.m_name = m_name;
   }

   public String getM_email() {
      return m_email;
   }

   public void setM_email(String m_email) {
      this.m_email = m_email;
   }

   public String getM_mobile() {
      return m_mobile;
   }

   public void setM_mobile(String m_mobile) {
      this.m_mobile = m_mobile;
   }

   public String getM_postcode() {
      return m_postcode;
   }

   public void setM_postcode(String m_postcode) {
      this.m_postcode = m_postcode;
   }

   public String getM_address() {
      return m_address;
   }

   public void setM_address(String m_address) {
      this.m_address = m_address;
   }

   public String getM_detail_address() {
      return m_detail_address;
   }

   public void setM_detail_address(String m_detail_address) {
      this.m_detail_address = m_detail_address;
   }

   public String getM_extra() {
      return m_extra;
   }

   public void setM_extra(String m_extra) {
      this.m_extra = m_extra;
   }

   public String getM_gender() {
      return m_gender;
   }

   public void setM_gender(String m_gender) {
      this.m_gender = m_gender;
   }

   public String getM_birth() {
      return m_birth;
   }

   public void setM_birth(String m_birth) {
      this.m_birth = m_birth;
   }

   public int getM_point() {
      return m_point;
   }

   public void setM_point(int m_point) {
      this.m_point = m_point;
   }

   public String getM_register() {
      return m_register;
   }

   public void setM_register(String m_register) {
      this.m_register = m_register;
   }

   public String getM_lastpwd() {
      return m_lastpwd;
   }

   public void setM_lastpwd(String m_lastpwd) {
      this.m_lastpwd = m_lastpwd;
   }

   public int getM_status() {
      return m_status;
   }

   public void setM_status(int m_status) {
      this.m_status = m_status;
   }

   public int getM_idle() {
      return m_idle;
   }

   public void setM_idle(int m_idle) {
      this.m_idle = m_idle;
   }

   public boolean isRequirePwdChange() {
      return requirePwdChange;
   }

   public void setRequirePwdChange(boolean requirePwdChange) {
      this.requirePwdChange = requirePwdChange;
   }

   
      
   
   
   
    /////////////////////////////////////////////////////////////
    
   
   
}
