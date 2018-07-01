package com.yangzi.fullR.entity;

import java.util.List;
/**
 * 菜单
 * @author win7
 *
 */
public class Menu {
  
	private String menuid;
	private String menuname;
	private String menuurl;
	private String parentid;
	private String menuorder;
	private String menuicon;
	private String menutype;
	private String target;
	private Menu parentMenu;
	private List<Menu> subMenu;
	private boolean hasMenu = false;
	public String getMenuid() {
		return menuid;
	}
	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}
	public String getMenuname() {
		return menuname;
	}
	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}
	public String getMenuurl() {
		return menuurl;
	}
	public void setMenuurl(String menuurl) {
		this.menuurl = menuurl;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getMenuorder() {
		return menuorder;
	}
	public void setMenuorder(String menuorder) {
		this.menuorder = menuorder;
	}
	public String getMenuicon() {
		return menuicon;
	}
	public void setMenuicon(String menuicon) {
		this.menuicon = menuicon;
	}
	public String getMenutype() {
		return menutype;
	}
	public void setMenutype(String menutype) {
		this.menutype = menutype;
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
