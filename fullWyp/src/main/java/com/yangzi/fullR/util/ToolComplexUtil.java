package com.yangzi.fullR.util;

public class ToolComplexUtil {
   
	
	/**
	 * 自动补零
	 * formatLength 补零个数
	 * sourceDate实际数值
	 * @param sourceDate
	 * @param formatLength
	 * @return
	 */
	public static String fronCompWithZore(int sourceDate,int formatLength) {
		
		String newString = String.format("%0"+formatLength+"d", sourceDate);
		return newString;
	}
	
	
	
	
	public static void main(String[] args) {
		String s =fronCompWithZore(5,4);
		System.out.println(s);
	}
}
