package com.yangzi.fullR.weixin.entity.vo;
/**
 * 微信网页授权access_token
 * @author Administrator
 *
 */
public class AccessTokenVo {

	private String access_token;//网页授权接口调用凭证
	private String expires_in;//access_token接口调用凭证超时时间
	private String refresh_token;//用户刷新access_token
	private String openid;//用户唯一标识
	private String scope;//用户授权的作用域
	
	//错误返回
	private String errcode;
	private String errmsg;
	public String getAccess_token() {
		return access_token;
	}
	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}
	public String getExpires_in() {
		return expires_in;
	}
	public void setExpires_in(String expires_in) {
		this.expires_in = expires_in;
	}
	public String getRefresh_token() {
		return refresh_token;
	}
	public void setRefresh_token(String refresh_token) {
		this.refresh_token = refresh_token;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public String getScope() {
		return scope;
	}
	public void setScope(String scope) {
		this.scope = scope;
	}
	public String getErrcode() {
		return errcode;
	}
	public void setErrcode(String errcode) {
		this.errcode = errcode;
	}
	public String getErrmsg() {
		return errmsg;
	}
	public void setErrmsg(String errmsg) {
		this.errmsg = errmsg;
	}
	
	
}
