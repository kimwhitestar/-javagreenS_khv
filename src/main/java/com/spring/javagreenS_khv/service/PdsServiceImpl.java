package com.spring.javagreenS_khv.service;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_khv.common.Support;
import com.spring.javagreenS_khv.dao.PdsDAO;
import com.spring.javagreenS_khv.vo.PdsVO;

@Service
public class PdsServiceImpl implements PdsService {

//	@Autowired
//	public PdsDAO pdsDao;
//	
//	@Override
//	public List<PdsVO> searchPdsList(int startIndexNo, int pageSize, String part) {
//		return pdsDao.searchPdsList(startIndexNo, pageSize, part);
//	}
//	
//	@Override
//	public PdsVO searchPds(int idx) {
//		return pdsDao.searchPds(idx);
//	}
//
//	@Override
//	public void insertPds(MultipartHttpServletRequest mFile, PdsVO vo) {
//		try {
//			List<MultipartFile> files = mFile.getFiles("file");
//			String oFName, oFNames = "";
//			String sFName, sFNames = "";
//			int fileSize = 0;
//			
//			for (MultipartFile file : files) {
//				oFName = file.getOriginalFilename();
//				sFName = getSFName(oFName); 
//				
//				new Support().writeFile(file, sFName, "pds");
//				
//				oFNames += oFName + "/";
//				sFNames += sFName + "/";
//				fileSize += file.getSize();
//			}
//			vo.setFName(oFNames);
//			vo.setFSName(sFNames);
//			vo.setFSize(fileSize);
//			
//			pdsDao.insertPds(vo);
//			
//		} catch (IOException e) {
//			System.out.println(e.getMessage());
//		}
//		
//	}
//	
//	//서버에 저장될 파일명(파일명 중복방지)
//	private String getSFName(String oFName) {
//		String fName = "";
//		
//		Calendar cal = Calendar.getInstance();
//		fName += cal.get(Calendar.YEAR);
//		fName += cal.get(Calendar.MONTH);
//		fName += cal.get(Calendar.DATE);
//		fName += cal.get(Calendar.HOUR);
//		fName += cal.get(Calendar.MINUTE);
//		fName += cal.get(Calendar.SECOND);
//		fName += cal.get(Calendar.MILLISECOND);
//		fName += "_" + oFName;
//		return fName;
//	}
//
//	@Override
//	public void updateDownNum(int idx) {
//		pdsDao.updateDownNum(idx);
//	}
//
//	@Override
//	public void deletePds(PdsVO vo) {
//		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
//		String realPath = req.getSession().getServletContext().getRealPath("/resources/data/pds/");
//		String[] fSNames = vo.getFSName().split("/");
//		String realPathFile = "";
//
//		//pds파일 삭제
//		for (int i=0; i<fSNames.length; i++) {
//			realPathFile = realPath + fSNames[i];
//			new File(realPathFile).delete();
//		}
//		
//		pdsDao.deletePds(vo.getIdx());
//	}
}