package com.yangzi.fullR.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.service.FREmpService;
import com.yangzi.fullR.service.MenuService;
import com.yangzi.fullR.service.RoleService;
import com.yangzi.fullR.system.FREmp;
import com.yangzi.fullR.system.Menu;
import com.yangzi.fullR.system.Role;
import com.yangzi.fullR.util.AppUtil;
import com.yangzi.fullR.util.Const;
import com.yangzi.fullR.util.DateUtil;
import com.yangzi.fullR.util.LogUtil;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RightsHelper;
import com.yangzi.fullR.util.Tools;
/**
 * 登录操作
 * 2018-03-20 lzd
 * @author win7
 *
 */
@Controller
public class LoginCotroller extends BaseController {

	@Autowired
	private FREmpService fREmpService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private RoleService roleService;
	
	
	/**
	 * 登录跳转
	 * lzd
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	
	@RequestMapping("/login_toLogin")
	public String index(Model model)throws Exception {
		PageData pd = new PageData();
		pd=this.getPageData();
		model.addAttribute("pd", pd);
		return "login/login";
	}
	/**
	 * 退出登陆
	 * cwh
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/admin/logout")
	public String loginout(HttpServletRequest request) throws Exception {
		Subject currentUser=SecurityUtils.getSubject();
		//登出时记录日志 cwh 2018-06-20
		LogUtil.logout(request, currentUser.getSession());
		currentUser.logout();
		return "login/login";
	}

	@RequestMapping(value="/login_login")
    @ResponseBody
	public Object login() throws Exception{
		  Map<String,String> map = new HashMap<String,String>();
			PageData pd = new PageData();
			pd = this.getPageData();
			String errInfo = "";
			String str=pd.getString("KEYDATA").toString();
			System.out.println(str);
		    String KEYDATA[]=pd.getString("KEYDATA").split(",FR,");
		 
		    if(null!=KEYDATA&&KEYDATA.length==2) {
		    	//shiro
				Subject currentUser = SecurityUtils.getSubject();
				Session session = currentUser.getSession();
				//String sessionCode = (String)session.getAttribute(Const.SESSION_SECURITY_CODE);
		    	
				String username=KEYDATA[0];
				String password =KEYDATA[1];
		    	pd.put("Emp_Name",username);
		    	String passwd = new SimpleHash("SHA-1", username, password).toString();	//密码加密
		    	pd.put("Pass_Word", passwd);
		    	pd=fREmpService.getEmpByNameAndPwd(pd);
		    	
		    	//角色 根据角色找对应登录用户信息表
		    	
		    	if(pd != null){
		    		pd.put("Last_Login",DateUtil.getTime().toString()); 
		    		FREmp emp = new FREmp();
		    		emp.setEmp_ID(pd.getString("Emp_ID"));
		    		emp.setEmp_Name(pd.getString("Emp_Name"));
		    		emp.setPass_Word(pd.getString("Pass_Word"));
		    		emp.setE_Name(pd.getString("E_Name"));
		    		emp.setRights(pd.getString("Rights"));
		    		emp.setRole_ID(pd.getString("Role_ID"));
		    		emp.setLast_Login(pd.getString("Last_Login"));
		    		emp.setIp(pd.getString("Ip"));
		    		emp.setStatus(pd.getString("Status"));
		    		emp.setWorkUnitID(pd.getString("WorkUnitID"));
		    		emp.setOfficeID(pd.getInteger("OfficeID"));
		    		emp.setWorkPositionID(pd.getInteger("WorkPositionID"));
		    		session.setAttribute(Const.SESSION_USER, emp);
					session.removeAttribute(Const.SESSION_SECURITY_CODE);
					
					//shiro加入身份验证
					Subject subject = SecurityUtils.getSubject(); 
				    UsernamePasswordToken token = new UsernamePasswordToken(username, password); 
				    try {
				    	   subject.login(token); 
					} catch (AuthenticationException e) {
						errInfo = "身份验证失败！";
					}
		    	}else{
		    		errInfo = "usererror"; 				//用户名或密码有误
		    	}
		    	if(Tools.isEmpty(errInfo)){
		    		errInfo = "success";	
		    	}
		    }else{
				errInfo = "error";	//缺少参数
			}
		    map.put("result", errInfo);
			return AppUtil.returnObject(new PageData(), map);

	}
	
	/**
	 * 访问系统首页
	 */
  @RequestMapping(value="/main/{changeMenu}")
	public String loginIndex(@PathVariable("changeMenu") String changeMenu,Model model,HttpServletRequest request){
		 PageData pd = new PageData();
		 pd=this.getPageData();
		 try {
			//shiro管理的session
				Subject currentUser = SecurityUtils.getSubject();  
				Session session = currentUser.getSession();
			    FREmp user =(FREmp) session.getAttribute(Const.SESSION_USER);
				if(user!=null){
					FREmp userr= (FREmp) session.getAttribute(Const.SESSION_USERROL);
					if(null == userr){
						user = fREmpService.getUserAndRoleById(user.getEmp_ID());
						session.setAttribute(Const.SESSION_USERROL, user);
					}else{
						user = userr;
					}
					Role role = user.getRole();
					String roleRights = role!=null ? role.getRights() : "";
					//避免每次拦截用户操作时查询数据库，以下将用户所属角色权限、用户权限限都存入session
					session.setAttribute(Const.SESSION_ROLE_RIGHTS, roleRights); 		//将角色权限存入session
				session.setAttribute(Const.SESSION_USERNAME, user.getEmp_Name());
				List<Menu> allmenuList = new ArrayList<Menu>();
				if(null == session.getAttribute(Const.SESSION_allmenuList)){
					allmenuList = menuService.listAllMenu();
					if(Tools.notEmpty(roleRights)){
						for(Menu menu : allmenuList){
							menu.setHasMenu(RightsHelper.testRights(roleRights, menu.getMenu_Id()));
							if(menu.isHasMenu()){
								List<Menu> subMenuList = menu.getSubMenu();
								for(Menu sub : subMenuList){
								boolean a=	RightsHelper.testRights(roleRights, sub.getMenu_Id());
									sub.setHasMenu(RightsHelper.testRights(roleRights, sub.getMenu_Id()));
								}
							}
						}
					}
					session.setAttribute(Const.SESSION_allmenuList, allmenuList);			//菜单权限放入session中
				}else{
					allmenuList = (List<Menu>)session.getAttribute(Const.SESSION_allmenuList);
				}
				
				 //切换菜单
				List<Menu>menuList= new ArrayList<Menu>();
				if(null == session.getAttribute(Const.SESSION_menuList) || ("yes".equals(changeMenu))){
                   List<Menu>menuList1 = new ArrayList<Menu>();
                   List<Menu>menuList2 = new ArrayList<Menu>();
                   
                   //拆分菜单
           		for(int i=0;i<allmenuList.size();i++){
					Menu menu = allmenuList.get(i);
					if("1".equals(menu.getMenu_Type())){
						menuList1.add(menu);
					}else{
						menuList2.add(menu);
					}
				}
				
           		session.removeAttribute(Const.SESSION_menuList);
           		String s = (String) session.getAttribute("changeMenu");
           		System.out.println(s);
           		if("2".equals(session.getAttribute("changeMenu"))){
					session.setAttribute(Const.SESSION_menuList, menuList1);
					session.removeAttribute("changeMenu");
					session.setAttribute("changeMenu", "1");
					menuList = menuList1;
				}else{
					session.setAttribute(Const.SESSION_menuList, menuList2);
					session.removeAttribute("changeMenu");
					session.setAttribute("changeMenu", "2");
					menuList = menuList2;
				}	
					
				}else{
					menuList = (List<Menu>)session.getAttribute(Const.SESSION_menuList);
				}
				
				//切换菜单=====
				
				if(null == session.getAttribute(Const.SESSION_QX)){
					session.setAttribute(Const.SESSION_QX, this.getUQX(session));	//按钮权限放到session中
				}
				//登陆时记录日志 cwh 2018-06-20
				LogUtil.login(request, session);
			 	
			 	model.addAttribute("user", user);
			 	model.addAttribute("menuList", menuList);
			 	return "system/admin/index";
				}else{
					return "system/admin/login";
				}
		} catch (Exception e) {
			// TODO: handle exception
			logger.error(e.getMessage(), e);
			return "system/admin/login";
		}
	  
	}
	
	
  
  /**
	 * 进入tab标签
	 * @return
	 */
	@RequestMapping(value="/tab")
	public String tab(){
		return "system/admin/tab";
	}
	
	/**
	 * 进入首页后的默认页面
	 * @return
	 */
	@RequestMapping(value="/login_default")
	public String defaultPage(){
		return "system/admin/default";
	}
	
	
	/**
	 * 获取用户权限
	 */
	public Map<String, String> getUQX(Session session){
		PageData pd = new PageData();
		Map<String, String> map = new HashMap<String, String>();
		try {
			String USERNAME = session.getAttribute(Const.SESSION_USERNAME).toString();
			pd.put(Const.SESSION_USERNAME, USERNAME);
			String ROLE_ID = fREmpService.findByUId(pd).get("Role_ID").toString();
			
			pd.put("Role_ID", ROLE_ID);
			
			PageData pd2 = new PageData();
			pd2.put(Const.SESSION_USERNAME, USERNAME);
			pd2.put("Role_ID", ROLE_ID);
			
			pd = roleService.findObjectById(pd);																
				
			pd2 = roleService.findGLbyrid(pd2);
			if(null != pd2){
				map.put("FX_QX", pd2.get("FX_QX").toString());
				map.put("FW_QX", pd2.get("FW_QX").toString());
				map.put("QX1", pd2.get("QX1").toString());
				map.put("QX2", pd2.get("QX2").toString());
				map.put("QX3", pd2.get("QX3").toString());
				map.put("QX4", pd2.get("QX4").toString());
			
				pd2.put("Role_ID", ROLE_ID);
				pd2 = roleService.findYHbyrid(pd2);
				map.put("C1", pd2.get("C1").toString());
				map.put("C2", pd2.get("C2").toString());
				map.put("C3", pd2.get("C3").toString());
				map.put("C4", pd2.get("C4").toString());
				map.put("Q1", pd2.get("Q1").toString());
				map.put("Q2", pd2.get("Q2").toString());
				map.put("Q3", pd2.get("Q3").toString());
				map.put("Q4", pd2.get("Q4").toString());
			}
			
			map.put("adds", pd.getString("ADD_QX"));
			map.put("dels", pd.getString("DEL_QX"));
			map.put("edits", pd.getString("EDIT_QX"));
			map.put("chas", pd.getString("CHA_QX"));
			
			//System.out.println(map);
			
			this.getRemortIP(USERNAME);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}	
		return map;
	}
	/**
	 * 获取登录用户的IP
	 * @throws Exception 
	 */
	public void getRemortIP(String Emp_Name) throws Exception {  
		PageData pd = new PageData();
		HttpServletRequest request = this.getRequest();
		String ip = "";
		if (request.getHeader("x-forwarded-for") == null) {  
			ip = request.getRemoteAddr();  
	    }else{
	    	ip = request.getHeader("x-forwarded-for");  
	    }
		pd.put("Emp_Name", Emp_Name);
		pd.put("Ip", ip);
		fREmpService.saveIP(pd);
	}  
	
}
