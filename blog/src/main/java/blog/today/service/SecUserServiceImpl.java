package blog.today.service;

import javax.annotation.Resource;
import blog.today.vo.CustomUserDetail;

import org.springframework.stereotype.Service;

import blog.today.common.exception.AlreadyExistingEmailException;
import blog.today.common.exception.AlreadyExistingIdException;
import blog.today.dao.UserAuthDAO;
import blog.today.util.RegisterRequest;
import blog.today.vo.UserVO;

@Service("userSer")
public class SecUserServiceImpl implements SecUserService {

	@Resource(name="userAuthDAO")
	private UserAuthDAO userDAO;

	@Override
	public void countFailure(String username) {
		userDAO.updateFailureCount(username);
	}

	@Override
	public int checkFailureCount(String username) {
		return userDAO.checkFailureCount(username);
	}

	@Override
	public void disabledUsername(String username) {
		userDAO.updateDisabled(username);
	}

	@Override
	public void resetFailureCnt(String username) {
		userDAO.updateFailureCountReset(username);
	}

	@Override
	public void updateAccessDate(String username) {
		userDAO.updateNewAccessDate(username);
	}
//	@Override
//	public void register(RegisterRequest regReq) throws Exception {
//
//		CustomUserDetail id = userDAO.getUserById(regReq.getId());
//        if(id!=null) {
//            throw new AlreadyExistingIdException(regReq.getId()+" is duplicate id.");
//        }
//        userDAO.insertUser(regReq);
//    }
	
}
