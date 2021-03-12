package blog.today.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import blog.today.common.dao.AbstractDAO;
import blog.today.command.CommandMap;
import blog.today.common.page.Criteria;
import blog.today.vo.ReplyVO;

@Repository("boardDAO")
public class BoardDAO extends AbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Criteria cri) {
		
		return (List<Map<String,Object>>)selectList("board.selectBoardList", cri);
	}
	public void insertBoard(CommandMap commandMap) {
		insert("board.insertBoard", commandMap.getMap());
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> detailBoard(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("board.detailBoard", map);
		
	}
	public void updateBoard(Map<String, Object> map)
	{
		update("board.updateBoard", map);
	}
	
	public void updateHitBoard(Map<String, Object> map) {
		update("board.updateHitBoard", map);
	}
	
	public void deleteBoard(Map<String, Object> map) {
		delete("board.deleteBoard", map);
	}
	public int countBoarList() {
		return (Integer) selectOne("board.countBoardList");
	}
	public void insertFile(Map<String, Object> map)
	{
		insert("board.insertFile",map);
	}
	@SuppressWarnings("unchecked")
    public List<Map<String, Object>> detailFile(Map<String, Object> map) {
        return selectList("board.detailFile", map);
    }
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> selectFileList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>)selectList("board.selectFileList", map);
	}
	public void deleteFileList(Map<String,Object>map) throws Exception {
		update("board.deleteFileList", map);
	}
	public void updateFile(Map<String,Object> map) throws Exception{
		update("board.updateFile", map);
	}
	public int countReplyList(int IDX) {
		return (Integer) selectOne("reply.countReplyList",IDX);
	}
	@SuppressWarnings("unchecked")
	public List<ReplyVO> getReplyList(int IDX, Criteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("IDX", IDX);
		map.put("pageStart", cri.getPageStart());
		map.put("perPageNum", cri.getPerPageNum());
		return selectList("reply.selectReplyList", map);
	}
//	@SuppressWarnings("unchecked")
//	public List<Map<String,Object>> getReplyList(int IDX, Criteria cri) throws Exception {
//		Map<String, Object> map = new HashMap<String,Object>();
//		map.put("IDX", IDX);
//		map.put("pageStart", cri.getPageStart());
//		map.put("perPageNum", cri.getPerPageNum());
//		return (List<Map<String,Object>>)selectList("reply.selectReplyList", map);
//	}
	
	public int saveReply(ReplyVO replyVO) throws Exception {

		return (Integer) insert("reply.insertReply", replyVO);

	}
	public int updateReply(ReplyVO replyVO) throws Exception {

		return (Integer) update("reply.updateReply", replyVO);

	}
	public int deleteReply(int reply_IDX) throws Exception {

		return (Integer) delete("reply.deleteReply", reply_IDX);

	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> listAll (String searchOption, String keyword ,Criteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("pageStart", cri.getPageStart());
		map.put("perPageNum", cri.getPerPageNum());
		return (List<Map<String,Object>>)selectList("board.listAll", map);
	}
	public int countArticle(String searchOption, String keyword) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		
		return (Integer) selectOne("board.countArticle", map);
	}
}
