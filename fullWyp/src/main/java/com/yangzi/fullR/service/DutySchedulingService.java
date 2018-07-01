package com.yangzi.fullR.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.util.PageData;

@Service("sutySchedulingService")
public class DutySchedulingService {

	@Autowired
	private DaoSupport dao;

	/**
	 * 保存操作
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public int save(PageData pd) throws Exception {
		return (int) dao.save("DutySchedulingMapper.saveSch", pd);
	}

	/**
	 * 根据empid 和dateT获取唯一条件
	 * 
	 * @return
	 * @throws Exception
	 */
	public PageData getSchedulingByCons(PageData pd) throws Exception {
		return (PageData) dao.findForObject("DutySchedulingMapper.getSchedulingByCons", pd);
	}

	/**
	 * 更新操作
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int updateSchedul(PageData pd) throws Exception {
		return (int) dao.update("DutySchedulingMapper.updateSchedul", pd);
	}

	/**
	 * 获取回显数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getBackSchedulData(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("DutySchedulingMapper.getSchedulDataByDateCircle", pd);
	}

	/**
	 * 获取一定时间段内某个人的排班记录
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getSchedulRecordByCons(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("DutySchedulingMapper.getSchedulRecordByCons", pd);
	}

	/**
	 * 删除操作
	 */
	public int deleteSchedul(PageData pd) throws Exception {
		return (int) dao.delete("DutySchedulingMapper.deleteSch", pd);
	}
    /**
     * lzd
     * 2018-06-04
     * 根据empid 和 dutydate 删除
     * @param pd
     * @return
     * @throws Exception
     */
	public int deleteSchByC(PageData pd)throws Exception{
		return (int)dao.delete("DutySchedulingMapper.deleteSchByC", pd);
	}
	
	/**
	 * 根据科室跟医生ID获取月排班
	 * 2018年6月4日  
	 * @author wyp
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getScheduls(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("DutySchedulingMapper.getScheduls", pd);
	}

	/**
	 * 根据科室跟医生ID删除月排班
	 * 2018年6月4日  
	 * @author wyp
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void deleteS(PageData pd) throws Exception {
		dao.delete("DutySchedulingMapper.deleteS", pd);
	}
}
