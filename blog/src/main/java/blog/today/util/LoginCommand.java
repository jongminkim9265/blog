package blog.today.util;

import javax.persistence.Entity;
import javax.validation.constraints.NotEmpty;


@Entity
public class LoginCommand {
	
	@NotEmpty(message="아이디를 입력해주세요.")
    private String id;
 
    @NotEmpty(message="비밀번호를 입력해주세요.")
    private String pw;
    public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	private boolean rememberId;
    
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public boolean isRememberId() {
        return rememberId;
    }
    public void setRememberId(boolean rememberId) {
        this.rememberId = rememberId;
    }
}
