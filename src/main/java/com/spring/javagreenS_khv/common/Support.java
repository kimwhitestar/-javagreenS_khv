package com.spring.javagreenS_khv.common;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_khv.HomeController;

public class Support {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	public int fileUpload(MultipartFile fName) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		int res = 0;
		try {
			UUID uuid = UUID.randomUUID();//화일명 중복방지 랜덤 난수 id
			String orgFName = fName.getOriginalFilename();
			String saveFName = uuid + "_" + orgFName;
			
			//writeFile(fName, saveFName, "pds");
			writeFile(fName, saveFName, "test");
			res = 1;
		} catch (IOException e) {
			res = -1;
			System.out.println(e.getMessage());
		}
		return res;
	}
	
	public void writeFile(MultipartFile fName, String saveFName, String flag) throws IOException {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		byte[] data = fName.getBytes();
		String uploadPath = "";
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();//자료업로드시킬 request객체 생성
		if (flag.equals("member"))
			uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/member/");//절대경로web-app주소
		else if (flag.equals("pds"))
			uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");//절대경로web-app주소
		else 
			uploadPath = request.getSession().getServletContext().getRealPath("/resources/images/test/");//절대경로web-app주소
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFName);
		fos.write(data);
		fos.close();
	}
	
	public void writeFile(MultipartFile fName, String saveFName) throws IOException {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		byte[] data = fName.getBytes();
		String uploadPath = "";
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();//자료업로드시킬 request객체 생성
		uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");//절대경로web-app주소
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFName);
		fos.write(data);
		fos.close();
	}
}