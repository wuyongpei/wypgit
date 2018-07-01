package com.yangzi.fullR.controller;

import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.vo.FRShift;
import com.yangzi.fullR.service.ShiftService;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;
/**
 * 基础数据班次规则
 * @author lzd
 *
 */
@Controller
@RequestMapping("/shift")
public class ShiftController extends BaseController {
    
	 @Autowired
	 private ShiftService shiftService;
	 
	
	  /**
	   * 班次列表查询
	   * @param page
	   * @param model
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("/listshifts")
	  public String getShiftList(Model model)throws Exception {
		  PageData pd = new PageData();
		  pd = this.getPageData();
		  List<FRShift> shiftlist = new ArrayList<FRShift>();
          String shiftName = pd.getString("shiftName");
          if(null!=shiftName &&!"".equals(shiftName)) {
        	  shiftName =shiftName.trim();
        	  pd.put("shiftName",shiftName);
          }else {
        	  pd.put("shiftName", "");
          }
		  //获取
          pd.put("parentid", 0);
		  List<FRShift> slist1 = shiftService.getShiftByParentId(pd);
		   if(slist1!=null&&!slist1.isEmpty()) {
			   for (FRShift fs : slist1) {
				   pd.put("parentid", fs.getShiftId());
				   pd.put("shiftName", "");
				   shiftlist.add(fs);
				 List<FRShift> slist2 = shiftService.getShiftByParentId(pd);
				  if(slist2!=null&&!slist2.isEmpty()) {
					  for (FRShift fs2 : slist2) {
						  pd.put("parentid", fs2.getShiftId());
						  pd.put("shiftName", "");
						   shiftlist.add(fs2);
						 List<FRShift> slist3 = shiftService.getShiftByParentId(pd);
						  for (FRShift fs3 : slist3) {
							  pd.put("parentid", fs3.getShiftId());
							  pd.put("shiftName", "");
							   shiftlist.add(fs3);
						}
					}
				  }
			}
		   }
		   model.addAttribute("shiftlist", shiftlist);
		   model.addAttribute("pd", pd);
		  return "system/shift/shift_list";
	  }
	
	/**
	 * 增加页面
	 * 20180504
	 * lzd
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goAddS")
	public String goAddS(Model model)throws Exception {
		 try {
			 model.addAttribute("addType", 0);
			 model.addAttribute("parent_Id", 0);
			 model.addAttribute("shiftLevel", 1);
			 model.addAttribute("msg", "shift/saveS.do");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		
		return "system/shift/win/shift_addAndEdit";
	}
	
	/**
	 * lzd
	 * 20180505
	 * 增加子项
	 * @param model
	 * @return
	 */
	@RequestMapping("/goAddSon/{tid}/{level}")
	public String goAddSon(@PathVariable("tid")String tid,@PathVariable("level")String level, Model model)throws Exception{
		 try {
			 if(tid!=null &&!"".equals(tid)){
			 model.addAttribute("parent_Id", tid);
			 }
			 if(level!=null &&!"".equals(level)){
				 model.addAttribute("shiftLevel", level);
			 }
			 model.addAttribute("addType", 1);
			 model.addAttribute("msg", "shift/saveS.do");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		 
		return "system/shift/win/shift_addAndEdit";
	}
	 
	/**
	 * 保存操作
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/saveS")
	public String saveSf(Model model)throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String addType = pd.getString("addType");
		try {
		   	if(addType!=null&&!"".equals(addType)) {
                if("0".equals(addType)) {
                	//創建規則
                	pd.put("shiftLevel", 1);
                	shiftService.save(pd);
                }else if("1".equals(addType)){
                	String level = pd.getString("shiftLevel");
                    pd.put("shiftLevel", Integer.parseInt(level)+1);
                    shiftService.save(pd);
                }
		   	}
			model.addAttribute("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("msg", "failed");
		}
		return "save_result";
	}
	
	/**
	 * 删除规则
	 * @throws Exception
	 */
	@RequestMapping("/del")
	public void delete(@RequestParam String shiftId,PrintWriter out)throws Exception{
		try {
			shiftService.deleteShiftById(shiftId);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 请求修改窗口
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toEditR")
	public String toEdit(@RequestParam String shiftId,Model model)throws Exception{
		PageData pd = new PageData();
		pd =this.getPageData();
		try {
			if(shiftId!=null &&!"".equals(shiftId)) {
			pd.put("shiftId", shiftId);
			pd =shiftService.getShiftById(pd);
			if(pd!=null) {
				int parent_Id = pd.getInteger("Parent_Id");
				int level = pd.getInteger("ShiftLevel");
			    model.addAttribute("level", level);
			    model.addAttribute("parent_Id", parent_Id);
			  if(level==1) {
				   model.addAttribute("addType", 0);
			   }else {
				   model.addAttribute("addType", 1);
			   }	
				model.addAttribute("pd",pd);
			}
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		 model.addAttribute("msg", "shift/updateS.do");
		return "system/shift/win/shift_addAndEdit";
	}
	
	/**
	 * 更新操作
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/updateS")
	public String updateS(FRShift fs,Model model)throws Exception {
		try {
			shiftService.edit(fs);
			model.addAttribute("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			model.addAttribute("msg", "failed");
		}
		return "save_result";
	}
	
	/**
	 * 获取shiftID数据及其子数据
	 * @author wyp
	 * 2018年6月5日  
	 * @param shiftID
	 * @param response
	 */
	@RequestMapping(value="getDateByID")
	public void getDateByID(int shiftID,HttpServletResponse response) {
		try {
			PageData pd= new PageData();
			pd.put("shiftId", shiftID);
			PageData parent=shiftService.getShiftById(pd);
			List<PageData> spdlist = shiftService.getDataByCons(shiftID);
			spdlist.add(parent);
			RenderUtil.renderJson(spdlist, response);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
}
