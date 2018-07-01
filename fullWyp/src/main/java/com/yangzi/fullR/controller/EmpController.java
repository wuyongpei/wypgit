package com.yangzi.fullR.controller;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.service.DictionaryService;
import com.yangzi.fullR.service.FREmpService;
import com.yangzi.fullR.service.MenuService;
import com.yangzi.fullR.service.RoleService;
import com.yangzi.fullR.service.WorkUnitAndOfficeService;
import com.yangzi.fullR.system.Role;
import com.yangzi.fullR.util.AppUtil;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;

import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletResponse;

/**
 * 用户操作类
 * 
 * @author win7
 *
 */
@Controller
@RequestMapping(value = "/emp")
public class EmpController extends BaseController {

	@Autowired
	private FREmpService frEmpService;

	@Autowired
	private RoleService roleService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private WorkUnitAndOfficeService workUnitAndOfficeService;

	@Autowired
	private DictionaryService dictionaryService;

	/**
	 * 用户列表 lzd 2018-04-11
	 * 
	 * @param page
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listEmps")
	public String listEmps(Page page, Model model) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();

		String emp_Name = pd.getString("emp_Name");
		if (null != emp_Name && !"".equals(emp_Name)) {
			emp_Name = emp_Name.trim();
			pd.put("emp_Name", emp_Name);
		}
		page.setPd(pd);
		List<PageData> empList = frEmpService.listPdPageEmp(page);
		List<Role> roleList = roleService.listAllERRoles();
		model.addAttribute("empList", empList);
		model.addAttribute("roleList", roleList);
		model.addAttribute("pd", pd);
		return "system/emp/emp_list";
	}

	/**
	 * lzd 2018-04-24
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goAddE")
	public String goAddE(Model model) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			List<PageData> pdlist = workUnitAndOfficeService.listWu();
			List<Role> roleList = roleService.listAllERRoles();
			List<PageData> doctypelist = dictionaryService.getDictionaryByName("DOCTOR_TYPE");
			model.addAttribute("pdlist", pdlist);
			model.addAttribute("roleList", roleList);
			model.addAttribute("doctypelist", doctypelist);
			model.addAttribute("msg", "emp/saveE.do");
			model.addAttribute("pd", pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "system/emp/win/emp_add_edit";
	}

	/**
	 * 保存用户
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/saveE")
	public String saveE(Model model) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			String empId = this.get32UUID().toString();
			pd.put("empId", empId);
			String pw = pd.getString("password");
			String un = pd.getString("empName");
			String password = "";
			if (pw != null && !"".equals(pw) && un != null && !"".equals(un)) {
				password = new SimpleHash("SHA-1", un, pw).toString();
			}
			pd.put("password", password);
			frEmpService.save(pd);
			model.addAttribute("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("msg", "failed");
		}

		return "save_result";
	}

	/**
	 * 删除用户
	 * 
	 * 
	 */
	@RequestMapping("/deleteE")
	public void deleteE(@RequestParam String empID, PrintWriter out) throws Exception {
		try {
			frEmpService.delete(empID);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 删除用户
	 * 
	 * 
	 */
	@RequestMapping("/deleteEs")
	public void deleteEs(@RequestParam String empIDs, PrintWriter out) throws Exception {
		try {
			frEmpService.deletes(empIDs);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 编辑用户
	 * 
	 * 
	 */
	@RequestMapping("/editE")
	public String editE(@RequestParam String emp_ID, Model model) throws Exception {
		PageData pd = new PageData();
		try {
			pd = frEmpService.getEmpByID(emp_ID);
			List<PageData> pdlist = workUnitAndOfficeService.listWu();
			List<Role> roleList = roleService.listAllERRoles();
			List<PageData> doctypelist = dictionaryService.getDictionaryByName("DOCTOR_TYPE");
			model.addAttribute("pdlist", pdlist);
			model.addAttribute("doctypelist", doctypelist);
			model.addAttribute("msg", "emp/editSave.do");
			model.addAttribute("roleList", roleList);
			model.addAttribute("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return "system/emp/win/emp_add_edit";
	}

	@RequestMapping("/editSave")
	public String editSave(Model model) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			String pw = pd.getString("password");
			String un = pd.getString("empName");
			String password = "";
			if (pw != null && !"".equals(pw) && un != null && !"".equals(un)) {
				password = new SimpleHash("SHA-1", un, pw).toString();
				pd.put("password", password);
			}
			frEmpService.edit(pd);
			model.addAttribute("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("msg", "failed");
		}

		return "save_result";
	}

	/**
	 * 根据 科室，预约日期，医生类别获取可选医生
	 * 
	 * @author wyp
	 * @param officeID
	 * @param date
	 * @param type
	 * @param response
	 */
	@RequestMapping(value = "/getEmpBydate")
	public void getEmpBydate(String officeID, String date, String type, HttpServletResponse response) {
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			if (type.equals("1")) {
				pd.put("Doctor_Type", "专家");
			} else if (type.equals("2")) {
				pd.put("Doctor_Type", "普通");
			} else {
				pd.put("Doctor_Type", "");
			}
			pd.put("wuid", "1");
			pd.put("OfficeID", officeID);
			pd.put("Appointment_Date", date);
			List<PageData> emps = frEmpService.getEmpBydate(pd);
			RenderUtil.renderJson(emps, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 根据科室获取医生
	 * 
	 * @author wyp 2018年6月8日
	 * @param OfficeID
	 * @param response
	 */
	@RequestMapping(value = "getEmpByo")
	public void getEmpByo(@RequestParam int OfficeID, HttpServletResponse response) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			if (OfficeID > 0) {
				pd.put("officeID", OfficeID);
			}
			pd.put("wuid", 1);
			Page page = new Page();
			page = this.getPage();
			page.setPd(pd);
			List<PageData> emps = frEmpService.empschullistPage(page);
			RenderUtil.renderJson(emps, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 分页获取医生
	 * 
	 * @author wyp 2018年6月8日
	 * @param response
	 */
	@RequestMapping("getEmpsPage")
	public void getEmpsPage(HttpServletResponse response) {
		Map<String, Object> result = new HashMap<>();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("wuid", 1);
			List<PageData> emps = frEmpService.getEmpsPage(pd);
			int empsLength = frEmpService.getEmpsLength(pd);
			double pageSize=Double.valueOf(pd.getString("pageSize"));
			double size=Math.ceil(empsLength/pageSize);
			result.put("data", emps);
			result.put("size", size);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		RenderUtil.renderJson(result, response);
	}
	
	/**
	 * 验证登录名是否存在
	 * @return
	 */
	@RequestMapping("/hasE")
	@ResponseBody
	public Object hasE() {
		Map<String,Object>map = new HashMap<String, Object>();
		String errInfo ="success";
		PageData pd = new PageData();
		try {
			pd =this.getPageData();
			if(frEmpService.findByUId(pd)!=null) {
				errInfo="error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
         map.put("result", errInfo);
         return AppUtil.returnObject(new PageData(), map);
	}
	
	
}
