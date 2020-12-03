package kr.co.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	@Autowired
	private SqlSession sql;

	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return sql.selectList("reply.readReply", bno);
	}

	@Override
	public void writeReply(ReplyVO vo) throws Exception {
		sql.insert("reply.writeReply", vo);
		
	}

	@Override
	public void updateReply(ReplyVO vo) throws Exception {
		sql.update("reply.updateReply", vo);
		
	}

	@Override
	public void deleteReply(ReplyVO vo) throws Exception {
		sql.delete("reply.deleteReply", vo);
		
	}

	@Override
	public ReplyVO selectReply(int rno) throws Exception {
		return sql.selectOne("reply.selectReply", rno);
	}

}
