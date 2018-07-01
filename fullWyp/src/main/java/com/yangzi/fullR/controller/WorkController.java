package com.yangzi.fullR.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.vo.ListAppointCout;
import com.yangzi.fullR.service.AppointmentService;
import com.yangzi.fullR.service.DutySchedulingService;
import com.yangzi.fullR.service.FREmpService;
import com.yangzi.fullR.service.WorkService;
import com.yangzi.fullR.service.WorkUnitAndOfficeService;
import com.yangzi.fullR.util.DateUtil;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;

@Controller
@RequestMapping(value = "/work")
public class WorkController extends BaseController {

	@Autowired
	private WorkService workService;
	@Autowired
	private AppointmentService appointmentService;
	@Autowired
	private WorkUnitAndOfficeService workUnitAndOfficeService;
	@Autowired
	private FREmpService fREmpService;

	@RequestMapping("")
	public String list(Model model) throws Exception {
		try {

		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/workStation/work_station";
	}

	/**
	 * 医生工作台
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/doctor")
	public String docStation(Model model) throws Exception {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
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
				lac.setMonCount("0");// 方法未写
				// 周二
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "1"));
				lac.setTueCount("0");
				// 周三
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "2"));
				lac.setWedCount("0");
				// 周四
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "3"));
				lac.setThuCount("0");
				// 周五
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "4"));
				lac.setFriCount("0");
				// 周六
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "5"));
				lac.setSatCount("0");
				// 周日
				pd.put("appointmentDate", DateUtil.getAfterDayDate2(mondayDate, "6"));
				lac.setSunCount("0");
				listac.add(lac);
			}
			model.addAttribute("listac", listac);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/workStation/doctor_station";
	}

	/**
	 * 护士工作台
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/nurse")
	public String nurStation() throws Exception {

		return "system/workStation/nurse_station";
	}

	/**
	 * 前台工作站
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/proscenium")
	public String pmcStation(Model model) throws Exception {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("wuid", "1");
			List<PageData> pdofList = workUnitAndOfficeService.oflistStatusByWuId(pd);
			if (pdofList != null && !pdofList.isEmpty()) {
				model.addAttribute("pdofList", pdofList);
			}
			List<PageData> empList2 = fREmpService.getAllByStatusAndDType(pd);
			if (empList2 != null && !empList2.isEmpty()) {
				model.addAttribute("empList2", empList2);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/workStation/pm_station";
	}

	@RequestMapping("/getSchedulsPage")
	public void getSchedulsPage(HttpServletResponse response) {
		try {
			/*
			 * PageData pd=new PageData(); pd=this.getPageData();
			 * RenderUtil.renderJson(listSch, response);
			 */
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

}
