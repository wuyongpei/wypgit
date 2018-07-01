package com.yangzi.fullR.entity;

import java.util.List;

/**
 * 科室
 * 2018-04-17
 * @author lzd
 *
 */
public class Office {
  
	private Integer officeID;
	private String officeCode;
	private String officeName;
	private String ospell;
	private Integer officeSort;
	private Integer officeLevel;
	private String wuid;
	private String ostatus;
	private String ofcom;
	private String officeType;
	private WorkUnit workUnit;
	private List<WorkPosition>workPList;
	public Integer getOfficeID() {
		return officeID;
	}
	public void setOfficeID(Integer officeID) {
		this.officeID = officeID;
	}
	public String getOfficeCode() {
		return officeCode;
	}
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	public String getOfficeName() {
		return officeName;
	}
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	public String getOspell() {
		return ospell;
	}
	public void setOspell(String ospell) {
		this.ospell = ospell;
	}
	public Integer getOfficeSort() {
		return officeSort;
	}
	public void setOfficeSort(Integer officeSort) {
		this.officeSort = officeSort;
	}
	public Integer getOfficeLevel() {
		return officeLevel;
	}
	public void setOfficeLevel(Integer officeLevel) {
		this.officeLevel = officeLevel;
	}
	public String getWuid() {
		return wuid;
	}
	public void setWuid(String wuid) {
		this.wuid = wuid;
	}
	public String getOstatus() {
		return ostatus;
	}
	public void setOstatus(String ostatus) {
		this.ostatus = ostatus;
	}
	public WorkUnit getWorkUnit() {
		return workUnit;
	}
	public void setWorkUnit(WorkUnit workUnit) {
		this.workUnit = workUnit;
	}
	public String getOfcom() {
		return ofcom;
	}
	public void setOfcom(String ofcom) {
		this.ofcom = ofcom;
	}
	public List<WorkPosition> getWorkPList() {
		return workPList;
	}
	public void setWorkPList(List<WorkPosition> workPList) {
		this.workPList = workPList;
	}
	public String getOfficeType() {
		return officeType;
	}
	public void setOfficeType(String officeType) {
		this.officeType = officeType;
	}
	

	
	
}
