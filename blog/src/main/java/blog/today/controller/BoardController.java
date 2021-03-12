package blog.today.controller;

import java.io.File;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import blog.today.command.CommandMap;
import blog.today.service.BoardService;
import blog.today.service.CommonService;
import blog.today.vo.ReplyVO;
import blog.today.common.page.PageMaker;
import blog.today.common.page.Criteria;

@Controller
public class BoardController {
Logger log = Logger.getLogger(this.getClass());
    
    @Resource(name="boardService")
    private BoardService boardService;
    
    @Resource(name = "commonService")
	private CommonService commonService;
    
    @RequestMapping(value="/boardList")
    public ModelAndView openBoardList(Criteria cri) throws Exception {
        
        //ModelAndView mav = new ModelAndView("/user/boardList");
        ModelAndView mav = new ModelAndView("/second/list");
        
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(boardService.countBoardListTotal());
        
        Map<String, Object> map = new HashMap<String,Object>();
        ArrayList<Integer> idx_int = new ArrayList<Integer>();
        int idx = 0;
        List<Map<String,Object>> list = boardService.selectBoardList(cri);
        
        for(Map<String, Object> v : list) {
        	idx_int.add(boardService.countReplyListTotal(((Integer) v.get("IDX"))));
        	
        }
        
        mav.addObject("cnt",idx_int);
        mav.addObject("list", list);
        mav.addObject("pageMaker", pageMaker);
        
        
        return mav;
        
    }
    
    @RequestMapping(value="/boardWrite")
    public String boardWrite() throws Exception {
    	
    	return "/second/write";
    }
  
    @RequestMapping(value="/boardInsert")
    public ModelAndView boardInsert(CommandMap commandMap,HttpServletRequest request) throws Exception { 
    	ModelAndView mav = new ModelAndView("redirect:/boardList");
    	boardService.insertBoard(commandMap, request);   
    	return mav;
    }
    
    @RequestMapping(value="/boardDetail")
    public ModelAndView boardDetail(CommandMap commandMap, Criteria cri) throws Exception {
    	ModelAndView mv = new ModelAndView("/second/detail");
    	Map<String,Object> detail = boardService.selectBoardDetail(commandMap.getMap());
    	
    	mv.addObject("map",detail.get("map"));
    	mv.addObject("list", detail.get("list"));
    	mv.addObject("replyVO",new ReplyVO());
    	
    	PageMaker pageMaker = new PageMaker();
    	pageMaker.setCri(cri);
    	mv.addObject("page",cri.getPage());
    	mv.addObject("pageMaker", pageMaker);
    	
    	return mv;
    }
    
    @RequestMapping(value="/boardUpdate")
    public ModelAndView boardUpdate(CommandMap commandMap, Criteria cri) throws Exception {
    	ModelAndView mv = new ModelAndView("/second/update");
    	Map<String,Object> detail = boardService.selectBoardDetail(commandMap.getMap());
    	mv.addObject("detail",detail.get("map"));
    	mv.addObject("list",detail.get("list"));
    	
    	PageMaker pageMaker = new PageMaker();
    	pageMaker.setCri(cri);
    	mv.addObject("page", cri.getPage());
    	mv.addObject("pageMaker", pageMaker);
    	
    	return mv;
    }
    
    @RequestMapping(value="/boardUpdate", method=RequestMethod.POST)
    public ModelAndView boardUpdatePOST(CommandMap commandMap, Criteria cri, RedirectAttributes redAttr,HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView("redirect:/boardDetail");
        
        boardService.updateBoard(commandMap.getMap(), request);
        mv.addObject("idx", commandMap.get("idx"));
        
        redAttr.addAttribute("page", cri.getPage());
        redAttr.addAttribute("perPagNum", cri.getPerPageNum());
        
        return mv;
    }
    @RequestMapping(value ="/boardDelete")
    public ModelAndView boardDelete(CommandMap commandMap) throws Exception {
    	ModelAndView mv = new ModelAndView("/user/boardDelete");
    	Map<String,Object> detail = boardService.selectBoardDetail(commandMap.getMap());
    	mv.addObject("detail",detail.get("map"));
    	//boardService.deleteBoard(commandMap.getMap());
    	return mv;
    }
    @RequestMapping(value ="/boardDeleteOK")
    public ModelAndView boardDeleteOK(CommandMap commandMap, Criteria cri, RedirectAttributes redAttr) throws Exception {
    	ModelAndView mv = new ModelAndView("redirect:/boardList");
    	
    	boardService.deleteBoard(commandMap.getMap());
  
    	return mv;
    }  
    @RequestMapping(value = "/boardSearch")
    public ModelAndView boardSearch(@RequestParam(defaultValue="title") String searchOption, @RequestParam(defaultValue="") String keyword, Criteria cri) throws Exception {
    	List<Map<String,Object>> list = boardService.listAll(searchOption, keyword,cri);
    	int count = boardService.countArticle(searchOption, keyword);
    	
    	ModelAndView mav = new ModelAndView();
    	Map<String, Object> map  = new HashMap<String, Object>();
    	map.put("list", list);
    	map.put("count", count);
    	map.put("searchOption", searchOption);
    	map.put("keyword", keyword);
    	mav.addObject("map", map);
    	ArrayList<Integer> idx_int = new ArrayList<Integer>();
    	for(Map<String, Object> v : list) {
        	idx_int.add(boardService.countReplyListTotal(((Integer) v.get("IDX"))));
        	
        }
        
        mav.addObject("cnt",idx_int);
    	
    	
    	PageMaker pageMaker = new PageMaker();
    	pageMaker.setCri(cri);
    	pageMaker.setTotalCount((Integer)map.get("count"));
    	mav.addObject("page", cri.getPage());
    	mav.addObject("pageMaker", pageMaker);
    	
    	mav.setViewName("/second/search");
    	return mav;
    }
    
}