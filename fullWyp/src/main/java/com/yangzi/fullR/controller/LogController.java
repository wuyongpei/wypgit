package com.yangzi.fullR.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.service.LogService;
import com.yangzi.fullR.util.PageData;

@Controller
public class LogController extends BaseController{

	@Autowired
	private LogService logService;
	
	/**
	 * 系统日志列表
	 * cwh
	 * 2018-06-21
	 * @param page
	 * @param model
	 * @return
	 */
	@RequestMapping("system/log")
	public String systemLogPage(Page page,Model model) {
		try {
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> logList=logService.getSystemLogListPage(page);
		for (PageData pageData : logList) {
			//日期格式调整
			pageData.put("CreateDateTime", pageData.get("CreateDateTime").toString().substring(0, 19));
			pageData.put("UpdateDateTime", pageData.get("UpdateDateTime").toString().substring(0, 19));
		}
		model.addAttribute("logList", logList);
		model.addAttribute("pd", pd);
			
		} catch (Exception e) {			
			e.printStackTrace();
		}
		
		return "system/systemLog/systemLog";
	}
}
