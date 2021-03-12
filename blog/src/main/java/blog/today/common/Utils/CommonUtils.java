package blog.today.common.Utils;
import java.util.UUID; public class CommonUtils
{
	public static String getRandomString()
	{ 
		return UUID.randomUUID().toString().replaceAll("-", "");
	} 
}


