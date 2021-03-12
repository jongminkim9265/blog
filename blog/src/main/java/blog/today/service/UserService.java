package blog.today.service;

import blog.today.util.RegisterRequest;
import blog.today.util.AuthInfo;
import blog.today.util.LoginCommand;

public interface UserService {
	
	void register(RegisterRequest regReq) throws Exception;
	
	
	
}
