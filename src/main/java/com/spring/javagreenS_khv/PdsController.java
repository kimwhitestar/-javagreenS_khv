package com.spring.javagreenS_khv;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_khv.common.Paging;
import com.spring.javagreenS_khv.vo.PagingVO;
import com.spring.javagreenS_khv.vo.PdsVO;

@Controller
@RequestMapping("/pds")
public class PdsController {
//
//	private static final Logger logger = LoggerFactory.getLogger(PdsController.class);
//	
////	@Autowired
////	public PdsService pdsService;
//	
//	public Paging paging;	
//
//	@Autowired
//	public BCryptPasswordEncoder bCrypt;
//	
//	@RequestMapping(value= "/pdsList", method=RequestMethod.GET)
//	public String pdsListGet(
//		@RequestParam(name="pageNo", defaultValue="1", required=false) int pageNo,
//		@RequestParam(name="pageSize", defaultValue="3", required=false) int pageSize,
//		@RequestParam(name="part", defaultValue="전체", required=false) String part,
//		Model model) {
//	logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
//
//		PagingVO pagingVo = paging.totRecCnt(5, pageSize, pageNo, "pds", part, "");
//		List<PdsVO> vos = pdsService.searchPdsList(pagingVo.getStartIndexNo(), pagingVo.getPageSize(), part);
//		pagingVo.setDivision(part);
//		model.addAttribute("vos", vos);
//		model.addAttribute("pagingVo", pagingVo);
//		
//		return "pds/pdsList";
//	}
//
//	@RequestMapping(value= "/pdsInput", method=RequestMethod.POST)
//	public String pdsInputPost(PdsVO vo, 
//		MultipartHttpServletRequest file, //file 여러개  
//		Model model) {
//		
//		String pwd = vo.getPassword();
//		vo.setPassword(bCrypt.encode(pwd));
//		
//		pdsService.insertPds(file, vo);
//		return "redirect:/msg/pdsInputOk";
//	}
//	
//	@ResponseBody
//	@RequestMapping(value= "/pdsDownNum", method=RequestMethod.POST)
//	public String pdsDownNumPost(int idx) {
//		pdsService.updateDownNum(idx);
//		return "";
//	}
//	
//	@RequestMapping(value= "/pdsDetail", method=RequestMethod.GET)
//	public String pdsDetailGet(@RequestParam int idx, Model model) {
//		PdsVO vo = pdsService.searchPds(idx);
//		model.addAttribute("vo", vo);
//		return "pds/pdsDetail";
//	}
//	
//	@ResponseBody
//	@RequestMapping(value= "/pdsPwdCheck", method=RequestMethod.POST)
//	public String pdsPwdCheckPost(int idx, String pwd) {
//		String bCryptPwd = bCrypt.encode(pwd);
//		PdsVO vo = pdsService.searchPds(idx);
//		if (!bCryptPwd.equals(vo.getPassword())) {
//			return "0";
//		}
//		pdsService.deletePds(vo);
//		return "1";
//	}
//
//	@RequestMapping(value= "/pdsCompress", method=RequestMethod.GET)
//	public String pdsCompressGet(HttpServletRequest request, PdsVO vo) 
//		throws IOException { //controller는 간단한 예외처리를 자동처리하는 기능이 있으므로 예외처리넘겨도됨
//		//다운로드수 증가
//		pdsService.updateDownNum(vo.getIdx()); 
//		
//		//파일 압축 처리
//		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
//		String[] fNames = vo.getFName().split("/");
//		String[] fSNames = vo.getFSName().split("/");
//		
//		FileInputStream fis = null;
//		FileOutputStream fos = null;
//		String zipPath = realPath + "zip/";
//		String zipName = vo.getTitle() + ".zip"; //보통크기:2KB~4KB
//		ZipOutputStream zipOut = new ZipOutputStream(new FileOutputStream(zipPath + zipName));//zip파일(명) 생성-빈파일
//		
//		byte[] buffer = new byte[2048];
//		File inFile = null, outFile = null;
//		int data;
//		for (int i=0; i<fSNames.length; i++) {
////			fis = new FileInputStream(realPath + fSNames[i]);
////			fos = new FileOutputStream(realPath + "zip/" + fNames[i]);
////			
////			data = 0;
////			while(-1 != (data = fis.read(buffer, 0, buffer.length))) {
////				fos.write(buffer, 0, data);
////			}
////			fos.close();
////			fis.close();
//			outFile = new File(zipPath + fNames[i]);//pds/zip폴더 밑 new File로 생성한 파일(명)-빈파일
//			inFile = new File(realPath + fSNames[i]);//pds폴더 밑 new File로 생성한 파일(명)-빈파일
//			inFile.renameTo(outFile);//파일명을 출력파일명으로 변경해서 파일 이동(복사아님)
//			
//			fis = new FileInputStream(outFile);
//			zipOut.putNextEntry(new ZipEntry(fNames[i]));//zip안에 여러파일(명) 생성-빈파일
//			
//			data = 0;
//			while(-1 != (data = fis.read(buffer, 0, buffer.length))) {//inFile을 stream빨대로 2048byte씩 read읽기
//				zipOut.write(buffer, 0, data);//zip안에 생성한 빈엔트리파일을 찾아서? stream빨대로 2048byte씩 write내용기록 출력
//			}
//			//zipOut.flush();
//			zipOut.closeEntry();
//			fis.close();
//		}
//		zipOut.close();
//		
//		return "redirect:/pds/pdsDownload?file=" + java.net.URLEncoder.encode(zipName, "UTF-8");
//	}
//
//	@RequestMapping(value= "/pdsDownload", method=RequestMethod.GET)
//	public void pdsDownloadGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
//		String file = req.getParameter("file");//위에 선언된 pdsCompressGet에서 redirect의 get으로 받은 파라미터
//		String downPath = req.getSession().getServletContext().getRealPath("/resources/data/pds/zip/"+file);
//		
//		String downFileName = "";
//		if (-1 == req.getHeader("user-agent").indexOf("MSIE")) { //Microsoft Internet Explorer가 아니면
//			downFileName = new String(file.getBytes("UTF-8"), "8859_1");
//		} else {
//			downFileName = new String(file.getBytes("EUC-KR"), "8859_1");
//		}
//		res.setHeader("Content-Disposition", "attachment;filename=" + downFileName);
//		
//		FileInputStream fis = new FileInputStream(new File(downPath));
//		ServletOutputStream sos = res.getOutputStream();
//		
//		byte[] buffer = new byte[2048];
//		int data = 0;
//		while(-1 != (data = fis.read(buffer, 0, buffer.length))) {
//			sos.write(buffer, 0, data);
//		}
//		sos.flush();
//		sos.close();
//		fis.close();
//		
//		new File(downPath).delete();
//	}
}