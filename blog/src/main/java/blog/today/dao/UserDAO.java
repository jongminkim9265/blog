package blog.today.dao;
import org.springframework.stereotype.Repository;

import blog.today.common.dao.AbstractDAO;
import blog.today.vo.UserVO;
import blog.today.util.RegisterRequest;

@Repository("userDAO")
public class UserDAO extends AbstractDAO {
	public UserVO selectByEmail(String email) {
        return (UserVO)selectOne("user.selectByEmail", email);
    }
 
    public UserVO selectById(String id) {
        return (UserVO)selectOne("user.selectById", id);
    }
 
    public void insertUser(RegisterRequest regReq) {
        insert("user.register", regReq);
    }
}
