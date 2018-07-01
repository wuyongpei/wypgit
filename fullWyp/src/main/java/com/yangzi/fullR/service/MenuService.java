package com.yangzi.fullR.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.system.Menu;
import com.yangzi.fullR.util.PageData;

@Service("menuService")
public class MenuService {
 
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	 
	
	public List<Menu> listSubMenuByParentId(String parentId) throws Exception {
		return (List<Menu>) dao.findForList("MenuMapper.listSubMenuByParentId", parentId);
	}
	public List<Menu> listSubMenuByParentIdAll(String parentId) throws Exception {
		return (List<Menu>) dao.findForList("MenuMapper.listSubMenuByParentIdAll", parentId);
	}
	
	public List<Menu> listAllMenu() throws Exception {
		List<Menu> rl = this.listAllParentMenu();
		for(Menu menu : rl){
			List<Menu> subList = this.listSubMenuByParentId(menu.getMenu_Id());
			menu.setSubMenu(subList);
		}
		return rl;
	}
	
	public List<Menu> listAllParentMenu() throws Exception {
		return (List<Menu>) dao.findForList("MenuMapper.listAllParentMenu", null);
		
	}
	
	public List<Menu> listAllParentMenuAll() throws Exception {
		return (List<Menu>) dao.findForList("MenuMapper.listAllParentMenuAll", null);
		
	}
   
	
	
	
	/**
	 * 保存菜单图标 (顶部菜单)
	 */
	public PageData editicon(PageData pd) throws Exception {
		return (PageData)dao.findForObject("MenuMapper.editicon", pd);
	}
	
	public PageData getMenuById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("MenuMapper.getMenuById", pd);
		
	}
	
	/**
	 * 更新子菜单类型菜单
	 */
	public PageData editType(PageData pd) throws Exception {
		return (PageData)dao.findForObject("MenuMapper.editType", pd);
	}
	
	/**
	 * 编辑
	 */
	public PageData edit(PageData pd) throws Exception {
		return (PageData)dao.findForObject("MenuMapper.updateMenu", pd);
	}
	
	public void deleteMenuById(String menu_Id) throws Exception {
		dao.save("MenuMapper.deleteMenuById", menu_Id);
		
	}

	
	//取最大id
	public PageData findMaxId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("MenuMapper.findMaxId", pd);
		
	}
	
	/**
	 * 保存
	 * @param menu
	 * @throws Exception
	 */
	public void saveMenu(Menu menu) throws Exception {
		if(menu.getMenu_Id()!=null && menu.getMenu_Id() != ""){
			dao.save("MenuMapper.insertMenu", menu);
		}else{
			dao.save("MenuMapper.insertMenu", menu);
		}
	}
}
