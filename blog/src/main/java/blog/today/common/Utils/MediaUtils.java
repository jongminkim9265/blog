package blog.today.common.Utils;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;
public class MediaUtils {
	private static Map<String, MediaType> mediaMap;
	// 클래스를 로딩할때 제일 먼저 생성되야 하기에 스테틱선언
	
	static {
		mediaMap = new HashMap();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("JPG", MediaType.IMAGE_GIF);
		mediaMap.put("JPG", MediaType.IMAGE_PNG);
	}
	public static MediaType getMediaType(String type) {
		return mediaMap.get(type.toUpperCase());
		// 그림파일이나 일반파일로 구분하기 위한 메서드로 소문자로 오류가 생길수있어 대문자로 바꿔줌
	}
}
