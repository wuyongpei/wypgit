package com.yangzi.fullR.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.util.PageData;

import net.sf.ehcache.transaction.xa.EhcacheXAException;

@Service("appointmentService")
public class AppointmentService {

	@Autowired
	private DaoSupport dao;

	/**
	 * 根据日期，时间范围进行当日某个时间段预约人数统计
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int countByDateCircle(PageData pd) throws Exception {
		return (int) dao.findForObject("AppointmentMapper.countByDateTimeCircle", pd);
	}

	/**
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int countByDateAndEmpID(PageData pd) throws Exception {
		return (int) dao.findForObject("AppointmentMapper.countByDateAndEmpID", pd);
	}

	/**
	 * 获取页面所需的
	 * 
	 * @return
	 */
	public List<String> timeCirle() {
		List<String> listS = new ArrayList<String>();
		listS.add("06:00");
		listS.add("07:00");
		listS.add("08:00");
		listS.add("09:00");
		listS.add("10:00");
		listS.add("11:00");
		listS.add("12:00");
		listS.add("13:00");
		listS.add("14:00");
		listS.add("15:00");
		listS.add("16:00");
		listS.add("17:00");
		listS.add("18:00");
		listS.add("19:00");
		listS.add("20:00");
		listS.add("21:00");
		listS.add("22:00");
		listS.add("23:00");
		return listS;
	}

	public void save(PageData pd) throws Exception {
		dao.save("AppointmentMapper.save", pd);
	}

	/**
	 * 根据日期时间获取预约信息
	 * 
	 * @author wyp
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAppByTime(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("AppointmentMapper.getAppByTime", pd);
	}

	/**
	 * 更新预约
	 * 
	 * @author wyp
	 * @param pd
	 * @throws Exception
	 */
	public void update(PageData pd) throws Exception {
		dao.update("AppointmentMapper.update", pd);
	}

	/**
	 * 预约列表所需查询
	 * 
	 * @author wyp
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAppList(Page page) throws Exception {
		return (List<PageData>) dao.findForList("AppointmentMapper.getApplistPage", page);
	}

	/**
	 * 根据病人ID查询
	 * 
	 * @author wyp
	 * @param patientID
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAppByPatient(Page page) throws Exception {
		return (List<PageData>) dao.findForList("AppointmentMapper.getAppByPatientlistPage", page);
	}

	/**
	 * 删除病人
	 * 
	 * @author wyp
	 * @param Appointment_ID
	 * @throws Exception
	 */
	public void delete(String Appointment_ID) throws Exception {
		dao.delete("AppointmentMapper.delete", Appointment_ID);
	}

	/**
	 * 根据医生跟预约信息获取已预约的时间
	 * 
	 * @author wyp
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<String> getTimes(PageData pd) throws Exception {
		return (List<String>) dao.findForList("AppointmentMapper.getTimes", pd);
	}

	/**
	 * 判断该医生的该时间额号是否被预约
	 * 
	 * @author wyp
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int countTime(PageData pd) throws Exception {
		return (int) dao.findForObject("AppointmentMapper.countTime", pd);
	}

	/**
	 * 根据病人id和预约状态(可为空)查询预约信息 cwh
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAppointmentByPIDAndStatus(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("AppointmentMapper.getAppointmentByPIDAndStatus", pd);
	}
	/**
	 * 根据病人id查询 历史预约(已就诊、失约)信息 cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAppHistoryByPIDAndStatus(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("AppointmentMapper.getAppHistoryByPIDAndStatus", pd);
	}
	/**
	 * 根据条件查询 LZD 20180605 可添加多个条件
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getAppointmentByCons(PageData pd) throws Exception {
		return (PageData) dao.findForObject("AppointmentMapper.getAppointmentByCons", pd);
	}

	/**
	 * LZD 20180605
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int countToGetQueueNo(PageData pd) throws Exception {
		return (int) dao.findForObject("AppointmentMapper.countToGetQueueNo", pd);
	}

	/**
	 * 日期范围内的医生ID每天的预约人数
	 * @author wyp
	 * 2018年6月11日  
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> countAppointByTimes(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("AppointmentMapper.countAppointByTimes", pd);
	}
	
	/**
	 * 今日预约分页查询
	 * @author wyp
	 * 2018年6月21日  
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getTodayAppoint(Page page) throws Exception{
		return (List<PageData>) dao.findForList("AppointmentMapper.getTodayAppointlistPage", page);
	}
	
	/**
	 * 修改预约状态
	 * @author wyp
	 * 2018年6月26日  
	 * @param pd
	 * @throws Exception
	 */
	public void updateAppintStatus(PageData pd) throws Exception{
		dao.update("AppointmentMapper.updateAppintStatus", pd);
	}
}
