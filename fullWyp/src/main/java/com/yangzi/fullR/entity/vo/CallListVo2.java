package com.yangzi.fullR.entity.vo;

import java.util.List;

/**
 * 总控对象实体类
 * @author win7
 *lzd
 */
public class CallListVo2 {

	private String empID;
	private String empName;
	private String workUnitID;//院所ID
	private String WorkUnitName;//院所名称
	private Integer officeId;
	private String officeName;
	private Integer countList;//排队数量
	private Integer countPass;//过号数量
	private Integer alreadyCall;//已经呼叫数量
	private Integer alreadyTreated;//已经就诊数量
	private List<CallListVo> volist;
	public String getEmpID() {
		return empID;
	}
	public void setEmpID(String empID) {
		this.empID = empID;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getWorkUnitID() {
		return workUnitID;
	}
	public void setWorkUnitID(String workUnitID) {
		this.workUnitID = workUnitID;
	}
	public String getWorkUnitName() {
		return WorkUnitName;
	}
	public void setWorkUnitName(String workUnitName) {
		WorkUnitName = workUnitName;
	}
	public Integer getCountList() {
		return countList;
	}
	public void setCountList(Integer countList) {
		this.countList = countList;
	}
	public Integer getCountPass() {
		return countPass;
	}
	public void setCountPass(Integer countPass) {
		this.countPass = countPass;
	}
	public Integer getAlreadyCall() {
		return alreadyCall;
	}
	public void setAlreadyCall(Integer alreadyCall) {
		this.alreadyCall = alreadyCall;
	}
	public Integer getAlreadyTreated() {
		return alreadyTreated;
	}
	public void setAlreadyTreated(Integer alreadyTreated) {
		this.alreadyTreated = alreadyTreated;
	}
	public List<CallListVo> getVolist() {
		return volist;
	}
	public void setVolist(List<CallListVo> volist) {
		this.volist = volist;
	}
	public Integer getOfficeId() {
		return officeId;
	}
	public void setOfficeId(Integer officeId) {
		this.officeId = officeId;
	}
	public String getOfficeName() {
		return officeName;
	}
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	
	
	
	
}
