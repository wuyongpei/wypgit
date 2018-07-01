package com.yangzi.fullR.weixin.entity.vo;
/**
 * 微信模版发送返回值
 * @author Administrator
 *
 */
public class WeixinSendModelBackVo {

	private Integer errcode;
	private String errmsg;
	private String msgid;
	public Integer getErrcode() {
		return errcode;
	}
	public void setErrcode(Integer errcode) {
		this.errcode = errcode;
	}
	public String getErrmsg() {
		return errmsg;
	}
	public void setErrmsg(String errmsg) {
		this.errmsg = errmsg;
	}
	public String getMsgid() {
		return msgid;
	}
	public void setMsgid(String msgid) {
		this.msgid = msgid;
	}
	
	
}
