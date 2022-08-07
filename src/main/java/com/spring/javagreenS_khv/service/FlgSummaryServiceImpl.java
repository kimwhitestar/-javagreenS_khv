package com.spring.javagreenS_khv.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_khv.dao.FlgSummaryDAO;
import com.spring.javagreenS_khv.dto.FlgSummaryDTO;
import com.spring.javagreenS_khv.vo.FlagVO;
import com.spring.javagreenS_khv.vo.FlgSummaryVO;

@Service
public class FlgSummaryServiceImpl implements FlgSummaryService {
	@Autowired
	public FlgSummaryDAO flgSummaryDao;
	
	@Override
	public FlgSummaryVO searchFlg(String flgCd, String menuCd, String subMenuCd) {
		if (null == flgCd || null == menuCd || null == subMenuCd) return null;
		
		FlgSummaryDTO flgSummaryDto = flgSummaryDao.searchFlg(flgCd, menuCd, subMenuCd);
		if (null == flgSummaryDto) return null;
		
		String[] flgNmRec = getFlgSummaryRecords(flgSummaryDto.getFlg_nm());
		List<FlagVO> flagVos = getFlgSummaryVos(flgNmRec);
		if (null == flagVos) return null;
		
		FlgSummaryVO flgSummaryVo = new FlgSummaryVO();
		flgSummaryVo.setFlagVos(flagVos);
		flgSummaryVo.setDelFlag(flgSummaryDto.getDel_flag());//default : enable, deleted : disable
		return flgSummaryVo;
	}
	
	private List<FlagVO> getFlgSummaryVos(String[] flgNmRec) {
		if (null == flgNmRec || 1 > flgNmRec.length) return null;
		List<FlagVO> flagVos = new ArrayList<>();
		FlagVO flagVo = null;
		int startIdx = 0, endIdx = 0;
		for (String flgNmRow : flgNmRec) {//NONE:해당안됨|OVER:30일경과|PRAC:30일미경과
			endIdx = flgNmRow.indexOf(":");
			if (1 > endIdx || endIdx == flgNmRow.length()-1) continue;
			flagVo = new FlagVO();
			flagVo.setFlgCd(flgNmRow.substring(startIdx, endIdx));//key
			startIdx = endIdx + 1;
			endIdx = flgNmRow.length();
			if (startIdx == endIdx) {
				flagVo.setFlgNm("");//value
				continue;
			}
			flagVo.setFlgNm(flgNmRow.substring(startIdx, endIdx));//value
			flagVos.add(flagVo);
			startIdx = 0;
		}
		if (1 > flagVos.size()) return null;
		else return flagVos;
	}
	
	private String[] getFlgSummaryRecords(String flgNm) {
		int length = getFlgSummaryVosTempSize(flgNm);
		if (0 == length) return null;
		
		int startIdx = 0, endIdx = 0, lastIdx = 0;
		String[] flgNmRec = new String[length];//[NONE:해당안됨][OVER:30일경과][PRAC:30일미경과]
		int recIdx = 0;
		for (int i=0; i<flgNm.length(); i++) {
			endIdx = flgNm.indexOf("|", startIdx);//-1, 0,1,2, 3,11의 경우
			lastIdx = flgNm.lastIndexOf("|");//-1, 0,1,2, 10,11의 경우
			if (lastIdx == (flgNm.length() - 1)) {//|로 끝나는 글자 1개는 안자름
				return null;
			} else { //lastIdx < (flgNm.length() - 1)
				if (-1 == endIdx) endIdx = flgNm.length();
			}
			if (startIdx == endIdx) {//|만 연속하는 값인 경우 안자름
				startIdx = endIdx + 1;
				if (startIdx >= flgNm.length()) break;
				else continue;//다음 endIdx 찾기
			}
			if (recIdx == length) break;
			flgNmRec[recIdx] = flgNm.substring(startIdx, endIdx);
			recIdx++;
			startIdx = endIdx + 1;
			if (startIdx >= flgNm.length()) break;
		}
		return flgNmRec;
	}
	
	private int getFlgSummaryVosTempSize(String flgNm) {
		int startIdx = 0, endIdx = 0, cnt = 0;
		if (null != flgNm) {
			if (3 <= flgNm.length()) {
				cnt = 1;
				for (int i=0; i<flgNm.length(); i++) {
					endIdx = flgNm.indexOf("|", startIdx);//NONE:해당안됨|OVER:30일경과|PRAC:30일미경과
					if (-1 == endIdx) break;
					if (startIdx == endIdx) {//|만 연속하는 값인 경우 안자름
						startIdx = endIdx + 1;
						if (startIdx >= flgNm.length()) break;
						else continue;//다음 endIdx 찾기
					}
					startIdx = endIdx + 1;
					cnt ++;
				}
			}
		}
		return cnt;
	}
	
}