package com.yangzi.fullR.controller;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.http.protocol.HTTP;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.aspectj.internal.lang.annotation.ajcDeclareAnnotation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.service.MenuService;
import com.yangzi.fullR.service.RoleService;
import com.yangzi.fullR.system.Menu;
import com.yangzi.fullR.system.Role;
import com.yangzi.fullR.util.AppUtil;
import com.yangzi.fullR.util.Const;
import com.yangzi.fullR.util.Jurisdiction;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;
import com.yangzi.fullR.util.RightsHelper;
import com.yangzi.fullR.util.Tools;

import net.sf.json.JSONArray;
/**
 * 角色权限操作
 * @author win7
 *
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {
   
	String menuUrl = "role.do"; //菜单地址(权限用)
	@Autowired
	private MenuService menuService;
	@Autowired
	private RoleService roleService;
	
	
	/*
	 * 获取角色列表
	 * 
	 */
	@RequestMapping("")
	public String roleList(Model model,Page page)throws Exception{
		try {
		 PageData pd = new PageData();
		 pd =this.getPageData();
		 
		 String roleId = pd.getString("Role_ID");
			if(roleId == null || "".equals(roleId)){
				pd.put("Role_ID", "1");
			}
			List<Role> roleList = roleService.listAllRoles();				//列出所有部门
			List<Role> roleList_z = roleService.listAllRolesByPId(pd);		//列出此部门的所有下级
			
			List<PageData> kefuqxlist = roleService.listAllkefu(pd);		//管理权限列表
			List<PageData> gysqxlist = roleService.listAllGysQX(pd);		//用户权限列表
			pd = roleService.findObjectById(pd);	
			model.addAttribute("pd", pd);
			model.addAttribute("kefuqxlist", kefuqxlist);
			model.addAttribute("gysqxlist", gysqxlist);
			model.addAttribute("rlList", roleList);
			model.addAttribute("roleList_z", roleList_z);
			model.addAttribute(Const.SESSION_QX, this.getHC());
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/role/role_list"; 
	}
	/**
	 * 新增页面
	 */
	@RequestMapping(value="/toAdd")
	public String toAdd(Page page,Model model){
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			model.addAttribute("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "system/role/role_add";
	}
	
	
	/**
	 * 保存新增信息
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(Model model)throws Exception{
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String parent_id = pd.getString("Parent_ID");		//父类角色id
			pd.put("Role_ID", parent_id);			
			if("0".equals(parent_id)){
				pd.put("Rights", "");
			}else{
				String rights = roleService.findObjectById(pd).getString("Rights");
				pd.put("Rights", (null == rights)?"":rights);
			}
			pd.put("QX_ID", "");
			
			String UUID = this.get32UUID();
			
				pd.put("GL_ID", UUID);
				pd.put("FX_QX", 0);				//发信权限
				pd.put("FW_QX", 0);				//服务权限
				pd.put("QX1", 0);				//操作权限
				pd.put("QX2", 0);				//产品权限
				pd.put("QX3", 0);				//预留权限
				pd.put("QX4", 0);				//预留权限
				if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){roleService.saveKeFu(pd);}//保存到K权限表
				
				pd.put("U_ID", UUID);
				pd.put("C1", 0);				//每日发信数量
				pd.put("C2", 0);
				pd.put("C3", 0);
				pd.put("C4", 0);
				pd.put("Q1", 0);				//权限1
				pd.put("Q2", 0);				//权限2
				pd.put("Q3", 0);
				pd.put("Q4", 0);
				if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){roleService.saveGYSQX(pd);}//保存到G权限表
				pd.put("Qx_Id", UUID);
		    	pd.put("Role_ID", UUID);
			    pd.put("Add_Qx", "0");
			    pd.put("Del_Qx", "0");
			    pd.put("Edit_Qx", "0");
			    pd.put("Cha_Qx", "0");
			if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){roleService.add(pd);}
			model.addAttribute("msg","success");
		} catch(Exception e){
			logger.error(e.toString(), e);
			model.addAttribute("msg","failed");
		}
		return "save_result";
	}
	/**
	 * 请求编辑
	 */
	@RequestMapping(value="/toEdit")
	public String toEdit(String ROLE_ID,Model model)throws Exception{
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd.put("Role_ID", ROLE_ID);
			pd = roleService.findObjectById(pd);
			model.addAttribute("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "system/role/role_edit";
	}
	
	/**
	 * 编辑
	 */
	@RequestMapping(value="/edit")
	public String edit(Model model)throws Exception{
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){pd = roleService.edit(pd);}
			model.addAttribute("msg","success");
		} catch(Exception e){
			logger.error(e.toString(), e);
			model.addAttribute("msg","failed");
		}
		return "save_result";
	}
	/**
	 * 请求角色菜单授权页面
	 */
	@RequestMapping(value="/auth")
	public String auth(@RequestParam String ROLE_ID,Model model)throws Exception{
		
		try{
			List<Menu> menuList = menuService.listAllMenu();
			Role role = roleService.getRoleById(ROLE_ID);
			String roleRights = role.getRights();
			if(Tools.notEmpty(roleRights)){
				for(Menu menu : menuList){
					menu.setHasMenu(RightsHelper.testRights(roleRights, menu.getMenu_Id()));
					if(menu.isHasMenu()){
						List<Menu> subMenuList = menu.getSubMenu();
						for(Menu sub : subMenuList){
							sub.setHasMenu(RightsHelper.testRights(roleRights, sub.getMenu_Id()));
						}
					}
				}
			}
			JSONArray arr = JSONArray.fromObject(menuList);
			String json = arr.toString();
			json = json.replaceAll("menu_Id", "id").replaceAll("menu_Name", "name").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked");
			model.addAttribute("zTreeNodes", json);
			model.addAttribute("roleId", ROLE_ID);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return "system/role/authorization";
	}
	
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object deleteRole(@RequestParam String ROLE_ID)throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		String errInfo = "";
		try{
			if(Jurisdiction.buttonJurisdiction(menuUrl, "del")){
				pd.put("Role_ID", ROLE_ID);
				List<Role> roleList_z = roleService.listAllRolesByPId(pd);		//列出此部门的所有下级
				if(roleList_z.size() > 0){
					errInfo = "false";
				}else{
					
					List<PageData> userlist = roleService.listAllUByRid(pd);
					if(userlist.size() > 0){
						errInfo = "false2";
					}else{
					roleService.deleteRoleById(ROLE_ID);
					roleService.deleteKeFuById(ROLE_ID);
					roleService.deleteGById(ROLE_ID);
					errInfo = "success";
					}
				}
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 保存角色菜单权限
	 */
	@RequestMapping(value="/auth/save")
	public void saveAuth(@RequestParam String ROLE_ID,@RequestParam String menuIds,HttpServletResponse response)throws Exception{
		PageData pd = new PageData();
		try{
			if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){
				if(null != menuIds && !"".equals(menuIds.trim())){
					BigInteger rights = RightsHelper.sumRights(Tools.str2StrArray(menuIds));
					Role role = roleService.getRoleById(ROLE_ID);
					role.setRights(rights.toString());
					roleService.updateRoleRights(role);
					pd.put("rights",rights.toString());
				}else{
					Role role = new Role();
					role.setRights("");
					role.setRole_ID(ROLE_ID);
					roleService.updateRoleRights(role);
					pd.put("rights","");
				}
					
					pd.put("roleId", ROLE_ID);
					roleService.setAllRights(pd);
			}
		
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	
	/**
	 * K权限
	 */
	@RequestMapping(value="/kfqx")
	public String kfqx(Model model)throws Exception{
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String msg = pd.getString("msg");
			if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){roleService.updateKFQx(msg,pd);}
			model.addAttribute("msg","success");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "save_result";
	}
	
	/**
	 * 请求角色按钮授权页面
	 */
	@RequestMapping(value="/button")
	public String button(@RequestParam String ROLE_ID,@RequestParam String msg,Model model)throws Exception{
		try{
			List<Menu> menuList = menuService.listAllMenu();
			Role role = roleService.getRoleById(ROLE_ID);
			
			String roleRights = "";
			if("add_qx".equals(msg)){
				roleRights = role.getAdd_Qx();
			}else if("del_qx".equals(msg)){
				roleRights = role.getDel_Qx();
			}else if("edit_qx".equals(msg)){
				roleRights = role.getEdit_Qx();
			}else if("cha_qx".equals(msg)){
				roleRights = role.getCha_Qx();
			}
			if(Tools.notEmpty(roleRights)){
				for(Menu menu : menuList){
					menu.setHasMenu(RightsHelper.testRights(roleRights, menu.getMenu_Id()));
					if(menu.isHasMenu()){
						List<Menu> subMenuList = menu.getSubMenu();
						for(Menu sub : subMenuList){
							sub.setHasMenu(RightsHelper.testRights(roleRights, sub.getMenu_Id()));
						}
					}
				}
			}
			JSONArray arr = JSONArray.fromObject(menuList);
			String json = arr.toString();
			json = json.replaceAll("menu_Id", "id").replaceAll("menu_Name", "name").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked");
			model.addAttribute("zTreeNodes", json);
			model.addAttribute("roleId", ROLE_ID);
			model.addAttribute("msg", msg);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return "system/role/role_button";
	}
	
	
	/**
	 * 保存角色按钮权限
	 */
	@RequestMapping(value="/roleButton/save")
	public void orleButton(@RequestParam String ROLE_ID,@RequestParam String menuIds,@RequestParam String msg,HttpServletResponse response)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> result = new HashMap<>();
		try{
			if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){
				if(null != menuIds && !"".equals(menuIds.trim())){
					BigInteger rights = RightsHelper.sumRights(Tools.str2StrArray(menuIds));
					pd.put("value",rights.toString());
				}else{
					pd.put("value","");
				}
				pd.put("Role_ID", ROLE_ID);
				roleService.updateQx(msg,pd);
			}
			result.put("status", "success");
			RenderUtil.renderJson(result, response);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	
	
	
	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
}
