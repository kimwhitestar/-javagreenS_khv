package com.spring.javagreenS_khv.dao;

import java.util.List;

import com.spring.javagreenS_khv.dto.CustomGradeDTO;

public interface CustomGradeDAO {
	public List<CustomGradeDTO> searchCustomGradeList();
	public List<CustomGradeDTO> searchCustomCompGradeList();
	public List<CustomGradeDTO> searchCustomPersonGradeList();
}