package blog.today.service;

import java.util.List;

import javax.inject.Inject;

import blog.today.common.page.Criteria;
import blog.today.dao.BoardDAO;
import blog.today.dao.ReplyDAO;
import blog.today.vo.ReplyVO;

public interface ReplyService {
	
	// 댓글 목록
    public List<ReplyVO> list(int IDX) throws Exception;

    // 댓글 목록 + 페이징
    public List<ReplyVO> list(int IDX, Criteria criteria) throws Exception;

    // 특정 게시글의 댓글 갯수
    public int count(int IDX) throws Exception;

    // 댓글 입력
    public void addReply(ReplyVO replyVO) throws Exception;

    // 댓글 수정
    public void modifyReply(ReplyVO replyVO) throws Exception;

    // 댓글 삭제
    public void removeReply(int reply_IDX) throws Exception;

    // 회원이 작성한 댓글 목록
    public List<ReplyVO> userReplies(String uid) throws Exception;
	
}
