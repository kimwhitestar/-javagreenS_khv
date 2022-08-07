package com.spring.javagreenS_khv.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_khv.dao.CustomKindDAO;
import com.spring.javagreenS_khv.dto.CustomKindDTO;

@Service
public class CustomKindServiceImpl implements CustomKindService {

	@Autowired
	public CustomKindDAO customKindDao;

	@Override
	public List<CustomKindDTO> searchCustomKindList() {
		return customKindDao.searchCustomKindList();
	}
}