package com.spring.javagreenS_khv.common;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

public class ProjectSupport {
	
	public int fileUpload(MultipartFile fName) throws IOException {
		int res = 0;
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String saveFileName = uid + "_" + oFileName;
		
		writeFile(fName, saveFileName, "");
		res = 1;
		return res;
	}

	public void writeFile(MultipartFile fName, String saveFileName, String flag) {
		try {
			byte[] data = fName.getBytes();
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String uploadPath = "";
			if (flag.equals("custom")) {
			  uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/"+flag+"/");
			} else if (flag.equals("qrCode")) {
			  uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/"+flag+"/");
			}
			FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
			fos.write(data);
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
