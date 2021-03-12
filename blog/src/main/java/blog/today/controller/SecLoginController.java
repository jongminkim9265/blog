package blog.today.controller;

import javax.annotation.Resource;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.servlet.ModelAndView;

import blog.today.util.LoginCommand;

@Controller
public class SecLoginController {
	
	@RequestMapping(value="/loginPage")
	public String page(LoginCommand loginCommand,@CookieValue(value="REMEMBER", required=false) Cookie rememberCookie) throws Exception {
		if(rememberCookie!=null) {
            loginCommand.setId(rememberCookie.getValue());
            loginCommand.setRememberId(true);
        }
		return "/user/signin/loginForm";
	}
	
	@RequestMapping(value="/access_denied_page")
	public String accessDeniedPage() throws Exception {
		return "/";
	}
	
    @RequestMapping(value="/access_denied")
    public ModelAndView accessDenied() throws Exception {
    	ModelAndView mv = new ModelAndView("/");
    	mv.addObject("msg", "접근 권한이 없습니다.");
    	mv.addObject("url", "/");
    	return mv;
    }
    
	
}
