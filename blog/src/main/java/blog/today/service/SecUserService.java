package blog.today.service;

import blog.today.util.RegisterRequest;

public interface SecUserService {

	void countFailure(String username);

	int checkFailureCount(String username);

	void disabledUsername(String username);

	void resetFailureCnt(String username);

	void updateAccessDate(String username);

	//void register(RegisterRequest regReq) throws Exception;
}