package com.spring.javagreenS_khv.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_khv.dao.CustomGradeDAO;
import com.spring.javagreenS_khv.dto.CustomGradeDTO;

@Service
public class CustomGradeServiceImpl implements CustomGradeService {
	@Autowired
	public CustomGradeDAO customGradeDao;

	@Override
	public List<CustomGradeDTO> searchCustomGradeList() {
		return customGradeDao.searchCustomGradeList();
	}
	@Override
	public List<CustomGradeDTO> searchCustomCompGradeList() {
		return customGradeDao.searchCustomCompGradeList();
	}
	@Override
	public List<CustomGradeDTO> searchCustomPersonGradeList() {
		return customGradeDao.searchCustomPersonGradeList();
	}
}