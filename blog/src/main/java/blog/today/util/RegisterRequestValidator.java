package blog.today.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
 
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class RegisterRequestValidator implements Validator{
//	private static final String emailRegExp =
//            "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" +
//            "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
//    private Pattern pattern;
// 
//    public RegisterRequestValidator() {
//        pattern = Pattern.compile(emailRegExp);
//    }
	
	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object target, Errors errors) {
		RegisterRequest regReq = (RegisterRequest) target;
        //Email 받아와서 비어있을 경우 넘어가지 않음
//        if(regReq.getEmail() == null || regReq.getEmail().trim().isEmpty()) {
//            errors.rejectValue("email", "required", "필수 정보 입니다.");
//        } else {
//        	//Email pattern을 보고 이메일인지 아닌지 파악
//            Matcher matcher = pattern.matcher(regReq.getEmail());
//            if(!matcher.matches()) {
//                errors.rejectValue("email", "bad", "올바르지 않는 형식입니다.");
//            }
//        }
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required", "필수 정보 입니다.");
        ValidationUtils.rejectIfEmpty(errors, "pw", "required", "필수 정보 입니다.");
        ValidationUtils.rejectIfEmpty(errors, "checkPw", "required", "필수 정보 입니다.");
        if(!regReq.getPw().isEmpty()) {
            if(!regReq.isPwEqualToCheckPw()) {
                errors.rejectValue("checkPw", "nomatch", "비밀번호가 일치하지 않습니다.");
            }
        }
    }	
}
