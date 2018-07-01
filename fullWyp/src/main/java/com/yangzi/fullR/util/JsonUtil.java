package com.yangzi.fullR.util;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.Version;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.impl.SimpleBeanPropertyFilter;
import com.fasterxml.jackson.databind.ser.impl.SimpleFilterProvider;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
/**
 * Jsontool
 * @author lzd
 *  
 */
public class JsonUtil {
	private static String[] DATE_FORMATS = new String[] { "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", "yyyy-MM-dd" };

	public static ObjectMapper getObjectMapper() {
		ObjectMapper mapper = new ObjectMapper();
		SimpleBeanPropertyFilter propertyFilter = SimpleBeanPropertyFilter.serializeAllExcept(CollectionUtil
				.array2Set(new String[0]));
		SimpleFilterProvider filters = new SimpleFilterProvider().addFilter("excludeFilter", propertyFilter);
		mapper.setFilters(filters);
		return mapper;
	}

	public static String obj2Json(final Object obj) {
		return obj2Json(obj, null, null, null);
	}
    
	public static String obj2Json(final Object obj,String dateformat){
		return obj2Json(obj,dateformat,null,null);
	}
	 
	public static String obj2Json(final Object obj, String[] excludes) {
		return obj2Json(obj, null, excludes, null);
	}

	public static String obj2Json(final Object obj, String[] excludes, Set<String> codeFields) {
		return obj2Json(obj, null, excludes, codeFields);
	}

	protected static String obj2Json(final Object obj, String dateformat, String[] excludes, Set<String> codeFields) {
		ObjectMapper mapper = getObjectMapper();
		SimpleDateFormat format;
		try {
			format = new SimpleDateFormat(dateformat);
		} catch (Exception ex) {
			format = DateOperator.defaultDateFormaterWithTime;
		}
		SimpleModule testModule = new SimpleModule("BooleanModule", Version.unknownVersion());
		ToStringSerializer stringSerializer = new ToStringSerializer();
		// testModule.addSerializer(boolean.class, stringSerializer);
		testModule.addSerializer(String.class, stringSerializer);
		mapper.registerModule(testModule);
		mapper.setDateFormat(format);
		SimpleBeanPropertyFilter propertyFilter = SimpleBeanPropertyFilter.serializeAllExcept(CollectionUtil
				.array2Set(excludes));
		SimpleFilterProvider filters = new SimpleFilterProvider().addFilter("excludeFilter", propertyFilter);
		mapper.setFilters(filters);
		CustomerSerializerFactory factory = new CustomerSerializerFactory(null);
		mapper.setSerializerFactory(factory);
//		
		mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
		// 去掉null值
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		// mapper.configure(JsonGenerator.Feature.WRITE_NUMBERS_AS_STRINGS,
		// true);
		String jsonString = "";
		try {
			jsonString = mapper.writeValueAsString(obj);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// JsonConfig config = getJsonConfig(excludes, dateformat, codeFields);
		return jsonString;
	}

	/**
	 * 把jsonString转成对象
	 * 
	 * @param clazz
	 * @param jsonString
	 * @param root
	 * @return
	 */
	public static <T> List<T> json2List(Class<T> clazz, String jsonString, String root) {
		ObjectMapper mapper = getObjectMapper();
		List<T> list = new ArrayList<T>();

		try {
			JSONObject jsonObject = new JSONObject(jsonString);
			JSONArray array = jsonObject.getJSONArray(root);
			for (int i = 0; i < array.length(); i++) {
				T obj = mapper.readValue(array.getString(i), clazz);
				list.add(obj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// JSONObject jsonObject = JSONObject.fromObject(jsonString);
		// JSONArray jsonArray = jsonObject.getJSONArray(root);
		// JSONUtils.getMorpherRegistry().registerMorpher(new
		// DateMorpher(DATE_FORMATS));
		return list;
	}
	
	public static <T> List<T> json2List(Class<T> clazz, String jsonString) {
		ObjectMapper mapper = getObjectMapper();
		List<T> list = new ArrayList<T>();

		try {
			JSONArray array = new JSONArray(jsonString);
			for (int i = 0; i < array.length(); i++) {
				try {
					T obj = mapper.readValue(array.getString(i), clazz);
					list.add(obj);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 把jsonString转成对象
	 * 
	 * @param <T>
	 * @param clazz
	 * @param jsonString
	 * @return
	 */
	public static <T> T json2Object(Class<T> clazz, String jsonString) {
		ObjectMapper mapper = getObjectMapper();

		// JSONObject jsonObject = JSONObject.fromObject(jsonString);
		// JSONUtils.getMorpherRegistry().registerMorpher(new
		// DateMorpher(DATE_FORMATS));
		try {
			return mapper.readValue(jsonString, clazz);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	protected static void renderDataJson(HttpServletResponse response, final Object obj, String dateformat,
			String[] excludes, Set<String> codeFields) {
		String jsonString = obj2Json(obj);
		RenderUtil.renderText(jsonString, response);
	}
	  //把List<Map<String, Object>>的字符串转换成JsonArray  
    public static String parseListForMapsToJsonArrayStr(List<Map<String, Object>> list) {  
        String jsonArrayStr = null;  
        if(list != null && list.size() != 0) {  
            JSONArray jsonArray = new JSONArray();  
            JSONObject jsonObject = null;  
            Object value = null;  
            for(Map<String, Object> map : list) {   
                jsonObject = new JSONObject();  
                Set<String> set = map.keySet();  
                for(String key : set) {  
                    value = map.get(key);  
                    if(value != null) {  
                        try {  
                            jsonObject.put(key, value.toString());  
                        } catch (JSONException e) {  
                            e.printStackTrace();  
                        }  
                    }  
                }  
                if(jsonObject.length() != 0) {  
                    jsonArray.put(jsonObject);  
                }  
            }  
            jsonArrayStr = jsonArray.toString();  
        }  
          
        return jsonArrayStr;  
    }  
      
	
}
