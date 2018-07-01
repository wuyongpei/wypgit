package com.yangzi.fullR.entity;

import java.beans.Transient;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 工作单位对象
 * 2018-04-17 
 *@author lzd
 *
 */
public class WorkUnit {
    
	private String workUnitID;
	private String workUnitCode;
	private String workUnitName;
	private String nameSpell;
	private String shortName;
	private String telphone;
	private String address;
	private String uRL;
	private String email;
	private String linkman;
	private String linkmanTelphone;
	private String linkmanEmail;
	private Date createDateTime;
	private String comment;
	private String status;
	
	private List<Office> officeList;
	public String getWorkUnitID() {
		return workUnitID;
	}
	public void setWorkUnitID(String workUnitID) {
		this.workUnitID = workUnitID;
	}
	public String getWorkUnitCode() {
		return workUnitCode;
	}
	public void setWorkUnitCode(String workUnitCode) {
		this.workUnitCode = workUnitCode;
	}
	public String getWorkUnitName() {
		return workUnitName;
	}
	public void setWorkUnitName(String workUnitName) {
		this.workUnitName = workUnitName;
	}
	public String getNameSpell() {
		return nameSpell;
	}
	public void setNameSpell(String nameSpell) {
		this.nameSpell = nameSpell;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getTelphone() {
		return telphone;
	}
	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getuRL() {
		return uRL;
	}
	public void setuRL(String uRL) {
		this.uRL = uRL;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getLinkman() {
		return linkman;
	}
	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	public String getLinkmanTelphone() {
		return linkmanTelphone;
	}
	public void setLinkmanTelphone(String linkmanTelphone) {
		this.linkmanTelphone = linkmanTelphone;
	}
	public String getLinkmanEmail() {
		return linkmanEmail;
	}
	public void setLinkmanEmail(String linkmanEmail) {
		this.linkmanEmail = linkmanEmail;
	}
	public Date getCreateDateTime() {
		return createDateTime;
	}
	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public List<Office> getOfficeList() {
		return officeList;
	}
	public void setOfficeList(List<Office> officeList) {
		this.officeList = officeList;
	}
	
	
} 
