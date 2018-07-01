package com.yangzi.fullR.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.entity.Office;
import com.yangzi.fullR.entity.WorkPosition;
import com.yangzi.fullR.entity.WorkUnit;
import com.yangzi.fullR.entity.base.Page;
import com.yangzi.fullR.service.WorkUnitAndOfficeService;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.RenderUtil;
import com.yangzi.fullR.util.ToolComplexUtil;
/**
 * lzd
 * 单位科室职位
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/waf")
public class WorkUnitAndOfficeController extends BaseController {
  
	 @Autowired
	 private WorkUnitAndOfficeService workUnitAndOfficeService;
	 
	   /**
	    * lzd
	    * @param model
	    * @return
	    * @throws Exception
	    */
		@RequestMapping("/waflist")
		public String workAOfficeList(Page page,Model model)throws Exception{
			PageData pd = new PageData();
			pd=this.getPageData();
			page.setPd(pd);
            //获取所有用人单位		
			List<WorkUnit> wuList = workUnitAndOfficeService.workUnitlistPdPage(page);
			if(wuList!=null && !wuList.isEmpty()) {
				model.addAttribute("wuList", wuList);			
			}
			model.addAttribute("gz", "未加载到数据");
 			return "system/workandoffice/waf_list";
		}
		
		/**
		 * lzd
		 * 2018-04-19
		 * 新增页面
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("/addPage")
		public String addPage(@RequestParam String addType,Model model)throws Exception {
			try {
			if(addType!=null) {
              if("1".equals(addType)) {
				return "system/workandoffice/wu-addAedit";
              }else if("2".equals(addType)) {
            	List<PageData> pdlist = workUnitAndOfficeService.listWu();  
            	  model.addAttribute("pdlist", pdlist);
            	return "system/workandoffice/of-addAedit";  
              }else if("3".equals(addType)) {
            	  List<PageData> pdlist = workUnitAndOfficeService.listWu();  
            	  model.addAttribute("pdlist", pdlist);
            	return "system/workandoffice/wp-addAedit";  
              }              
			}
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
           return null;			
		}
		
		/**
		 * 保存工作单位
		 * lzd
		 * 20180421
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/addWu")
		public void addWu(WorkUnit wu,Model model,HttpServletResponse response)throws Exception {
			Map<String,Object> result = new HashMap<String,Object>();
            try {
             if(wu.getWorkUnitID()==null||"".equals(wu.getWorkUnitID())){
               wu.setWorkUnitID(this.get32UUID());
               wu.setCreateDateTime(new Date());
               workUnitAndOfficeService.saveWu(wu); 
               result.put("statue", "success");	
             }else{
            	 workUnitAndOfficeService.editWu(wu); 
               result.put("statue", "success");	
             } 	
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
            RenderUtil.renderJson(result, response);
		}
		
		/**
		 * 保存科室或者部门 ,包括修改
		 * lzd
		 * 2018-04-21
		 * @param o
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/addOf")
		public void addOf(Office o,Model model,HttpServletResponse response)throws Exception{
			Map<String,Object> result = new HashMap<String,Object>();
			try {
				if(o.getOfficeID()==null){
                     o.setOfficeLevel(1);
					workUnitAndOfficeService.saveOf(o);
					 result.put("statue", "success");	
				}else{
					 workUnitAndOfficeService.editOf(o);
		               result.put("statue", "success");	
				}
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
			 RenderUtil.renderJson(result, response);
		}
		
		/**
		 * 保存职位
		 * lzd
		 * 2018-04-21
		 * @param wp
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value="/addWp")
		public void addWp(WorkPosition wp,HttpServletResponse response)throws Exception{
			Map<String,Object> result = new HashMap<String,Object>();
			try {
				if(wp.getWorkPositionID()==null) {
					workUnitAndOfficeService.saveWp(wp);
					 result.put("statue", "success");
				}else {
					 workUnitAndOfficeService.editWP(wp);
		               result.put("statue", "success");	
				}
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
			 RenderUtil.renderJson(result, response);
		}
		
		
		
		/**
		 * lzd
		 * 2018-04-19
		 * 修改操作页面跳转
		 * @param edittype
		 * @param nodeId
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("/editPage")
		public String editPage(@RequestParam String edittype,@RequestParam String nodeId,Model model)throws Exception{
		   PageData pd = new PageData();
		   try {
			 pd = this.getPageData();
			if(edittype!=null&&!"".equals(edittype)) {
			   if(nodeId!=null&&!"".equals(nodeId)) {
                   if("1".equals(edittype)) {
                	 String id = nodeId.replaceAll("wu_","");
                	 pd.put("workUnitID", id);
                	 pd=workUnitAndOfficeService.getWrokUnitById(pd);
                	 model.addAttribute("pd", pd);
                     return "system/workandoffice/wu-addAedit"; 
                   }else if("2".equals(edittype)) {
                	   String id = nodeId.replaceAll("of_","");
                	   pd.put("officeID", id);
                	   pd=workUnitAndOfficeService.getOfficeById(pd);
                	   List<PageData> pdlist = workUnitAndOfficeService.listWu();  
                 	  model.addAttribute("pdlist", pdlist);
                 	  model.addAttribute("pd", pd);
                	   return "system/workandoffice/of-addAedit";
                   }else if("3".equals(edittype)) {
                	   String id = nodeId.replaceAll("wp_","");
                	   pd.put("workPositionID", id);
                	   pd=workUnitAndOfficeService.getWorkPositionById(pd);
                	   List<PageData> pdlist = workUnitAndOfficeService.listWu();  
                 	   model.addAttribute("pdlist", pdlist);
                 	   model.addAttribute("pd", pd);
                	   return "system/workandoffice/wp-addAedit";
                   }
			   }
		   }
		   } catch (Exception e) {
			   logger.error(e.toString(), e);
		   }
		   return null;	
		}
		
		/**
		 * 根据单位id 获取科室
		 * lzd
		 * 2018-04-23
		 */
		@RequestMapping("/get/ofics")
		public void gOfficesByWuId(String wuid,HttpServletResponse response)throws Exception {
		   PageData pd = new PageData();
		   pd= this.getPageData();
			try {
			  if(wuid!=null&&!"".equals(wuid)) {
			   List<PageData> ofpdList =workUnitAndOfficeService.oflistByWuId(pd);                
               if(ofpdList!=null&&!ofpdList.isEmpty()) {
                  RenderUtil.renderJson(ofpdList, response);   
               }				  
			  }	
			} catch (Exception e) {
				 logger.error(e.toString(), e);
			}
		}
		/**
		 * 根据ofid 获取职位
		 * @param ofics
		 * @param response
		 * @throws Exception
		 */
		@RequestMapping("/get/wps")
		public void gWpByOfid(String ofid,HttpServletResponse response)throws Exception{
			PageData pd = new PageData();
			   pd= this.getPageData();
			   try {
					  if(ofid!=null&&!"".equals(ofid)) {
					   List<PageData> wppdList =workUnitAndOfficeService.wplistByOfId(pd);                
		               if(wppdList!=null&&!wppdList.isEmpty()) {
		                  RenderUtil.renderJson(wppdList, response);   
		               }				  
					  }	
					} catch (Exception e) {
						 logger.error(e.toString(), e);
					}
		}
		
		
		/**
		 * lzd
		 * 根据ID删除操作
		 * 2018-04-23
		 * @throws Exception
		 */
		@RequestMapping("/del.do")
		public void delByIdAndType(String edittype,String nodeId,HttpServletResponse response)throws Exception{
			try {
				Map<String,Object> result = new HashMap<String,Object>();
				if(edittype!=null&&!"".equals(edittype)) {
				  if(nodeId!=null&&!"".equals(nodeId)) {
					  if("1".equals(edittype)) {
		                String id = nodeId.replaceAll("wu_","");	    
				  		 //暂时禁止删除   
		              
					  }else if("2".equals(edittype)) {
						  String id = nodeId.replaceAll("of_","");
						  workUnitAndOfficeService.deleteAllWpByOf(id);
						  workUnitAndOfficeService.deleteOf(id);
						  result.put("success", "success");	
					  }else if("3".equals(edittype)) {
						  String id = nodeId.replaceAll("wp_","");
					      workUnitAndOfficeService.deleteWp(id);
					      result.put("success", "success");	
					  }  
				}}
				RenderUtil.renderJson(result, response);
			} catch (Exception e) {
				 logger.error(e.toString(), e);
			}
		}
		
		/**
		 * 统计二级科室数量
		 * @author wyp
		 * 2018年6月12日  
		 * @param response
		 */
		@RequestMapping("countWorkPosition")
		public void countWorkPosition(HttpServletResponse response) {
			try {
				int number=workUnitAndOfficeService.countWorkPosition()+1;
				RenderUtil.renderText(ToolComplexUtil.fronCompWithZore(number,3), response);
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
		}
		
		/**
		 * 统计科室数量
		 * @author wyp
		 * 2018年6月12日  
		 * @param response
		 */
		@RequestMapping("countOffice")
		public void countOffice(HttpServletResponse response) {
			try {
				int number=workUnitAndOfficeService.countOffice()+1;
				RenderUtil.renderText(ToolComplexUtil.fronCompWithZore(number,3), response);
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
		}
		
}
