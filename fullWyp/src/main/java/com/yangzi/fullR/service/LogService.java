package com.yangzi.fullR.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.util.PageData;

@Service("logService")
public class LogService {
	
	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	/**
	 * 后台登陆/登出时 记录日志
	 * cwh
	 * 2018-06-20
	 * @param pd
	 * @throws Exception
	 */
	public void saveLog(PageData pd) throws Exception {
		dao.save("SystemLog.saveLog", pd);
	}

	/**
	 * 可根据操作人员姓名 查询系统日志
	 * cwh
	 * 2018-06-21
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getSystemLogListPage(Page page) throws Exception{
		return (List<PageData>) dao.findForList("SystemLog.systemLoglistPage", page);
	}
}
