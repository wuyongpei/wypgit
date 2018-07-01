package com.yangzi.fullR.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.zxing.pdf417.encoder.PDF417;
import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.entity.vo.ListAppointCout;
import com.yangzi.fullR.entity.vo.TimeIntervalVo;
import com.yangzi.fullR.service.AppointmentService;
import com.yangzi.fullR.service.DictionaryService;
import com.yangzi.fullR.service.DutySchedulingService;
import com.yangzi.fullR.service.FREmpService;
import com.yangzi.fullR.service.ShiftService;
import com.yangzi.fullR.service.WorkAppointTimeService;
import com.yangzi.fullR.service.WorkUnitAndOfficeService;
import com.yangzi.fullR.util.DateUtil;
import com.yangzi.fullR.util.JsonUtil;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;

import net.sf.jsqlparser.expression.operators.relational.JsonOperator;

@Controller
@RequestMapping(value = "/appointment")
public class AppointmentController extends BaseController {

	@Autowired
	private WorkUnitAndOfficeService workUnitAndOfficeService;
	@Autowired
	private AppointmentService appointmentService;
	@Autowired
	private FREmpService fREmpService;
	@Autowired
	private ShiftService shiftService;
	@Autowired
	private DutySchedulingService dutySchedulingService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private WorkAppointTimeService workAppointTimeService;
	@Autowired
	private SickPatientController sickPatientController;

	/**
	 * WYP 预约界面
	 */
	@RequestMapping(value = "/yuyue")
	public String yuyue(Model model) throws Exception {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			if (pd.containsKey("Appointment_ID")) {
				pd = new PageData();
			}
			List<ListAppointCout> listac = new ArrayList<ListAppointCout>();
			List<String> listS = appointmentService.timeCirle();
			String mondayDate = DateUtil.getNowMonday();
			for (int i = 0; i < listS.size(); i++) {
				ListAppointCout lac = new ListAppointCout();
				lac.setTimeD(listS.get(i));
				pd.put("startAppointTime", listS.get(i));
				if (i < (listS.size() - 1)) {
					pd.put("endAppointTime", listS.get(i + 1));
				} else if (i == (listS.size() - 1)) {
					pd.put("endAppointTime", listS.get(i));
				}
				// 周一
				pd.put("appointmentDate", mondayDate);
				lac.setMonCount(appointmentService.countByDateCircle(pd) + "");
				// 周二
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "1"));
				lac.setTueCount(appointmentService.countByDateCircle(pd) + "");
				// 周三
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "2"));
				lac.setWedCount(appointmentService.countByDateCircle(pd) + "");
				// 周四
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "3"));
				lac.setThuCount(appointmentService.countByDateCircle(pd) + "");
				// 周五
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "4"));
				lac.setFriCount(appointmentService.countByDateCircle(pd) + "");
				// 周六
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "5"));
				lac.setSatCount(appointmentService.countByDateCircle(pd) + "");
				// 周日
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "6"));
				lac.setSunCount(appointmentService.countByDateCircle(pd) + "");
				listac.add(lac);
			}
			pd.put("wuid", "1");
			List<PageData> pdofList = workUnitAndOfficeService.oflistStatusByWuId(pd);
			if (pdofList != null && !pdofList.isEmpty()) {
				model.addAttribute("pdofList", pdofList);
			}
			List<PageData> appointment = dictionaryService.getDictionaryByName("APPOINTMENT");
			model.addAttribute("appointment", appointment);
			model.addAttribute("listac", listac);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/appointment/appoint-ment";
	}

	/**
	 * 预约列表
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/appointpagelist")
	public String getListPage(Page page, Model model) throws Exception {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			if (!pd.containsKey("fromDate") && !pd.containsKey("toDate")) {
				pd.put("fromDate", DateUtil.getDay());
				pd.put("toDate", DateUtil.getDay());
			}
			page.setShowCount(12);
			page.setPd(pd);
			List<PageData> listApps = appointmentService.getAppList(page);
			model.addAttribute("listApps", listApps);
			pd.put("wuid", "1");
			String emps = pd.getString("empList");
			if (emps != null && !emps.equals("")) {
				JSONArray jsons = new JSONArray(emps);
				List<PageData> empList = new ArrayList();
				for (int i = 0; i < jsons.length(); i++) {
					PageData pagedata = new PageData();
					JSONObject json = jsons.getJSONObject(i);
					Iterator iterator = json.keys();
					while (iterator.hasNext()) {
						String key = (String) iterator.next();
						pagedata.put(key, json.getString(key));
					}
					empList.add(pagedata);
				}
				pd.put("empList", empList);
			}
			List<PageData> pdofList = workUnitAndOfficeService.oflistStatusByWuId(pd);
			if (pdofList != null && !pdofList.isEmpty()) {
				pd.put("pdofList", pdofList);
			}
			List<PageData> appointment = dictionaryService.getDictionaryByName("APPOINTMENT");
			List<PageData> appointmentState = dictionaryService.getDictionaryByName("APPOINTMENTSTATE");
			pd.put("appointment", appointment);
			pd.put("appointmentState", appointmentState);
			model.addAttribute("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/appointment/appoint-list";
	}

	/**
	 * 新增预约界面
	 * 
	 * @return
	 */
	@RequestMapping("/appointAdd")
	public String getAddAppointPage(Model model) throws Exception {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("wuid", "1");
			List<PageData> pdofList = workUnitAndOfficeService.oflistStatusByWuId(pd);
			if (pdofList != null && !pdofList.isEmpty()) {
				model.addAttribute("pdofList", pdofList);
			}
			List<PageData> appointment = dictionaryService.getDictionaryByName("APPOINTMENT");
			model.addAttribute("appointment", appointment);
			model.addAttribute("action", "appointment/save");
			model.addAttribute("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/appointment/appoint-add";
	}

	/**
	 * 预约号发布页面
	 * 
	 * @return
	 */
	@RequestMapping("/apSetPage")
	public String goAppointSetPage(Page page, Model model) throws Exception {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("wuid", "1");
			List<PageData> pdofList = workUnitAndOfficeService.oflistStatusByWuId(pd);
			if (pdofList != null && !pdofList.isEmpty()) {
				model.addAttribute("pdofList", pdofList);
			}
			if (!pd.containsKey("officeID")) {
				pd.put("officeID", "");
			}
			if (!pd.containsKey("doctorName")) {
				pd.put("doctorName", "");
			}
			page.setShowCount(10);
			page.setPd(pd);
			// 分页
			List<PageData> empList = fREmpService.empschullistPage(page);
			if (empList != null && !empList.isEmpty()) {
				model.addAttribute("empList", empList);
			}
			// 获取所有可用的医生用户
			List<PageData> empList2 = fREmpService.getAllByStatusAndDType(pd);
			if (empList2 != null && !empList2.isEmpty()) {
				model.addAttribute("empList2", empList2);
			}

			model.addAttribute("page", page);
			model.addAttribute("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}

		return "system/appointment/iframe/appoint-set";
	}

	/**
	 * 261c70b1b145484b91bdfd0de794b787 2018-05-16
	 */
	@RequestMapping("/appointTimeBackData")
	public void getAppointTimeBD(HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String startDay = pd.getString("startDay");
			String endDay = pd.getString("endDay");
			List<PageData> pdList = new ArrayList<PageData>();
			List<PageData> pdATList = new ArrayList<PageData>();
			List<PageData> pdATList1 = new ArrayList<PageData>();
			if (startDay != null && !"".equals(startDay) && endDay != null && !"".equals(endDay)) {
				pdList = dutySchedulingService.getBackSchedulData(pd);// 获取周班表
				// 两个List数据进行合并 不要做 pdATList=pdATList2的操作
				if (pdList != null && !pdList.isEmpty()) {
					result.put("data", pdList);
					for (PageData pdl : pdList) {
						pdATList = workAppointTimeService.getAppointTimeByCons(pdl);// 获取医生指定日期可预约时间段
						if (pdATList != null && !pdATList.isEmpty()) {
							PageData pd2 = new PageData();
							StringBuffer sb = new StringBuffer();
							for (PageData pD : pdATList) {
								sb.append(pD.getString("AppointStartTime")).append("-")
										.append(pD.getString("AppointEndTime"))
										.append("(间隔" + pD.getInteger("TimeInterval") + "分钟)<br/>");
							}
							// pd1.put("AppointNoID", pdl.getString("AppointNoID"));
							pd2.put("DocTorID", pdl.getString("Emp_ID"));
							pd2.put("DocTorName", pdl.getString("E_Name"));
							// pd1.put("TimeInterval", pdl.getString("TimeInterval"));
							pd2.put("SaveDay", pdl.getString("SaveDay"));
							pd2.put("DutyDate", pdl.getString("DutyDate"));
							pd2.put("ValueID", pdl.getString("ValueID"));
							pd2.put("TimeText", sb.toString());
							pdATList1.add(pd2);
						}
					}
					result.put("appData", pdATList1);
				}
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 预约单条设置
	 * 
	 * @param empId
	 * @param empName
	 * @param dateT
	 * @param valueId
	 * @param saveDay
	 * @param array
	 * @param response
	 */
	@RequestMapping("/saveOne")
	public void saveOne(String empId, String empName, String dateT, String valueId, String saveDay, String arrayJson,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<>();
		try {
			// 记得做重复提交验证操作

			// 保存操作
			List<TimeIntervalVo> volist = new ArrayList<>();
			if (arrayJson != null && !"".equals(arrayJson)) {
				volist = JsonUtil.json2List(TimeIntervalVo.class, arrayJson);
				if (volist != null && !volist.isEmpty()) {
					// 删除操作
					PageData dpd = new PageData();
					dpd.put("DocTorID", empId);
					dpd.put("DutyDate", dateT);
					workAppointTimeService.deleteByEAndD(dpd);
					// 循环保存
					for (TimeIntervalVo vo : volist) {
						PageData pd = new PageData();
						pd.put("AppointNoID", this.get32UUID().toString());
						if (empId != null && !"".equals(empId)) {
							pd.put("DocTorID", empId);
						}
						pd.put("DocTorName", empName);
						if (dateT != null && !"".equals(dateT)) {
							pd.put("DutyDate", dateT);
						}
						if (valueId != null && !"".equals(valueId)) {
							pd.put("ValueID", valueId);
						}
						if (saveDay != null && !"".equals(saveDay)) {
							pd.put("SaveDay", saveDay);
						}
						if (vo.getStartTime() != null && !"".equals(vo.getStartTime())) {
							pd.put("AppointStartTime", vo.getStartTime());
						}
						if (vo.getEndTime() != null && !"".equals(vo.getEndTime())) {
							pd.put("AppointEndTime", vo.getEndTime());
						}
						if (vo.getInterTime() != null && !"".equals(vo.getInterTime())) {
							pd.put("TimeInterval", vo.getInterTime());
						}
						int count = DateUtil.getCount(vo.getStartTime(), vo.getEndTime(),
								Integer.parseInt(vo.getInterTime()));
						pd.put("AppointTickets", count);
						int success = workAppointTimeService.saveOneApTime(pd);
						if (success == 1) {
							result.put("status", "success");
						}
					}
				} else {
					result.put("status", "emptyData");
				}
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("status", "faile");
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 批量设置
	 * 
	 * @param startDate
	 * @param endDate
	 * @param intervalTime
	 * @param arrayJson
	 * @param response
	 */
	@RequestMapping("/saveList")
	public void saveList(String startDate, String endDate, Integer intervalTime, String arrayJson,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<>();
		try {
			if (arrayJson != null && !"".equals(arrayJson)) {
				ObjectMapper objectMapper = new ObjectMapper();
				List<Map<String, Object>> arrayList = objectMapper.readValue(arrayJson, List.class);
				if (arrayList != null && !arrayList.isEmpty()) {
					for (Map<String, Object> map : arrayList) {// 第1次循环
						String empID = (String) map.get("empId");
						PageData pd = new PageData();
						pd.put("startDate", startDate);
						pd.put("endDate", endDate);
						pd.put("empID", empID);
						List<PageData> pdlist = dutySchedulingService.getSchedulRecordByCons(pd);
						if (pdlist != null && !pdlist.isEmpty()) {
							for (PageData dspd : pdlist) {// 排班表 第二次循环
								int shiftID = dspd.getInteger("DutyTypeID");
								String empName = dspd.getString("E_Name");
								String dateT = dspd.getString("DutyDate");
								String valueId = dspd.getString("ValueID");
								String saveDay = dspd.getString("SaveDay");
								List<PageData> spdlist = shiftService.getDataByCons(shiftID);
								if (spdlist != null && !spdlist.isEmpty()) {
									for (PageData spd : spdlist) {// 规则表 第三次循环
										String startTime = spd.getString("StartTime");
										int slength = startTime.length();
										startTime = startTime.substring(0, slength - 3);
										String endTime = spd.getString("EndTime");
										int elength = endTime.length();
										endTime = endTime.substring(0, slength - 3);
										int isCrossDay = spd.getInteger("CrossDayType");
										int count = 0;
										PageData pdsave = new PageData();
										pdsave.put("AppointNoID", this.get32UUID().toString());
										pdsave.put("DocTorID", empID);
										pdsave.put("DocTorName", empName);
										pdsave.put("DutyDate", dateT);
										pdsave.put("ValueID", valueId);
										pdsave.put("SaveDay", saveDay);
										pdsave.put("AppointStartTime", startTime);
										if (isCrossDay != 1) {
											pdsave.put("AppointEndTime", endTime);
										} else {
											pdsave.put("AppointEndTime", "23:59");
										}
										pdsave.put("TimeInterval", intervalTime);
										count = DateUtil.getCount(startTime, pdsave.getString("AppointEndTime"),
												intervalTime);
										pdsave.put("AppointTickets", count);
										int success = workAppointTimeService.saveOneApTime(pdsave);
										if (success == 1) {
											result.put("status", "success");
										}
									}
								}
							}
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
	 * 修改预约号时间段
	 * 
	 * @param response
	 */
	@RequestMapping("/edit/setTime")
	public void editAppSetTime(String docID, String dutyDate, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<>();
		try {
			PageData pd = new PageData();
			pd.put("Emp_ID", docID);
			pd.put("DutyDate", dutyDate);
			List<PageData> pdlist = workAppointTimeService.getAppointTimeByCons(pd);
			if (pdlist != null && !pdlist.isEmpty()) {
				for (int i = 0; i < pdlist.size(); i++) {
					PageData pagedata = pdlist.get(i);
					PageData pddata = new PageData();
					pddata.put("startAppointTime", pagedata.getString("AppointStartTime"));
					pddata.put("endAppointTime", pagedata.getString("AppointEndTime"));
					pddata.put("Emp_ID", pagedata.getString("DocTorID"));
					pddata.put("appointmentDate", pagedata.getString("DutyDate"));
					int num = appointmentService.countByDateCircle(pddata);
					if (num == 0) {
						pagedata.put("disabled", false);
					} else {
						pagedata.put("disabled", true);
					}
					pdlist.set(i, pagedata);
				}
				result.put("data", pdlist);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 根据条件删除预约号
	 * 
	 * @param docID
	 * @param dutyDate
	 * @param response
	 */
	@RequestMapping("/del/setTime")
	public void delAppSetTime(String docID, String dutyDate, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<>();
		try {
			PageData pd = new PageData();
			pd.put("DocTorID", docID);
			pd.put("DutyDate", dutyDate);
			// 做是否有预约票字段已经被使用验证
			int count = appointmentService.countByDateAndEmpID(pd);
			if (count == 0) {
				// 该组预约号没有被使用可以删除
				workAppointTimeService.deleteByEAndD(pd);
				result.put("status", "success");
			} else {
				// 有预约号被领取不能删除
				result.put("status", "cannotdel");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("status", "faile");
		}
	}

	/**
	 * 保存新增预约
	 * 
	 * @author wyp
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(Model model) throws Exception {
		String url = "";
		String data="";
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			url = pd.getString("url");
			data=new String(pd.getString("patient").getBytes("iso-8859-1"), "utf-8");
			String id = pd.getString("Appointment_ID");
			if (id.equals("") || id == null) {
				id = this.get32UUID();
				pd.put("Appointment_ID", id);
				pd.put("AppointmentStatus", "0");
				pd.put("Appointment_Code", id);
				pd.put("CreateDateTime", DateUtil.getTime());
				if (appointmentService.countTime(pd) == 0) {
					appointmentService.save(pd);
					model.addAttribute("msg", "新增预约成功！");
				} else {
					model.addAttribute("msg", "该号已被预约，请选择其他时间！");
				}

			} else {
				appointmentService.update(pd);
				model.addAttribute("msg", "修改预约成功！");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("msg", "保存失败");
		}
		if (url.equals("")) {
			return yuyue(model);
		} else {
			Map map = new HashMap();
			PageData pageData=new PageData();
			if (!data.equals("")) {
				data=data.substring(1,data.length()-1).replaceAll(" ", "");
				String[] datas=data.split(",");
				for (int i = 0; i < datas.length; i++) {
					String[] dataS=datas[i].split("=");
					if (dataS.length==1) {
						pageData.put(dataS[0], "");
					} else {
						pageData.put(dataS[0], dataS[1]);
					}
				}
			}
			model.addAttribute("data", pageData);
			return "system/patient/view/patient_view";
		}

	}

	/**
	 * 按周查询每个小时预约人数
	 * 
	 * @author wyp
	 * @param firstday
	 * @param response
	 */
	@RequestMapping(value = "refresh")
	public void refresh(String firstday, String OfficeID, String Emp_ID, HttpServletRequest request,
			HttpServletResponse response) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			List<ListAppointCout> listac = new ArrayList<ListAppointCout>();
			List<String> listS = appointmentService.timeCirle();
			String mondayDate = firstday;
			pd.put("OfficeID", OfficeID);
			pd.put("Emp_ID", Emp_ID);
			for (int i = 0; i < listS.size(); i++) {
				ListAppointCout lac = new ListAppointCout();
				lac.setTimeD(listS.get(i));
				pd.put("startAppointTime", listS.get(i));
				if (i < (listS.size() - 1)) {
					pd.put("endAppointTime", listS.get(i + 1));
				} else if (i == (listS.size() - 1)) {
					pd.put("endAppointTime", listS.get(i));
				}
				// 周一
				pd.put("appointmentDate", mondayDate);
				lac.setMonCount(appointmentService.countByDateCircle(pd) + "");
				// 周二
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "1"));
				lac.setTueCount(appointmentService.countByDateCircle(pd) + "");
				// 周三
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "2"));
				lac.setWedCount(appointmentService.countByDateCircle(pd) + "");
				// 周四
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "3"));
				lac.setThuCount(appointmentService.countByDateCircle(pd) + "");
				// 周五
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "4"));
				lac.setFriCount(appointmentService.countByDateCircle(pd) + "");
				// 周六
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "5"));
				lac.setSatCount(appointmentService.countByDateCircle(pd) + "");
				// 周日
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "6"));
				lac.setSunCount(appointmentService.countByDateCircle(pd) + "");
				listac.add(lac);
			}
			RenderUtil.renderJson(listac, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 根据日期时间获取预约信息
	 * 
	 * @author wyp
	 * @param startAppointTime
	 * @param endAppointTime
	 * @param appointmentDate
	 * @param response
	 */
	@RequestMapping(value = "getAppByTime")
	public void getAppByTime(@RequestParam String startAppointTime, @RequestParam String endAppointTime,
			@RequestParam String appointmentDate, HttpServletResponse response) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("startAppointTime", startAppointTime);
			pd.put("endAppointTime", endAppointTime);
			pd.put("appointmentDate", appointmentDate);
			List<PageData> listApp = appointmentService.getAppByTime(pd);
			RenderUtil.renderJson(listApp, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 预约日历跳转至预约修改
	 * 
	 * @author wyp
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "editApp")
	public String editApp(HttpServletRequest request, Model model) throws Exception {
		try {
			String data = new String(request.getParameter("data").getBytes("iso-8859-1"), "utf-8");
			String view = request.getParameter("view");
			model.addAttribute("data", data);
			model.addAttribute("view", view);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return getAddAppointPage(model);
	}

	/**
	 * 取消预约
	 * 
	 * @author wyp
	 * @param Appointment_ID
	 * @param out
	 */
	@RequestMapping(value = "delete")
	public void delete(String Appointment_ID, PrintWriter out) {
		try {
			appointmentService.delete(Appointment_ID);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 获取可用的预约号
	 * 
	 * @author wyp
	 * @param Emp_ID
	 * @param Appointment_Date
	 * @param response
	 */
	@RequestMapping(value = "getTimes")
	public void getTimes(String Emp_ID, String Appointment_Date, HttpServletResponse response) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("DutyDate", Appointment_Date);
			List<PageData> appTime = workAppointTimeService.getAppointTimeByCons(pd);
			List<String> timesMsg = new ArrayList<String>();
			for (int i = 0; i < appTime.size(); i++) {
				PageData appoint = appTime.get(i);
				String start = appoint.getString("AppointStartTime");
				String end = appoint.getString("AppointEndTime");
				int interval = appoint.getInteger("TimeInterval");
				List<String> time = DateUtil.getAllTimeMsg(start, end, interval);
				timesMsg.addAll(time);
			}
			List<String> timesUsed = appointmentService.getTimes(pd);
			for (int i = 0; i < timesUsed.size(); i++) {
				String time = timesUsed.get(i);
				time = time.substring(0, time.length() - 3);
				for (int j = 0; j < timesMsg.size(); j++) {
					if (timesMsg.get(j).equals(time)) {
						timesMsg.remove(j);
						break;
					}
				}
			}
			RenderUtil.renderJson(timesMsg, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 根据日期与emp_ID获取每日预约人数
	 * 
	 * @author wyp 2018年6月11日
	 * @param response
	 */
	@RequestMapping("countAppointByTimes")
	public void countAppointByTimes(HttpServletResponse response) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String[] emps = pd.getString("empIDs").split(",");
			pd.put("emps", emps);
			List<PageData> appointList = appointmentService.countAppointByTimes(pd);
			RenderUtil.renderJson(appointList, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 今日预约
	 * 
	 * @author wyp 2018年6月21日
	 * @param page
	 * @param model
	 * @return
	 */
	@RequestMapping("appointToday")
	public String appointToday(Page page, Model model) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("appointmentDate", DateUtil.getDay());
			pd.put("startAppointTime", "00:00:00");
			pd.put("endAppointTime", "23:59:59");
			page.setShowCount(12);
			page.setPd(pd);
			// 分页
			List<PageData> appointmentList = appointmentService.getTodayAppoint(page);
			if (appointmentList != null && !appointmentList.isEmpty()) {
				model.addAttribute("appointmentList", appointmentList);
			}
			model.addAttribute("page", page);
			model.addAttribute("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/appointment/iframe/appoint-today";
	}

	/**
	 * 修改预约状态
	 * 
	 * @author wyp 2018年6月26日
	 * @param out
	 */
	@RequestMapping("updateAppintStatus")
	public void updateAppintStatus(PrintWriter out) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			appointmentService.updateAppintStatus(pd);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
}
