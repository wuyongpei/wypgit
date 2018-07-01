package com.yangzi.fullR.entity;
/**
 * 数据字典对象
 * 2018-05-02
 * @author cwh
 *
 */
public class Dictionary {
	
	private int dictionaryID;
	private String dictionaryCode;
	private String dictionaryName;
	private int dictionaryType;
	private int orderIndex;
	private String simpleCode;
	private String comment;
	private int patientID;
	public int getDictionaryID() {
		return dictionaryID;
	}
	public void setDictionaryID(int dictionaryID) {
		this.dictionaryID = dictionaryID;
	}
	public String getDictionaryCode() {
		return dictionaryCode;
	}
	public void setDictionaryCode(String dictionaryCode) {
		this.dictionaryCode = dictionaryCode;
	}
	public String getDictionaryName() {
		return dictionaryName;
	}
	public void setDictionaryName(String dictionaryName) {
		this.dictionaryName = dictionaryName;
	}
	public int getDictionaryType() {
		return dictionaryType;
	}
	public void setDictionaryType(int dictionaryType) {
		this.dictionaryType = dictionaryType;
	}
	public int getOrderIndex() {
		return orderIndex;
	}
	public void setOrderIndex(int orderIndex) {
		this.orderIndex = orderIndex;
	}
	public String getSimpleCode() {
		return simpleCode;
	}
	public void setSimpleCode(String simpleCode) {
		this.simpleCode = simpleCode;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getPatientID() {
		return patientID;
	}
	public void setPatientID(int patientID) {
		this.patientID = patientID;
	}

	
	
}
