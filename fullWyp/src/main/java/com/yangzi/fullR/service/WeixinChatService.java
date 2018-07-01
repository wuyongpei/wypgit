package com.yangzi.fullR.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.util.HttpSend;
import com.yangzi.fullR.util.JsonUtil;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.SysParamsToolkit;
import com.yangzi.fullR.weixin.entity.vo.WeixinSendDataVo;
import com.yangzi.fullR.weixin.entity.vo.WeixinSendModelBackVo;
import com.yangzi.fullR.weixin.entity.vo.WeixinSendModelMsgVo;

/**
 * 微信操作处理类
 * cwh
 * @author Administrator
 *
 */
@Service("weixinChatService")
public class WeixinChatService {

	@Autowired
	private DaoSupport dao;
	/**
	 * 绑定微信号信息
	 * cwh
	 * @param pd
	 * @throws Exception
	 */
	public void saveWeChartRelation(PageData pd) throws Exception {
		dao.save("FRWeChartRelationMapper.saveWeChartRelation", pd);
	}
	/**
	 * 保存就诊卡绑定
	 * cwh
	 * 2018-05-16
	 * @param pd
	 * @throws Exception
	 */
	public void saveBindCard(PageData pd) throws Exception {
		dao.save("FRWeChartRelationMapper.saveBindCard", pd);
	}
	/**
	 * 微信绑定  创建病人档案
	 * cwh
	 * @param pd
	 * @throws Exception
	 */
	public void saveFRSickPatient(PageData pd) throws Exception {
		dao.save("FRWeChartRelationMapper.saveFRSickPatient", pd);
	}
	/**
	 * 根据openid查询微信绑定
	 * cwh
	 * 2018-05-16
	 * @param openID 
	 * @throws Exception
	 */
	public PageData selectWeChartRelationByOpenID(String openID) throws Exception {
		return (PageData) dao.findForObject("FRWeChartRelationMapper.selectWeChartRelationByOpenID", openID);
	}
	/**
	 * 根据weChartID查询是否存在就诊卡
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> selectWeChartRCByweChartID(String weChartID) throws Exception{
		return (List<PageData>) dao.findForList("FRWeChartRelationMapper.selectWeChartRCByweChartID", weChartID);
	}
	/**
	 * 根据openid查询就诊卡
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> selectWeChartRCByOpenID(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("FRWeChartRelationMapper.selectWeChartRCByOpenID", pd);
	}
	/**
	 * 根据就诊卡号查询是否被绑定
	 * cwh
	 * 2018-05-16
	 * @param medicalCode
	 * @return
	 * @throws Exception
	 */
	public int selectWeChartRCByCardNo(PageData pd) throws Exception{
		return (int) dao.findForObject("FRWeChartRelationMapper.selectWeChartRCByCardNo", pd);
	}
	/**
	 * 解除就诊卡绑定
	 * cwh
	 * @param pd
	 * @throws Exception
	 */
	public void removeBindCard(PageData pd) throws Exception {
		 dao.delete("FRWeChartRelationMapper.removeBindCard", pd);
	}
	/**
	 * 统计病人档案数量
	 * cwh
	 * 2018-06-05
	 * @return
	 * @throws Exception
	 */
	public int getSumFromSickPatient() throws Exception {
		return (int) dao.findForObject("FRWeChartRelationMapper.getSumFromSickPatient", null);
	}
	/**
	 * 根据手机号查询病人档案
	 * cwh
	 * 2018-06-05
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int getSickPatientByMobileNo(PageData pd) throws Exception {
		return (int) dao.findForObject("FRWeChartRelationMapper.getSickPatientByMobileNo", pd);
	}
	/**
	 * 根据身份证查询 微信就诊卡绑定
	 * cwh
	 * 2018-06-05
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int getWeChartRCByIDNo(PageData pd) throws Exception {
		return (int) dao.findForObject("FRWeChartRelationMapper.getWeChartRCByIDNo", pd);
	}
	/**
	 * 根据身份证查询病人档案
	 * cwh
	 * 2018-06-05
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData selectSickPatientByIDNumber(PageData pd) throws Exception {
		return (PageData) dao.findForObject("FRWeChartRelationMapper.selectSickPatientByIDNumber", pd);
	}
	/**
	 * 根据就诊卡号查询病人档案
	 * cwh
	 * 2018-06-06
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData selectSickPatientByCardCode(PageData pd) throws Exception {
		return (PageData) dao.findForObject("FRWeChartRelationMapper.selectSickPatientByCardCode", pd);
	}
	/**
	 * 根据patientid修改病人档案手机号
	 * cwh
	 * 2018-06-05
	 * @param pd
	 * @throws Exception
	 */
	public void updateSickPatientMobileNo(PageData pd) throws Exception {
		dao.update("FRWeChartRelationMapper.updateSickPatientMobileNo", pd);
	}
	/**
	 * 查询工作单位(暂时用于科室分类)
	 * cwh
	 * @return
	 * @throws Exception
	 */
	public List<PageData> selectAllDepartment() throws Exception{
		return (List<PageData>) dao.findForList("DepartmentMapper.selectAllWorkUnit", null);
	}
	/**
	 * 根据医院id查询对应科室
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> selectDepartmentByWorkUnitID(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("DepartmentMapper.selectDepartmentByWorkUnitID", pd);
	}
	/**
	 * 根据科室id查询子科室
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> selectWorkPositionByOfficeID(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("DepartmentMapper.selectWorkPositionByOfficeID", pd);
	}
	/**
	 * 查询对应科室下医生(按一级科室)
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> selectEmpByOfficeID(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("DepartmentMapper.selectEmpByOfficeID", pd);
	}
	/**
	 * 查询对应科室下医生总数(按一级科室)
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int selectEmpTotalByOfficeID(PageData pd) throws Exception {
		return (int) dao.findForObject("DepartmentMapper.selectEmpTotalByOfficeID", pd);
	}
	
	/**
	 * 查询对应科室下医生(按二级科室)
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> selectEmpByWorkPositionID(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("DepartmentMapper.selectEmpByWorkPositionID", pd);
	}
	/**
	 * 查询对应科室下医生总数(按二级科室)
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int selectEmpTotalByWorkPositionID(PageData pd) throws Exception{
		return  (int) dao.findForObject("DepartmentMapper.selectEmpTotalByWorkPositionID", pd);
	}
	/**
	 * 根据名称模糊查询一级科室
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getOfficeByName(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("DepartmentMapper.getOfficeByName", pd);
	}
	/**
	 * 根据名称模糊查询一级科室 总数量
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int getOfficeTotalByName(PageData pd) throws Exception {
		return (int) dao.findForObject("DepartmentMapper.getOfficeTotalByName", pd);
	}
	/**
	 * 根据名称模糊查询二级科室
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getWorkPositionByName(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("DepartmentMapper.getWorkPositionByName", pd);
	}
	/**
	 * 根据名称模糊查询二级科室的总数量
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int getWorkPositionTotalByName(PageData pd) throws Exception{
		return (int) dao.findForObject("DepartmentMapper.getWorkPositionTotalByName", pd);
	}
	/**
	 * 根据姓名模糊查询医生
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getEmpByName(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("DepartmentMapper.getEmpByName", pd);
	}
	/**
	 * 根据姓名模糊查询医生的总数量
	 * cwh
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public int getEmpTotalByName(PageData pd) throws Exception{
		return (int) dao.findForObject("DepartmentMapper.getEmpTotalByName", pd);
	}
	/**
	 * 客服通知模版消息推送
	 * 将绑定和解绑的消息推送给当前操作用户
	 * @param type  1为已绑定   0为未绑定/解除绑定
	 * @param accessToken
	 * @return
	 */
	public int sendBindMsg(int type,String accessToken,String openid) {
		String template_id=SysParamsToolkit.getProperty("wcmodel.notice");
		String url="https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=" + accessToken;
		WeixinSendModelMsgVo wsmmvo=new WeixinSendModelMsgVo();
		WeixinSendDataVo wsdvo=new WeixinSendDataVo();
		Map<String, Object> map=null;
		String colorblue="#173177";
		//查询数据库 微信绑定表  ???
		//查到   且type==1
		if(type==1) {
			map=new HashMap<String,Object>();
			map.put("value", "您已绑定就诊卡成功");
			wsdvo.setFirst(map);
			map=new HashMap<String,Object>();
			map.put("value", "华仔没有信封11");
			map.put("color", colorblue);
			wsdvo.setKeyword1(map);
			map=new HashMap<String,Object>();
			map.put("value", "尊敬的华仔没有信封11，您已成功绑定吉林市中医院");
			map.put("color", colorblue);
			wsdvo.setKeyword2(map);
		}else if(type==0) {
			map=new HashMap<String,Object>();
			map.put("value", "该就诊卡解绑成功");
			wsdvo.setFirst(map);
		}
		wsmmvo.setTouser(openid);//接收者openid
		wsmmvo.setTemplate_id(template_id);//公众号模版id
		wsmmvo.setData(wsdvo);
		String jsonstr=JsonUtil.obj2Json(wsmmvo);
		if(jsonstr!=null && !"".equals(jsonstr)) {
			HttpSend send=new HttpSend();
			String backjson=send.post(url, jsonstr);
			WeixinSendModelBackVo backvo=JsonUtil.json2Object(WeixinSendModelBackVo.class, backjson);
			if(backvo!=null && backvo.getErrcode()==0 && "ok".equals(backvo.getErrmsg())) {
				return 1;//模版推送成功
			}
		}
		return 0;//模版推送失败
	}
	
	
}
