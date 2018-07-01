package com.yangzi.fullR.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.service.SettingService;
import com.yangzi.fullR.service.WorkUnitAndOfficeService;
import com.yangzi.fullR.system.FREmp;
import com.yangzi.fullR.util.Const;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;

@Controller
@RequestMapping("setting")
public class SettingController extends BaseController {

	@Autowired
	private SettingService settingService;
	@Autowired
	private WorkUnitAndOfficeService workUnitAndOfficeService;

	/**
	 * 获取所有
	 * 
	 * @author wyp 2018年6月16日
	 * @param model
	 * @return
	 */
	@RequestMapping("settingList")
	public String settingList(Model model) {
		try {
			PageData pd = new PageData();
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			FREmp user = (FREmp) session.getAttribute(Const.SESSION_USER);
			String workUnitID = user.getWorkUnitID();
			List<PageData> processSetList = settingService.getProcessSet(workUnitID);
			pd.put("wuid", workUnitID);
			List<PageData> officeList = workUnitAndOfficeService.oflistByWuId(pd);
			model.addAttribute("processSetList", processSetList);
			model.addAttribute("officeList", officeList);
			model.addAttribute("wuid", workUnitID);
		} catch (Exception e) {
			logger.error(e.toString());
		}
		return "system/setting/setting_list";
	}

	/**
	 * 音频分页显示
	 * 
	 * @author wyp 2018年6月20日
	 * @param response
	 */
	@RequestMapping("voiceIPRPage")
	public void voiceIPRPage(HttpServletResponse response) {
		Map<String, Object> result = new HashMap<>();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String officeID = pd.getString("officeID");
			if (officeID != null && !"".equals(officeID)) {
				String[] offices = officeID.split(",");
				pd.put("offices", offices);
				List<PageData> voiceIPRList = settingService.getVoiceIPR(pd);
				int voiceLength = settingService.getVoiceIPRSize(pd);
				double pageSize = Double.valueOf(pd.getString("pageSize"));
				double size = Math.ceil(voiceLength / pageSize);
				result.put("data", voiceIPRList);
				result.put("size", size);
				RenderUtil.renderJson(result, response);
			}
		} catch (Exception e) {
			logger.error(e.toString());
		}
	}

	/**
	 * 增删改
	 * 
	 * @author wyp 2018年6月20日
	 * @param out
	 */
	@RequestMapping("update")
	public void update(PrintWriter out,HttpServletRequest request) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			if (pd.getString("param").equals("process")) {
				settingService.updateProcess(pd);
			} else {
				pd.put("OfficeName", new String(request.getParameter("OfficeName").getBytes("iso-8859-1"), "utf-8"));
				settingService.updateVoice(pd);
			}
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error(e.toString());
		}
	}

	@RequestMapping("insert")
	public void insert(PrintWriter out,HttpServletRequest request) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			if (pd.getString("param").equals("process")) {
				pd.put("ProcessSetID", this.get32UUID());
				Subject currentUser = SecurityUtils.getSubject();
				Session session = currentUser.getSession();
				FREmp user = (FREmp) session.getAttribute(Const.SESSION_USER);
				String workUnitID = user.getWorkUnitID();
				pd.put("WorkUnitID", workUnitID);
				pd.put("WorkUnitName", workUnitAndOfficeService.getWorkUnitNameByID(workUnitID));
				settingService.insertProcess(pd); 
			} else {
				pd.put("OfficeName", new String(request.getParameter("OfficeName").getBytes("iso-8859-1"), "utf-8"));
				settingService.insertVoice(pd);
			}
			out.write("success");
			out.flush(); 
			out.close();
		} catch (Exception e) {
			logger.error(e.toString());
		}
	}

	@RequestMapping("delete")
	public void delete(PrintWriter out) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			if (pd.getString("param").equals("process")) {
				settingService.deleteProcess(pd);
			} else {
				settingService.deleteVoice(pd);
			}
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error(e.toString());
		}
	}
}
