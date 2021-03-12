package blog.today.handler;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import blog.today.service.SecUserService;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	private static int TIME = 60 * 3; //3q
	
	Logger log = Logger.getLogger(getClass());
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();
	
	private String loginidname;
	private String defaultUrl;
	
	@Resource(name="userSer")
	private SecUserService userSer;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
		Authentication authentication) throws IOException, ServletException {
		String username = request.getParameter(loginidname);
		request.getSession().setMaxInactiveInterval(TIME);
		Cookie rememberCookie = new Cookie("REMEMBER", username);
		rememberCookie.setPath("/");

		userSer.resetFailureCnt(username);
		userSer.updateAccessDate(username);
		
		//에러 세션 지우는 함수
		clearAuthenticationAttributes(request);
		
		resultRedirectStrategy(request, response, authentication);
		
	}
	
	
	protected void clearAuthenticationAttributes(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if(session == null) return;
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}
	protected void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response, Authentication authentication ) throws IOException, ServletException {
		
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		if(savedRequest != null ) {
			log.debug("권한이 필요한 페이지 접근 시 ");
			useSessionUrl(request,response);
		} else {
			log.debug("직접 로그인 url로 이동했을 경우 ");
			useDefaultUrl(request,response);
		}
	}

	protected void useSessionUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String targetUrl = savedRequest.getRedirectUrl();
		redirectStratgy.sendRedirect(request, response, targetUrl);
		
	}
	protected void useDefaultUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {
		redirectStratgy.sendRedirect(request, response, defaultUrl);
	}
	public String getLoginidname() {
		return loginidname;
	}
	public void setLoginidname(String loginidname) {
		this.loginidname = loginidname;
	}
	
	public String getDefaultUrl() {
		return defaultUrl;
	}
	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}
	public void setDefualtUrl(String defaultUrl) {
		this.defaultUrl = this.defaultUrl;
	}
}
