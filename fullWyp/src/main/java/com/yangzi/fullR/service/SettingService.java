package com.yangzi.fullR.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.util.PageData;

@Service("settingService")
public class SettingService {

	@Autowired
	private DaoSupport dao;
	
	/**
	 * 获取单位的设置
	 * @author wyp
	 * 2018年6月19日  
	 * @param WorkUnitID
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getProcessSet(String WorkUnitID) throws Exception{
		return (List<PageData>) dao.findForList("SettingsMapper.getProcessSet", WorkUnitID);
	}
	
	/**
	 * 分页查询
	 * @author wyp
	 * 2018年6月19日  
	 * @param OfficeID
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getVoiceIPR(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("SettingsMapper.getVoiceIPRPage", pd);
	}
	
	/**
	 * 分页查询总数
	 * @author wyp
	 * 2018年6月20日  
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int getVoiceIPRSize(PageData pd) throws Exception {
		return (int) dao.findForObject("SettingsMapper.getVoiceIPRSize", pd);
	}
	/**
	 * 增删改
	 * @author wyp
	 * 2018年6月20日  
	 * @param pd
	 * @throws Exception
	 */
	//begin
	public void updateVoice(PageData pd) throws Exception {
		dao.update("SettingsMapper.updateVoice", pd);
	}
	
	public void updateProcess(PageData pd) throws Exception {
		dao.update("SettingsMapper.updateProcess", pd);
	}
	
	public void insertProcess(PageData pd) throws Exception {
		dao.save("SettingsMapper.insertProcess", pd);
	}
	
	public void insertVoice(PageData pd) throws Exception {
		dao.save("SettingsMapper.insertVoice", pd);
	}
	
	public void deleteProcess(PageData pd) throws Exception {
		dao.delete("SettingsMapper.deleteProcess", pd);
	}
	
	public void deleteVoice(PageData pd) throws Exception {
		dao.delete("SettingsMapper.deleteVoice", pd);
	}
	//end
}
