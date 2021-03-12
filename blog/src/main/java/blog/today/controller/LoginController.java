//package blog.today.controller;
//
//import javax.annotation.Resource;
//
//import javax.servlet.http.Cookie;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import javax.validation.Valid;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.validation.BindingResult;
//import org.springframework.web.bind.annotation.CookieValue;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.servlet.ModelAndView;
//
//import blog.today.service.UserService;
//import blog.today.util.LoginCommand;
//import blog.today.util.AuthInfo;
//import blog.today.common.exception.IdPassworeNotMatchingException;
//
////@Controller
//public class LoginController {
//	 	@RequestMapping(value="/loginPage", method=RequestMethod.GET)
//	    public ModelAndView loginForm(LoginCommand loginCommand,
//	                    @CookieValue(value="REMEMBER", required=false) Cookie rememberCookie) throws Exception {
//	        
//	        if(rememberCookie!=null) {
//	            loginCommand.setId(rememberCookie.getValue());
//	            loginCommand.setRememberId(true);
//	        }
//	        
//	        ModelAndView mv = new ModelAndView("/user/signin/loginForm");
//	        return mv;
//	    }
//	 	@Resource(name="userService")
//	    private UserService userSer;
//	 	
//	 	 @RequestMapping(value="/loginPage", method=RequestMethod.POST)
//	     public ModelAndView loginSuccess(@Valid LoginCommand loginCommand, BindingResult bindingResult,
//	                                     HttpSession session, HttpServletResponse response) throws Exception {
//	  
//	         if(bindingResult.hasErrors()) {
//	             ModelAndView mv = new ModelAndView("/user/signin/loginForm");
//	             return mv;
//	         }
//	         
//	         try {
//	             
//	             AuthInfo authInfo = userSer.loginAuth(loginCommand);
//	             session.setAttribute("authInfo", authInfo);
//	             
//	             Cookie rememberCookie = new Cookie("REMEMBER", loginCommand.getId());
//	             rememberCookie.setPath("/");
//	             if(loginCommand.isRememberId()) {
//	                 rememberCookie.setMaxAge(60*60*24*7);
//	             } else {
//	                 rememberCookie.setMaxAge(0);
//	             }
//	             response.addCookie(rememberCookie);
//	             
//	         } catch (IdPassworeNotMatchingException e) {
//	             bindingResult.rejectValue("pw", "notMatch", "아이디와 비밀번호가 맞지않습니다.");
//	             ModelAndView mv = new ModelAndView("/user/signin/loginForm");
//	             return mv;
//	         }
//	         
//	         ModelAndView mv = new ModelAndView("redirect:/");
//	         
//	         
//	         return mv;
//	     }
//	 @RequestMapping("/signout")
//	 public ModelAndView logout(HttpSession session) {
//		 session.invalidate();
//		 ModelAndView mv = new ModelAndView("redirect:/");
//		 return mv;
//	 }
//}
