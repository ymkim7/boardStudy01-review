package kr.co.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.vo.BoardVO;

@Component("fileUtils")
public class FileUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUtils.class);
	
	private static final String filePath = "C:\\file\\";
	
	public List<Map<String, Object>> parseInsertFileInfo(BoardVO vo
			, MultipartHttpServletRequest mpRequest) throws Exception {
		logger.info("parseInsertFileInfo");
		
		/*
		 * Iterator는 데이터들의 집합체(?)에서 컬렉션으로부터 정보를 얻어올 수 있는 인터페이스 List나 배열은 순차적으로 데이터 접근이
		 * 가능하지만 Map등의 다른 클래스들은 순차적으로 접근할 수 없음 그래서 Iterator를 이용하여 Map에 있는 데이터들을 while문을
		 * 이용하여 순차적으로 접근
		 */
		
		Iterator<String> iterator = mpRequest.getFileNames();
		
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;
		
		int bno = vo.getBno();
		File file = new File(filePath);
		
		if(file.exists() == false) {
			file.mkdirs();
		}
		
		while(iterator.hasNext()) {
			multipartFile = mpRequest.getFile(iterator.next());
			
			if(multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;
				
				file = new File(filePath + storedFileName);
				multipartFile.transferTo(file);
				listMap = new HashMap<String, Object>();
				listMap.put("bno", bno);
				listMap.put("orgFileName", originalFileName);
				listMap.put("storedFileName", storedFileName);
				listMap.put("fileSize", multipartFile.getSize());
				list.add(listMap);
			}
		}
		
		return list;
	}
	
	public static String getRandomString() {
		logger.info("getRandomString");
		
		return UUID.randomUUID().toString().replace("-", "");
	}

}
