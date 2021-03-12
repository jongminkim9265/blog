package blog.today.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import blog.today.vo.ReplyVO;
import blog.today.common.page.Criteria;
import blog.today.common.page.PageMaker;
import blog.today.service.BoardService;

@RestController
@RequestMapping(value="/restBoard")
public class meReplyController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Inject
	private BoardService boardService;

	@RequestMapping(value = "/replyList", method = {RequestMethod.POST, RequestMethod.GET})
	public List<ReplyVO> getReplyList(@RequestParam("IDX") int IDX, Criteria cri) throws Exception {
		return boardService.getReplyList(IDX,cri);
	}

//	@RequestMapping(value = "/replyList", method = {RequestMethod.POST, RequestMethod.GET})
//	public ModelAndView getReplyList(@RequestParam("IDX") int IDX, Criteria cri) throws Exception {
//		Map<String, Object> result = new HashMap<String, Object>();
//		int count = boardService.countReplyListTotal(IDX);
//		List<Map<String,Object>> list = boardService.getReplyList(IDX, cri);
//		result.put("list",list);
//		result.put("count", count);
//		ModelAndView mav = new ModelAndView();
//		PageMaker pageMaker = new PageMaker();
//    	pageMaker.setCri(cri);
//    	pageMaker.setTotalCount(count);
//		mav.addObject("map",result);
//    	mav.addObject("page",cri.getPage());
//    	mav.addObject("pageMaker", pageMaker);
//    	
//    	
//		return mav;
//	}
	
	@RequestMapping(value = "/saveReply", method = RequestMethod.POST)
	public Map<String,Object> saveReply(@RequestBody ReplyVO replyVO) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			boardService.saveReply(replyVO);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		
		return result;
	}
	@RequestMapping(value = "/updateReply", method = RequestMethod.POST)
	public Map<String, Object> updateReply(@RequestBody ReplyVO replyVO) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			boardService.updateReply(replyVO);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		
		return result;
	}
	@RequestMapping(value = "/deleteReply", method = RequestMethod.POST)
	public Map<String, Object> deleteReply(@RequestParam("replyIDX") int replyIDX) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			boardService.deleteReply(replyIDX);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		
		return result;
	}
}