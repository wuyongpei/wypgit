package com.yangzi.fullR.system;

import java.util.Date;

import com.yangzi.fullR.entity.base.Page;

/**
 * 
* 类名称：User.java
* 类描述： 
* @author FH
* 作者单位： 
* 联系方式：
* 创建时间：2014年6月28日
* @version 1.0
 */
public class FREmp {
	
	private String Emp_ID;		//用户id
	private String Emp_Name;	//用户名
	private String Pass_Word; 	//密码
	private String E_Name;		//姓名
	private String Rights;		//权限
	private String Role_ID;		//角色id
	private String Last_Login;	//最后登录时间
	private String Ip;			//用户登录ip地址
	private String Status;		//状态
	private String Skin;		//皮肤
	private String WorkUnitID;  //工作单位
	private Integer OfficeID;
	private Integer WorkPositionID;
	private Role role;			//角色对象
	private Page page;			//分页对象
	public String getEmp_ID() {
		return Emp_ID;
	}
	public void setEmp_ID(String emp_ID) {
		Emp_ID = emp_ID;
	}
	public String getEmp_Name() {
		return Emp_Name;
	}
	public void setEmp_Name(String emp_Name) {
		Emp_Name = emp_Name;
	}
	public String getPass_Word() {
		return Pass_Word;
	}
	public void setPass_Word(String pass_Word) {
		Pass_Word = pass_Word;
	}
	public String getE_Name() {
		return E_Name;
	}
	public void setE_Name(String e_Name) {
		E_Name = e_Name;
	}
	public String getRights() {
		return Rights;
	}
	public void setRights(String rights) {
		Rights = rights;
	}
	public String getRole_ID() {
		return Role_ID;
	}
	public void setRole_ID(String role_ID) {
		Role_ID = role_ID;
	}
	public String getLast_Login() {
		return Last_Login;
	}
	public void setLast_Login(String last_Login) {
		Last_Login = last_Login;
	}
	public String getIp() {
		return Ip;
	}
	public void setIp(String ip) {
		Ip = ip;
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	public String getSkin() {
		return Skin;
	}
	public void setSkin(String skin) {
		Skin = skin;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public String getWorkUnitID() {
		return WorkUnitID;
	}
	public void setWorkUnitID(String workUnitID) {
		WorkUnitID = workUnitID;
	}
	public Integer getOfficeID() {
		return OfficeID;
	}
	public void setOfficeID(Integer officeID) {
		OfficeID = officeID;
	}
	public Integer getWorkPositionID() {
		return WorkPositionID;
	}
	public void setWorkPositionID(Integer workPositionID) {
		WorkPositionID = workPositionID;
	}
	
	
	
}
