package com.yangzi.fullR.entity.vo;

public class FRShift {
    
	private Integer shiftId;
	private String shiftName;
	private String comment;
	private Integer shiftValueType;
	private Integer shiftOrder;
	private String startTime;
	private Boolean isWorkTime;
	private Boolean isWorkAttendance;
	private String endTime;
	private Integer parent_Id;
	private Integer shiftLevel;
	private Integer status;//是否启用
	private Integer crossDayType;
	
	public Integer getShiftId() {
		return shiftId;
	}
	public void setShiftId(Integer shiftId) {
		this.shiftId = shiftId;
	}
	public String getShiftName() {
		return shiftName;
	}
	public void setShiftName(String shiftName) {
		this.shiftName = shiftName;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Integer getShiftValueType() {
		return shiftValueType;
	}
	public void setShiftValueType(Integer shiftValueType) {
		this.shiftValueType = shiftValueType;
	}
	public Integer getShiftOrder() {
		return shiftOrder;
	}
	public void setShiftOrder(Integer shiftOrder) {
		this.shiftOrder = shiftOrder;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public Boolean getIsWorkTime() {
		return isWorkTime;
	}
	public void setIsWorkTime(Boolean isWorkTime) {
		this.isWorkTime = isWorkTime;
	}
	public Boolean getIsWorkAttendance() {
		return isWorkAttendance;
	}
	public void setIsWorkAttendance(Boolean isWorkAttendance) {
		this.isWorkAttendance = isWorkAttendance;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public Integer getParent_Id() {
		return parent_Id;
	}
	public void setParent_Id(Integer parent_Id) {
		this.parent_Id = parent_Id;
	}
	public Integer getShiftLevel() {
		return shiftLevel;
	}
	public void setShiftLevel(Integer shiftLevel) {
		this.shiftLevel = shiftLevel;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getCrossDayType() {
		return crossDayType;
	}
	public void setCrossDayType(Integer crossDayType) {
		this.crossDayType = crossDayType;
	}
	
	
}
