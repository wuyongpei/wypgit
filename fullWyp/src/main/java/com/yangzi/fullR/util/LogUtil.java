package com.yangzi.fullR.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;


import com.yangzi.fullR.service.LogService;
import com.yangzi.fullR.system.FREmp;



public class LogUtil {
     
	private static Logger log = LogManager.getLogger(LogUtil.class);
	private static LogService logService =SpringContextHolder.getBean("logService");
	
	
	/** 异步保存日志 */
	private static void infoAsyn(final HttpServletRequest request, final Session session, final String operationContent,
			final String comment) {
      Runnable runnable = new Runnable() {
		
		public void run() {

			try {
				infoSyn(request, session, operationContent, comment);
			} catch (Exception e) {

				e.printStackTrace();
			} 
          
		}
	};

	}
	
	/**
	 * 同步保存日志
	 * @param request
	 * @param session
	 * @param operationContent	操作内容
	 * @param comment 备注
	 * @throws Exception
	 */
	private static void infoSyn(final HttpServletRequest request,Session session,final String operationContent,
			final String comment) throws Exception {   
		PageData pd=new PageData();
		FREmp user =(FREmp) session.getAttribute(Const.SESSION_USER);
		if(user!=null) {
			pd.put("createDateTime", DateUtil.getTime());
			pd.put("updateDateTime", DateUtil.getTime());
			pd.put("ipAddress", IPUtil.getIpAddr(request));
			pd.put("port", request.getRemotePort()+"");
			pd.put("computerName", WebUserAgentUtil.browserName(request));
			pd.put("operationID", user.getEmp_ID());
			pd.put("operationName", user.getE_Name());
			pd.put("operationContent", operationContent);
			pd.put("comment", comment);
		}
		logService.saveLog(pd);
	}
	
	
	/**
	 * 登出记录日志
	 * @param request
	 * @param session
	 * @throws Exception
	 */
	public static void logout(HttpServletRequest request,Session session) throws Exception{
		infoSyn(request, session, "已登出", null);
	}
	/**
	 * 登陆记录日志
	 * @param request
	 * @param session
	 * @throws Exception
	 */
	public static void login(HttpServletRequest request,Session session) throws Exception{	
		infoSyn(request, session, "已登入", null);
		
	}
	/**
	 * 用户操作记录日志
	 * @param request
	 * @param operationContent	(增删改查)
	 * @param comment			(具体操作内容)
	 * @throws Exception
	 */
	public static void operation(HttpServletRequest request,String operationContent,String comment) throws Exception {
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		infoSyn(request, session, operationContent, comment);
	}
	
	
	
	
	
	
	
	
	
	
}
