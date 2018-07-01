package com.yangzi.fullR.service;

import java.util.*;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.entity.vo.FRShift;
import com.yangzi.fullR.util.PageData;

@Service("shiftService")
public class ShiftService {
   
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	//根据parentid获取
	public List<FRShift> getShiftByParentId(PageData pd)throws Exception{
		
		 return (List<FRShift>)dao.findForList("ShiftMapper.selectByParentid",pd);
	}
	
	/**
	 * 获取所有status=0的班次
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAllStatus(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ShiftMapper.getAllStatus", pd);
	}
	
	/**
	 * 获取所有status=0 parentid =shifID or SHIFIID=shiftID的班次数据
	 * @param shifID
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getDataByCons(Integer shiftID)throws Exception{
		return (List<PageData>)dao.findForList("ShiftMapper.getDataByCons", shiftID);
		
	}
	
	
	
	
	/**
	 * 保存规则
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception{
		dao.save("ShiftMapper.saveSf", pd);
		
	}
	
	
	/**
	 * 删除规则
	 * @param shiftId
	 * @throws Exception
	 */
	public void deleteShiftById(String shiftId)throws Exception{
		dao.delete("ShiftMapper.deleleR", shiftId);
	}
	
	
	/**
	 * 根据id获取pagedata对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData  getShiftById(PageData pd)throws Exception{
		return (PageData) dao.findForObject("ShiftMapper.getShiftById", pd);
	}
	
	/**
	 *编辑
	 */
	public void edit(FRShift fs)throws Exception{
		 dao.update("ShiftMapper.updateS", fs);
	}
}
