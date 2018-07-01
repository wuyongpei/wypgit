package com.yangzi.fullR.entity;

/**
 * 职位对象
 * 2018-04-17
 * @author lzd
 *
 */
public class WorkPosition {
   
	 private Integer workPositionID;
	 private String workPositionName;
	 private String workPositionCode;
	 private String wnsell;
	 private Integer ofID;
	 private String wcomment;
	 private String wstatus;
	 private Office office;
	public Integer getWorkPositionID() {
		return workPositionID;
	}
	public void setWorkPositionID(Integer workPositionID) {
		this.workPositionID = workPositionID;
	}
	public String getWorkPositionName() {
		return workPositionName;
	}
	public void setWorkPositionName(String workPositionName) {
		this.workPositionName = workPositionName;
	}
	public String getWorkPositionCode() {
		return workPositionCode;
	}
	public void setWorkPositionCode(String workPositionCode) {
		this.workPositionCode = workPositionCode;
	}
	public String getWnsell() {
		return wnsell;
	}
	public void setWnsell(String wnsell) {
		this.wnsell = wnsell;
	}
	public Integer getOfID() {
		return ofID;
	}
	public void setOfID(Integer ofID) {
		this.ofID = ofID;
	}
	public String getWcomment() {
		return wcomment;
	}
	public void setWcomment(String wcomment) {
		this.wcomment = wcomment;
	}
	public String getWstatus() {
		return wstatus;
	}
	public void setWstatus(String wstatus) {
		this.wstatus = wstatus;
	}
	public Office getOffice() {
		return office;
	}
	public void setOffice(Office office) {
		this.office = office;
	}

	
}
