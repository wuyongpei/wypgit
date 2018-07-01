package com.yangzi.fullR.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.system.FREmp;
import com.yangzi.fullR.util.PageData;

@Service("fREmpService")
public class FREmpService {

	@Autowired
	private DaoSupport dao;

	/**
	 * 获取所有对象
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findAll() throws Exception {
		return (List<PageData>) dao.findForList("FREmpMapper.getAll", null);
	}

	public List<PageData>empschullistPage(Page page)throws Exception{
        return (List<PageData>)dao.findForList("FREmpXMapper.empschullistPage", page);		
	}
	/**
	 * 根据院所获取相关医务人员
	 * @param workUnitID
	 * @return
	 * @throws Exception
	 */
	public List<PageData>getCanUserEmpByUnitID(Page page)throws Exception{
		return (List<PageData>) dao.findForList("FREmpXMapper.getCanUserEmpByUnitIDlistPage",page);
	}
	
	/**
	 * 获取状态启用的所有医生用户
	 * @return
	 * @throws Exception 
	 */
	public List<PageData>getAllByStatusAndDType(PageData pd) throws Exception{
		return (List<PageData>)dao.findForList("FREmpXMapper.getEmpsList", pd);		
	}
	
	
	/**
	 * 登录判断
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getEmpByNameAndPwd(PageData pd) throws Exception {
		return (PageData) dao.findForObject("FREmpXMapper.getUserInfo", pd);
	}

	public void saveIP(PageData pd) throws Exception {
		dao.update("FREmpXMapper.saveIP", pd);
	}

	/*
	 * 通过loginname获取数据
	 */
	public PageData findByUId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("FREmpXMapper.findByUId", pd);
	}

	/*
	 * 通过id获取数据
	 */
	public FREmp getUserAndRoleById(String USER_ID) throws Exception {
		return (FREmp) dao.findForObject("FREmpMapper.getUserAndRoleById", USER_ID);
	}
	
	public PageData getEmpByID(String emp_ID)throws Exception {
		return  (PageData)dao.findForObject("FREmpXMapper.getEmpByID", emp_ID);
	}
	
	/*
	 * 获取用户
	 * 
	 */
	public List<PageData>listPdPageEmp(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FREmpXMapper.emplistPage", page);
	}
	/*
	 * 保存用户
	 * 
	 */
	public void save(PageData pd) throws Exception{
		dao.save("FREmpXMapper.saveEmp", pd);
	}
	
	/*
	 * 删除用户
	 * 
	 */
	public void delete(String emp_ID) throws Exception{
		dao.delete("FREmpXMapper.deleteEmp", emp_ID);
	}
	
	/*
	 * 批量删除用户
	 * 
	 */
	public void deletes(String empIDs) throws Exception{
		try {
			String[] empID=empIDs.split(",");
			for (int i = 0; i < empID.length; i++) {
				dao.delete("FREmpXMapper.deleteEmp", empID[i]);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
	}
	
	/*
	 * 保存编辑用户
	 * 
	 */
	public void edit(PageData pd) throws Exception{
		dao.delete("FREmpXMapper.editEmp", pd);
	}

	/**
	 * @author wyp
	 * 根据科室与预约时间获取可预约的医生
	 * 
	 */
	public List<PageData> getEmpBydate(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("FREmpXMapper.getEmpBydate", pd);
	}
	
	/**
	 * 科室跟医生ID查询医生（分页）
	 * @author wyp
	 * 2018年6月8日  
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getEmpsPage(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("FREmpXMapper.getEmpsPage", pd);
	}

	/**
	 * 获取总数（分页）
	 * @author wyp
	 * 2018年6月8日  
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int getEmpsLength(PageData pd)throws Exception{
		return  (int) dao.findForObject("FREmpXMapper.getEmpsLength", pd);
	}
}
