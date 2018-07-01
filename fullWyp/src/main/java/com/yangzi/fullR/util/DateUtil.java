package com.yangzi.fullR.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DateUtil {

	private final static SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");

	private final static SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");

	private final static SimpleDateFormat sdfDays = new SimpleDateFormat("yyyyMMdd");

	private final static SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	/**
	 * 获取YYYY格式
	 * 
	 * @return
	 */
	public static String getYear() {
		return sdfYear.format(new Date());
	}

	/**
	 * 获取YYYY-MM-DD格式
	 * 
	 * @return
	 */
	public static String getDay() {
		return sdfDay.format(new Date());
	}

	/**
	 * 获取YYYYMMDD格式
	 * 
	 * @return
	 */
	public static String getDays() {
		return sdfDays.format(new Date());
	}

	/**
	 * 获取YYYY-MM-DD HH:mm:ss格式
	 * 
	 * @return
	 */
	public static String getTime() {
		return sdfTime.format(new Date());
	}

	/**
	 * @Title: compareDate
	 * @Description: TODO(日期比较，如果s>=e 返回true 否则返回false)
	 * @param s
	 * @param e
	 * @return boolean
	 * @throws @author
	 *             luguosui
	 */
	public static boolean compareDate(String s, String e) {
		if (fomatDate(s) == null || fomatDate(e) == null) {
			return false;
		}
		return fomatDate(s).getTime() >= fomatDate(e).getTime();
	}

	/**
	 * 格式化日期
	 * 
	 * @return
	 */
	public static Date fomatDate(String date) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return fmt.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 校验日期是否合法
	 * 
	 * @return
	 */
	public static boolean isValidDate(String s) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		try {
			fmt.parse(s);
			return true;
		} catch (Exception e) {
			// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
			return false;
		}
	}

	public static int getDiffYear(String startTime, String endTime) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		try {
			long aa = 0;
			int years = (int) (((fmt.parse(endTime).getTime() - fmt.parse(startTime).getTime()) / (1000 * 60 * 60 * 24))
					/ 365);
			return years;
		} catch (Exception e) {
			// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
			return 0;
		}
	}

	/**
	 * <li>功能描述：时间相减得到天数
	 * 
	 * @param beginDateStr
	 * @param endDateStr
	 * @return long
	 * @author Administrator
	 */
	public static long getDaySub(String beginDateStr, String endDateStr) {
		long day = 0;
		java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.util.Date beginDate = null;
		java.util.Date endDate = null;

		try {
			beginDate = format.parse(beginDateStr);
			endDate = format.parse(endDateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		day = (endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60 * 1000);
		// System.out.println("相隔的天数="+day);

		return day;
	}

	/**
	 * 得到n天之后的日期
	 * 
	 * @param days
	 * @return
	 */
	public static String getAfterDayDate(String days) {
		int daysInt = Integer.parseInt(days);

		Calendar canlendar = Calendar.getInstance(); // java.util包
		canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
		Date date = canlendar.getTime();

		SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateStr = sdfd.format(date);

		return dateStr;
	}

	/**
	 * 得到n天之后的日期
	 * 
	 * @param days
	 *            datetime
	 * @return
	 */
	public static String getAfterDayDate2(String dateTimeStr, String days) {
		int daysInt = Integer.parseInt(days);
		SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-MM-dd");
		Date d = new Date();
		try {
			d = sdfd.parse(dateTimeStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Calendar canlendar = Calendar.getInstance(); // java.util包
		canlendar.setTime(d);
		canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
		Date date = canlendar.getTime();
		String dateStr = sdfd.format(date);
		return dateStr;

	}

	/**
	 * 得到n天之后是周几
	 * 
	 * @param days
	 * @return
	 */
	public static String getAfterDayWeek(String days) {
		int daysInt = Integer.parseInt(days);

		Calendar canlendar = Calendar.getInstance(); // java.util包
		canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
		Date date = canlendar.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("E");
		String dateStr = sdf.format(date);

		return dateStr;
	}

	/**
	 * 获取本周周一日期
	 * 
	 * @return
	 */
	public static String getNowMonday() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		Date date = cal.getTime();
		String day = sdf.format(date);
		return day;
	}

	/**
	 * 根据起始时间和结束时间，以及间隔时间获取间隔票数
	 */
	public static int getCount(String start, String end, int interval) {
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		Date d1;
		Date d2;
		int count = 0;
		try {
			d1 = sdf.parse(start);
			d2 = sdf.parse(end);
			count = (int) ((d2.getTime() - d1.getTime()) / (60 * 1000)) / interval;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

	/**
	 * 获取时间间隔时间段队列
	 * 
	 * @param start
	 * @param end
	 * @param interval
	 * @return
	 * @throws ParseException
	 */
	public static List<String> getAllTimeMsg(String start, String end, int interval) throws ParseException {
		List<String> liststr = new ArrayList<String>();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		int count = getCount(start, end, interval);
		for (int i = 0; i < count; i++) {
			Date st = sdf.parse(start);
			Long st1 = st.getTime() + (i * interval * 60 * 1000);
			Date st2 = new Date(st1);
			String str = sdf.format(st2);
			liststr.add(str);
		}
		return liststr;
	}

	/**
	 * 获取指定日期的上月日期
	 * 2018-06-03
	 * @author wyp
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String getDateAfterMonth(String date, int month) throws ParseException {
		Date dateD = sdfDay.parse(date);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateD);
		calendar.add(Calendar.MONTH, month);
		return sdfDay.format(calendar.getTime());
	}

	/**
	 * 根据日期获取周几及简拼
	 * 2018-06-03
	 * @author wyp
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String[] getWeek(String date) throws ParseException {
		String[] week = new String[2];
		Date dateD = sdfDay.parse(date);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateD);
		week[0] = String.valueOf(calendar.get(Calendar.DAY_OF_WEEK));
		switch (week[0]) {
		case "0":
			week[1] = "sun";
			break;
		case "1":
			week[1] = "mon";
			break;
		case "2":
			week[1] = "tue";
			break;
		case "3":
			week[1] = "wed";
			break;
		case "4":
			week[1] = "thu";
			break;
		case "5":
			week[1] = "fri";
			break;
		case "6":
			week[1] = "sat";
			break;
		default:
			break;
		}
		return week;
	}

	/**
	 * 获取日期的年月日
	 * @author wyp
	 * 2018年6月27日  
	 * @param time 时间字符串
	 * @param type 获取的类型(1:year,2:month,5:date,10:hour,12:minute,13:second-详细见Calendar类)
	 * @return
	 * @throws ParseException 
	 */
	public static int getYearMonthDate(String time,int type) throws ParseException {
		Date date=sdfDay.parse(time);
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		
		return cal.get(type);
	}
	
	public static void main(String[] args) throws ParseException {
		// System.out.println(getDays());
		// System.out.println(getAfterDayWeek("3"));
		// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// try {
		// Date date =sdf.parse("2018-05-10");
		// System.out.println(date.getTime());
		// } catch (ParseException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// String str = getAfterDayDate2("2018-05-10","7");
		//String str = getNowMonday();
		int str=getYearMonthDate("2018-05-31",5);
		System.out.println(str);
	}

}
