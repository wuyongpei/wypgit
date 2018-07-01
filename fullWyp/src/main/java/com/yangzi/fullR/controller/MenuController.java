package com.yangzi.fullR.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * MenuController
 * lzd
 * 
 */
import org.springframework.web.bind.annotation.RequestParam;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.service.MenuService;
import com.yangzi.fullR.system.Menu;
import com.yangzi.fullR.util.Logger;
import com.yangzi.fullR.util.PageData;

import net.sf.json.JSONArray;
@Controller
@RequestMapping(value="/menu")
public class MenuController extends BaseController {
  
	  @Resource(name="menuService")
	  private MenuService menuService;
	
	  @RequestMapping("")
	  public String list(Model model)throws Exception{
		  try {
     	List<Menu> menuList = menuService.listAllParentMenuAll();
         model.addAttribute("menuList", menuList);
			  
		} catch (Exception e) {
		   logger.error(e.toString(), e);
		}
		  return "system/menu/menu_list";
	  }
	  
	  
	  /**
	   * 获取当前菜的那所有子菜单
	   * @param Menu_Id
	   * @param response
	   * @throws Exception
	   */
	  @RequestMapping(value="/sub")
	  public void getSub(@RequestParam String Menu_Id,HttpServletResponse response)throws Exception{
			try {
		  List<Menu> subMenu = menuService.listSubMenuByParentIdAll(Menu_Id);
			JSONArray arr = JSONArray.fromObject(subMenu);
			PrintWriter out;
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String json = arr.toString();
			out.write(json);
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	  }
		/**
		 * 请求编辑菜单图标页面
		 * @param 
		 * @return
		 */
		@RequestMapping(value="/toEditicon")
		public String toEditicon(String menu_id,Model model)throws Exception{
			PageData pd = new PageData();
			try{
				pd = this.getPageData();
				pd.put("menu_Id",menu_id);
				model.addAttribute("pd", pd);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			return "system/menu/menu_icon";
		}
	  
	  
		/**
		 * 保存菜单图标 (顶部菜单)
		 * @param 
		 * @return
		 */
		@RequestMapping(value="/editicon")
		public String editicon(Model model)throws Exception{
			PageData pd = new PageData();
			try{
				pd = this.getPageData();
				pd = menuService.editicon(pd);
				model.addAttribute("msg","success");
			} catch(Exception e){
				logger.error(e.toString(), e);
				model.addAttribute("msg","failed");
			}
			return "save_result";
		}
	  
		/**
		 * 请求编辑菜单页面
		 * @param 
		 * @return
		 */
		@RequestMapping(value="/toEdit")
		public String toEdit(String menu_Id,Model model)throws Exception{
			PageData pd = new PageData();
			try{
				pd = this.getPageData();
				pd.put("menu_Id",menu_Id);
				pd = menuService.getMenuById(pd);
				List<Menu> menuList = menuService.listAllParentMenu();
				model.addAttribute("menuList", menuList);
				model.addAttribute("pd", pd);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			return "system/menu/menu_edit";
		}
		
		
		/**
		 * 保存编辑
		 * @param 
		 * @return
		 */
		@RequestMapping(value="/edit")
		public String edit(Model model)throws Exception{
			PageData pd = new PageData();
			try{
				pd = this.getPageData();
				String Parent_Id = pd.getString("Parent_Id");
				if(null == Parent_Id || "".equals(Parent_Id)){
					Parent_Id = "0";
					pd.put("Parent_Id", Parent_Id);
				}
				if("0".equals(Parent_Id)){
					//处理菜单类型====
					menuService.editType(pd);
					//处理菜单类型====
				}
				pd = menuService.edit(pd);
				model.addAttribute("msg","success");
			} catch(Exception e){
				logger.error(e.toString(), e);
				model.addAttribute("msg","failed");
			}
			return "save_result";
		}
		
		
		/**
		 * 删除菜单
		 * @param menuId
		 * @param out
		 */
		@RequestMapping(value="/del")
		public void delete(@RequestParam String menu_Id,PrintWriter out)throws Exception{
			
			try{
				menuService.deleteMenuById(menu_Id);
				out.write("success");
				out.flush();
				out.close();
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			
		}
		
		
		/**
		 * 请求新增菜单页面
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/toAdd")
		public String toAdd(Model model)throws Exception{
			try{
				List<Menu> menuList = menuService.listAllParentMenu();
				model.addAttribute("menuList", menuList);
			} catch(Exception e){
				logger.error(e.toString(), e);
			}
			return 	"system/menu/menu_add";
		}
	  
		
		/**
		 * 保存菜单信息
		 * @param menu
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/add")
		public String add(Menu menu,Model model)throws Exception{
			PageData pd = new PageData();
			pd = this.getPageData();
			try{
				menu.setMenu_Id(String.valueOf(Integer.parseInt(menuService.findMaxId(pd).get("MID").toString())+1));
				String parent_Id = menu.getParent_Id();
				if(!"0".equals(parent_Id)){
					//处理菜单类型====
					pd.put("menu_Id",parent_Id);
					pd = menuService.getMenuById(pd);
					menu.setMenu_Type(pd.getString("Menu_Type"));
					//处理菜单类型====
				}
				menuService.saveMenu(menu);
				model.addAttribute("msg","success");
			} catch(Exception e){
				logger.error(e.toString(), e);
				model.addAttribute("msg","failed");
			}
			return "save_result";
			
		}
		
}
