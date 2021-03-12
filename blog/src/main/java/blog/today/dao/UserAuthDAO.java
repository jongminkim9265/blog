package blog.today.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import blog.today.util.RegisterRequest;
import blog.today.vo.CustomUserDetail;

@Repository("userAuthDAO")
public class UserAuthDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
//	 public void insertUser(RegisterRequest regReq) {
//	        sqlSession.insert("secuser.register", regReq);
//	    }
//	
	public CustomUserDetail getUserById(String username) {
		return sqlSession.selectOne("secuser.selectUserById", username);
	}
	public void updateFailureCount(String username) {
		sqlSession.update("secuser.updateFailureCount", username);
	}
	public int checkFailureCount(String username) {
		return sqlSession.selectOne("secuser.checkFailureCount",username);
	}
	public void updateDisabled(String username) {
		sqlSession.update("secuser.updateUnenabled", username);
	}
	public void updateFailureCountReset(String username) {
		sqlSession.update("secuser.updateFailureCountReset", username);
	}
	public void updateNewAccessDate(String username) {
		sqlSession.update("secuser.updateAccessDate", username);
	}
}
