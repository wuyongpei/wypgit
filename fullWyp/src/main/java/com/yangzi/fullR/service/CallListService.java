package com.yangzi.fullR.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.entity.vo.CallListVo;
import com.yangzi.fullR.util.PageData;
/**
 * 队列服务层
 * lzd
 * 20180604
 * @author Administrator
 *
 */
@Service("callListService")
public class CallListService {
    
	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	/**
	 * lzd
	 * 20180604
	 * 根据当天时间，当前登录用户ID获取队列 
	 * 只获取当天当前用户的队列
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getCallListByCons(PageData pd)throws Exception{
		
		return (List<PageData>) dao.findForList("CallListMapper.getCallListByCons", pd);
	}
	
	/**
	 * lzd
	 * 20180611
	 * 根据Id获取对象
	 * @param queueID
	 * @return
	 * @throws Exception
	 */
	public PageData getCallByID(String queueID)throws Exception{
		return  (PageData) dao.findForObject("CallListMapper.getCallByID", queueID);
	}
	
	/**
	 * 查询lzd 20180606
	 * 根据条件获取唯一的一条数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getNextOne(PageData pd)throws Exception{
		return (PageData) dao.findForObject("CallListMapper.getNextOne", pd);
	}
	
	/**
	 * 获取当前叫号人
	 * lzd 20180606
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getNowOne(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CallListMapper.getNowOne", pd);
	}
	
	/**
	 * 根据条件统计
	 * lzd 20180606
	 * @return
	 * @throws Exception
	 */
	public int countByStatusAndMySelf(PageData pd)throws Exception{
		return (int) dao.findForObject("CallListMapper.countByStatusAndMySelf", pd);
	}
	
	/**
	 * lzd
	 * 20180605
	 * 保存队列操作
	 * @param pd
	 * @throws Exception
	 */
	public void saveQueue(CallListVo vo)throws Exception{
	        dao.save("CallListMapper.insertQueue", vo);
	}
	
	/**
	 * lzd
	 * 20180606
	 * 更新
	 * @param queueID
	 * @throws Exception
	 */
	public void updateQueue(PageData pd)throws Exception{
		    dao.update("CallListMapper.updatgeQueue", pd);
	}
	/**
	 * lzd
	 * 20180611
	 * 更新
	 * @param pd
	 * @throws Exception
	 */
	public void updateQueUeC(PageData pd)throws Exception{
		 dao.update("CallListMapper.updateQueUeC", pd);
	}
	
   /**
    * lzd
    * 通过officeID 获取关联设备使用IP
    * @param oficeID
    * @return
    * @throws Exception
    */
    public PageData getVoiceControlIP(Integer oficeID)throws Exception{
    	return (PageData) dao.findForObject("VoiceIPR.getVoiceControlIP", oficeID);
    }
	
}
