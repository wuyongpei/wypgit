package com.yangzi.fullR.weixin.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
/**
 * 微信公众号验证页面操作类
 * @author cwh
 *
 */
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.service.AppointmentService;
import com.yangzi.fullR.service.WeixinChatService;
import com.yangzi.fullR.util.DateUtil;
import com.yangzi.fullR.util.HttpSend;
import com.yangzi.fullR.util.IdcardUtils;
import com.yangzi.fullR.util.JsonUtil;
import com.yangzi.fullR.util.PageData;
import com.yangzi.fullR.util.SysParamsToolkit;
import com.yangzi.fullR.util.ToolComplexUtil;
import com.yangzi.fullR.weixin.entity.vo.AccessTokenVo;
import com.yangzi.fullR.weixin.entity.vo.WeChatAdminVo;
@Controller
public class WeixinBindUserController extends BaseController{

	@Resource(name="weixinChatService")
	private WeixinChatService weixinChatService;
	
	@Resource(name="appointmentService")
	private AppointmentService appointmentService;
	
	/**
	 * 用户同意授权，获取code
	 * @param request
	 */
	@RequestMapping("weixin/code")
	public void getweiCode(HttpServletRequest request) {
		String appid=SysParamsToolkit.getProperty("app.id");
		String redirect_uri=SysParamsToolkit.getProperty("redirect.uri");
		HttpSend send=new HttpSend();
		String code="";
		String url="https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appid + "&redirect_uri="
				+ redirect_uri + "&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";
		try {
			code=send.post(url, null);//5分钟后过期	
			System.out.println(code);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 跳转绑定页面
	 * cwh
	 * @param request
	 * @return
	 */
	@RequestMapping("weixin/bind/page")
	public String bindPage(HttpServletRequest request,Model model,String jumpAddress) {	
		String ua=request.getHeader("user-agent").toLowerCase();
		if(ua.indexOf("micromessenger")>0) {//判断是否微信内置浏览器
			HttpSend send=new HttpSend();
			String appid=SysParamsToolkit.getProperty("app.id");
			String secret=SysParamsToolkit.getProperty("secret");
			String code=request.getParameter("code");
			String url="https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appid + "&secret="
					+ secret + "&code=" + code + "&grant_type=authorization_code";
			String atjson=send.post(url, null);//通过code换取网页授权access_token
			System.out.println(atjson);
			if(atjson!=null && !"".equals(atjson)) {
				AccessTokenVo atvo=JsonUtil.json2Object(AccessTokenVo.class, atjson);
				if(atvo!=null && atvo.getAccess_token()!=null && atvo.getOpenid()!=null && atvo.getErrcode()==null ) {
					if(atvo.getOpenid()!=null && !"".equals(atvo.getOpenid())) {
						//1.查询数据看是否有存入绑定卡
							model.addAttribute("openID", atvo.getOpenid());
							model.addAttribute("accessToken", atvo.getAccess_token());
							
						//2.有 跳转已绑定的用户信息页面
					}
				}
			}
			model.addAttribute("jumpAddress", jumpAddress);
			String bindcard=SysParamsToolkit.getProperty("process.weChartBindCard");
			if("buildCard".equals(SysParamsToolkit.getProperty("process.weChartBindCard"))) {
				//用户建卡
				return "weixin/userBind/weixin_buildCard";//用户建卡
			}else if("bindCard".equals(SysParamsToolkit.getProperty("process.weChartBindCard"))) {
				//用户绑卡
				return "weixin/userBind/weixin_userBindCard";
			}
			return "weixin/userBind/weixin_buildCard";//用户建卡
		}else {
			return "weixin/userBind/page-error-remind";
		}
	}
	/**
	 * 用户建卡
	 * cwh
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("weixin/build/card")
	@ResponseBody
	public Map<String,Object> buildCard() throws Exception {

		String accessToken="1223";
		PageData pd=new PageData();
		pd=this.getPageData();
		//String appid=appSysParamsToolkit.getProperty("app.id");
		String openID=(String)pd.get("openID");
		HttpSend send =new HttpSend();
		WeChatAdminVo wcavo=new WeChatAdminVo();
		Map<String, Object> result=new HashMap<String,Object>();
		if(openID!=null && !"".equals(openID) && accessToken!=null && !"".equals(accessToken)) {
			String url="https://api.weixin.qq.com/cgi-bin/user/info?access_token=" + accessToken + "&openid=" + openID + "&lang=zh_CN";
			String backjson=send.post(url, null);
			if(backjson!=null && !"".equals(backjson)) {
				wcavo=JsonUtil.json2Object(WeChatAdminVo.class, backjson);
				if(wcavo!=null) {				
					try {
							//3(1)绑定微信     判断是否已绑定微信
						pd.put("createDateTime", DateUtil.getTime());
						PageData pdWCR=weixinChatService.selectWeChartRelationByOpenID(openID);
							if(pdWCR!=null) {	
								pd.put("weChartID", pdWCR.get("WeChartID"));	
							}else {
								pd.put("weChartID", this.get32UUID());
								wcavo.setNickname("华仔没有信封");//测试用
								wcavo.setHeadimgurl("http://thirdwx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0");//测试用
								pd.put("nickName", wcavo.getNickname());
								pd.put("headImgUrl", wcavo.getHeadimgurl());
								weixinChatService.saveWeChartRelation(pd);
							}
						//根据身份证查询 微信就诊卡绑定     查到提示  已被绑定
						int numRCB=weixinChatService.getWeChartRCByIDNo(pd);
						if(numRCB>0) {
							result.put("statue", "idNumberExist");//身份证已被绑定
							return result;
						}
						// 未查到    根据身份证  查病人档案  查到不再创建新的档案(手机号修改)
						int numSP=weixinChatService.getSickPatientByMobileNo(pd);
						PageData patient=weixinChatService.selectSickPatientByIDNumber(pd);
						if(patient!=null) {
							//查到   1.不创建新的档案
							pd.put("patientID", patient.get("PatientID"));
							if(!pd.get("phoneNumber").equals(patient.get("MobileNO"))) {			
								//判断手机号是否被绑定
								if(numSP>0) {
									result.put("statue", "phoneExist");
									return result;
								}
								weixinChatService.updateSickPatientMobileNo(pd);
							}
							//2.微信绑定就诊卡
							pd.put("relationID", this.get32UUID());
							pd.put("cardNo", patient.get("CardCode"));
							weixinChatService.saveBindCard(pd);
							result.put("statue", "success");
						}else {
							//判断手机号是否被绑定
							if(numSP>0) {
								result.put("statue", "phoneExist");
								return result;
							}
							//   查不到病人档案     1.创建新的档案
							int spsum=weixinChatService.getSumFromSickPatient();
							String CardNo=ToolComplexUtil.fronCompWithZore(spsum+1, 10);
							pd.put("cardNo",SysParamsToolkit.getProperty("cardInitials")+CardNo );//就诊卡号  P0000000001
							pd.put("patientID", this.get32UUID());
							String idCard=pd.getString("idNumber");
							pd.put("sex", IdcardUtils.getGenderByIdCard(idCard));//性别
							pd.put("birthday", IdcardUtils.getBirthByIdCard(idCard));//出生日期
							pd.put("age", IdcardUtils.getAgeByIdCard(idCard));//年龄
							pd.put("state", 0);//状态 0-可用
							pd.put("operatorID", 1);//操作人员id  当前默认1
							pd.put("cardType", 0);//持卡类型 0就诊卡 1医保卡
							weixinChatService.saveFRSickPatient(pd);
							//2.微信绑定就诊卡
							pd.put("relationID", this.get32UUID());
							weixinChatService.saveBindCard(pd);
							result.put("statue", "success");
						}

					} catch (Exception e) {
						logger.error(e.toString(), e);
					}

				}
			}
		}
		
		return result;
	}
	/**
	 * 用户绑卡
	 * cwh
	 * @return
	 */
	@RequestMapping("weixin/bind/card")
	@ResponseBody
	public Map<String,Object> bindCard(){
		String accessToken="1223";
		PageData pd=new PageData();
		pd=this.getPageData();
		//String appid=appSysParamsToolkit.getProperty("app.id");
		String openID=(String)pd.get("openID");
		HttpSend send =new HttpSend();
		WeChatAdminVo wcavo=new WeChatAdminVo();
		Map<String, Object> result=new HashMap<String,Object>();
		if(openID!=null && !"".equals(openID) && accessToken!=null && !"".equals(accessToken)) {
			String url="https://api.weixin.qq.com/cgi-bin/user/info?access_token=" + accessToken + "&openid=" + openID + "&lang=zh_CN";
			String backjson=send.post(url, null);
			if(backjson!=null && !"".equals(backjson)) {
				wcavo=JsonUtil.json2Object(WeChatAdminVo.class, backjson);
				if(wcavo!=null) {				
					try {
						
						//3(1)绑定微信     判断是否已绑定微信
						pd.put("createDateTime", DateUtil.getTime());
						PageData pdWCR=weixinChatService.selectWeChartRelationByOpenID(openID);
						if(pdWCR!=null) {	
							pd.put("weChartID", pdWCR.get("WeChartID"));	
						}else {
							pd.put("weChartID", this.get32UUID());
							wcavo.setNickname("华仔没有信封");//测试用
							wcavo.setHeadimgurl("http://thirdwx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0");//测试用
							pd.put("nickName", wcavo.getNickname());
							pd.put("headImgUrl", wcavo.getHeadimgurl());
							weixinChatService.saveWeChartRelation(pd);
						}
						//就诊卡格式是否正确    P开头  长度为11位  1-11位数字组成
						String medicalCard=(String) pd.get("medicalcard");
						String cardInitials=SysParamsToolkit.getProperty("cardInitials");
						boolean isNum=medicalCard.substring(1, 11).matches("[0-9]*");
						if(!cardInitials.equals(medicalCard.substring(0, 1)) || medicalCard.length()!=11 || isNum==false) {
							result.put("statue", "invalid");//无效卡号
							return result;
						}
						//根据就诊卡号  查询  是否已绑定就诊卡
						int numRCB=weixinChatService.selectWeChartRCByCardNo(pd);
						if(numRCB>0) {
							result.put("statue", "cardExist");//就诊卡已被绑定
							return result;
						}
						//无  根据就诊卡号  查询病人档案  
						PageData patient=weixinChatService.selectSickPatientByCardCode(pd);
						if(patient!=null) {
							//微信就诊卡绑定
							pd.put("RelationID", this.get32UUID());
							pd.put("cardNo", patient.get("CardNo"));
							pd.put("idNumber", patient.get("IDNo"));
							pd.put("patientID", patient.get("PatientID"));
							weixinChatService.saveBindCard(pd);	
							
						}else {
							//该卡号可能不存在或已挂失  无法查询相应档案信息
							result.put("statue", "invalid");//无效卡号
							return result;
						}
						
					} catch (Exception e) {
						logger.error(e.toString(), e);
					}

				}
			}
		}
		
		return result;
	}
	/**
	 * 跳转 我的门诊
	 * cwh
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("weixin/outpatient")
	public String outPatient(HttpServletRequest request,Model model) throws Exception {
		PageData pd=new PageData();
		pd=this.getPageData();
		String ua=request.getHeader("user-agent").toLowerCase();
		if(ua.indexOf("micromessenger")>0) {//判断是否微信内置浏览器
			HttpSend send=new HttpSend();
			String appid=SysParamsToolkit.getProperty("app.id");
			String secret=SysParamsToolkit.getProperty("secret");
			String code=request.getParameter("code");
			String url="https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appid + "&secret="
					+ secret + "&code=" + code + "&grant_type=authorization_code";
			String atjson=send.post(url, null);//通过code换取网页授权access_token
			//System.out.println(atjson);
			if(atjson!=null && !"".equals(atjson)) {
				AccessTokenVo atvo=JsonUtil.json2Object(AccessTokenVo.class, atjson);
					/** 测试用数据**/
					atvo.setOpenid("o7d6S0csa33EBut2A2XDbbeY_Xk0");//测试用
					atvo.setAccess_token("测试");
					atvo.setErrcode(null);
				if(atvo!=null && atvo.getAccess_token()!=null && atvo.getOpenid()!=null && atvo.getErrcode()==null ) {
					if(atvo.getOpenid()!=null && !"".equals(atvo.getOpenid())) {
						//根据openid查看是否绑定微信  没跳转绑定
					PageData pdWCR=weixinChatService.selectWeChartRelationByOpenID(atvo.getOpenid());
						if(!pdWCR.isEmpty()) {
							//已绑定 跳转 我的门诊
								//门诊列表
							pd.put("OpenID", atvo.getOpenid());
						List<PageData> wrclist=weixinChatService.selectWeChartRCByOpenID(pd);
							if(!wrclist.isEmpty()) {
								model.addAttribute("wrclist", wrclist);//就诊卡列表
							}
							
							return "weixin/outpatient/weixin_outPatient";//我的门诊
						}
						
					}
				}
			}

			return "weixin/userBind/weixin_buildCard";//用户建卡  默认
		}else {
			return "weixin/userBind/page-error-remind";
		}
	}	
	/**
	 * 解除就诊卡绑定
	 * cwh
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("weixin/cancel/bind/card")
	@ResponseBody
	public Map<String,Object> cancelBindCard() throws Exception{
		Map<String, Object> result=new HashMap<String,Object>();
 		PageData pd=new PageData();
		pd=this.getPageData();
		//根据病人id查询是否存在  已预约 信息
		pd.put("AppointmentStatus", 0);//预约状态 0:已预约 1已就诊 2失约
		List<PageData> alist=appointmentService.getAppointmentByPIDAndStatus(pd);
		if(!alist.isEmpty()) {
			result.put("status", "reserved");//已预约
		}else {
			try {
				
				weixinChatService.removeBindCard(pd);
				result.put("status", "success");
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
		}
		return result;
	}
}
