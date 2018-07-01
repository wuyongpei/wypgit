package com.yangzi.fullR.system;

import java.util.List;
/**
 * 
* 类名称：Menu.java
* 类描述： 
* @author FH
* 作者单位： 
* 联系方式：
* 创建时间：2014年6月28日
* @version 1.0
 */
public class Menu {
	
	private String menu_Id;
	private String menu_Name;
	private String menu_Url;
	private String parent_Id;
	private String menu_Order;
	private String menu_Icon;
	private String menu_Type;
	private String menu_Level;
	private String status;
	private String target;
	
	private Menu parentMenu;
	private List<Menu> subMenu;
	
	private boolean hasMenu = false;

	public String getMenu_Id() {
		return menu_Id;
	}

	public void setMenu_Id(String menu_Id) {
		this.menu_Id = menu_Id;
	}

	public String getMenu_Name() {
		return menu_Name;
	}

	public void setMenu_Name(String menu_Name) {
		this.menu_Name = menu_Name;
	}

	public String getMenu_Url() {
		return menu_Url;
	}

	public void setMenu_Url(String menu_Url) {
		this.menu_Url = menu_Url;
	}

	public String getParent_Id() {
		return parent_Id;
	}

	public void setParent_Id(String parent_Id) {
		this.parent_Id = parent_Id;
	}

	public String getMenu_Order() {
		return menu_Order;
	}

	public void setMenu_Order(String menu_Order) {
		this.menu_Order = menu_Order;
	}

	public String getMenu_Icon() {
		return menu_Icon;
	}

	public void setMenu_Icon(String menu_Icon) {
		this.menu_Icon = menu_Icon;
	}

	public String getMenu_Type() {
		return menu_Type;
	}

	public void setMenu_Type(String menu_Type) {
		this.menu_Type = menu_Type;
	}

	public String getMenu_Level() {
		return menu_Level;
	}

	public void setMenu_Level(String menu_Level) {
		this.menu_Level = menu_Level;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public Menu getParentMenu() {
		return parentMenu;
	}

	public void setParentMenu(Menu parentMenu) {
		this.parentMenu = parentMenu;
	}

	public List<Menu> getSubMenu() {
		return subMenu;
	}

	public void setSubMenu(List<Menu> subMenu) {
		this.subMenu = subMenu;
	}

	public boolean isHasMenu() {
		return hasMenu;
	}

	public void setHasMenu(boolean hasMenu) {
		this.hasMenu = hasMenu;
	}


	
	
}
