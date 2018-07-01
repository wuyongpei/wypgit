/**
 * @Name：日期控件
 * @Description：手机条状日期控件
 * @author：Huayf
 * @date：2015年1月12日下午
 */
var timebar = new function() {

    	this.init = initTimeBar;  // 初始化日历控件
    	this.getDate = getDisDate; // 获取当前所选的日期
    	this.nextTime = nextTime;
    	this.lastTime = lastTime;
    	this.id;
	
	var now = new Date();
	/*
	 * 初始化时间控件，传入要渲染div的id，和时间的点击事件
	 */
	function initTimeBar(id,evn){
		this.id = id;
		var timeHtml = '<p  class="calendar-year" style="font-size:14px;" id="calyearp"></p><a href="javascript:timebar.nextTime();" class="mt20 calendar-btn calendar-btn-l"><span class="icon-chevron-left"></span></a><a href="javascript:timebar.lastTime();" class="mt20 calendar-btn calendar-btn-r"><span class="icon-chevron-right"></span></a><div class="calendar-day"><ul class="week week-hd "><li id="wli1">日</li><li id="wli2">一</li><li id="wli3">二</li><li id="wli4">三</li><li id="wli5">四</li><li id="wli6">五</li><li id="wli7">六</li></ul><ul class="week  week-day " id="dul"><li id="dli1"><label>1</label><input type="hidden" value=""/></li><li id="dli2"><label>2</label><input type="hidden" value=""/></li><li id="dli3"><label>3</label><input type="hidden" value=""/></li><li class="duty-cur" id="dli4"><label>4</label><input type="hidden" value=""/></li><li id="dli5"><label>5</label><input type="hidden" value=""/></li><li id="dli6"><label>6</label><input type="hidden" value=""/></li><li id="dli7"><label>7</label><input type="hidden" value=""/></li></ul>';
		$("#"+id).html(timeHtml);
		showTime();//初始化时间
		var distime = $("#dli1 input").val();
		changeTime(distime);//改变显示时间
		changeTimeStyle();//改变选中节点样式
		$("#dul li").click(function(){
			clickTime(this.id);
			if(evn){
				evn();
			}
		});
		
	}

	/*
	 * 时间显示
	 */
	function showTime(){
		var d = new Array(7);
		//var now = new Date();
//		d[3] = now;
//		d[2] = getLastDay(now);
//		d[1] = getLastDay(d[2]);
//		d[0] = getLastDay(d[1]);
//		d[4] = getNextDay(now);
//		d[5] = getNextDay(d[4]);
//		d[6] = getNextDay(d[5]);
		d[0] =now;
		d[1] =getNextDay(now);
		d[2] =getNextDay(d[1]);
		d[3] =getNextDay(d[2]);
		d[4] =getNextDay(d[3]);
		d[5] =getNextDay(d[4]);
		d[6] =getNextDay(d[5]);
		setDataText(d);
		changeTimeStyle();
	}
	/*
	 * 通过时间给文本赋值
	 */
	function setDataText(d){
		for(var i=0;i<7;i++){
			var year = d[i].getYear() + 1900;
			var sunday = d[i].getDay();
			var month = d[i].getMonth()+1;
			var day = d[i].getDate();
			$("#wli"+(i+1)).html(getweek(sunday));//给星期文本复制
			$("#dli"+(i+1)+ " label").html(day);//给日期文本复制
			if(month < 10)
				month = "0" + month;
			if(day < 10)
				day = "0" + day;
			$("#dli"+(i+1)+ " input").val(year+"-"+month+"-"+day+"-"+getweek(sunday));//给隐藏日期赋值
			//周六周日边变红
			if(getweek(sunday)=="日" || getweek(sunday)=="六"){
				$("#wli"+(i+1)).css("color","red");
			}
			else{
				$("#wli"+(i+1)).css("color","black");
			}
		}
	}
	/*
	 * 设置显示日期
	 * return: 当前选择日期
	 */
	function getDisDate(){
		var time = $("#"+ this.id +" input").val();
		var t = time.split("-");
		if(t[1].length==1) t[1] = "0" + t[1];
		if(t[2].length==1) t[2] = "0" + t[2];
		return new Date(t[0],t[1]-1,t[2]);
	}
	/*
	 * 获取时间
	 */
	function clickTime(id){
		$("#dul li").removeClass("duty-cur");
		$("#"+id).addClass("duty-cur");
		var time = $("#"+id +" input").val();
		changeTime(time);
	}
	/*
	 *改变选中显示时间
	 */
	function changeTime(time){
		var t = time.split("-");
		if(t[1].length==1)
			t[1] = "0" + t[1];
		if(t[2].length==1)
			t[2] = "0" + t[2];
		$(".calendar-year").html(t[0]+"年"+ t[1] +"月" + t[2] + "日" +"  星期"+t[3]);
	}
	/*
	 * 改变选中结点样式
	 */
	function changeTimeStyle(){
		$("#dul li").removeClass("duty-cur");
		var time = $(".calendar-year").html();
		var y = time.substring(0,4);
		var m = time.substring(5,7);
		var d = time.substring(8,10);
		//星期
		var w = time.substring(15,16);
		time = y + "-" + m + "-" + d + "-" +w;
		for(var i=0;i<7;i++){
			if($("#dli"+(i+1)+ " input").val() == time)
				$("#dli"+(i+1)).addClass("duty-cur");

		}
	}
	/*
	 * 时间切换,向左滚动,后退（左箭头点击事件）
	 */
	function nextTime(){
		var date=new Date();
		if(now>date){//大于当前时间			
			now = getLastDay(now);
			showTime();
		}
	}
	/*
	 * 时间切换,向右滚动,前进（右箭头点击事件）
	 */
	function lastTime(){
		var date=new Date();
		var interval=7;//预约间隔		
		if(now.getDate()-date.getDate()<(interval-7)){		
			now = getNextDay(now);
			showTime();
		}
	}
	/*
	 * 获取后一天的时间
	 */
	function getNextDay(d){
		d = new Date(d);
		d = + d + 1000 * 60 * 60 * 24;
		d = new Date(d);
		return d;
	}
	/*
	 * 获取前一天的时间
	 */
	function getLastDay(d){
		d = new Date(d);
		d = + d - 1000 * 60 * 60 *24;
		d=new Date(d);
		return d;
	}
	/*
	 * 获取星期
	 */
	function getweek(day){
		  var week = "";
		  switch(day){
			 case 0:week="日";break;
			 case 1:week="一";break;
			 case 2:week="二";break;
			 case 3:week="三";break;
			 case 4:week="四";break;
			 case 5:week="五";break;
			 case 6:week="六";break;
		  }
		  return week;
	}

}
