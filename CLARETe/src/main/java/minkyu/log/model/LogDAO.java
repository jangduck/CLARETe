package minkyu.log.model;

import java.sql.SQLException;
import java.util.List;

import log.domain.LogVO;

public interface LogDAO {
	
	// 로그인 기록 알아오기
	List<LogVO> totalLog() throws SQLException;

}
