package com.yangzi.fullR.util;

import javax.servlet.http.HttpServletRequest;

import nl.bitwalker.useragentutils.Browser;
import nl.bitwalker.useragentutils.OperatingSystem;
import nl.bitwalker.useragentutils.UserAgent;

public class WebUserAgentUtil {

	  
	  public static String osName(HttpServletRequest req){
		   
		//获取浏览器信息
		  String ua = req.getHeader("User-Agent");
		  //转成UserAgent对象
		  UserAgent userAgent = UserAgent.parseUserAgentString(ua); 
		  //获取浏览器信息
		  Browser browser = userAgent.getBrowser();  
		  //获取系统信息
		  OperatingSystem os = userAgent.getOperatingSystem();
		  //系统名称
		  String  osname = os.getName();
		  //浏览器名称
		  String browserName = browser.getName();
		  
		  
		  return osname;
	  }
	  public static String browserName(HttpServletRequest req){
		  
		  //获取浏览器信息
		  String ua = req.getHeader("User-Agent");
		  //转成UserAgent对象
		  UserAgent userAgent = UserAgent.parseUserAgentString(ua); 
		  //获取浏览器信息
		  Browser browser = userAgent.getBrowser();  
		  //获取系统信息
		  OperatingSystem os = userAgent.getOperatingSystem();
//		  //系统名称
//		  String  osname = os.getName();
		  //浏览器名称
		  String browserName = browser.getName();
		  
		  
		  return browserName;
	  }
}
