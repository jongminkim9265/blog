package blog.today.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;


import org.apache.log4j.Logger; 
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import blog.today.command.CommandMap;
import blog.today.dao.BoardDAO;
import blog.today.vo.ReplyVO;
import blog.today.common.Utils.FileUtils;
import blog.today.common.page.Criteria;


@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="boardDAO")
	private BoardDAO boardDAO;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;

	@Override
	public List<ReplyVO> getReplyList(int IDX, Criteria cri) throws Exception {
		return boardDAO.getReplyList(IDX, cri);
	}
//	@Override
//	public List<Map<String, Object>> getReplyList(int IDX, Criteria cri) throws Exception {
//		return boardDAO.getReplyList(IDX, cri);
//	}
	
	@Override
	public int saveReply(ReplyVO replyVO) throws Exception {

		return boardDAO.saveReply(replyVO);
	}

	@Override
	public int updateReply(ReplyVO replyVO) throws Exception {

		return boardDAO.updateReply(replyVO);
	}
	@Override
	public int deleteReply(int rid) throws Exception {

		return boardDAO.deleteReply(rid);
	}
	@Override
	public int countReplyListTotal(int IDX) {
		return boardDAO.countReplyList(IDX);
	}
	@Override
    public List<Map<String, Object>> selectBoardList(Criteria cri) {
        // TODO Auto-generated method stub
        return boardDAO.selectBoardList(cri);
    }
	@Override
	public void insertBoard(CommandMap commandMap,HttpServletRequest request) throws Exception
	{
	    boardDAO.insertBoard(commandMap);
	    List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(commandMap.getMap(), request);
	    for(int i=0, size=list.size(); i<size; i++)
	    {
	    	boardDAO.insertFile(list.get(i)); 
	    }
	    

	}
	
	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		boardDAO.updateHitBoard(map);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		Map<String,Object> tempMap = boardDAO.detailBoard(map);
		resultMap.put("map",tempMap);
		
		List<Map<String,Object>> list = boardDAO.selectFileList(map);
		resultMap.put("list", list);
		return resultMap;
	}
	@Override
	public void updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception
	{
		boardDAO.updateBoard(map);
		
		boardDAO.deleteFileList(map);
		List<Map<String,Object>> list = fileUtils.parseUpdateFileInfo(map, request);
		Map<String,Object> tempMap = null;
		for (int i=0, size = list.size(); i < size ; i++)
		{
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) {
				boardDAO.insertFile(tempMap);
			}
			else {
				boardDAO.updateFile(tempMap);
			}
		}
	}
	@Override
	public void deleteBoard(Map<String, Object> map) {
		boardDAO.deleteBoard(map);
	}
	@Override
	public int countBoardListTotal() {
		return boardDAO.countBoarList();
	}
	@Override
    public Map<String, Object> viewBoardDetail(Map<String, Object> map) {
        // TODO Auto-generated method stub
        boardDAO.updateHitBoard(map);
        Map<String, Object> detail = boardDAO.detailBoard(map);
        List<Map<String, Object>> fileDetail = boardDAO.detailFile(map);
 
        Map<String, Object> resultBoard = new HashMap<String, Object>();
        resultBoard.put("detail", detail);
        resultBoard.put("file", fileDetail);
 
        return resultBoard;
    }
	@Override
	public int countArticle(String searchOption, String keyword) throws Exception{
		return boardDAO.countArticle(searchOption, keyword);
	}
	@Override
	public List<Map<String, Object>> listAll(String searchOption, String keyword,Criteria cri) throws Exception{
		return boardDAO.listAll(searchOption, keyword,cri);
	}
	
}
