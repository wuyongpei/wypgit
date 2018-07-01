package com.yangzi.fullR.util;

import java.io.IOException;
import java.util.Properties;

public class SysParamsToolkit {

	 public static Properties prop; 

     public  SysParamsToolkit() { 
     } 

     static { 
//             reload(); 
             reload1();
     } 

//     public static boolean reload() { 
//             boolean flag = true; 
//             prop = new Properties(); 
//             try { 
//                     prop.load(SysParamsToolkit.class.getResourceAsStream("/wscfg.properties")); 
//                     flag = false; 
//             } catch (IOException e) { 
//                     e.printStackTrace(); 
//             } 
//             return flag; 
//     } 
     public static boolean reload1() { 
         boolean flag = true; 
         prop = new Properties(); 
         try { 
                 prop.load(SysParamsToolkit.class.getResourceAsStream("/dbconfig.properties")); 
                 flag = false; 
         } catch (IOException e) { 
                 e.printStackTrace(); 
         } 
         return flag; 
 } 

     public static Properties getSysProperties() { 
             return prop; 
     } 

     public static Properties getFileProperties(){
    	  return prop; 
     }
     /** 
      * 获取指定的系统属性值 
      * 
      * @param key 指定的属性名称 
      * @return 指定的系统属性值 
      */ 
     public static String getProperty(String key) { 
             return prop.getProperty(key); 
     } 

     /** 
      * 获取指定的系统属性值 
      * 
      * @param key                指定的属性名称 
      * @param defaultVal 默认值 
      * @return 指定的系统属性值 
      */ 
     public static String getProperty(String key, String defaultVal) { 
             return prop.getProperty(key, defaultVal); 
     } 

     public static void main(String[] args) { 
             Properties prop = getSysProperties(); 
          String ip =    prop.getProperty("Java6WS.wsip");
          System.out.println(ip);
             
     } 
}
