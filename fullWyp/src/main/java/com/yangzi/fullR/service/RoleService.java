package com.yangzi.fullR.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.system.Role;
import com.yangzi.fullR.util.PageData;

@Service("roleService")
public class RoleService {
 
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	
	//获取所有二级角色
	public List<Role> listAllERRoles() throws Exception {
		return (List<Role>) dao.findForList("RoleMapper.listAllERRoles", null);
		
	}
	
	
	//通过当前登录用的角色id获取管理权限数据
	public PageData findGLbyrid(PageData pd) throws Exception {
		return (PageData) dao.findForObject("RoleMapper.findGLbyrid", pd);
	}
	
	
	/**
	 * 通过id查找
	 */
	public PageData findObjectById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("RoleMapper.findObjectById", pd);
	}
	
	
	   //通过当前登录用的角色id获取用户权限数据
		public PageData findYHbyrid(PageData pd) throws Exception {
			return (PageData) dao.findForObject("RoleMapper.findYHbyrid", pd);
		}
	
	    /**
	     * 列出所有角色
	     * @return
	     * @throws Exception
	     */
		public List<Role> listAllRoles() throws Exception {
			return (List<Role>) dao.findForList("RoleMapper.listAllRoles", null);
			
		}
		
		
		/**
		 * 列出此部门的所有下级
		 */
		public List<Role> listAllRolesByPId(PageData pd) throws Exception {
			return (List<Role>) dao.findForList("RoleMapper.listAllRolesByPId", pd);
			
		}
		
		//列出此角色下的所有用户
		public List<PageData> listAllUByRid(PageData pd) throws Exception {
			return (List<PageData>) dao.findForList("RoleMapper.listAllUByRid", pd);
			
		}
		
		//列出K权限表里的数据 
		public List<PageData> listAllkefu(PageData pd) throws Exception {
			return (List<PageData>) dao.findForList("RoleMapper.listAllkefu", pd);
		}
		
		//列出G权限表里的数据 
		public List<PageData> listAllGysQX(PageData pd) throws Exception {
			return (List<PageData>) dao.findForList("RoleMapper.listAllGysQX", pd);
		}
		
		/**
		 * 保存客服权限
		 */
		public void saveKeFu(PageData pd) throws Exception {
			dao.save("RoleMapper.saveKeFu", pd);
		}
		
		/**
		 * 保存G权限
		 */
		public void saveGYSQX(PageData pd) throws Exception {
			dao.save("RoleMapper.saveGYSQX", pd);
		}
		
		/**
		 * 添加
		 */
		public void add(PageData pd) throws Exception {
			dao.save("RoleMapper.insert", pd);
		}
		
		/**
		 * 编辑角色
		 */
		public PageData edit(PageData pd) throws Exception {
			return (PageData)dao.update("RoleMapper.edit", pd);
		}
		
		public Role getRoleById(String roleId) throws Exception {
			return (Role) dao.findForObject("RoleMapper.getRoleById", roleId);
			
		}
		
		//删除K权限表里对应的数据
		public void deleteKeFuById(String ROLE_ID) throws Exception {
			dao.delete("RoleMapper.deleteKeFuById", ROLE_ID);
		}
		
		//删除G权限表里对应的数据
		public void deleteGById(String ROLE_ID) throws Exception {
			dao.delete("RoleMapper.deleteGById", ROLE_ID);
		}
		
		public void deleteRoleById(String ROLE_ID) throws Exception {
			dao.delete("RoleMapper.deleteRoleById", ROLE_ID);
			
		}
		
		public void updateRoleRights(Role role) throws Exception {
			dao.update("RoleMapper.updateRoleRights", role);
		}
		
		/**
		 * 给全部子职位加菜单权限
		 */
		public void setAllRights(PageData pd) throws Exception {
			dao.update("RoleMapper.setAllRights", pd);
		}
		/**
		 * 客服权限
		 */
		public void updateKFQx(String msg,PageData pd) throws Exception {
			dao.update("RoleMapper."+msg, pd);
		}
		/**
		 * 权限(增删改查)
		 */
		public void updateQx(String msg,PageData pd) throws Exception {
			dao.update("RoleMapper."+msg, pd);
		}
}
