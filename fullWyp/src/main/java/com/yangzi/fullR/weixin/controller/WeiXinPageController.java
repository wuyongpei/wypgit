package com.yangzi.fullR.weixin.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.service.AppointmentService;
import com.yangzi.fullR.service.DictionaryService;
import com.yangzi.fullR.service.FREmpService;
import com.yangzi.fullR.service.WeixinChatService;
import com.yangzi.fullR.service.WorkAppointTimeService;
import com.yangzi.fullR.util.DateUtil;
import com.yangzi.fullR.util.HttpSend;
import com.yangzi.fullR.util.JsonUtil;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;
import com.yangzi.fullR.util.SysParamsToolkit;
import com.yangzi.fullR.weixin.entity.vo.AccessTokenVo;

@Controller
public class WeiXinPageController extends BaseController{

	@Resource(name="weixinChatService")
	private WeixinChatService weixinChatService;
	
	@Resource(name="fREmpService")
	private FREmpService frEmpService;
	
	@Resource(name="workAppointTimeService")
	private WorkAppointTimeService workAppointTimeService;
	
	@Resource(name="appointmentService")
	private AppointmentService appointmentService;
	
	@Resource(name="dictionaryService")
	private DictionaryService dictionaryService;
	
	@RequestMapping(value="/weixin/ini")
	public String weixinTest() {
		System.out.println("微信、、");
		return "weixin/weixin_institutes";
	}
	
	/**
	 * 跳转选择科室
	 * cwh
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/selectdepartment")
	public String selectSection2(Model model,HttpServletRequest request) throws Exception {
		PageData pd=new PageData();
		pd=this.getPageData();
		String ua=request.getHeader("user-agent").toLowerCase();
		if(ua.indexOf("micromessenger")>0) {//判断是否微信内置浏览器			
			String workUnitID=SysParamsToolkit.getProperty("workUnitID");
			//根据医院id 查询对应科室
			pd.put("workUnitID", workUnitID);
			List<PageData> deplist=null;
			deplist=weixinChatService.selectDepartmentByWorkUnitID(pd);
			if(!deplist.isEmpty()) {			
				model.addAttribute("deplist", deplist);
			}
			//没有子科室
			if("no".equals(SysParamsToolkit.getProperty("isSub"))) {
				return "weixin/departmentRegister/weixin_selectionDepartment2";
			}
			//有子科室
			
			/*		List<PageData> worklist=weixinChatService.selectAllDepartment();
			if(!worklist.isEmpty()) {
				model.addAttribute("worklist", worklist);
			}*/
			return "weixin/departmentRegister/weixin_selectionDepartment";
		}else {
			return "weixin/userBind/page-error-remind";
		}
	}
	/**
	 * 加载对应的二级科室
	 * cwh
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("weixin/load/page/department")
	public void loadPageDepartment(HttpServletResponse response) throws Exception {
		Map<String,Object> result=new HashMap<String,Object>();
		PageData pd=new PageData();
		pd=this.getPageData();
		//查询科室下子科室
		List<PageData> depsonlist=weixinChatService.selectWorkPositionByOfficeID(pd);
		if(!depsonlist.isEmpty()) {
			result.put("depsonlist", depsonlist);
		}
		/*		List<PageData> depsonlist=weixinChatService.selectDepartmentByWorkUnitID(pd);
			if(!depsonlist.isEmpty()) {
				//model.addAttribute("deplist", deplist);
				result.put("depsonlist", depsonlist);
			}*/
		RenderUtil.renderJson(result, response);
	}
	//跳转选择科室  泉州一院
	@RequestMapping(value="/weixin/selectdepartment2")
	public String selectSection() {
		System.out.println("跳转选择科室");
		return "weixin/departmentRegister/weixin_selectionDepartment2";
	}
	/**
	 * 只有一级科室，跳转选择医生
	 * cwh
	 * @param model
	 * @param OfficeID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/selectDoctor/{OfficeID}")
	public String selectDoctor(Model model,@PathVariable String OfficeID) throws Exception {
		PageData pd=new PageData();
		pd=this.getPageData();
		pd.put("officeID", OfficeID);
		List<PageData> emplist=weixinChatService.selectEmpByOfficeID(pd);
		if(!emplist.isEmpty()) {
			PageData pddic=new PageData();
			for (int i = 0; i < emplist.size(); i++) {
				pddic=dictionaryService.getDictionaryById(emplist.get(i).getInteger("DoctorPosition"));
				emplist.get(i).put("doctorPosition", pddic.get("DictionaryName"));
			}
			int total=weixinChatService.selectEmpTotalByOfficeID(pd);
			model.addAttribute("officeName", emplist.get(0).get("OfficeName"));
			model.addAttribute("emplist", emplist);
			model.addAttribute("total", total);
			model.addAttribute("officeID", emplist.get(0).get("OfficeID"));//科室id
		}
		//return "weixin/weixin_selectionDoctor2";  //按 选择医生
		return "weixin/weixin_selectionDoctor3";//  医生选择  按医生挂号/时间挂号
	}
	
	/**
	 * 二级科室，跳转选择医生
	 * cwh
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/selectDoctor2/{WorkPositionID}")
	public String selectDoctor2(Model model,@PathVariable String WorkPositionID) throws Exception {
		PageData pd=new PageData();
		pd=this.getPageData();
		pd.put("workPositionID", WorkPositionID);
		List<PageData> emplist=weixinChatService.selectEmpByWorkPositionID(pd);
			if(!emplist.isEmpty()) {
				int total=weixinChatService.selectEmpTotalByWorkPositionID(pd);
				model.addAttribute("officeName", emplist.get(0).get("WorkPositionName"));
				model.addAttribute("emplist", emplist);
				model.addAttribute("total", total);
			}
		return "weixin/weixin_selectionDoctor2";
	}	
	/**
	 * 跳转选择医生排班日期
	 * cwh
	 * @param emp_ID
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/selectSchedule/{emp_ID}")
	public String selectSchedule(@PathVariable String emp_ID,Model model) throws Exception {
		PageData pd=new PageData();
		pd=this.getPageData();
		pd.put("Emp_ID", emp_ID);
		//1.查询医生信息
		PageData emp=frEmpService.getEmpByID(emp_ID);
		if(emp!=null) {
			PageData pddic=dictionaryService.getDictionaryById(emp.getInteger("DoctorPosition"));
			if(!pddic.isEmpty()) {
				model.addAttribute("doctorPosition", pddic.get("DictionaryName"));//医生职位
			}
			model.addAttribute("emp", emp);//医生信息
		}
		//2.查询  预约时间
		pd.put("nowDate", DateUtil.getDay());//当天日期
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		List<PageData> atlist=workAppointTimeService.getAppointTimeByDoctorID(pd);
			if(!atlist.isEmpty()) {
				//判断是否过了当前时间
				String atime="";
				for(int i=atlist.size()-1;i>=0;i--) {	
					//yyyy-MM-dd HH:mm:ss格式
					atime=atlist.get(i).get("DutyDate")+" "+atlist.get(i).get("AppointEndTime")+":00";
					//String itime=DateUtil.getTime();
					//long nowtime=fmt.parse(itime).getTime();
					//long ltime=fmt.parse(atime).getTime();
					//过了当前时间
					if(fmt.parse(DateUtil.getTime()).getTime() >fmt.parse(atime).getTime()) {//过了当前时间
						atlist.remove(atlist.get(i));
					}
				}		
				//查询可用余号     
				for(int i=0;i<atlist.size();i++) {		
					List<String> timelist=DateUtil.getAllTimeMsg((String)atlist.get(i).get("AppointStartTime"), (String)atlist.get(i).get("AppointEndTime"), (int) atlist.get(i).get("TimeInterval"));
					int surplusnum=timelist.size();//预约时间 余号
			
					//list 查询 已预约时间点
					pd.put("Appointment_Date", atlist.get(i).get("DutyDate"));//预约日期
					DateFormat fmttime = new SimpleDateFormat("hh:mm");
					List<String> slist=appointmentService.getTimes(pd);//根据医生  日期  查询已预约时间
						if(!slist.isEmpty()) {	
							//将已预约时间点   与   预约时间比较   相同移除
							for(int j=0;j<slist.size();j++) {
								String time=slist.get(j).substring(0, 5);
									for(int z=0;z<timelist.size();z++) {									
										if(time.equals(timelist.get(z))) {
											timelist.remove(timelist.get(z));//将相同时间点  移除
											break;
										}
									}
							}
						}
						//没有预约   当天余号=总数-已预约-已过期
						if(DateUtil.getDay().equals(atlist.get(i).get("DutyDate"))) {
							for (int j = timelist.size()-1; j>=0; j--) {
								//String al=DateUtil.getTime().substring(11, 16);
								//Date itime=fmttime.parse(DateUtil.getTime().substring(11, 16));//当前时间
								//Date fortime=fmttime.parse(timelist.get(j));//循环
								if(fmttime.parse(DateUtil.getTime().substring(11, 16)).getTime() > fmttime.parse(timelist.get(j)).getTime()) {
									timelist.remove(timelist.get(j));
								}
							}
						}
						surplusnum=timelist.size();//余号						
						atlist.get(i).put("num", surplusnum);
				}
				model.addAttribute("atlist", atlist);
			}
		//该医生下没有排班信息    医生排班：显示暂无排班信息
		return "weixin/weixin_selectionSchedule";
	}
	/**
	 * 预约挂号选择时间
	 * cwh
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/selectTime")
	public String selectTime(Model model) throws Exception {	
		PageData pd=new PageData();
		pd=this.getPageData();
		String openID=(String)pd.get("openID");
		openID="o7d6S0csa33EBut2A2XDbbeY_Xk0";
		if(openID!=null && !"".equals(openID)) {
			PageData pdWCR=weixinChatService.selectWeChartRelationByOpenID(openID);
			if(!pdWCR.isEmpty()) {//微信已绑定     
				//就诊卡已绑定
				List<PageData> patientlist=weixinChatService.selectWeChartRCByweChartID(pdWCR.getString("WeChartID"));
				if(!patientlist.isEmpty()) {
					//医生信息
					PageData emp=frEmpService.getEmpByID(pd.getString("Emp_ID"));
					if(emp!=null) {
						PageData pddic=dictionaryService.getDictionaryById(emp.getInteger("DoctorPosition"));
						if(!pddic.isEmpty()) {
							model.addAttribute("doctorPosition", pddic.get("DictionaryName"));//医生职位
						}
						model.addAttribute("emp", emp);
					}			
					model.addAttribute("patientlist", patientlist);//就诊人列表
					//医生的预约时间
					PageData apppointTime=workAppointTimeService.getAppointTimeByAppointNoID(pd);
						if(apppointTime!=null) {
							//时间段
							List<String> timelist=DateUtil.getAllTimeMsg(apppointTime.getString("AppointStartTime"), apppointTime.getString("AppointEndTime"), apppointTime.getInteger("TimeInterval"));
								
							//如果是当天挂号  超出时间移除
							DateFormat fmt = new SimpleDateFormat("HH:mm");							
							if(DateUtil.getDay().equals(apppointTime.get("DutyDate"))) {								
								for (int i = timelist.size()-1; i>=0; i--) {
									//String al=DateUtil.getTime().substring(11, 16);
									//Date itime=fmt.parse(DateUtil.getTime().substring(11, 16));//当前时间
									//Date fortime=fmt.parse(timelist.get(i));//循环
									if(fmt.parse(DateUtil.getTime().substring(11, 16)).getTime() > fmt.parse(timelist.get(i)).getTime()) {
										timelist.remove(timelist.get(i));
									}
								}
							}
							
							//已被预约的时间段
							pd.put("Appointment_Date", apppointTime.get("DutyDate"));//预约日期
							List<String> slist=appointmentService.getTimes(pd);//根据医生  日期  查询已预约时间	
							if(!slist.isEmpty()) {
									//已预约时间段
								List<String> identicalList=new ArrayList<>();
									//将已预约时间点   与   预约时间比较   相同移除
									for(int i=0;i<slist.size();i++) {
										String time=slist.get(i).substring(0, 5);
											for(int j=0;j<timelist.size();j++) {									
												if(time.equals(timelist.get(j))) {
													//转换成时间段
													String identicalTime=null;
													if(j==timelist.size()-1) {//如果是最后一条时间点
														identicalTime=timelist.get(j)+"~"+apppointTime.getString("AppointEndTime");
													}else {
														identicalTime=timelist.get(j)+"~"+timelist.get(j+1);
													}
													identicalList.add(identicalTime);
													timelist.remove(timelist.get(j));//将相同时间点  移除
													break;
												}
											}
									}
									model.addAttribute("identicalList", identicalList);//已预约时间段
								}
							
							
							//可用预约时间段
							List<String> timelist2=new ArrayList<>();
							for(int i=0;i<timelist.size();i++) {
								String time=null;
								if(i==timelist.size()-1) {
									time=timelist.get(i)+"~"+apppointTime.getString("AppointEndTime");//最后一条预约时间
								}else {		
									time=timelist.get(i)+"~"+timelist.get(i+1);
								}
								timelist2.add(time);
							}
								model.addAttribute("timelist", timelist2);//可用预约时间
							model.addAttribute("apppointTime", apppointTime);
						}
					return "weixin/weixin_selectionTime";//跳转到选择预约时间
				}
			}
		}
		model.addAttribute("jumpAddress", "weixin/selectTime");//就诊卡绑定成功后跳转地址(选择挂号时间)
		return "weixin/userBind/weixin_buildCard";//用户建卡		
	}
	/**
	 * 我的挂号-当前挂号
	 * cwh
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/myregisteration")
	public String myRegisteration(HttpServletRequest request,Model model) throws Exception {		
		PageData pd=new PageData();
		pd=this.getPageData();
		String ua=request.getHeader("user-agent").toLowerCase();
		if(ua.indexOf("micromessenger")>0) {//判断是否微信内置浏览器
			HttpSend send=new HttpSend();
			String appid=SysParamsToolkit.getProperty("app.id");
			String secret=SysParamsToolkit.getProperty("secret");
			String code=request.getParameter("code");
			String url="https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appid + "&secret="
					+ secret + "&code=" + code + "&grant_type=authorization_code";
			String atjson=send.post(url, null);
			if(atjson!=null && !"".equals(atjson)){
				String openid="o7d6S0csa33EBut2A2XDbbeY_Xk0";//测试用openid
				pd.put("OpenID", openid);
				List<PageData> rclist=weixinChatService.selectWeChartRCByOpenID(pd);
				if(!rclist.isEmpty()) {	
					Page page=new Page();
					//已挂号
					List<PageData> appointlist=new ArrayList<PageData>();
					List<PageData> appointlist2=new ArrayList<PageData>();
					pd.put("nowDate", DateUtil.getDay());//当天日期
					pd.put("AppointmentStatus", 0);//预约状态 0:已预约 1已就诊 2失约
					for(int i=0;i<rclist.size();i++) {
						//根据病人id查询预约信息
						pd.put("PatientID", rclist.get(i).getString("PatientID"));
						page.setPd(pd);
						//大于当天  已预约
						appointlist2=appointmentService.getAppointmentByPIDAndStatus(pd);
						if(!appointlist2.isEmpty()) {							
							//截取时间点06:00
							String time="";
							for(int j=0;j<appointlist2.size();j++) {
								time=(String)appointlist2.get(j).get("Appointment_Time");
								appointlist2.get(j).put("Appointment_Time", time.substring(0, 5));
							}
							appointlist.addAll(appointlist2);
						}
					}
					model.addAttribute("appointlist", appointlist);
					model.addAttribute("nowtotal", appointlist.size());
					model.addAttribute("OpenID", openid);
					return "weixin/myRegister/weixin_myRegistration";//跳转 我的预约挂号
				}
				
			}
			return "weixin/userBind/weixin_buildCard";//用户建卡
		}else {
			return "weixin/userBind/page-error-remind"; //链接报错
		}
	}
	/**
	 * 我的挂号-历史挂号
	 * cwh
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/history/register")
	public String historyRegister(Model model) throws Exception {
		PageData pd=new PageData();
		pd=this.getPageData();
		List<PageData> rclist=weixinChatService.selectWeChartRCByOpenID(pd);
		if(!rclist.isEmpty()) {
			//已就诊
			List<PageData> visitlist=new ArrayList<PageData>();
			List<PageData> visitlist2=new ArrayList<PageData>();
			for (int i = 0; i < rclist.size(); i++) {
				pd.put("PatientID", rclist.get(i).get("PatientID"));
				pd.put("AppointmentStatus", 1);//预约状态 0:已预约 1已就诊 2失约
				pd.put("AppointmentStatus2", 2);
				visitlist2=appointmentService.getAppHistoryByPIDAndStatus(pd);
					if(!visitlist2.isEmpty()) {			
						String time="";
						for(int j=0;j<visitlist2.size();j++) {
							time=(String)visitlist2.get(j).get("Appointment_Time");
							visitlist2.get(j).put("Appointment_Time", time.substring(0, 5));
						}
						visitlist.addAll(visitlist2);
					}
			}
			model.addAttribute("visitlist", visitlist);
			model.addAttribute("histotal", visitlist.size());
		}
		return "weixin/myRegister/weixin_historicalRegistration";
	}
	//无关注医生数据页面
	@RequestMapping(value="/weixin/noFollowDoctor")
	public String noFollowDoctor() {
		System.out.println("无关注医生");
		return "weixin/weixin-noData-doctor";
	}
	/**
	 * 加载按时间挂号页面
	 * cwh
	 * @param officeID
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/weixin/time/register/page")
	public String timeRegisterPage(String officeID,Model model) {
		if(officeID!=null) {
			model.addAttribute("officeID", officeID);
		}
		return "weixin/doctorRegister/weixin_selectionTime_page";
	}
	/**
	 * 按时间 选择医生挂号
	 * cwh
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/time/register")
	@ResponseBody
	public Map<String,Object> timeRegister() throws Exception{
		 Map<String,Object> result=new HashMap<String,Object>();
		 PageData pd=new PageData();
		 pd=this.getPageData();
		 List<PageData> watlist=workAppointTimeService.getAppointTimeByOIDandDD(pd);
		 if(!watlist.isEmpty()) {
			 //医生职位
			 for (int i = 0; i < watlist.size(); i++) {
				PageData pddic=dictionaryService.getDictionaryById(watlist.get(i).getInteger("DoctorPosition"));
				if(!pddic.isEmpty()) {
					watlist.get(i).put("DoctorPosition", pddic.get("DictionaryName"));			
				}
			 }
			 
			 //判断是否过了当前时间
			 DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			 String atime="";
			 for(int i=watlist.size()-1;i>=0;i--) {
				//yyyy-MM-dd HH:mm:ss格式
					atime=watlist.get(i).get("DutyDate")+" "+watlist.get(i).get("AppointEndTime")+":00";
					//String itime=DateUtil.getTime();
					//long nowtime=fmt.parse(itime).getTime();
					//long ltime=fmt.parse(atime).getTime();
					//过了当前时间
					if(fmt.parse(DateUtil.getTime()).getTime() >fmt.parse(atime).getTime()) {//过了当前时间
						watlist.remove(watlist.get(i));
					}
			 }
				//查询可用余号     
				for(int i=0;i<watlist.size();i++) {		
					List<String> timelist=DateUtil.getAllTimeMsg((String)watlist.get(i).get("AppointStartTime"), (String)watlist.get(i).get("AppointEndTime"), (int) watlist.get(i).get("TimeInterval"));
					int surplusnum=timelist.size();//预约时间 余号
			
					//list 查询 已预约时间点
					pd.put("Appointment_Date", watlist.get(i).get("DutyDate"));//预约日期
					pd.put("Emp_ID", watlist.get(i).get("DocTorID"));
					DateFormat fmttime = new SimpleDateFormat("hh:mm");
					List<String> slist=appointmentService.getTimes(pd);//根据医生  日期  查询已预约时间
						if(!slist.isEmpty()) {	
							//将已预约时间点   与   预约时间比较   相同移除
							for(int j=0;j<slist.size();j++) {
								String time=slist.get(j).substring(0, 5);
									for(int z=0;z<timelist.size();z++) {									
										if(time.equals(timelist.get(z))) {
											timelist.remove(timelist.get(z));//将相同时间点  移除
											break;
										}
									}
							}
						}
						//没有预约   当天余号=总数-已预约-已过期
						if(DateUtil.getDay().equals(watlist.get(i).get("DutyDate"))) {
							for (int j = timelist.size()-1; j>=0; j--) {
								//String al=DateUtil.getTime().substring(11, 16);
								//Date itime=fmttime.parse(DateUtil.getTime().substring(11, 16));//当前时间
								//Date fortime=fmttime.parse(timelist.get(j));//循环
								if(fmttime.parse(DateUtil.getTime().substring(11, 16)).getTime() > fmttime.parse(timelist.get(j)).getTime()) {
									timelist.remove(timelist.get(j));
								}
							}
						}
						surplusnum=timelist.size();//余号						
						watlist.get(i).put("num", surplusnum);
				}
			 result.put("watlist", watlist);
		 }
		 return result;
	}
	/**
	 * 跳转就诊卡充值页面
	 * cwh
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/card/recharge")
	public String medicalCardRecharge(HttpServletRequest request) throws Exception {
		
		String ua=request.getHeader("user-agent").toLowerCase();
		if(ua.indexOf("micromessenger")>0) {//判断是否微信内置浏览器
			HttpSend send=new HttpSend();
			String appid=SysParamsToolkit.getProperty("app.id");
			String secret=SysParamsToolkit.getProperty("secret");
			String code=request.getParameter("code");
			String url="https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appid + "&secret="
					+ secret + "&code=" + code + "&grant_type=authorization_code";
			String atjson=send.post(url, null);
			if(atjson!=null && !"".equals(atjson)){
				String openid="o7d6S0csa33EBut2A2XDbbeY_Xk0";//测试用openid
				PageData pdWCR=weixinChatService.selectWeChartRelationByOpenID(openid);
				if(!pdWCR.isEmpty()) {				
					return "weixin/recharge/weixin_recharge";//跳转 就诊卡充值
				}
//				AccessTokenVo atvo=JsonUtil.json2Object(AccessTokenVo.class, atjson);
//				if(atvo!=null && atvo.getAccess_token()!=null && atvo.getOpenid()!=null && atvo.getErrcode()==null) {
//					List<PageData> list=weixinChatService.selectWeChartRelationByOpenID(atvo.getOpenid());
//					String openid="o7d6S0csa33EBut2A2XDbbeY_Xk0";//测试用openid
//					List<PageData> list=weixinChatService.selectWeChartRelationByOpenID(openid);
//					if(!list.isEmpty()) {				
//						return "weixin/recharge/weixin_recharge";//跳转 就诊卡充值
//					}
//				}
			}
			return "weixin/userBind/weixin_buildCard";//用户建卡
		}else {
			return "weixin/userBind/page-error-remind"; //链接报错
		}
	}
	/**
	 * 根据关键字 查询科室或医生
	 * cwh
	 * @param model
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/search/keyword")
	@ResponseBody
	public Map<String,Object> getDepartmentOrEmpByName(Model model,HttpServletResponse response) throws Exception {
		Map<String, Object> result=new HashMap<String,Object>();
		PageData pd=new PageData();
		 pd=this.getPageData();
		 String workUnitID=SysParamsToolkit.getProperty("workUnitID");
		 pd.put("workUnitID", workUnitID);
/*		 //查询科室 按二级科室查询
		List<PageData> depsonlist= weixinChatService.getWorkPositionByName(pd);
		 	if(!depsonlist.isEmpty()) {
		 		int deptotal=weixinChatService.getWorkPositionTotalByName(pd);
		 		result.put("depsonlist", depsonlist);
		 		result.put("deptotal", deptotal);
		 	}*/
		 //查询科室 按一级科室查询
		 List<PageData> deplist=weixinChatService.getOfficeByName(pd);
		 if(!deplist.isEmpty()) {
			 int deptotal=weixinChatService.getOfficeTotalByName(pd);
			 result.put("deplist", deplist);
		 	 result.put("deptotal", deptotal);
		 }
		 //查询医生
		 List<PageData> emplist=weixinChatService.getEmpByName(pd);
		 if(!emplist.isEmpty()) {
			PageData pddic=new PageData();
			for (int i = 0; i < emplist.size(); i++) {
				pddic=dictionaryService.getDictionaryById(emplist.get(i).getInteger("DoctorPosition"));
				emplist.get(i).put("doctorPosition", pddic.get("DictionaryName"));
			}
			int emptotal= weixinChatService.getEmpTotalByName(pd);	 
	 		result.put("emplist", emplist);
	 		result.put("emptotal", emptotal);
		 }
		 return result;
	}
	/**
	 * 提交预约信息
	 * cwh
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/submit/appointment")
	@ResponseBody
	public Map<String,Object> submitAppointment() throws Exception{
		Map<String,Object> result=new HashMap<String,Object>();
		
		PageData pd=new PageData();
		pd=this.getPageData();
		//医生类型    专家-1,普通-2
		String docType=(String) pd.get("Doctor_Type");
		if(docType.equals("专家")) {
			pd.put("Doctor_Type", 1);
		}else if(docType.equals("普通")) {
			pd.put("Doctor_Type", 2);
		}
		pd.put("Appointment_ID", this.get32UUID());//预约id
		pd.put("Appointment_Type", "1");//预约类型   初诊-1     字典DictionaryCode字段
		pd.put("Appointment_Con", "");//预约内容
		pd.put("Appointment_Come", 1);//预约来源：1.微信预约
		pd.put("Comment", "");//Comment备注
		pd.put("Appointment_Code", this.get32UUID());//预约编号
		pd.put("isConfirm", null);//是否已取票
		pd.put("AppointmentStatus", 0);//预约状态 0.已预约
		pd.put("CreateDateTime", DateUtil.getTime());//创建时间
		synchronized (this) {
			
			//1.查询预约时间（医生 日期 时间）是否已被预约
			int num=appointmentService.countTime(pd);
			if(num>0) {
				result.put("statue", "exist");//已被预约
			}else {	
				//保存预约信息
				try {
					appointmentService.save(pd);
					result.put("statue", "success");
				} catch (Exception e) {
					logger.error(e.toString(), e);
				}
			}
		}
		return result;
	}
	/**
	 * 取消挂号
	 * cwh
	 * @param Appointment_ID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/weixin/cancel/registration")
	@ResponseBody
	public Map<String,Object> cancelRegistration(String Appointment_ID) throws Exception{
		Map<String,Object> result=new HashMap<String,Object>();
		try {		
			appointmentService.delete(Appointment_ID);
			result.put("statue", "success");
		} catch (Exception e) {
			logger.error(e.toString(),e);
		}
		return result;
	}
}
