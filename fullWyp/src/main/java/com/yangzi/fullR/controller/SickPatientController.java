package com.yangzi.fullR.controller;

import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.service.AppointmentService;
import com.yangzi.fullR.service.SickPatientService;
import com.yangzi.fullR.util.DateUtil;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;

@Controller
@RequestMapping(value = "/sickPatient")
public class SickPatientController extends BaseController {
	@Autowired
	private SickPatientService sickPatientService;
	@Autowired
	private RegisterController registerController;
	@Autowired
	private AppointmentController appointmentController;
	@Autowired
	private AppointmentService appointmentService;

	@RequestMapping(value = "/getPatientByName")
	public void getPatientByName(String PatientName, HttpServletResponse response) {
		try {
			List<PageData> patients = sickPatientService.getPatientByName(PatientName);
			for (int i = 0; i < patients.size(); i++) {
				PageData page = patients.get(i);
				page.remove("CreateDateTime");
				patients.set(i, page);
			}
			if (patients != null && !patients.isEmpty()) {
				RenderUtil.renderJson(patients, response);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 病人列表
	 * 
	 * @author wyp
	 * @param page
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "getPatients")
	public String getPatients(Page page, Model model) {
		try {
			PageData pd = new PageData();
			if (!model.containsAttribute("msg")) {
				pd = this.getPageData();
			}
			String time = pd.getString("time");
			if (null != time && !"".equals(time)) {
				String[] times = time.split(" - ");
				pd.put("fromTime", times[0]);
				pd.put("toTime", times[1]);
			} else {
				pd.put("time", "");
			}
			page.setPd(pd);
			List<PageData> patients = sickPatientService.getPatients(page);
			model.addAttribute("patients", patients);
			model.addAttribute("pd", pd);
			model.addAttribute("action", "sickPatient/getPatients");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/patient/patient_list";
	}

	/**
	 * 编辑病人
	 * 
	 * @author wyp
	 * @param data
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "editPatient")
	public String editPatient(HttpServletRequest request, Model model) {
		try {
			String data = new String(request.getParameter("data").getBytes("iso-8859-1"), "utf-8");
			model.addAttribute("data", data);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return registerController.dengji(model);
	}

	/**
	 * 新增预约
	 * 
	 * @author wyp
	 * @param data
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "appoint")
	public String appoint(HttpServletRequest request, Model model) throws Exception {
		try {
			String data = new String(request.getParameter("data").getBytes("iso-8859-1"), "utf-8");
			model.addAttribute("data", data);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return appointmentController.getAddAppointPage(model);
	}

	/**
	 * 删除病人
	 * 
	 * @author wyp
	 * @param PatientID
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "deletePatient")
	public void deletePatient(String PatientID, PrintWriter out) {
		try {
			sickPatientService.delete(PatientID);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 病人库查看页面
	 * 
	 * @author wyp
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "view")
	public String view(String data, Model model) {
		try {
			PageData pd = new PageData();
			PageData pageData = new PageData();
			pageData=this.getPageData();
			data = new String(data.getBytes("iso-8859-1"), "utf-8");
			JSONObject json = new JSONObject(data);
			Iterator iterator = json.keys();
			while (iterator.hasNext()) {
				String key = (String) iterator.next();
				pd.put(key, json.getString(key));
			}
			model.addAttribute("data", pd);
			model.addAttribute("pd", pageData);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/patient/view/patient_view";
	}

	/**
	 * 根据病人ID查看所有预约信息
	 * 
	 * @author wyp
	 * @param page
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "view/appointments")
	public String appointments(Page page, Model model) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			if (pd.containsKey("data")) {
				pd.put("data", new String(pd.getString("data").getBytes("iso-8859-1"), "utf-8"));
			}else {
				pd.put("data", new String(pd.getString("patient").getBytes("iso-8859-1"), "utf-8"));
			}
			page.setShowCount(10);
			page.setPd(pd);
			List<PageData> apps = appointmentService.getAppByPatient(page);
			model.addAttribute("page", page);
			model.addAttribute("apps", apps);
			model.addAttribute("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/patient/view/patient-appointments";
	}

	/**
	 * 登记记录
	 * 
	 * @author wyp 2018年6月22日
	 * @param page
	 * @param model
	 * @return
	 */
	@RequestMapping("registerlistPage")
	public String registerlistPage(Page page, Model model) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			if (!pd.containsKey("fromTime") && !pd.containsKey("toTime")) {
				String fromTime = DateUtil.getDay() + " 00:00:00";
				pd.put("fromTime", fromTime);
				pd.put("toTime", DateUtil.getAfterDayDate2(fromTime, "1") + " 00:00:00");
			}
			String patientName = pd.getString("PatientName");
			if (patientName != null && !patientName.equals("")) {
				if (patientName.equals(new String(patientName.getBytes("iso-8859-1"), "iso-8859-1"))) {
					patientName = new String(patientName.getBytes("iso-8859-1"), "UTF-8");
					pd.put("PatientName", patientName);
				}
			}
			page.setShowCount(12);
			page.setPd(pd);
			List<PageData> sickList = sickPatientService.registerlistPage(page);
			model.addAttribute("page", page);
			model.addAttribute("pd", pd);
			model.addAttribute("sickList", sickList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/appointment/iframe/sickPatient-today";
	}

	/**
	 * 手机号或卡号查找
	 * 
	 * @author wyp 2018年6月25日
	 * @param cardCode
	 * @param response
	 */
	@RequestMapping("getByPhoneOrCard")
	public void getByPhoneOrCard(String cardCode, HttpServletResponse response) {
		try {
			List<PageData> patientList = sickPatientService.getByPhoneOrCard(cardCode);
			for (int i = 0; i < patientList.size(); i++) {
				PageData pd = patientList.get(i);
				pd.remove("CreateDateTime");
				patientList.set(i, pd);
			}
			RenderUtil.renderJson(patientList, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
}
