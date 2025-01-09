package youjin.qna.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import qna.domain.QnaVO;

public interface QnaDAO {

	// 1:1문의 등록
	int qnaUpload(QnaVO qvo) throws SQLException;

	// Q&A 게시판
	List<QnaVO> qnaList(Map<String, String> paraMap) throws SQLException;

	// 선택한 Q&A 상세하게 보여주기	
	QnaVO selectOneQna(int q_num) throws SQLException;

	// 1:1문의 답변 등록
	int qnaAnswerUpload(QnaVO qvo) throws SQLException;

	// 회원 1:1문의 리스트
	List<QnaVO> myQnaList(String fk_m_id) throws SQLException;

	// 답변등록하기
	int updateAnswer(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 위한 총페이지수 알아오기 //
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	
	int getTotalQnaCount(Map<String, String> paraMap) throws SQLException;

	// 내 자신의 qna 리스트 페이징 조회
	List<QnaVO> select_qna_paging(Map<String, String> paraMap) throws SQLException;

	int getTotalPageA(Map<String, String> paraMap) throws SQLException;

	int qnaDelete(String q_num) throws SQLException;
	
	

}
