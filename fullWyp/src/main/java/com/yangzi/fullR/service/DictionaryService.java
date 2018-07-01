package com.yangzi.fullR.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yangzi.fullR.dao.DaoSupport;
import com.yangzi.fullR.entity.Dictionary;
import com.yangzi.fullR.util.PageData;

@Service("dictionaryService")
public class DictionaryService {

	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	/**
	 * 显示字典列表
	 * cwh
	 * 2018-04-28
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getDictionaryTypeList() throws Exception {
		return (List<PageData>) dao.findForList("FRDictionaryMapper.getDictionaryTypeList", null);
	}
	/**
	 * 根据字典类型加载对应详细列表
	 * cwh
	 * 2018-04-28
	 * @param dicitonaryType
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getDictionaryListByType(int dictionaryid) throws Exception{
		return (List<PageData>) dao.findForList("FRDictionaryMapper.getDictionaryListByType", dictionaryid);
	}
	/**
	 * 根据字典id查询字典
	 * cwh
	 * 2018-05-02
	 * @param dictionaryid
	 * @return
	 * @throws Exception
	 */
	public PageData getDictionaryById(int dictionaryid) throws Exception {
		return (PageData) dao.findForObject("FRDictionaryMapper.getDictionaryById", dictionaryid);
	}
	/**
	 * 新增字典
	 * cwh
	 * 2018-05-02
	 * @param dictionary
	 * @throws Exception
	 */
	public void saveDictionary(Dictionary dictionary) throws Exception {
		dao.save("FRDictionaryMapper.insertDictionary", dictionary);
	}
	/**
	 * 编辑字典
	 * cwh
	 * 2018-05-02
	 * @param dictionary
	 * @throws Exception
	 */
	public void updateDictionary(Dictionary dictionary) throws Exception {
		dao.update("FRDictionaryMapper.updateDictionary", dictionary);
	}
	/**
	 * 删除字典
	 * cwh
	 * 2018-05-03
	 * @param dictionaryID
	 * @throws Exception
	 */
	public void deleteDictionary(int dictionaryid) throws Exception {
		dao.delete("FRDictionaryMapper.deleteDictionary", dictionaryid);
	}
	
	/**
	 * 根据父名称获取子字典名称
	 * 
	 */
	public List<PageData> getDictionaryByName(String DictionaryName)throws Exception {
		return (List<PageData>) dao.findForList("FRDictionaryMapper.getDictionaryByName", DictionaryName);
	}
	
	/**
	 * lzd
	 * 20180605
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public String getDictionaryNameByCons(PageData pd)throws Exception{
		return (String) dao.findForObject("FRDictionaryMapper.getDictionaryNameByCons", pd);
	}
	
	
	
 }
