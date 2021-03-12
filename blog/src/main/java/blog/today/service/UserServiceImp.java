package blog.today.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.security.core.userdetails.UserDetailsService;

import blog.today.common.exception.AlreadyExistingEmailException;
import blog.today.common.exception.AlreadyExistingIdException;
import blog.today.vo.UserVO;
import blog.today.dao.UserDAO;
import blog.today.util.RegisterRequest;
import blog.today.util.AuthInfo;
import blog.today.util.LoginCommand;
import blog.today.common.exception.IdPassworeNotMatchingException;

@Service("userService")
public class UserServiceImp implements UserService {
	@Resource(name="userDAO")
    private UserDAO userDAO;
	
	@Override
	public void register(RegisterRequest regReq) throws Exception {
//        UserVO email = userDAO.selectByEmail(regReq.getEmail());
//        if(email!=null) {
//            throw new AlreadyExistingEmailException(regReq.getEmail()+" is duplicate email.");
//        }
        UserVO id = userDAO.selectById(regReq.getId());
        if(id!=null) {
            throw new AlreadyExistingIdException(regReq.getId()+" is duplicate id.");
        }
        userDAO.insertUser(regReq);
    }
	
}
	
