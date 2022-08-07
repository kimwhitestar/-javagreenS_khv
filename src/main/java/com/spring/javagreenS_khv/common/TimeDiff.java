package com.spring.javagreenS_khv.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

// 오늘날짜와 DB날짜의 시간의 차이를 산출 (선생님 소스)
public class TimeDiff {
	
	//1. 오늘날짜와 DB날짜를 날짜형식의 문자형으로 변경
	//2. 날짜산출은 날짜형식에서 산출
	//3. 날짜차이는 숫자형식에서 24시간제로 산출
	public int timeDiff(String strWdate) {
		
		//1-1. 오늘날짜와 DB날짜를 날짜형식의 문자형으로 변경
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat dateFmt = new SimpleDateFormat("yyyyMMddHHmm"); //HH:24시간제 hh:12시간제
		String sToday = dateFmt.format(cal.getTime()); //오늘날짜(문자형)
		
		//2-1. 날짜산출은 날짜형식에서 산출
		Date dToday = null;
		try {
			dToday = dateFmt.parse(sToday);
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		
		//1-2. DB에 저장된 날짜를 오늘날짜와 같은 문자형포맷형식으로 변경
		String sWDate = strWdate.substring(0, 4) + strWdate.substring(5, 7) + strWdate.substring(8, 10) 
			+ strWdate.substring(11, 13) + strWdate.substring(14, 16);
		
		//2-2. DB에 저장된 날짜를 날짜형식으로 변경
		Date dWDate = null;
		try {
			dWDate = dateFmt.parse(sWDate);
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		
		//3. 날짜형식을 숫자형시간제(getTime())로 변경 : 결과값 milliseconds(1/1000)형식으로 산출
		long diffTime = (dToday.getTime()) / (dWDate.getTime()) / (60 * 60 * 1000) + 1;//24시간제 시간차 산출
		
		return (int)diffTime;//long형으로 받은 24시간제 시간차 길이가 int형으로 표시가능한 범위
	}
}