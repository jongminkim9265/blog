package blog.today.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import blog.today.common.page.Criteria;
import blog.today.vo.ReplyVO;

@Repository("replyDAO")
public class ReplyDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<ReplyVO> list(int IDX) throws Exception {
		return sqlSession.selectList("reply.list", IDX);
	}
	
    public List<ReplyVO> list(int IDX, Criteria criteria) throws Exception {

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("IDX", IDX);
        paramMap.put("criteria", criteria);

        return sqlSession.selectList("reply.listPaging", paramMap);
    }
	public void create(ReplyVO replyVO) throws Exception {
		sqlSession.insert("reply.create", replyVO);
	}
	public void update(ReplyVO replyVO) throws Exception {
		sqlSession.update("reply.update", replyVO);
	}
	public void delete(int IDX) throws Exception {
		sqlSession.delete("reply.delete", IDX);
	}
	 
    public int count(int IDX) throws Exception {
        return sqlSession.selectOne("reply.count", IDX);
    }
	// 특정 댓글의 게시글 번호
    public int getBno(int reply_IDX) throws Exception{
    	return sqlSession.selectOne("reply.getBno",reply_IDX);
    }

    // 회원이 작성한 댓글 목록
    public List<ReplyVO> userReplies(String uid) throws Exception {
    	return sqlSession.selectList("reply.userReplies",uid);
    }
}
