package com.yangzi.fullR.controller;

import java.util.*;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.service.FREmpService;
import com.yangzi.fullR.util.Const;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;

@Controller
@RequestMapping(value="/head")
public class HeadController extends BaseController{
 
	 
	 @Autowired
	 private FREmpService fREmpService;
	
	
	/**
	 * 获取头部信息
	 * @param model
	 * @param response
	 */
	@RequestMapping("/getUname")
	@ResponseBody
	public void getList(Model model,HttpServletResponse response) {
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<>();
		try {
			pd =this.getPageData();
			List<PageData>pdList= new ArrayList<>();
			
			//shiro
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			
			PageData pds = new PageData();
			pds = (PageData)session.getAttribute(Const.SESSION_userpds);
			
			
			if(null==pds) {
				String username = session.getAttribute(Const.SESSION_USERNAME).toString();
				pd.put("USERNAME", username);
				pds=fREmpService.findByUId(pd);
				session.setAttribute(Const.SESSION_userpds,pds);
			}
			pdList.add(pds);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}finally {
			logAfter(logger);
		}
		RenderUtil.renderJson(map, response);
	}
	
	
}
