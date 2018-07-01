package com.yangzi.fullR.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.util.PageData;

@Service("sickPatientService")
public class SickPatientService {
	
	@Autowired
	private DaoSupport dao;
	
	public void savePatient(PageData pd) throws Exception {
		dao.save("SickPatientMapper.savePatient", pd);
	}
	
	
	public void updateByID(PageData pd) throws Exception {
		dao.save("SickPatientMapper.updateByID", pd);
	}
	
	/**  
	 *根据病人姓名模糊查询获得  
	 *
	 */
	public List<PageData> getPatientByName(String PatientName) throws Exception {
		return (List<PageData>) dao.findForList("SickPatientMapper.getPatientByName", PatientName);
	}
	
	/**
	 * 根据名字，登记时间获取患者(病人库所需查询)
	 * @author wyp
	 * @param PatientName
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getPatients(Page page) throws Exception {
		return (List<PageData>) dao.findForList("SickPatientMapper.sicklistPage", page);
	}
	
	/**
	 * 根据ID删除病人
	 * @author wyp
	 * @param PatientID
	 * @throws Exception
	 */
	public void delete(String PatientID) throws Exception {
		dao.delete("SickPatientMapper.deletePatient", PatientID);
	}
	
	/**
	 * 通过条件获取病人档案信息
	 * lzd 20180605
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getPatientByCons(PageData pd)throws Exception{
		return (PageData) dao.findForObject("SickPatientMapper.getPatientByCons", pd);
	}
	
	/**
	 * 登记-登记记录页面
	 * @author wyp
	 * 2018年6月21日  
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> registerlistPage(Page page)throws Exception{
		return (List<PageData>) dao.findForList("SickPatientMapper.registerlistPage", page);
	}
	
	/**
	 * 手机号或卡号查找
	 * @author wyp
	 * 2018年6月25日  
	 * @param cardCode
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getByPhoneOrCard(String cardCode)throws Exception{
		return (List<PageData>) dao.findForList("SickPatientMapper.getByPhoneOrCard", cardCode);
	}

}
