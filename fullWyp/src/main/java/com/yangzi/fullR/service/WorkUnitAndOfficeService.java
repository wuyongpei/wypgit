package com.yangzi.fullR.service;

import javax.annotation.Resource;
import java.util.*;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.entity.Office;
import com.yangzi.fullR.entity.WorkPosition;
import com.yangzi.fullR.entity.WorkUnit;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.util.PageData;

/**
 * 工作单位 科室 职位操作
 * @author lzd
 * 2018-04-17
 *
 */
@Service("workUnitAndOfficeService")
public class WorkUnitAndOfficeService {
  
	
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	/*
	 * 获取所有的
	 */
	public List<WorkUnit> workUnitlistPdPage(Page page)throws Exception{
		return (List<WorkUnit>)dao.findForList("WorkPositionMapper.workUnitlistPage", page);
	}
	
     /**
      * 根据ID获取工作单位对象
      * @param pd
      * @return
      * @throws Exception
      */
	public PageData getWrokUnitById(PageData pd)throws Exception{
		
		return (PageData)dao.findForObject("WorkPositionMapper.findWuById", pd);
	}
	
	
	/**
	 * 根据ID获取科室和部门
	 * lzd
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getOfficeById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("WorkPositionMapper.findOfById", pd);
	}
	
   /**
    * 根据ID获取职位信息
    * @param pd
    * @return
    * @throws Exception
    */
	 public PageData getWorkPositionById(PageData pd)throws Exception{
		 return (PageData)dao.findForObject("WorkPositionMapper.findWpById", pd);
		 
	 }
	
	 /**
	  * 根据id获取名称
	  * @param wpId
	  * @return
	  * @throws Exception
	  */
	 public String getWorkPNameByPid(Integer wpId)throws Exception{
		 return (String) dao.findForObject("WorkPositionMapper.getWorkPNameByPid", wpId);
	 }
	 
	/**
	 * 保存修改和新增
	 * lzd
	 * 2018-04-21
	 * @param wu
	 * @throws Exception
	 */
	public void saveWu(WorkUnit wu)throws Exception{
	   dao.save("WorkPositionMapper.insertWu", wu);
	}
	
	/**
	 * lzd
	 * 修改单位操作
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData editWu(WorkUnit wu)throws Exception{
	  return (PageData)dao.findForObject("WorkPositionMapper.updateWu", wu);
	}
	
	
	/**
	 * LZD
	 * 2018-04-21
	 * 保存科室
	 * @param ofic
	 * @throws Exception
	 */
	public void saveOf(Office ofic)throws Exception{
		dao.save("WorkPositionMapper.insertOf", ofic);
	}
	/**
	 * 修改科室
	 * lzd
	 * 2018-04-21
	 * @param ofic
	 * @return
	 * @throws Exception
	 */
	public PageData editOf(Office ofic)throws Exception{
	   return (PageData)dao.findForObject("WorkPositionMapper.updateOf", ofic);
	}
	
	/**
	 * 获取所有的单位
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listWu()throws Exception{
		return (List<PageData>)dao.findForList("WorkPositionMapper.workUnitList", null);
	}
	
	
	
	
	
	/**
	 * 根据单位ID获取科室和部门名称
	 * lzd
	 * 2018-04-23
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> oflistByWuId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("WorkPositionMapper.findOflistByWuId", pd);
	}
	
	/**
	 * 根据单位ID获取科室名称
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> oflistStatusByWuId(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("WorkPositionMapper.findOfStatuslistByWuId", pd);
	}
	
	
	/**
	 * 根据ofid 获取职位
	 * lzd
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData>wplistByOfId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("WorkPositionMapper.findWplistByOfId", pd);
	}
	
	/**
	 * 保存职位
	 * lzd
	 * 2018-04-23
	 * @param wp
	 * @throws Exception
	 */
	public void saveWp(WorkPosition wp)throws Exception{
		dao.save("WorkPositionMapper.insertWp", wp);
	}
	
	/**
	 * 编辑职位操作
	 * lzd
	 * 2018-04-23
	 * @param wp
	 * @throws Exception
	 */
	public void editWP(WorkPosition wp)throws Exception{
		dao.save("WorkPositionMapper.updateWp", wp);
	}
	
	/**
	 * 根据wu id 删除对象
	 * lzd
	 * 注意进行子类级联删除
	 * @param wuId
	 * @throws Exception
	 */
	public void deleteWu(String wuId)throws Exception {
		dao.delete("WorkPositionMapper.delWu", wuId);
	}
	
	/**
	 * 根据of id 删除对象
	 * lzd
	 * 注意进行子类级联删除
	 * @param wuId
	 * @throws Exception
	 */
	public void deleteOf(String ofId)throws Exception {
		dao.delete("WorkPositionMapper.delOf", ofId);
	}
	
	/**
	 * 根据ofid删除职位相关内容
	 * lzd
	 * 
	 * @param ofId
	 * @throws Exception
	 */
	public void deleteAllWpByOf(String ofId)throws Exception{
		dao.delete("WorkPositionMapper.delAllByOfId", ofId);
	}
	
	/**
	 * 根据wp id 删除对象
	 * lzd
	 * 注意进行子类级联删除
	 * @param wuId
	 * @throws Exception
	 */
	public void deleteWp(String wpId)throws Exception {
		dao.delete("WorkPositionMapper.delWP", wpId);
	}
	
	/**
	 * 统计二级科室数量
	 * @author wyp
	 * 2018年6月12日  
	 * @param OfficeID
	 * @return
	 * @throws Exception
	 */
	public int countWorkPosition() throws Exception {
		return (int) dao.findForObject("WorkPositionMapper.countWorkPosition", null);
	}
	
	/**
	 * 统计一级科室数量
	 * @author wyp
	 * 2018年6月12日  
	 * @return
	 * @throws Exception
	 */
	public int countOffice() throws Exception {
		return (int) dao.findForObject("WorkPositionMapper.countOffice", null);
	}
	
	/**
	 * 获取医院名称根据ID
	 * @author wyp
	 * 2018年6月22日  
	 * @param WorkUnitID
	 * @return
	 * @throws Exception
	 */
	public String getWorkUnitNameByID(String WorkUnitID) throws Exception {
		return (String) dao.findForObject("WorkPositionMapper.getWorkUnitNameByID", WorkUnitID);
	}
}
