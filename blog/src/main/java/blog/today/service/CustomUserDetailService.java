package blog.today.service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import blog.today.dao.UserAuthDAO;
import blog.today.vo.CustomUserDetail;

public class CustomUserDetailService implements UserDetailsService{
	Logger log = Logger.getLogger(getClass());
	
	@Autowired
	private UserAuthDAO userAuthDAO;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.debug("loadUserByUsername ::::::: 2");
		
		CustomUserDetail user = userAuthDAO.getUserById(username);
		
		if(user==null) {
			log.debug("no user :::::: AuthenticationProvider");
			throw new InternalAuthenticationServiceException(username);
		}
		
		return user;
	}
			
}
