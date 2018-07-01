package com.yangzi.fullR.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.service.ZoneService;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;

@Controller
@RequestMapping(value = "/zone")
public class ZoneController extends BaseController {
	@Autowired
	private ZoneService zoneService;

	/**
	 * 获取parentID下辖的  区/县
	 * 
	 * 
	 */
	@RequestMapping(value = "getCity")
	public void getCity(String parentID, HttpServletResponse response) {
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			if (parentID != null && !"".equals(parentID)) {
				List<PageData> city = zoneService.getCity(parentID);
				if (city != null && !city.isEmpty()) {
					RenderUtil.renderJson(city, response);
				}
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
	
}
