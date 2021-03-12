package blog.today.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import blog.today.command.CommandMap;
import blog.today.common.page.Criteria;
import blog.today.vo.ReplyVO;


public interface BoardService {
	List<Map<String, Object>> selectBoardList(Criteria cri);
	
	void insertBoard(CommandMap commandMap, HttpServletRequest request) throws Exception;
	
	Map<String, Object> viewBoardDetail(Map<String, Object> map);
	
	Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception;
	void updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	void deleteBoard(Map<String, Object> map);
	
	int countBoardListTotal();
	
	public List<ReplyVO> getReplyList(int IDX, Criteria cri) throws Exception;

	//public List<Map<String,Object>> getReplyList(int IDX, Criteria cri) throws Exception;
	
	public int saveReply(ReplyVO replyVO) throws Exception;

	public int updateReply(ReplyVO replyVO) throws Exception;

	public int deleteReply(int rid) throws Exception;

	int countReplyListTotal(int IDX);
	
	public List<Map<String, Object>> listAll(String searchOption, String keyword, Criteria cri) throws Exception;
	
	public int countArticle(String searchOption, String keyword) throws Exception;

}
