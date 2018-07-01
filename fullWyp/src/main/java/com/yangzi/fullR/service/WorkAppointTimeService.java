package com.yangzi.fullR.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.util.PageData;

/**
 * 预约时间发布
 * @author win7
 *
 */
@Service("workAppointTimeService")
public class WorkAppointTimeService {
 
	
	@Autowired
	private DaoSupport dao;
	
	/**
	 * 获取某个时间段内的数据值
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAppointTimeByDateCircle(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("AppointTimeMapper.getAppointTimeByDateCircle", pd);
	}
	
	/**
	 * 根据条件获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAppointTimeByCons(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("AppointTimeMapper.getAppointTimeByCons", pd);
	}
	/**
	 * 根据医生id查询预约时间,当天开始
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAppointTimeByDoctorID(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("AppointTimeMapper.getAppointTimeByDoctorID", pd);
	}
	/**
	 * 根据主键查询预约时间
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getAppointTimeByAppointNoID(PageData pd) throws Exception {
		return (PageData) dao.findForObject("AppointTimeMapper.getAppointTimeByAppointNoID", pd);
	}
	/**
	 * 根据科室id和预约日期  查询预约信息
	 * cwh
	 * 2018-06-11
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAppointTimeByOIDandDD(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("AppointTimeMapper.getAppointTimeByOIDandDD", pd);
	}
	/**
	 * 保存一条操作
	 * @return
	 * @throws Exception
	 */
	public int saveOneApTime(PageData pd)throws Exception{
		return (int) dao.save("AppointTimeMapper.saveOPAppointTime",pd);
	}
	
	
	/**
	 * 根据empid 和 dutydate进行删除
	 * @throws Exception
	 */
	public void deleteByEAndD(PageData pd)throws Exception {
		dao.delete("AppointTimeMapper.deleteByEAndD", pd);
	} 
	
	
	
	
}
