package kr.co.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.vo.BoardVO;
import kr.co.vo.Criteria;
import kr.co.vo.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSession sql;

	@Override
	public void write(BoardVO boardVO) throws Exception {
		sql.insert("board.insert", boardVO);

	}

	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception {
		return sql.selectList("board.listPage", scri);
	}

	@Override
	public BoardVO read(int bno) throws Exception {
		return sql.selectOne("board.read", bno);
	}

	@Override
	public void update(BoardVO boardVO) throws Exception {
		sql.update("board.update", boardVO);
		
	}

	@Override
	public void delete(BoardVO boardVO) throws Exception {
		sql.delete("board.delete", boardVO);
		
	}

	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		return sql.selectOne("board.listCount", scri);
	}

	@Override
	public void insertFile(Map<String, Object> map) throws Exception {
		sql.insert("board.insertFile", map);
		
	}

	@Override
	public List<Map<String, Object>> selectFileList(int bno) throws Exception {
		return sql.selectList("board.selectFileList", bno);
	}

	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return sql.selectOne("board.selectFileInfo", map);
	}

}
