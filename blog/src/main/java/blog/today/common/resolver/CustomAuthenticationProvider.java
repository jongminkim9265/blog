package blog.today.common.resolver;

import java.util.Collection;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import blog.today.service.SecUserService;
import blog.today.vo.CustomUserDetail;

public class CustomAuthenticationProvider implements AuthenticationProvider {
	
	Logger log = Logger.getLogger(getClass());
	
	@Resource(name="userSer")
	private SecUserService userSer;
	
	@Autowired
	private UserDetailsService userDeSer;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@SuppressWarnings("unchecked")
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		String username = (String) authentication.getPrincipal();
		String password = (String) authentication.getCredentials();
		
		log.debug("AuthenticationProvider :::::: 1");
		
		CustomUserDetail user = (CustomUserDetail) userDeSer.loadUserByUsername(username);
		
		if(!user.isEnabled() || !user.isCredentialsNonExpired()) {
			log.debug("isEnabled or isCredentialsNonExpired ::::::::: false");
			throw new AuthenticationCredentialsNotFoundException(username);
		}
		
		Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) user.getAuthorities();
		
		log.debug("AuthenticationProvider loadUserByUsername ::::::: 3");
		log.debug(password);
		log.debug(user.getPassword());
		
		if(!matchPassword(password, user.getPassword())) {
			log.debug("matchPassword :::::::::: false");
            throw new BadCredentialsException(username);
        }
		
		log.debug("matchPassword ::::::::: true!");
		
		return new UsernamePasswordAuthenticationToken(username,password, authorities);
	}
	 @Override
	    public boolean supports(Class<?> authentication) {
	        return true;
	    }
	    
	    private boolean matchPassword(String loginPwd, String password) {
	        return loginPwd.equals(password);
	    }

}
