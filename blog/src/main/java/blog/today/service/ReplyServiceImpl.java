package blog.today.service;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import blog.today.vo.ReplyVO;
import blog.today.common.page.Criteria;
import blog.today.dao.BoardDAO;
import blog.today.dao.ReplyDAO;

@Service("ReplyService")
public class ReplyServiceImpl implements ReplyService {
	
	@Inject
    private ReplyDAO replyDAO;

    @Inject
    private BoardDAO boardDAO;

    // 댓글 목록
    @Override
    public List<ReplyVO> list(int IDX) throws Exception{
        return replyDAO.list(IDX);
    }

    // 댓글 목록 + 페이징
    @Override
	public List<ReplyVO> list(int IDX, Criteria criteria) throws Exception {
		return replyDAO.list(IDX,criteria);
	}

    // 특정 게시글의 댓글 갯수
    @Override
    public int count(int IDX) throws Exception {
        return replyDAO.count(IDX);
    }

    // 댓글 입력
    @Transactional
    @Override
    public void addReply(ReplyVO replyVO) throws Exception {
        replyDAO.create(replyVO);
    }

    // 댓글 수정
    @Override
    public void modifyReply(ReplyVO replyVO) throws Exception {
        replyDAO.update(replyVO);
    }

    // 댓글 삭제
    @Transactional
    @Override
    public void removeReply(int IDX) throws Exception {
        int bno = replyDAO.getBno(IDX);
        replyDAO.delete(IDX);
        
    }

    // 회원이 작성한 댓글 목록
    @Override
    public List<ReplyVO> userReplies(String uid) throws Exception {
        return replyDAO.userReplies(uid);
    }

	
	
}
