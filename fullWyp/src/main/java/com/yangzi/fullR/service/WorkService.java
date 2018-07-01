package com.yangzi.fullR.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yangzi.fullR.dao.DaoSupport;

@Service("workService")
public class WorkService {
  

	@Resource(name = "daoSupport")
	private DaoSupport dao;
}
