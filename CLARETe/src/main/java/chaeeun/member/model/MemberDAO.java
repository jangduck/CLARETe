package chaeeun.member.model;

import java.sql.SQLException;
import java.util.List;

import member.domain.MemberVO;

public interface MemberDAO {

   // 모든 회원을 조회하는 메소드
   List<MemberVO> SelectAll_member() throws SQLException;

   // 회원가입
   int registerMember(MemberVO member) throws SQLException;
   
}