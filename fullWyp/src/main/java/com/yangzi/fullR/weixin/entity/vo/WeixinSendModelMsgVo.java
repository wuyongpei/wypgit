package com.yangzi.fullR.weixin.entity.vo;
/**
 * 发送模版消息
 * @author Administrator
 *
 */

import java.util.Map;

public class WeixinSendModelMsgVo {

	private String touser;//接收者的openid
	private String template_id;//模版id
	private String url;//模版跳转链接
	private Map<String, Object> miniprogram;//跳转小程序
	private WeixinSendDataVo data;//模版数据
	public String getTouser() {
		return touser;
	}
	public void setTouser(String touser) {
		this.touser = touser;
	}
	public String getTemplate_id() {
		return template_id;
	}
	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Map<String, Object> getMiniprogram() {
		return miniprogram;
	}
	public void setMiniprogram(Map<String, Object> miniprogram) {
		this.miniprogram = miniprogram;
	}
	public WeixinSendDataVo getData() {
		return data;
	}
	public void setData(WeixinSendDataVo data) {
		this.data = data;
	}
	
	
	
		
}
