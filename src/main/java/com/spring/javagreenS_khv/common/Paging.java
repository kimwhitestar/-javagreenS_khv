package com.spring.javagreenS_khv.common;

import java.io.IOException;

import javax.servlet.ServletException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.spring.javagreenS_khv.HomeController;
//import com.spring.javagreenS_khv.dao.PdsDAO;
import com.spring.javagreenS_khv.vo.PagingVO;

public class Paging {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
//	@Autowired
//	private PdsDAO pdsDao;
	
	private PagingVO pagingVo;
	
	private Model model;
	private int startIndexNo = 0;
	private int pageSize = 0;
	
	/**
	 * 페이징 생성자
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @throws ServletException
	 * @throws IOException
	 */
	public Paging(Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		this.model = model;
	}
	
	/**
	 * 페이징 정보를 산출하여 REQUEST 객체에 페이징 설정
	 * @param pageNo 현재의 페이지 번호
	 * @param totalRecordSize 목록의 총 레코드 갯수
	 * @param pagingRecordSize 각 페이징할 목록의 레코드 갯수
	 * @param blockingSize 페이징할 블록 갯수
	 */
	public void setPaging(int pageNo, int totalRecordSize, int pagingRecordSize, int blockingSize) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		/*
		 *   페이징 처리
		 *   0. 현 페이지 구하기 : page = @param pageNo
		 *   1. 한 페이지 분량을 정한다 : pageSize = 5
		 *   2. 총 레코드 건수를 구하기 : totRecCnt = @param totalRecordCnt
		 *   3. 총 페이지 수 구하기 : totPage => totRecCnt % pageSize (몫의 정수값이 0이면 정수, 몫의 정수값이 아니면 정수값 + 1)
		 * 	 4. 현재페이지의 시작 인덱스 : startIndexNo => (page -1) * pageSize
		 * 	 5. 화면에 보이는 방문소감의 시작번호 : curScrStartNo = totRecCnt - startIndexNo
		 *	 6. 블록페이징처리
		 */
		//0. 현 페이지
		int page = pageNo;
		
		//1. 한 페이지 분량
		this.pageSize = pagingRecordSize;
		
		//2. 총 레코드 건수
		int totRecCnt = totalRecordSize;
		
		//3. 총 페이지 수
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize)+1;
		
		//4. 현재페이지 시작 인덱스
		this.startIndexNo = (page -1) * pageSize;
		
		//5. 방문소감의 시작번호
		int curScrStartNo = totRecCnt - startIndexNo;

		//6. 블록페이징처리시 아래 내용 추가 (한블럭에 3page씩 보여준다) : blockSize
		int blockSize = blockingSize;
		
		//7. 현재 블럭 위치 (첫번째 블럭 = 0) : curBlock 
		int curBlock = (page - 1) / blockSize;
		
		//8. 마지막 블럭 : lastBlock
		int lastBlock = (totPage % blockSize)==0 ? (totPage / blockSize) - 1 : (totPage / blockSize);
		
		model.addAttribute("curScrStartNo", curScrStartNo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("totPage", totPage);
		model.addAttribute("pageSize", this.pageSize);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
	}
	
	/**
	 * 한 페이징에 표시할 레코드 시작번호 취득
	 * @return startIndexNo
	 */
	public int getStartIndexNo() {
		return this.startIndexNo;
	}
	
	/**
	 * 한 페이지 분량 취득
	 * @return pageSize
	 */
	public int getPageSize() {
		return this.pageSize;
	}

	/* 선생님 수업용 */
	public PagingVO totRecCnt(int blockSize, int pageSize, int pageNo, String menuName, String division, String searchingKeyWord) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		int totRecCnt = 0;
//		if (menuName.equals("member")) {
//			totRecCnt = memberDao.searchMemberListTotRecCnt();
//		} else if (menuName.equals("board")) {
//			if (division.equals("") || searchingKeyWord.equals("")) {
//				totRecCnt = boardDao.searchBoardListTotRecCnt();
//			} else {
//				totRecCnt = boardDao.searchBoardListTotSearchRecCnt(division, searchingKeyWord);
//			}
//		} else if (menuName.equals("pds")) {
			totRecCnt = 0;//pdsDao.searchPdsListTotRecCnt(division);
//		}
		
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize)+1;
		int startIndexNo = (pageNo -1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int curBlock = (pageNo - 1) / blockSize;
		int lastBlock = (totPage % blockSize)==0 ? (totPage / blockSize) - 1 : (totPage / blockSize);

		pagingVo.setBlockSize(blockSize);
		pagingVo.setCurBlock(curBlock);
		pagingVo.setLastBlock(lastBlock);
		pagingVo.setPageSize(pageSize);
		pagingVo.setPageNo(pageNo);
		pagingVo.setTotRecCnt(totRecCnt);
		pagingVo.setTotPage(totPage);
		pagingVo.setStartIndexNo(startIndexNo);
		pagingVo.setCurScrStartNo(curScrStartNo);
		
		return pagingVo;
	}
}