package com.yangzi.fullR.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.util.PageData;

@Service("zoneService")
public class ZoneService {
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	
	
	/**
	 * 获取所有省
	 * @throws Exception 
	 * 
	 */
	
	public List<PageData> getProvince() throws Exception{
		return (List<PageData>)dao.findForList("ZoneMapper.getProvince", null);
	}
	
	/**
	 * 根据ParentID获取下辖的   市/县
	 * @throws Exception 
	 *
	 */
	public List<PageData> getCity(String parentID) throws Exception{
		return (List<PageData>)dao.findForList("ZoneMapper.getCityByp", parentID);
	}
	
}
