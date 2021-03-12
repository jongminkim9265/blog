package blog.today.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import blog.today.common.page.Criteria;
import blog.today.common.page.PageMaker;
import blog.today.service.ReplyService;
import blog.today.vo.ReplyVO;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Inject
    private ReplyService replyService;

	@Inject
	public ReplyController(ReplyService replyService) {
		this.replyService = replyService;
	}
	
	@RequestMapping(value = "/{IDX}/{page}", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> list(@PathVariable("IDX") Integer IDX,
                                                    @PathVariable("page") Integer page) {
        ResponseEntity<Map<String, Object>> entity = null;
        try {
            Criteria criteria = new Criteria();
            criteria.setPage(page);

            List<ReplyVO> list = replyService.list(IDX, criteria);
            System.out.println(list+"=====================================================================");
            int totalCount = replyService.count(IDX);

            PageMaker pageMaker = new PageMaker();
            pageMaker.setCri(criteria);
            pageMaker.setTotalCount(totalCount);

            Map<String, Object> map = new HashMap<String, Object>();
            map.put("list", list);
            map.put("pageMaker", pageMaker);

            entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 댓글 입력
    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseEntity<String> write(@RequestBody ReplyVO replyVO) {
        ResponseEntity<String> entity = null;
        try {
            replyService.addReply(replyVO);
            entity = new ResponseEntity<String>("INSERTED", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 댓글 수정
    @RequestMapping(value = "/{replyIDX}", method = {RequestMethod.PUT, RequestMethod.PATCH})
    public ResponseEntity<String> modify(@PathVariable("replyIDX") Integer replyIDX, @RequestBody ReplyVO replyVO) {
        ResponseEntity<String> entity = null;
        try {
            replyVO.setReplyIDX(replyIDX);
            replyService.modifyReply(replyVO);
            entity = new ResponseEntity<String>("UPDATED", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 댓글 삭제
    @RequestMapping(value = "/{replyIDX}", method = RequestMethod.DELETE)
    public ResponseEntity<String> remove(@PathVariable("replyIDX") Integer replyIDX) {
        ResponseEntity<String> entity = null;
        try {
            replyService.removeReply(replyIDX);
            entity = new ResponseEntity<String>("DELETED", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return entity;
    }
	
}
