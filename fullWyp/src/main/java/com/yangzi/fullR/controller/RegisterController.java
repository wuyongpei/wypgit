package com.yangzi.fullR.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sun.pdfview.PagePanel;
import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.service.DictionaryService;
import com.yangzi.fullR.service.SickPatientService;
import com.yangzi.fullR.service.ZoneService;
import com.yangzi.fullR.util.JsonUtil;
import com.yangzi.fullR.util.PageData;

@Controller
@RequestMapping(value = "/register")
public class RegisterController extends BaseController {
	@Autowired
	private ZoneService zoneService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private SickPatientService sickPatientService;
	@Autowired
	private SickPatientController sickPatientController;

	/**
	 * 登记界面
	 */
	@RequestMapping(value = "/dengji")
	public String dengji(Model model) {
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			if (pd.containsKey("data")) {
				pd.put("data", new String(pd.getString("data").getBytes("iso-8859-1"), "utf-8"));
			}
			List<PageData> provice = zoneService.getProvince();
			List<PageData> nation = dictionaryService.getDictionaryByName("NATION");
			List<PageData> occupation = dictionaryService.getDictionaryByName("OCCUPATION");
			List<PageData> marriagestate = dictionaryService.getDictionaryByName("MARRIAGESTATE");
			List<PageData> relationship = dictionaryService.getDictionaryByName("RELATIONSHIP");
			model.addAttribute("provice", provice);
			model.addAttribute("nation", nation);
			model.addAttribute("occupation", occupation);
			model.addAttribute("marriagestate", marriagestate);
			model.addAttribute("relationship", relationship);
			model.addAttribute("pd", pd);
			model.addAttribute("action", "register/save.do");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}

		return "system/appointment/register-sick";
	}

	/**
	 * 保存登记
	 */
	@RequestMapping(value = "/save")
	public String save(Model model) {
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			String id = pd.getString("PatientID");
			if (id.equals("") || id == null) {
				id = this.get32UUID().toString();
				pd.put("PatientID", id);
				pd.put("PatientCode", "");
				pd.put("SettleType", -1);
				pd.put("State", 0);
				pd.put("OperatorID", 1);
				pd.put("CreateDateTime", new Date());
				pd.put("ArchivesNo", "");
				pd.put("Password", "");
				sickPatientService.savePatient(pd);
			} else {
				sickPatientService.updateByID(pd);
			}
			model.addAttribute("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("msg", "faile");
		}

		String url = pd.getString("url");
		if (url == null || url.equals("")) {
			return dengji(model);
		} else {
			if (url.equals("patientList")) {
				Page page=new Page();
				return sickPatientController.getPatients(page,model);
			} else {
				model.addAttribute("data", pd);
				return "system/patient/view/patient_view";
			}
		}
	}

}
