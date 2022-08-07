package com.spring.javagreenS_khv.service;

import java.util.List;

import com.spring.javagreenS_khv.dto.CustomGradeDTO;

public interface CustomGradeService {

	public List<CustomGradeDTO> searchCustomGradeList();

	public List<CustomGradeDTO> searchCustomCompGradeList();

	public List<CustomGradeDTO> searchCustomPersonGradeList();

}