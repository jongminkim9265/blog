package blog.today.common.Utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.util.UUID;

import org.imgscalr.Scalr;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
@Component("fileUtils")
public class FileUtils 
{
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		// uuid 랜덤 발급 , uuid를 생성해서 파일이름에 붙여줌으로 중복을 피함
		UUID uid = UUID.randomUUID();
		//uuid + 파일이름
		String savedName = uid.toString() + "_" + originalName;
		// 업로드할 디렉토리 생성
		String savedPath = calcPath(uploadPath);
		File target = new File(uploadPath + savedPath, savedName);
		// 업로드 경로와 저장경로에 저장한 파일의 이름에 대한 File 객체 생성
		FileCopyUtils.copy(fileData, target);
		//임시 디렉토리에 업로된 파일을 지정된 디렉토리로 복사
		String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);
		//확장자를 찾기위에서 . 뒤에 문자열을 포멧네임에 받아옴
		String uploadedFileName = null; // 업로드할 파일네임의 초기값
		if(MediaUtils.getMediaType(formatName) != null) {
			//들어온 파일이 이미지일 경우 썸네일 생성
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);
		}else {
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		return uploadedFileName;
	}
	//아이콘 생성
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {
		String iconName = uploadPath + path + File.separator + fileName;
		//여기서 File.separator는 구분자를 의미함 (윈도우 \ , 리눅스 /)
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
		//파일 이름
	}
	private static String makeThumbnail(String uploadPath, String path, String fileName) throws Exception {
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));
		//이미지를 버퍼에 담아줌
		//100픽셀 단위 썸네일 생성
		// 이미지 크기를 줄이기위함
		// 높이가 100픽셀이면 가로 세로가 알아서 지정
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		
		//썸네일 이름 지정
		String thumnailName = uploadPath + path + File.separator + "_s" + fileName;
		
		// 썸네일의 경로를 newfile에 저장
		File newFile = new File(thumnailName);
		
		//확장자를 찾기위해 . 을 검색한 후 뒤에문자 전부이므로 확장자 검색
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		//썸네일 생성
		//리사이즈한 이미지형식의 파일이름을 대문자로 바꿔서 newfile 경로에 저장
		//write를 통한 이미지 생성
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		
		//썸네일 이름 리턴
		return thumnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		
		// "월"이랑 "일"은 10보다 작을떄가 있으므로 (01 ,02 ... ) 에 대한 처리
		// DecimalFormat을 통한 십진수형식으로 표현
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		makeDir(uploadPath, yearPath, monthPath, datePath);
		return datePath;
	}
	private static void makeDir(String uploadPath, String... paths) {
		// 호출 당시에는 4개의 매개변수이지만 ...이 가변사이즈 매개변수이기 때문에 호출시에 숫자가 많아도 배열로 만들어져 paths로 다 들어간다.
		// ex) paths -> 0번 : yearPath , 1 번 monthPath등
		//디렉토리가 존재하면 만들지 않고 넘어감
		if(new File(paths[paths.length -1]).exists()) {
			return;
		}
		//디렉토리가 없을 경우 생성
		for(String path : paths) {
			File dirPath = new File(uploadPath + path);
			if(!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
	private static final String filePath = "C:\\Downloads\\";
	public List<Map<String,Object>> parseInsertFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception
	{
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null;
		String boardIDX = String.valueOf(map.get("idx"));
		String creaID = (String) map.get("crea_id");

		File file = new File(filePath);
		if(file.exists() == false)
		{
			file.mkdirs();
			
		} 
		while(iterator.hasNext())
		{ 
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false)
			{ 
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = CommonUtils.getRandomString() + originalFileExtension;
				file = new File(filePath + storedFileName); multipartFile.transferTo(file);
				listMap = new HashMap<String,Object>();
				listMap.put("BOARD_IDX", boardIDX);
				listMap.put("ORIGINAL_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName); 
				listMap.put("FILE_SIZE", multipartFile.getSize()); 
				listMap.put("CREA_ID", creaID);
				list.add(listMap);
				} 
			} 
			return list;
			} 
		public List<Map<String,Object>> parseUpdateFileInfo(Map<String, Object>map, HttpServletRequest request) throws Exception{
			Logger log = Logger.getLogger(this.getClass());
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
			Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
			
			MultipartFile multipartFile = null;
			String originalFileName = null;
			String originalFileExtension = null;
			String storedFileName = null;
			
			List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
			Map<String,Object> listMap = null;
			
			String boardIDX = String.valueOf(map.get("idx"));
			String requestName = null;
			String idx = null;
			String creaID = (String) map.get("crea_id");
			
			while(iterator.hasNext()) {
				multipartFile  = multipartHttpServletRequest.getFile(iterator.next());
				if(multipartFile.isEmpty() == false) {
					originalFileName = multipartFile.getOriginalFilename();
					originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
					storedFileName = CommonUtils.getRandomString() + originalFileExtension;
					multipartFile.transferTo(new File(filePath + storedFileName));
					listMap = new HashMap<String, Object>();
					listMap.put("IS_NEW", "Y");
					listMap.put("BOARD_IDX", boardIDX);
					listMap.put("ORIGINAL_FILE_NAME", originalFileName);
					listMap.put("STORED_FILE_NAME", storedFileName);
					listMap.put("FILE_SIZE", multipartFile.getSize());
					listMap.put("CREA_ID", creaID);
					list.add(listMap);
				}
				else {
						requestName = multipartFile.getName();
						idx = "IDX_"+requestName.substring(requestName.indexOf("_")+1);
						if(map.containsKey(idx) == true && map.get(idx) != null) {
							listMap = new HashMap<String,Object>();
							listMap.put("IS_NEW", "N");
							listMap.put("FILE_IDX", map.get(idx));
							list.add(listMap);
						}
				}
			}
			return list;
		}
		
	}


