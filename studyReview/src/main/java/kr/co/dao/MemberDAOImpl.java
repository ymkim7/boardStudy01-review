package kr.co.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired
	private SqlSession sql;

	@Override
	public void register(MemberVO vo) throws Exception {
		sql.insert("member.register", vo);

	}

	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		return sql.selectOne("member.login", vo);
	}

	@Override
	public void memberUpdate(MemberVO vo) throws Exception {
		sql.update("member.memberUpdate", vo);
		
	}

	@Override
	public void memberDelete(MemberVO vo) throws Exception {
		sql.delete("member.memberDelete", vo);
		
	}

	@Override
	public int passChk(MemberVO vo) throws Exception {
		
		int result = sql.selectOne("member.passChk", vo);
		
		return result;
	}

	@Override
	public int idChk(MemberVO vo) throws Exception {

		int result = sql.selectOne("member.idChk", vo);
		
		return result;
	}

}
