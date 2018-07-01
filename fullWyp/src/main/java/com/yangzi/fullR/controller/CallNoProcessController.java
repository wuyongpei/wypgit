package com.yangzi.fullR.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.deser.Deserializers.Base;
import com.fasterxml.jackson.databind.module.SimpleAbstractTypeResolver;
import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.entity.vo.CallListVo;
import com.yangzi.fullR.entity.vo.CallListVo2;
import com.yangzi.fullR.service.AppointmentService;
import com.yangzi.fullR.service.CallListService;
import com.yangzi.fullR.service.DictionaryService;
import com.yangzi.fullR.service.FREmpService;
import com.yangzi.fullR.service.SickPatientService;
import com.yangzi.fullR.service.WorkUnitAndOfficeService;
import com.yangzi.fullR.system.FREmp;
import com.yangzi.fullR.util.CallHttpSend;
import com.yangzi.fullR.util.Const;
import com.yangzi.fullR.util.DateOperator;
import com.yangzi.fullR.util.HttpSend;
import com.yangzi.fullR.util.JsonUtil;
import com.yangzi.fullR.util.MSTTSSpeech;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;
import com.yangzi.fullR.util.SysParamsToolkit;
import com.yangzi.fullR.util.ToolComplexUtil;
/**
 * LZD
 * 20180604
 * 排队叫号路口控制
 * @author win7
 *
 */
@Controller
@RequestMapping("/process")
public class CallNoProcessController extends BaseController {
    
	@Autowired
	private CallListService callListService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private AppointmentService appointmentService;
	@Autowired
	private SickPatientService sickPatientService;
	@Autowired
	private FREmpService fREmpService;
	@Autowired
	private WorkUnitAndOfficeService workUnitAndOfficeService;
	@Autowired
	
	/**
	 * lzd
	 * t跳转确认窗口
	 * @return
	 */
	@RequestMapping("/comfirm/win")
	public String comfirmWin()throws Exception 
	{
		return "system/process/getTicket";
	}
	
	/**
	 * 到场确认
	 * 取票并进行队列创建
	 * lzd
	 * 20180605
	 */
	@RequestMapping("/make/callList")
	public void createCallList(HttpServletRequest request,HttpServletResponse response) {
		try {
			SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
	       PageData pd = new PageData();
	       PageData pob = null;
	       PageData pad = null;
	       pd= this.getPageData();
	       String cardno =pd.getString("cardno");
	       String phone =pd.getString("phone");
	       String idNum =pd.getString("idNum");
	       if((cardno!=null&&!"".equals(cardno))||(phone!=null&&!"".equals(phone))||(idNum!=null&&!"".equals(idNum))) {
	    	   pob=sickPatientService.getPatientByCons(pd);
	    	   if(pob!=null) {
                  String patientid = pob.getString("PatientID");
                  String date = sdf.format(new Date());
                  pd.put("patientid", patientid);
                  pd.put("date", date);
                     //获取预约信息
                 pad = appointmentService.getAppointmentByCons(pd);
	                 //生成取票号并且记录到队列中
                 if(pad!=null) {
                	String queueID =this.get32UUID().toString();
                	Integer queueCode =appointmentService.countToGetQueueNo(pad);
                	CallListVo vo = new CallListVo();
                	vo.setQueueID(queueID);
                	vo.setQueueCode("wp"+ToolComplexUtil.fronCompWithZore(queueCode, 3));
                	vo.setEmpID(pad.getString("Emp_ID"));
                	vo.setEmpName(pad.getString("E_Name"));
                	vo.setAppointmentTime(pad.getString("Appointment_Time"));
                	vo.setAppointmentType(pad.getString("Appointment_Type"));
                	vo.setPatientID(pad.getString("PatientID"));
                	vo.setPatientName(pad.getString("PatientName"));
                	vo.setStatus("1");
                	vo.setAppointmentDate(pad.getString("Appointment_Date"));
                	vo.setMnCardNO(pob.getString("CardCode"));
                	callListService.saveQueue(vo);
                 }else {
                	 System.out.println("没有预约信息");
                 }
	    	   }
	       }
			  
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	} 
	
	 /**
	  * 叫号页面
	  * LZD
	  * @param model
	  * @return
	  */
	@RequestMapping("/doctor/call")
	public String index(Model model){
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
		Subject currentUser = SecurityUtils.getSubject();  
		 Session session = currentUser.getSession();
		 FREmp emp= (FREmp) session.getAttribute(Const.SESSION_USERROL);
		 int countnl=0;//当前排队数量
		 int countg=0;//过号数量
		 int countac=0;//已经叫过号的数量
		 int countaj=0;//
		 PageData pd = new PageData();
		 String empid="";
		 if(emp!=null){ 
			 empid=emp.getEmp_ID();
		     pd.put("empID",empid );
		     pd.put("appointmentDate", sdf.format(new Date()));
		     //当前排队数量条件
		     pd.put("status", 1);
			 countnl =callListService.countByStatusAndMySelf(pd);
			 //过号数量
			 pd.put("status", 3);
			 countg =callListService.countByStatusAndMySelf(pd);
			 //已经就诊数量
			 pd.put("status", 2);
			 countaj=callListService.countByStatusAndMySelf(pd);
			 //已经叫过的数量
			 pd.put("status", "");
			 pd.put("hasTime", "1");
			 countac=callListService.countByStatusAndMySelf(pd);
			 
			 pd=callListService.getNowOne(pd);
		 }
		 model.addAttribute("countnl", countnl);
		 model.addAttribute("countg", countg); 
		 model.addAttribute("countac", countac);
		 model.addAttribute("countaj", countaj);
		 model.addAttribute("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}  
		return "system/process/call-list-c";
	}
	
	/**
	 * 单独叫号列表获取
	 * LZD
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/calllists")
	public String callLists(@RequestParam String status ,Model model) throws Exception{
	     PageData pd = new PageData();
	     pd = this.getPageData();
	     SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	     SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	     List<PageData> pdList = null;
	     List<CallListVo> callList =new ArrayList<>();
	     Subject currentUser = SecurityUtils.getSubject();  
		 Session session = currentUser.getSession();
	     FREmp emp= (FREmp) session.getAttribute(Const.SESSION_USERROL);
	     if(emp!=null){
         pd.put("empID", emp.getEmp_ID());
         pd.put("appointmentDate", sdf.format(new Date()));
	     pd.put("status", status);	 
	     pd.put("empName", emp.getE_Name());
	     pdList= callListService.getCallListByCons(pd);
	     if(pdList!=null && !pdList.isEmpty()){
	    	 for(PageData pda:pdList){
	    		 CallListVo vo = new CallListVo();
	    		 PageData p = new PageData();
	    		 String queueID=pda.getString("Queue_ID");
	    		 vo.setQueueID(queueID);
	    		 vo.setQueueCode(pda.getString("Queue_Code"));
	    		 vo.setEmpID(pda.getString("Emp_ID"));
	    		 vo.setEmpName(pda.getString("E_Name"));
	    		 String appTime =pda.getString("Appointment_Time");
	    		 vo.setAppointmentTime(appTime);
	    		
	    		 p.put("dictname", "APPOINTMENT");
	    		 p.put("dictcode", pda.getString("Appointment_Type"));
	    		 String atype= dictionaryService.getDictionaryNameByCons(p);
	    		 vo.setAppointmentType(atype);
	    		 vo.setCallTime(pda.getString("Call_Time"));
	    		 vo.setPatientID(pda.getString("PatientID"));
	    		 vo.setPatientName(pda.getString("PatientName"));
	    		 
	    		 p.put("dictname", "WAITSTATUS");
	    		 p.put("dictcode", pda.getString("Status"));
	    		 String stus= dictionaryService.getDictionaryNameByCons(p);
	    		 vo.setStatus(stus);
	    		 String adate = pda.getString("Appointment_Date");
	    		 vo.setAppointmentDate(adate);
	    		 vo.setMnCardNO(pda.getString("MN_CardNO"));
	    		 
	    		//计算
	    		 Date appDate =sdf1.parse(adate+" "+appTime+"00");
	    		 if("1".equals(status)) {
	    		   if(DateOperator.comparetBig(new Date(), appDate)) {
	    			   String time =DateOperator.compareTime(new Date(), appDate);
	    			   vo.setWaitTime(time);
	    		    callList.add(vo);
	    		   }else {
	    			 pd.put("status", 3);
	    			 pd.put("queueID", queueID);
	    			 callListService.updateQueue(pd);
	    		   }
	    		 }else if("2".equals(status)) {
	    			 
	    			 callList.add(vo);
	    		 }else if("3".equals(status)) {
	    			  vo.setWaitTime("已超时");
	    			 callList.add(vo);
	    		 }
	    	 }
	     }
	     }
	     model.addAttribute("callList", callList);
	     model.addAttribute("pd", pd);
		return "system/process/call-list";
	}
	/**
	 * 呼叫下一个或者重呼操作
	 * lzd 20180606
	 * @param type
	 * @param queueID
	 * @param response
	 */
	@RequestMapping("/callWaitP")
	public void callWaitP(String type,String queueID,String empID,HttpServletResponse response) {
		Map<String,Object> result = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		CallHttpSend send = new CallHttpSend();
		try {
			PageData pd= new PageData();
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			String date =sf.format(new Date());
			String callTime =sdf.format(new Date());
			if("0".equals(type)) {
				//重新呼叫当前人 调用语音文件 进行呼叫操作
			     if(queueID!=null &&!"".equals(queueID)) {
			    	 pd = callListService.getCallByID(queueID);
                     if(pd!=null) { 
                    	 pd.put("Call_Time", callTime);
                    	 callListService.updateQueUeC(pd);
                    	 String text= pd.getString("VoiceName");
                         //语音呼叫流程调用  
                    	 map.put("text", text);
                    	 String json =JsonUtil.obj2Json(map);
  					  String back= send.sendPost("http://192.168.1.43:8080/process/play/voice", json);
  					   if(back!=null&&!"".equals(back)) {
  						   //更新呼叫时间
  						   result.put("status", "success");
  					   }
                     }
			     }
			}else if("1".equals(type)) {
			   	pd.put("empID", empID);
			   	pd.put("appointmentDate", date);
			   	pd.put("status", 1);
                PageData pds = callListService.getNextOne(pd); 
			   if(pds!=null) {
				   PageData empPd =fREmpService.getEmpByID(pds.getString("Emp_ID"));
				   if(empPd!=null) {
					  String wpName =workUnitAndOfficeService.getWorkPNameByPid(empPd.getInteger("WorkPositionID"));
							   //创建音频文件并进行播放
							   //1.创建音频文件
					   StringBuffer voiceText = new StringBuffer();
					   String qcode = pds.getString("Queue_Code");
					   String patientName =pds.getString("PatientName");
					   voiceText.append("请").append(qcode).append("号").append(patientName).append("到").append(wpName).append("就诊");
					   String text = voiceText.toString();
					   pds.put("VoiceName", text);
					   pds.put("Call_Time", callTime);   
					   //更新叫号时间
					   callListService.updateQueUeC(pds);
					   //语音呼叫流程调用 //测试写死
//					   PageData ipda = callListService.getVoiceControlIP(empPd.getInteger("OfficeID"));
					   map.put("text", text);
                  	   String json =JsonUtil.obj2Json(map);
  					  String back= send.sendPost("http://192.168.1.43:8080/process/play/voice", json);
  					 if(back!=null&&!"".equals(back)) {
  						 result.put("data", pds);
  						 result.put("status", "success");
  					 }
				   }
			   }
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("status", "faile");
		}
		
		RenderUtil.renderJson(result, response);
	}
	
	/**
	 * 单人呼叫 和单人重呼
	 * lzd 20180612
	 * @param queueId
	 * @param response
	 */
	@RequestMapping("/callOneP")
	public void callOneP(String queueId,HttpServletResponse response) {
		Map<String,Object> result = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		CallHttpSend send = new CallHttpSend();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		PageData pd = new PageData();
		String back="";
		try {
		if(queueId!=null &&!"".equals(queueId)) {
			 pd = callListService.getCallByID(queueId);
			 if(pd!=null) {
                String text =pd.getString("VoiceName");	
                if(text!=null&&!"".equals(text)) {
                	  map.put("text", text);
                 	   String json =JsonUtil.obj2Json(map);
                 	  back= send.sendPost("http://192.168.1.43:8080/process/play/voice", json);
                 	  if(back!=null&&!"".equals(back)) {
                 		 result.put("status", "success");
                 	  }
                }else {
                	StringBuffer voiceText = new StringBuffer();
                	String qcode = pd.getString("Queue_Code");
                	String patientName =pd.getString("PatientName");
                	String wpName ="";
                	  PageData empPd =fREmpService.getEmpByID(pd.getString("Emp_ID"));
                      if(empPd!=null) {
                    	  wpName =  workUnitAndOfficeService.getWorkPNameByPid(empPd.getInteger("WorkPositionID"));
                      }
                	  voiceText.append("请").append(qcode).append("号").append(patientName).append("到").append(wpName).append("就诊");
					  text = voiceText.toString();
					  pd.put("VoiceName", text);
					   pd.put("Call_Time", sdf.format(new Date()));   
					   //更新叫号时间
					   callListService.updateQueUeC(pd);
					  map.put("text", text);
                	   String json =JsonUtil.obj2Json(map);
                	   back= send.sendPost("http://192.168.1.43:8080/process/play/voice", json);
                	   if(back!=null&&!"".equals(back)) {
                   		 result.put("status", "success");
                   	  }
                }
                
			 }
		}
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("status", "faile");
		}
		RenderUtil.renderJson(result, response);
	}
	
	
	/**
	 * 改变状态
	 * lzd 20180606
	 */
	@RequestMapping("/comfirmMz")
	public void comfirmMz(String queueID,String status,HttpServletResponse response) { 
		Map<String,Object> result = new HashMap<>();
		try {
			PageData pd= new PageData();
			if(queueID!=null&&!"".equals(queueID)) {
				pd.put("queueID", queueID);
				pd.put("status",status);
			 	callListService.updateQueue(pd);
				result.put("status", "success");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("status", "faile");
		}
		RenderUtil.renderJson(result, response);
	}
	/**********************************************************排队叫号队列管理****************************************************************/
	
	/**
	 * 队列叫号总控显示页面
	 * lzd
	 * 2018-06-12 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/confirm")
	public String waitListPage(Page page,Model model)throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		 PageData pd = new PageData();
		 pd=this.getPageData();
		 String dockey =pd.getString("dockey");
		 if(dockey!=null &&!"".equals(dockey)) {
			 dockey =dockey.trim();
            pd.put("dockey", dockey);			 
		 }
		 List<CallListVo2>volist = new ArrayList<CallListVo2>();
		 Subject currentUser = SecurityUtils.getSubject();  
		 Session session = currentUser.getSession();
		 FREmp emp= (FREmp) session.getAttribute(Const.SESSION_USER);
		 String workUnitID="";
		 if(emp!=null) {
			 workUnitID =emp.getWorkUnitID();
		 }
		 if(!"".equals(workUnitID)) {
			 pd.put("workUnitID", workUnitID);
				page.setShowCount(9);
				page.setPd(pd);
			 //根据院所获取所有相关的医生角色 并组合成相关的展示数据
		 List<PageData>empPdlist = fREmpService.getCanUserEmpByUnitID(page);
            if(empPdlist!=null &&!empPdlist.isEmpty()) {
            	for (PageData pdemp : empPdlist) {
            		CallListVo2 vo = new CallListVo2(); 
            		int countnl=0;//当前排队数量
            		 int countg=0;//过号数量
            		 int countac=0;//已经叫过号的数量
            		 int countaj=0;//已经就诊
            		String empid=pdemp.getString("Emp_ID");
        		     pd.put("empID",empid );
        		     pd.put("appointmentDate", sdf.format(new Date()));
        		     //当前排队数量条件
        		     pd.put("status", 1);
        			 countnl =callListService.countByStatusAndMySelf(pd);
        			 //过号数量
        			 pd.put("status", 3);
        			 countg =callListService.countByStatusAndMySelf(pd);
        			 //已经就诊数量
        			 pd.put("status", 2);
        			 countaj=callListService.countByStatusAndMySelf(pd);
        			 //已经叫过的数量
        			 pd.put("status", "");
        			 pd.put("hasTime", "1");
        			 countac=callListService.countByStatusAndMySelf(pd); 
            		 vo.setEmpID(empid);
            		 vo.setEmpName(pdemp.getString("E_Name"));
            		 vo.setWorkUnitID(workUnitID);
            		 vo.setWorkUnitName(pdemp.getString("WorkUnitName"));
            		 vo.setOfficeId(pdemp.getInteger("OfficeID"));
        			 vo.setOfficeName(pdemp.getString("OfficeName"));
        			 vo.setCountList(countnl);
        			 vo.setCountPass(countg);
        			 vo.setAlreadyCall(countac);
        			 vo.setAlreadyTreated(countaj);
        			 volist.add(vo);
				}
            }	
            model.addAttribute("callList", volist);
		 }
		return "system/process/all-wait-list";
	} 
	/**
	 * 单个医生单窗口列表
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/one/list/call")
	public String onWaitListPage(Model model,HttpServletRequest request)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String empId = request.getParameter("docId");
		String status =request.getParameter("status");
		if(empId!=null&&!"".equals(empId)) {
		     SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		     SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		     List<PageData> pdList = null;
		     List<CallListVo> callList =new ArrayList<>();
		     pd.put("empID", empId);
	         pd.put("appointmentDate", sdf.format(new Date()));
		     pd.put("status", status);	  
		     pdList= callListService.getCallListByCons(pd);
		     if(pdList!=null && !pdList.isEmpty()){
		    	 for(PageData pda:pdList){
		    		 CallListVo vo = new CallListVo();
		    		 PageData p = new PageData();
		    		 String queueID=pda.getString("Queue_ID");
		    		 vo.setQueueID(queueID);
		    		 vo.setQueueCode(pda.getString("Queue_Code"));
		    		 vo.setEmpID(pda.getString("Emp_ID"));
		    		 vo.setEmpName(pda.getString("E_Name"));
		    		 String appTime =pda.getString("Appointment_Time");
		    		 vo.setAppointmentTime(appTime);
		    		
		    		 p.put("dictname", "APPOINTMENT");
		    		 p.put("dictcode", pda.getString("Appointment_Type"));
		    		 String atype= dictionaryService.getDictionaryNameByCons(p);
		    		 vo.setAppointmentType(atype);
		    		 vo.setCallTime(pda.getString("Call_Time"));
		    		 vo.setPatientID(pda.getString("PatientID"));
		    		 vo.setPatientName(pda.getString("PatientName"));
		    		 
		    		 p.put("dictname", "WAITSTATUS");
		    		 p.put("dictcode", pda.getString("Status"));
		    		 String stus= dictionaryService.getDictionaryNameByCons(p);
		    		 vo.setStatus(stus);
		    		 String adate = pda.getString("Appointment_Date");
		    		 vo.setAppointmentDate(adate);
		    		 vo.setMnCardNO(pda.getString("MN_CardNO"));
		    		 
		    		//计算
		    		 Date appDate =sdf1.parse(adate+" "+appTime+"00");
		    		 if("1".equals(status)) {
		    		   if(DateOperator.comparetBig(new Date(), appDate)) {
		    			   String time =DateOperator.compareTime(new Date(), appDate);
		    			   vo.setWaitTime(time);
		    		    callList.add(vo);
		    		   }else {
		    			 pd.put("status", 3);
		    			 pd.put("queueID", queueID);
		    			 callListService.updateQueue(pd);
		    		   }
		    		 }else if("2".equals(status)) {
		    			 callList.add(vo);
		    		 }else if("3".equals(status)) {
		    			  vo.setWaitTime("已超时");
		    			 callList.add(vo);
		    		 }
		    	 }
		     }
		     model.addAttribute("callList", callList);
		     model.addAttribute("sta", status);
		}
		return "system/process/one-wait-list";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/***********************************************************定时器与处理方法****************************************************************/
	
	
	
	
	
	
	
	
}
