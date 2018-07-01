package com.yangzi.fullR.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.service.AppointmentService;
import com.yangzi.fullR.service.DutySchedulingService;
import com.yangzi.fullR.service.FREmpService;
import com.yangzi.fullR.service.ShiftService;
import com.yangzi.fullR.service.WorkUnitAndOfficeService;
import com.yangzi.fullR.util.DateUtil;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;

@Controller
@RequestMapping(value = "/scheduling")
public class SchedulingController extends BaseController {

	@Autowired
	private WorkUnitAndOfficeService workUnitAndOfficeService;

	@Autowired
	private FREmpService fREmpService;

	@Autowired
	private ShiftService shiftService;

	@Autowired
	private DutySchedulingService dutySchedulingService;

	@Autowired
	private AppointmentService appointmentService;

	/**
	 * 排班界面
	 * 
	 */
	@RequestMapping(value = "/listschedulings")
	public String paiban(Page page, Model model) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("wuid", "1");
			String officeID = pd.getString("officeID");
			String doctorName = pd.getString("doctorName");
			List<PageData> pdofList = workUnitAndOfficeService.oflistStatusByWuId(pd);
			if (pdofList != null && !pdofList.isEmpty()) {
				model.addAttribute("pdofList", pdofList);
			}
			page.setShowCount(20);
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
			pd.put("status", "0");
			List<PageData> shiftList = shiftService.getAllStatus(pd);
			if (shiftList != null && !shiftList.isEmpty()) {
				model.addAttribute("shiftList", shiftList);
			}

			// model.addAttribute("officeID", officeID);
			// model.addAttribute("doctorName", doctorName);
			model.addAttribute("page", page);
			model.addAttribute("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/appointment/paiban";
	}

	/**
	 * 获取回显数据 lzd
	 */
	@RequestMapping("/schedulBackData")
	public void getRebackScheduling(HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String startDay = pd.getString("startDay");
			String endDay = pd.getString("endDay");
			List<PageData> pdList = new ArrayList<PageData>();
			if (startDay != null && !"".equals(startDay) && endDay != null && !"".equals(endDay)) {
				pdList = dutySchedulingService.getBackSchedulData(pd);
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if (pdList != null && pdList.size() > 0) {
					Date start = formatter.parse(startDay + " 00:00:00");
					Date end = formatter.parse(endDay + " 23:59:59");
					Date now = new Date();
					if (start.getTime() <= now.getTime() && now.getTime() <= end.getTime()) {
						for (int i = 0; i < pdList.size(); i++) {
							PageData pagedata = pdList.get(i);
							Date DutyDate = formatter.parse(pagedata.getString("DutyDate") + " 23:59:59");
							if (DutyDate.getTime() >= now.getTime()) {
								PageData pddata = new PageData();
								pddata.put("DocTorID", pagedata.getString("Emp_ID"));
								pddata.put("DutyDate", pagedata.getString("DutyDate"));
								int num = appointmentService.countByDateAndEmpID(pddata);
								if (num == 0) {
									pagedata.put("disabled", false);
								} else {
									pagedata.put("disabled", true);
								}
								pdList.set(i, pagedata);
							}
						}
					}
					result.put("data", pdList);
				}
			}

		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 添加排班与更新
	 * 
	 * @param empid
	 * @param shiftId
	 * @param dateT
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/saveDoctorS")
	public void saveDoctorS(HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			PageData pd = new PageData();
			PageData pemp = new PageData();
			PageData pshift = new PageData();
			pd = this.getPageData();
			String empid = pd.getString("empid");
			String shiftId = pd.getString("shiftId");
			String dateT = pd.getString("dateT");
			String valueID = pd.getString("valueId");
			String saveDay = pd.getString("saveDay");
			if (shiftId != null && !"".equals(shiftId)) {
				pd.put("shiftId", shiftId);
				pshift = shiftService.getShiftById(pd);
			}
			pd = dutySchedulingService.getSchedulingByCons(pd);
			// 更新与创建判断
			if (pd != null && !"".equals(pd.getString("Duty_ID")) && pshift != null) {
				// 更新操作
				if (!pshift.isEmpty()) {
					pd.put("DutyTypeID", pshift.getInteger("ShiftID"));
					pd.put("DutyTypeName", pshift.getString("ShiftName"));
					pd.put("CreateDateTime", sdf.format(new Date()));
					int upsuc = dutySchedulingService.updateSchedul(pd);
					if (upsuc == 1) {
						result.put("status", "upsuccess");
					}
				} else {
					// 空白考勤规则删除操作
					int upsuc = dutySchedulingService.deleteSchedul(pd);
					if (upsuc == 1) {
						result.put("status", "upsuccess");
					}
				}
			} else {// 保存操作
				if (empid != null && !"".equals(empid)) {
					pemp = fREmpService.getEmpByID(empid);
				}
				pd = new PageData();
				String duty_id = this.get32UUID().toString();
				if (pemp != null && pshift != null) {
					pd.put("Duty_ID", duty_id);
					pd.put("Emp_ID", pemp.getString("Emp_ID"));
					pd.put("E_Name", pemp.getString("E_Name"));
					pd.put("CreateDateTime", sdf.format(new Date()));
					pd.put("DutyDate", dateT);
					pd.put("DutyTypeID", pshift.getInteger("ShiftID"));
					pd.put("DutyTypeName", pshift.getString("ShiftName"));
					pd.put("ValueID", valueID);
					pd.put("SaveDay", saveDay);
				}
				int success = dutySchedulingService.save(pd);
				if (success == 1) {
					result.put("status", "success");
				}
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
			result.put("status", "faile");
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 复制上周排班表 lzd 20180604改 2018-06-27 wyp改
	 * 
	 * @param response
	 * @throws Exception
	 *             lzd
	 */
	@RequestMapping("/copyLastSchedul")
	public void copyLastWeekSchedul(HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			SimpleDateFormat dateConver = new SimpleDateFormat("yyyy-MM-dd");
			PageData pd = new PageData();
			pd = this.getPageData();
			String nowMonDay = pd.getString("nowMonDay");
			String nowSunDay = pd.getString("nowSunDay");
			String[] Emp_ID = pd.getString("emp_ID").split(",");// 医生ID（删除当前周排班使用）
			pd.put("Emp_ID", Emp_ID);
			List<PageData> pdLastList = new ArrayList<PageData>();
			if (nowMonDay != null && !"".equals(nowMonDay) && nowSunDay != null && !"".equals(nowSunDay)) {
				// 当前日期之前班表不能修改
				if (new Date().after(dateConver.parse(nowMonDay))) {
					nowMonDay = DateUtil.getDay();
				}
				pd.put("startDate", nowMonDay);
				pd.put("endDate", nowSunDay);
				dutySchedulingService.deleteS(pd);// 删除当前周班表
				pd.put("startDate", DateUtil.getAfterDayDate2(nowMonDay, "-7"));
				pd.put("endDate", DateUtil.getAfterDayDate2(nowSunDay, "-7"));
				// 获取上周医生排班表
				pdLastList = dutySchedulingService.getScheduls(pd);
				// 进行复制保存
				if (pdLastList != null) {
					for (PageData pdlast : pdLastList) {
						String dateT = DateUtil.getAfterDayDate2(pdlast.getString("DutyDate"), "7");
						String empID = pdlast.getString("Emp_ID");
						pd = new PageData();
						String duty_ID = this.get32UUID().toString();
						pd.put("Duty_ID", duty_ID);
						pd.put("Emp_ID", empID);
						pd.put("E_Name", pdlast.getString("E_Name"));
						pd.put("CreateDateTime", sdf.format(new Date()));
						pd.put("DutyDate", dateT);
						pd.put("DutyTypeID", pdlast.getInteger("DutyTypeID"));
						pd.put("DutyTypeName", pdlast.getString("DutyTypeName"));
						pd.put("ValueID", pdlast.getString("ValueID"));
						pd.put("SaveDay", pdlast.getString("SaveDay"));
						int suc = dutySchedulingService.save(pd);
						// if(suc!=1){
						// //失败人员提醒
						// }
					}
				}
				result.put("status", "success");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 月排班 2018年6月4日
	 * 
	 * @author wyp
	 * @param page
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "paibanM")
	public String paibanM(Page page, Model model) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("wuid", "1");
			List<PageData> pdofList = workUnitAndOfficeService.oflistStatusByWuId(pd);
			if (pdofList != null && !pdofList.isEmpty()) {
				model.addAttribute("pdofList", pdofList);
			}
			// 获取所有可用的医生用户
			List<PageData> empList2 = fREmpService.getAllByStatusAndDType(pd);
			if (empList2 != null && !empList2.isEmpty()) {
				model.addAttribute("empList2", empList2);
			}
			page.setShowCount(5000);
			page.setPd(pd);
			List<PageData> empList = fREmpService.empschullistPage(page);
			if (empList != null && !empList.isEmpty()) {
				model.addAttribute("empList", empList);
			}
			pd.put("status", "0");
			List<PageData> shiftList = shiftService.getAllStatus(pd);
			if (shiftList != null && !shiftList.isEmpty()) {
				model.addAttribute("shiftList", shiftList);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/appointment/paiban_month";
	}

	/**
	 * 月排班搜索 2018年6月4日
	 * 
	 * @author wyp
	 * @param Emp_ID
	 * @param OfficeID
	 * @param response
	 */
	@RequestMapping(value = "searchM")
	public void searchM(HttpServletResponse response) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("wuid", "1");
			Page page = new Page();
			page.setShowCount(5000);
			page.setPd(pd);
			List<PageData> empList = fREmpService.empschullistPage(page);
			RenderUtil.renderJson(empList, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 批量排班 2018年6月4日
	 * 
	 * @author wyp
	 * @param data
	 * @param out
	 */
	@RequestMapping(value = "updateM")
	public void updateM(HttpServletRequest request, PrintWriter out) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			String data = new String(request.getParameter("data").getBytes("iso-8859-1"), "utf-8");
			JSONArray array = new JSONArray(data);
			if (array != null && array.length() > 0) {
				for (int i = 0; i < array.length(); i++) {
					JSONObject json = array.getJSONObject(i);
					PageData pd = new PageData();
					if (json != null && json.length() > 0) {
						Iterator iterator = json.keys();
						while (iterator.hasNext()) {
							String key = (String) iterator.next();
							pd.put(key, json.getString(key));
						}
						if (pd.getString("DutyTypeID") != null && !pd.getString("DutyTypeID").equals("")) {
							if (json.length() > 3) {
								String duty_id = this.get32UUID().toString();
								pd.put("Duty_ID", duty_id);
								pd.put("CreateDateTime", sdf.format(new Date()));
								dutySchedulingService.save(pd);
							} else {
								pd.put("CreateDateTime", sdf.format(new Date()));
								dutySchedulingService.updateSchedul(pd);
							}
						} else {
							dutySchedulingService.deleteSchedul(pd);
						}
					}
				}
			}
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 复制上月班表
	 * 
	 * @author wyp 2018年6月4日
	 * @param fromDate
	 * @param toDate
	 * @param lastFromDate
	 * @param lastToDate
	 * @param emps
	 * @param size
	 * @param out
	 */
	@RequestMapping(value = "copyM")
	public void copyM(String fromDate, String toDate, String lastFromDate, String lastToDate, String emps, int size,
			PrintWriter out) {
		try {
			if (emps != null && !emps.equals("")) {
				if (size > 0) {
					String[] empID = emps.split(",");
					PageData pd = new PageData();// 当月班表
					PageData lpd = new PageData();// 上月班表
					SimpleDateFormat dateConver = new SimpleDateFormat("yyyy-MM-dd");
					// 小于当前日期时间不能修改
					if (new Date().after(dateConver.parse(fromDate))) {
						fromDate = DateUtil.getDay();
					}
					lastFromDate = DateUtil.getDateAfterMonth(fromDate, -1);
					//判断当前日期跟当前日期的上月日期是否匹配（如：fromDate='2018-05-31',则lastFromDate='2018-04-30',则不复制）
					if (DateUtil.getYearMonthDate(fromDate, 5) <= DateUtil.getYearMonthDate(lastFromDate, 5)) {
						pd.put("startDate", fromDate);
						pd.put("endDate", toDate);
						pd.put("Emp_ID", empID);
						lpd.put("startDate", lastFromDate);
						lpd.put("endDate", lastToDate);
						lpd.put("Emp_ID", empID);
						List<PageData> lpdList = dutySchedulingService.getScheduls(lpd);
						if (lpdList == null || lpdList.size() == 0) {
							dutySchedulingService.deleteS(pd);
						} else {
							List<PageData> pdList = dutySchedulingService.getScheduls(pd);
							if (pdList == null || pdList.size() == 0) {
								for (int i = 0; i < lpdList.size(); i++) {
									PageData duty = lpdList.get(i);
									save(duty);
								}
							} else {
								int length = pdList.size() - 1;
								for (int i = length; i >= 0; i--) {
									PageData duty = pdList.get(i);
									for (int j = 0; j < lpdList.size(); j++) {
										PageData lduty = lpdList.get(j);
										if (duty.getString("Emp_ID").equals(lduty.getString("Emp_ID"))
												&& duty.getString("DutyDate").equals(
														DateUtil.getDateAfterMonth(lduty.getString("DutyDate"), 1))) {
											duty.put("DutyTypeID", lduty.getInteger("DutyTypeID"));
											duty.put("DutyTypeName", lduty.getString("DutyTypeName"));
											duty.put("CreateDateTime", DateUtil.getTime());
											dutySchedulingService.updateSchedul(duty);
											lpdList.remove(lduty);
											pdList.remove(duty);
											break;
										}
									}
								}
								for (int i = 0; i < lpdList.size(); i++) {
									PageData duty = lpdList.get(i);
									save(duty);
								}
								for (int i = 0; i < pdList.size(); i++) {
									PageData duty = pdList.get(i);
									dutySchedulingService.deleteSchedul(duty);
								}
							}
						}
					}
				}

			}
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 根据上月日期的排班生成该月日期的排班
	 * 
	 * @author wyp 2018年6月4日
	 * @param duty
	 * @throws Exception
	 */
	public void save(PageData duty) throws Exception {
		String date = duty.getString("DutyDate");
		String[] week = DateUtil.getWeek(date);
		duty.put("Duty_ID", this.get32UUID());
		duty.put("CreateDateTime", DateUtil.getTime());
		duty.put("DutyDate", DateUtil.getDateAfterMonth(date, 1));
		duty.put("ValueID", week[1] + duty.getString("Emp_ID"));
		duty.put("SaveDay", week[0]);
		dutySchedulingService.save(duty);
	}

	/**
	 * 排班表
	 * 
	 * @author wyp 2018年6月5日
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "doctorSchedual")
	public String doctorSchedual(Model model) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("wuid", "1");
			List<PageData> pdofList = workUnitAndOfficeService.oflistStatusByWuId(pd);
			if (pdofList != null && !pdofList.isEmpty()) {
				model.addAttribute("pdofList", pdofList);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/workStation/doctor_schedual";
	}

	/**
	 * 根据医生ID与起止日期获得排班
	 * 
	 * @author wyp 2018年6月5日
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/getSchedulByEmpID")
	public void getSchedulByEmpID(HttpServletResponse response) throws Exception {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			List<PageData> pdList = dutySchedulingService.getSchedulRecordByCons(pd);
			RenderUtil.renderJson(pdList, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 获取指定时间内指定医生的排班
	 * 
	 * @author wyp 2018年6月11日
	 * @param response
	 */
	@RequestMapping("getScheduls")
	public void getScheduls(HttpServletResponse response) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String[] empID = pd.getString("emps").split(",");
			pd.put("Emp_ID", empID);
			List<PageData> schedulList = dutySchedulingService.getScheduls(pd);
			RenderUtil.renderJson(schedulList, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

}
