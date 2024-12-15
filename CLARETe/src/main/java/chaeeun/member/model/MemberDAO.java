package chaeeun.member.model;

import java.sql.SQLException;
import java.util.List;

import member.domain.MemberVO;

public interface MemberDAO {

   // 모든 회원을 조회하는 메소드
   List<MemberVO> SelectAll_member() throws SQLException;

   // 회원가입
   int registerMember(MemberVO member) throws SQLException;

   // 아이디 중복검사
   boolean idDuplicateCheck(String m_id) throws SQLException;

   // 이메일 중복검사
   boolean emailDuplicateCheck(String email) throws SQLException;
   
}