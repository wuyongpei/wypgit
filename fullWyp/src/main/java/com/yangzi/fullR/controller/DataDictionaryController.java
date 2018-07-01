package com.yangzi.fullR.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.Dictionary;
import com.yangzi.fullR.service.DictionaryService;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;

/**
 * 数据字典 cwh
 * 
 * @author Administrator
 *
 */
@Controller
public class DataDictionaryController extends BaseController {

	@Resource(name = "dictionaryService")
	private DictionaryService dictionaryService;

	/**
	 * 跳转数据字典 cwh 2018-04-27
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "data/dictionary")
	public String dataDictionary(Model model) throws Exception {
		List<PageData> dicList = dictionaryService.getDictionaryTypeList();
		if (!dicList.isEmpty()) {
			model.addAttribute("dicList", dicList);
		}
		return "system/dataDictionary/dataDictionary_list";
	}

	/**
	 * 加载对应类型下字典列表 cwh 2018-04-28
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "show/dictionary/desc/{dictionaryID}")
	public String openDictionaryDesc(@PathVariable String dictionaryID, Model model) throws Exception {
		if (dictionaryID != null && !"".equals(dictionaryID)) {
			int dictionaryid = Integer.parseInt(dictionaryID);
			PageData data = dictionaryService.getDictionaryById(dictionaryid);
			if (data != null) {
				String DictionaryName = data.getString("DictionaryName");
				model.addAttribute("DictionaryName", DictionaryName);
				model.addAttribute("DictionaryID", data.get("DictionaryID"));
			}
			List<PageData> dicList = dictionaryService.getDictionaryListByType(dictionaryid);
			if (!dicList.isEmpty()) {
				model.addAttribute("dicList", dicList);
			}
		}
		return "system/dataDictionary/dataDictionary_desc";
	}

	/**
	 * 弹出新增字典窗口 cwh 2018-04-28
	 * 
	 * @return
	 */
	@RequestMapping(value = "load/win/addType")
	public String addDictionaryTypeWin() {
		return "system/dataDictionary/win/win-add-dictionaryType";
	}

	/**
	 * 弹出添加字典窗口 cwh 2018-04-28
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "load/win/add/{dictionaryID}")
	public String addDictionaryWin(@PathVariable String dictionaryID, Model model) throws Exception {
		if (dictionaryID != null && !"".equals(dictionaryID)) {
			int dictionaryid = Integer.parseInt(dictionaryID);
			PageData data = dictionaryService.getDictionaryById(dictionaryid);
			if (data != null) {
				model.addAttribute("DictionaryID", data.get("DictionaryID"));
				model.addAttribute("DictionaryName", data.get("DictionaryName"));
			}
		}
		return "system/dataDictionary/win/win-add-dictionary";
	}

	/**
	 * 弹出修改字典类别窗口 cwh 2018-05-03
	 * 
	 * @param dictionaryID
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "load/win/edittype/{dictionaryID}")
	public String editDictionaryTypeWin(@PathVariable String dictionaryID, Model model) throws Exception {
		if (dictionaryID != null && !"".equals(dictionaryID)) {
			int dictionaryid = Integer.parseInt(dictionaryID);
			PageData dic = dictionaryService.getDictionaryById(dictionaryid);
			if (dic != null) {
				model.addAttribute("dic", dic);
			}
		}
		return "system/dataDictionary/win/win-edit-dictionaryType";
	}

	/**
	 * 保存编辑字典类别 cwh 2018-05-03
	 * 
	 * @param dictionary
	 * @param response
	 */
	@RequestMapping(value = "update/dictionaryType")
	public void updateDictionaryType(Dictionary dictionary, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			dictionaryService.updateDictionary(dictionary);
			result.put("statue", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 弹出编辑字典窗口 cwh 2018-04-28
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "load/win/edit/{dictionaryID}")
	public String editDictionaryWin(@PathVariable String dictionaryID, Model model) throws Exception {
		if (dictionaryID != null && !"".equals(dictionaryID)) {
			int dictionaryid = Integer.parseInt(dictionaryID);
			PageData dic = dictionaryService.getDictionaryById(dictionaryid);
			if (dic != null) {
				dictionaryid = (int) dic.get("PatientID");
				PageData dictype = dictionaryService.getDictionaryById(dictionaryid);
				if (dictype != null) {
					model.addAttribute("DictionaryName", dictype.get("DictionaryName"));
				}
				model.addAttribute("dic", dic);
			}
		}
		return "system/dataDictionary/win/win-edit-dictionary";
	}

	/**
	 * 新增字典类别 cwh 2018-05-02
	 * 
	 * @param dictionary
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "add/dictionary/patient")
	public void addDicitonaryType(Dictionary dictionary, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if (dictionary != null) {
				dictionary.setDictionaryType(0);// 0-父类别 1-子类别
				dictionary.setPatientID(0);// 没有父级为0
				dictionaryService.saveDictionary(dictionary);
				result.put("statue", "success");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 添加字典 cwh 2018-05-02
	 * 
	 * @param dictionary
	 * @param response
	 */
	@RequestMapping(value = "add/dictionary")
	public void addDictionary(Dictionary dictionary, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if (dictionary != null) {
				dictionary.setDictionaryType(1);// 0-父类别 1-子类别
				dictionaryService.saveDictionary(dictionary);
				result.put("statue", "success");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 保存编辑字典 cwh 2018-05-03
	 * 
	 * @param dictionary
	 * @param response
	 */
	@RequestMapping(value = "update/dictionary")
	public void updateDictionary(Dictionary dictionary, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if (dictionary != null) {
				// dictionary.setDictionaryType(1);//0-父类别 1-子类别
				dictionaryService.updateDictionary(dictionary);
				result.put("statue", "success");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 删除字典 cwh 2018-05-03
	 * 
	 * @param dictionaryID
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "delete/dictionary")
	public void deleteDictionary(String dictionaryID, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if (dictionaryID != null && !"".equals(dictionaryID)) {
				int dictionaryid = Integer.parseInt(dictionaryID);
				dictionaryService.deleteDictionary(dictionaryid);
				result.put("statue", "success");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 删除字典类别 cwh 2018-05-03
	 * 
	 * @param dictionaryID
	 * @param response
	 */
	@RequestMapping(value = "delete/dictionaryType")
	public void deleteDictionaryType(String dictionaryID, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			if (dictionaryID != null && !"".equals(dictionaryID)) {
				// 根据字典父类别id查询是否有子类别数据
				int dictionaryid = Integer.parseInt(dictionaryID);
				List<PageData> dicList = dictionaryService.getDictionaryListByType(dictionaryid);
				if (!dicList.isEmpty()) {
					result.put("statue", "muchdata");
				} else {
					// 无子数据可删除
					dictionaryService.deleteDictionary(dictionaryid);
					result.put("statue", "success");
				}
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		RenderUtil.renderJson(result, response);
	}

	/**
	 * 获取指定字典下的指定DictionaryCode子字典
	 * 
	 * @author wyp 2018年6月6日
	 * @param out
	 */
	@RequestMapping("getByCode")
	public void getByCode(HttpServletResponse response) {
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			String name = dictionaryService.getDictionaryNameByCons(pd);
			if (name == null) {
				name = "";
			}
			RenderUtil.renderText(name, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
}
