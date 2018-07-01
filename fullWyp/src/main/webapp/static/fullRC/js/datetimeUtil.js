
/**  
* 日期范围工具类  
*/  
var dateRangeUtil = (function () {  
	
    /***  
    * 获得当前时间  
    */  
    this.getCurrentDate = function () {  
        return new Date('2015','07','-1');  
    };  
  //获取上周两个时间段  標題展示
    this.getWeekCirle=function(dayType,dateTime){
    	Date.prototype.Format = function (fmt) { //author: meizz   
    	    var o = {  
    	        "M+": this.getMonth() + 1, //月份   
    	        "d+": this.getDate(), //日   
    	        "H+": this.getHours(), //小时   
    	        "m+": this.getMinutes(), //分   
    	        "s+": this.getSeconds(), //秒   
    	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
    	        "S": this.getMilliseconds() //毫秒   
    	    };  
    	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    	    for (var k in o)  
    	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
    	    return fmt;  
    	}  	
    	 //起止日期数组    
        var startStop = new Array();  
        //获取把值时间段 上周则为当前时间数往前推   -7******
        var currentDate = new Date(dateTime);
        //返回date是一周中的某一天    
        var week = currentDate.getDay();  
        //返回date是一个月中的某一天    
        var month = currentDate.getDate();  
        //一天的毫秒数    
        var millisecond = 1000 * 60 * 60 * 24;  
       if(dayType == -1){ //获取上周时间范围
        var lastMon = new Date(currentDate.getTime()- (7*millisecond)).Format("yyyy-MM-dd");
        var lastSun = new Date(currentDate.getTime()-(1*millisecond)).Format("yyyy-MM-dd");
        startStop.push(lastMon);
        startStop.push(lastSun);
          return startStop;
       }else if(dayType ==1){
    	   var nextMon = new Date(currentDate.getTime()+(1*millisecond)).Format("yyyy-MM-dd");
           var nextSun = new Date(currentDate.getTime()+(7*millisecond)).Format("yyyy-MM-dd");
           startStop.push(nextMon);
           startStop.push(nextSun);
             return startStop;
       }else if(dayType ==0){
    	   var nowMon = new Date(currentDate.getTime()).Format("yyyy-MM-dd");
           var nowSun = new Date(currentDate.getTime()+(6*millisecond)).Format("yyyy-MM-dd");
           startStop.push(nowMon);
           startStop.push(nowSun);
             return startStop;
    	   
       }
       
    }  
    
  //获取多個时间段   週一至週日7個時間段 
    this.getWeekSevenDayCirle=function(dayType,dateTime){
    	Date.prototype.Format = function (fmt) { //author: meizz   
    	    var o = {  
    	        "M+": this.getMonth() + 1, //月份   
    	        "d+": this.getDate(), //日   
    	        "H+": this.getHours(), //小时   
    	        "m+": this.getMinutes(), //分   
    	        "s+": this.getSeconds(), //秒   
    	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
    	        "S": this.getMilliseconds() //毫秒   
    	    };  
    	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    	    for (var k in o)  
    	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
    	    return fmt;  
    	}  	
    	 //起止日期数组    
        var startStop = new Array();  
        //获取把值时间段 上周则为当前时间数往前推   -7******
        var currentDate = new Date(dateTime);
        //返回date是一周中的某一天    
        var week = currentDate.getDay();  
        //返回date是一个月中的某一天    
        var month = currentDate.getDate();  
        //一天的毫秒数    
        var millisecond = 1000 * 60 * 60 * 24;  
       if(dayType == -1){ //获取上周时间范围
        var lastMon = new Date(currentDate.getTime()- (7*millisecond)).Format("MM/dd");
        var lastTue = new Date(currentDate.getTime()- (6*millisecond)).Format("MM/dd");
        var lastWed = new Date(currentDate.getTime()- (5*millisecond)).Format("MM/dd");
        var lastThu = new Date(currentDate.getTime()- (4*millisecond)).Format("MM/dd");
        var lastFri = new Date(currentDate.getTime()- (3*millisecond)).Format("MM/dd");
        var lastSat = new Date(currentDate.getTime()- (2*millisecond)).Format("MM/dd");
        var lastSun = new Date(currentDate.getTime()- (1*millisecond)).Format("MM/dd");
        startStop.push(lastMon);
        startStop.push(lastTue);
        startStop.push(lastWed);
        startStop.push(lastThu);
        startStop.push(lastFri);
        startStop.push(lastSat);
        startStop.push(lastSun);
          return startStop;
       }else if(dayType ==1){
    	   var nextMon = new Date(currentDate.getTime()+(1*millisecond)).Format("MM/dd");
    	   var nextTue = new Date(currentDate.getTime()+(2*millisecond)).Format("MM/dd");
    	   var nextWed = new Date(currentDate.getTime()+(3*millisecond)).Format("MM/dd");
    	   var nextThu = new Date(currentDate.getTime()+(4*millisecond)).Format("MM/dd");
    	   var nextFri = new Date(currentDate.getTime()+(5*millisecond)).Format("MM/dd");
    	   var nextSat = new Date(currentDate.getTime()+(6*millisecond)).Format("MM/dd");
           var nextSun = new Date(currentDate.getTime()+(7*millisecond)).Format("MM/dd");
           startStop.push(nextMon);
           startStop.push(nextTue);
           startStop.push(nextWed);
           startStop.push(nextThu);
           startStop.push(nextFri);
           startStop.push(nextSat);
           startStop.push(nextSun);
             return startStop;
       }else if(dayType ==0){
    	   var nowMon = new Date(currentDate.getTime()).Format("MM/dd");
    	   var nowTue = new Date(currentDate.getTime()+(1*millisecond)).Format("MM/dd");
    	   var nowWed = new Date(currentDate.getTime()+(2*millisecond)).Format("MM/dd");
    	   var nowThu = new Date(currentDate.getTime()+(3*millisecond)).Format("MM/dd");
    	   var nowFri = new Date(currentDate.getTime()+(4*millisecond)).Format("MM/dd");
    	   var nowSat = new Date(currentDate.getTime()+(5*millisecond)).Format("MM/dd");
           var nowSun = new Date(currentDate.getTime()+(6*millisecond)).Format("MM/dd");
           startStop.push(nowMon);
           startStop.push(nowTue);
           startStop.push(nowWed);
           startStop.push(nowThu);
           startStop.push(nowFri);
           startStop.push(nowSat);
           startStop.push(nowSun);
             return startStop;
       }		
    }  
    
    //获取多個时间段   週一至週日7個時間段  2
    this.getWeekSevenDayCirle2=function(dayType,dateTime){
    	Date.prototype.Format = function (fmt) { //author: meizz   
    		var o = {  
    				"M+": this.getMonth() + 1, //月份   
    				"d+": this.getDate(), //日   
    				"H+": this.getHours(), //小时   
    				"m+": this.getMinutes(), //分   
    				"s+": this.getSeconds(), //秒   
    				"q+": Math.floor((this.getMonth() + 3) / 3), //季度   
    				"S": this.getMilliseconds() //毫秒   
    		};  
    		if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    		for (var k in o)  
    			if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
    		return fmt;  
    	}  	
    	//起止日期数组    
    	var startStop = new Array();  
    	//获取把值时间段 上周则为当前时间数往前推   -7******
    	var currentDate = new Date(dateTime);
    	//返回date是一周中的某一天    
    	var week = currentDate.getDay();  
    	//返回date是一个月中的某一天    
    	var month = currentDate.getDate();  
    	//一天的毫秒数    
    	var millisecond = 1000 * 60 * 60 * 24;  
    	if(dayType == -1){ //获取上周时间范围
    		var lastMon = new Date(currentDate.getTime()- (7*millisecond)).Format("yyyy-MM-dd");
    		var lastTue = new Date(currentDate.getTime()- (6*millisecond)).Format("yyyy-MM-dd");
    		var lastWed = new Date(currentDate.getTime()- (5*millisecond)).Format("yyyy-MM-dd");
    		var lastThu = new Date(currentDate.getTime()- (4*millisecond)).Format("yyyy-MM-dd");
    		var lastFri = new Date(currentDate.getTime()- (3*millisecond)).Format("yyyy-MM-dd");
    		var lastSat = new Date(currentDate.getTime()- (2*millisecond)).Format("yyyy-MM-dd");
    		var lastSun = new Date(currentDate.getTime()- (1*millisecond)).Format("yyyy-MM-dd");
    		startStop.push(lastMon);
    		startStop.push(lastTue);
    		startStop.push(lastWed);
    		startStop.push(lastThu);
    		startStop.push(lastFri);
    		startStop.push(lastSat);
    		startStop.push(lastSun);
    		return startStop;
    	}else if(dayType ==1){
    		var nextMon = new Date(currentDate.getTime()+(1*millisecond)).Format("yyyy-MM-dd");
    		var nextTue = new Date(currentDate.getTime()+(2*millisecond)).Format("yyyy-MM-dd");
    		var nextWed = new Date(currentDate.getTime()+(3*millisecond)).Format("yyyy-MM-dd");
    		var nextThu = new Date(currentDate.getTime()+(4*millisecond)).Format("yyyy-MM-dd");
    		var nextFri = new Date(currentDate.getTime()+(5*millisecond)).Format("yyyy-MM-dd");
    		var nextSat = new Date(currentDate.getTime()+(6*millisecond)).Format("yyyy-MM-dd");
    		var nextSun = new Date(currentDate.getTime()+(7*millisecond)).Format("yyyy-MM-dd");
    		startStop.push(nextMon);
    		startStop.push(nextTue);
    		startStop.push(nextWed);
    		startStop.push(nextThu);
    		startStop.push(nextFri);
    		startStop.push(nextSat);
    		startStop.push(nextSun);
    		return startStop;
    	}else if(dayType ==0){
    		var nowMon = new Date(currentDate.getTime()).Format("yyyy-MM-dd");
    		var nowTue = new Date(currentDate.getTime()+(1*millisecond)).Format("yyyy-MM-dd");
    		var nowWed = new Date(currentDate.getTime()+(2*millisecond)).Format("yyyy-MM-dd");
    		var nowThu = new Date(currentDate.getTime()+(3*millisecond)).Format("yyyy-MM-dd");
    		var nowFri = new Date(currentDate.getTime()+(4*millisecond)).Format("yyyy-MM-dd");
    		var nowSat = new Date(currentDate.getTime()+(5*millisecond)).Format("yyyy-MM-dd");
    		var nowSun = new Date(currentDate.getTime()+(6*millisecond)).Format("yyyy-MM-dd");
    		startStop.push(nowMon);
    		startStop.push(nowTue);
    		startStop.push(nowWed);
    		startStop.push(nowThu);
    		startStop.push(nowFri);
    		startStop.push(nowSat);
    		startStop.push(nowSun);
    		return startStop;
    	}		
    }  
    
    
    
    
    
  //获取周一日期
    this.getCurrentWeekMon=function(){
    	Date.prototype.Format = function (fmt) { //author: meizz   
    	    var o = {  
    	        "M+": this.getMonth() + 1, //月份   
    	        "d+": this.getDate(), //日   
    	        "H+": this.getHours(), //小时   
    	        "m+": this.getMinutes(), //分   
    	        "s+": this.getSeconds(), //秒   
    	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
    	        "S": this.getMilliseconds() //毫秒   
    	    };  
    	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    	    for (var k in o)  
    	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
    	    return fmt;  
    	}  	
        //获取当前时间    
        var currentDate = new Date();
        //返回date是一周中的某一天    
        var week = currentDate.getDay();  
        //返回date是一个月中的某一天    
        var month = currentDate.getDate();  
  
        //一天的毫秒数    
        var millisecond = 1000 * 60 * 60 * 24;  
        //减去的天数    
        var minusDay = week != 0 ? week - 1 : 6;  
        //本周 周一    
        var monday = new Date(currentDate.getTime() - (minusDay * millisecond)); 
        var mon=monday.Format("yyyy-MM-dd");
        return mon;
    }
    
    //获取指定日期
    this.getCurrentOtherDay=function(day){
    	Date.prototype.Format = function (fmt) { //author: meizz   
    	    var o = {  
    	        "M+": this.getMonth() + 1, //月份   
    	        "d+": this.getDate(), //日   
    	        "H+": this.getHours(), //小时   
    	        "m+": this.getMinutes(), //分   
    	        "s+": this.getSeconds(), //秒   
    	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
    	        "S": this.getMilliseconds() //毫秒   
    	    };  
    	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    	    for (var k in o)  
    	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
    	    return fmt;  
    	}  	
        //获取当前时间    
        var currentDate = new Date();
        //返回date是一周中的某一天    
        var week = currentDate.getDay();  
        //返回date是一个月中的某一天    
        var month = currentDate.getDate();  
  
        //一天的毫秒数    
        var millisecond = 1000 * 60 * 60 * 24;  
        //减去的天数    
        var minusDay = week != 0 ? week - 1 : 6;  
        //本周 周一    
        var monday = new Date(currentDate.getTime() - (minusDay * millisecond)); 
        var selectday  = new Date(monday.getTime() + ((day-1) * millisecond));
        var sday=selectday.Format("yyyy-MM-dd");
        return sday;
    }
    
    //获取周日日期
    this.getCurrentWeekSun=function(){
    	Date.prototype.Format = function (fmt) { //author: meizz   
    	    var o = {  
    	        "M+": this.getMonth() + 1, //月份   
    	        "d+": this.getDate(), //日   
    	        "H+": this.getHours(), //小时   
    	        "m+": this.getMinutes(), //分   
    	        "s+": this.getSeconds(), //秒   
    	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
    	        "S": this.getMilliseconds() //毫秒   
    	    };  
    	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    	    for (var k in o)  
    	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
    	    return fmt;  
    	}  	
        //获取当前时间    
        var currentDate = new Date();
        //返回date是一周中的某一天    
        var week = currentDate.getDay();  
        //返回date是一个月中的某一天    
        var month = currentDate.getDate();  
        //一天的毫秒数    
        var millisecond = 1000 * 60 * 60 * 24;  
        //减去的天数    
        var minusDay = week != 0 ? week - 1 : 6;  
      //本周 周一    
        var monday = new Date(currentDate.getTime() - (minusDay * millisecond)); 
      //本周 周日    
        var sunday = new Date(monday.getTime() + (6 * millisecond));
        var sun=sunday.Format("yyyy-MM-dd");
        return sun;
    }
    
    /***  
     * 获得本周周一至周日的时间队列
     */  
     this.getCurrentWeekOtoS = function () { 
     	Date.prototype.Format = function (fmt) { //author: meizz   
     	    var o = {  
     	        "M+": this.getMonth() + 1, //月份   
     	        "d+": this.getDate(), //日   
     	        "H+": this.getHours(), //小时   
     	        "m+": this.getMinutes(), //分   
     	        "s+": this.getSeconds(), //秒   
     	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
     	        "S": this.getMilliseconds() //毫秒   
     	    };  
     	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
     	    for (var k in o)  
     	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
     	    return fmt;  
     	}  
         //起止日期数组    
         var startStop = new Array();  
         //获取当前时间    
         var currentDate = new Date();
         //返回date是一周中的某一天    
         var week = currentDate.getDay();  
         //返回date是一个月中的某一天    
         var month = currentDate.getDate();  
   
         //一天的毫秒数    
         var millisecond = 1000 * 60 * 60 * 24;  
         //减去的天数    
         var minusDay = week != 0 ? week - 1 : 6;  
         //alert(minusDay);    
         //本周 周一    
         var monday = new Date(currentDate.getTime() - (minusDay * millisecond)); 
         var mon=monday.Format("MM/dd");	
         //本周 周二    
         var tuesday  = new Date(monday.getTime() + (1 * millisecond));
         var tue=tuesday.Format("MM/dd");
         //本周 周三    
         var wednesday  = new Date(monday.getTime() + (2 * millisecond));
         var wed=wednesday.Format("MM/dd");
         //本周 周四    
         var thursday  = new Date(monday.getTime() + (3 * millisecond));
         var thu=thursday.Format("MM/dd");
         //本周 周五 
         var friday  = new Date(monday.getTime() + (4 * millisecond));
         var fri=friday.Format("MM/dd");
         //本周 周六 
         var saturday  = new Date(monday.getTime() + (5 * millisecond));
         var sat=saturday.Format("MM/dd");
         //本周 周日    
         var sunday = new Date(monday.getTime() + (6 * millisecond));
         var sun=sunday.Format("MM/dd");
         //添加本周时间    
         startStop.push(mon); //本周起始时间    
         startStop.push(tue); //本周起始时间    
         startStop.push(wed); //本周起始时间    
         startStop.push(thu); //本周起始时间    
         startStop.push(fri); //本周起始时间    
         startStop.push(sat); //本周起始时间    
         //添加本周最后一天时间    
         startStop.push(sun); //本周终止时间    
         //返回    
         return startStop;  
     };  
    
     /***  
      * 获得本周周一至周日的时间队列
      */  
      this.getCurrentWeekOtoSOtherType = function () { 
      	Date.prototype.Format = function (fmt) { //author: meizz   
      	    var o = {  
      	        "M+": this.getMonth() + 1, //月份   
      	        "d+": this.getDate(), //日   
      	        "H+": this.getHours(), //小时   
      	        "m+": this.getMinutes(), //分   
      	        "s+": this.getSeconds(), //秒   
      	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
      	        "S": this.getMilliseconds() //毫秒   
      	    };  
      	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
      	    for (var k in o)  
      	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
      	    return fmt;  
      	}  
          //起止日期数组    
          var startStop = new Array();  
          //获取当前时间    
          var currentDate = new Date();
          //返回date是一周中的某一天    
          var week = currentDate.getDay();  
          //返回date是一个月中的某一天    
          var month = currentDate.getDate();  
    
          //一天的毫秒数    
          var millisecond = 1000 * 60 * 60 * 24;  
          //减去的天数    
          var minusDay = week != 0 ? week - 1 : 6;  
          //alert(minusDay);    
          //本周 周一    
          var monday = new Date(currentDate.getTime() - (minusDay * millisecond)); 
          var mon=monday.Format("yyyy-MM-dd");	
          //本周 周二    
          var tuesday  = new Date(monday.getTime() + (1 * millisecond));
          var tue=tuesday.Format("yyyy-MM-dd");	
          //本周 周三    
          var wednesday  = new Date(monday.getTime() + (2 * millisecond));
          var wed=wednesday.Format("yyyy-MM-dd");	
          //本周 周四    
          var thursday  = new Date(monday.getTime() + (3 * millisecond));
          var thu=thursday.Format("yyyy-MM-dd");	
          //本周 周五 
          var friday  = new Date(monday.getTime() + (4 * millisecond));
          var fri=friday.Format("yyyy-MM-dd");	
          //本周 周六 
          var saturday  = new Date(monday.getTime() + (5 * millisecond));
          var sat=saturday.Format("yyyy-MM-dd");	
          //本周 周日    
          var sunday = new Date(monday.getTime() + (6 * millisecond));
          var sun=sunday.Format("yyyy-MM-dd");	
          //添加本周时间    
          startStop.push(mon); //本周起始时间    
          startStop.push(tue); //本周起始时间    
          startStop.push(wed); //本周起始时间    
          startStop.push(thu); //本周起始时间    
          startStop.push(fri); //本周起始时间    
          startStop.push(sat); //本周起始时间    
          //添加本周最后一天时间    
          startStop.push(sun); //本周终止时间    
          //返回    
          return startStop;  
      };  
     
     
     
    /***  
    * 获得本周起止时间  
    */  
    this.getCurrentWeek = function () { 
    	Date.prototype.Format = function (fmt) { //author: meizz   
    	    var o = {  
    	        "M+": this.getMonth() + 1, //月份   
    	        "d+": this.getDate(), //日   
    	        "H+": this.getHours(), //小时   
    	        "m+": this.getMinutes(), //分   
    	        "s+": this.getSeconds(), //秒   
    	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
    	        "S": this.getMilliseconds() //毫秒   
    	    };  
    	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    	    for (var k in o)  
    	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
    	    return fmt;  
    	}  
        //起止日期数组    
        var startStop = new Array();  
        //获取当前时间    
        var currentDate = this.getCurrentDate();  
        //返回date是一周中的某一天    
        var week = currentDate.getDay();  
        //返回date是一个月中的某一天    
        var month = currentDate.getDate();  
  
        //一天的毫秒数    
        var millisecond = 1000 * 60 * 60 * 24;  
        //减去的天数    
        var minusDay = week != 0 ? week - 1 : 6;  
        //alert(minusDay);    
        //本周 周一    
        var monday = new Date(currentDate.getTime() - (minusDay * millisecond)); 
        var mon=monday.Format("yyyy-MM-dd");	
        //本周 周日    
        var sunday = new Date(monday.getTime() + (6 * millisecond));
        var sun=sunday.Format("yyyy-MM-dd");
        //添加本周时间    
        startStop.push(mon); //本周起始时间    
        //添加本周最后一天时间    
        startStop.push(sun); //本周终止时间    
        //返回    
        return startStop;  
    };  
  
    /***  
    * 获得本月的起止时间  
    */  
    this.getCurrentMonth = function () {  
        //起止日期数组    
        var startStop = new Array();  
        //获取当前时间    
        var currentDate = this.getCurrentDate();  
        //获得当前月份0-11    
        var currentMonth = currentDate.getMonth();  
        //获得当前年份4位年    
        var currentYear = currentDate.getFullYear();  
        //求出本月第一天    
        var firstDay = new Date(currentYear, currentMonth, 1);  
  
  
        //当为12月的时候年份需要加1    
        //月份需要更新为0 也就是下一年的第一个月    
        if (currentMonth == 11) {  
            currentYear++;  
            currentMonth = 0; //就为    
        } else {  
            //否则只是月份增加,以便求的下一月的第一天    
            currentMonth++;  
        }  
  
  
        //一天的毫秒数    
        var millisecond = 1000 * 60 * 60 * 24;  
        //下月的第一天    
        var nextMonthDayOne = new Date(currentYear, currentMonth, 1);  
        //求出上月的最后一天    
        var lastDay = new Date(nextMonthDayOne.getTime() - millisecond);  
  
        //添加至数组中返回    
        startStop.push(firstDay);  
        startStop.push(lastDay);  
        //返回    
        return startStop;  
    };  
  
    /**  
    * 得到本季度开始的月份  
    * @param month 需要计算的月份  
    ***/  
    this.getQuarterSeasonStartMonth = function (month) {  
        var quarterMonthStart = 0;  
        var spring = 0; //春    
        var summer = 3; //夏    
        var fall = 6;   //秋    
        var winter = 9; //冬    
        //月份从0-11    
        if (month < 3) {  
            return spring;  
        }  
  
        if (month < 6) {  
            return summer;  
        }  
  
        if (month < 9) {  
            return fall;  
        }  
  
        return winter;  
    };  
  
    /**  
    * 获得该月的天数  
    * @param year年份  
    * @param month月份  
    * */  
    this.getMonthDays = function (year, month) {  
        //本月第一天 1-31    
        var relativeDate = new Date(year, month, 1);  
        //获得当前月份0-11    
        var relativeMonth = relativeDate.getMonth();  
        //获得当前年份4位年    
        var relativeYear = relativeDate.getFullYear();  
  
        //当为12月的时候年份需要加1    
        //月份需要更新为0 也就是下一年的第一个月    
        if (relativeMonth == 11) {  
            relativeYear++;  
            relativeMonth = 0;  
        } else {  
            //否则只是月份增加,以便求的下一月的第一天    
            relativeMonth++;  
        }  
        //一天的毫秒数    
        var millisecond = 1000 * 60 * 60 * 24;  
        //下月的第一天    
        var nextMonthDayOne = new Date(relativeYear, relativeMonth, 1);  
        //返回得到上月的最后一天,也就是本月总天数    
        return new Date(nextMonthDayOne.getTime() - millisecond).getDate();  
    };  
  
    /**  
    * 获得本季度的起止日期  
    */  
    this.getCurrentSeason = function () {  
        //起止日期数组    
        var startStop = new Array();  
        //获取当前时间    
        var currentDate = this.getCurrentDate();  
        //获得当前月份0-11    
        var currentMonth = currentDate.getMonth();  
        //获得当前年份4位年    
        var currentYear = currentDate.getFullYear();  
        //获得本季度开始月份    
        var quarterSeasonStartMonth = this.getQuarterSeasonStartMonth(currentMonth);  
        //获得本季度结束月份    
        var quarterSeasonEndMonth = quarterSeasonStartMonth + 2;  
  
        //获得本季度开始的日期    
        var quarterSeasonStartDate = new Date(currentYear, quarterSeasonStartMonth, 1);  
        //获得本季度结束的日期    
        var quarterSeasonEndDate = new Date(currentYear, quarterSeasonEndMonth, this.getMonthDays(currentYear, quarterSeasonEndMonth));  
        //加入数组返回    
        startStop.push(quarterSeasonStartDate);  
        startStop.push(quarterSeasonEndDate);  
        //返回    
        return startStop;  
    };  
  
    /***  
    * 得到本年的起止日期  
    *   
    */  
    this.getCurrentYear = function () {  
        //起止日期数组    
        var startStop = new Array();  
        //获取当前时间    
        var currentDate = this.getCurrentDate();  
        //获得当前年份4位年    
        var currentYear = currentDate.getFullYear();  
  
        //本年第一天    
        var currentYearFirstDate = new Date(currentYear, 0, 1);  
        //本年最后一天    
        var currentYearLastDate = new Date(currentYear, 11, 31);  
        //添加至数组    
        startStop.push(currentYearFirstDate);  
        startStop.push(currentYearLastDate);  
        //返回    
        return startStop;  
    };  
  
    /**  
    * 返回上一个月的第一天Date类型  
    * @param year 年  
    * @param month 月  
    **/  
    this.getPriorMonthFirstDay = function (year, month) {  
        //年份为0代表,是本年的第一月,所以不能减    
        if (month == 0) {  
            month = 11; //月份为上年的最后月份    
            year--; //年份减1    
            return new Date(year, month, 1);  
        }  
        //否则,只减去月份    
        month--;  
        return new Date(year, month, 1); ;  
    };  
  
    /**  
    * 获得上一月的起止日期  
    * ***/  
    this.getPreviousMonth = function () {  
        //起止日期数组    
        var startStop = new Array();  
        //获取当前时间    
        var currentDate = this.getCurrentDate();  
        //获得当前月份0-11    
        var currentMonth = currentDate.getMonth();  
        //获得当前年份4位年    
        var currentYear = currentDate.getFullYear();  
        //获得上一个月的第一天    
        var priorMonthFirstDay = this.getPriorMonthFirstDay(currentYear, currentMonth);  
        //获得上一月的最后一天    
        var priorMonthLastDay = new Date(priorMonthFirstDay.getFullYear(), priorMonthFirstDay.getMonth(), this.getMonthDays(priorMonthFirstDay.getFullYear(), priorMonthFirstDay.getMonth()));  
        //添加至数组    
        startStop.push(priorMonthFirstDay);  
        startStop.push(priorMonthLastDay);  
        //返回    
        return startStop;  
    };  
  
  
    /**  
    * 获得上一周的起止日期  
    * **/  
    this.getPreviousWeek = function () {  
        //起止日期数组    
        var startStop = new Array();  
        //获取当前时间    
        var currentDate = this.getCurrentDate();  
        //返回date是一周中的某一天    
        var week = currentDate.getDay();  
        //返回date是一个月中的某一天    
        var month = currentDate.getDate();  
        //一天的毫秒数    
        var millisecond = 1000 * 60 * 60 * 24;  
        //减去的天数    
        var minusDay = week != 0 ? week - 1 : 6;  
        //获得当前周的第一天    
        var currentWeekDayOne = new Date(currentDate.getTime() - (millisecond * minusDay));  
        //上周最后一天即本周开始的前一天    
        var priorWeekLastDay = new Date(currentWeekDayOne.getTime() - millisecond);  
        //上周的第一天    
        var priorWeekFirstDay = new Date(priorWeekLastDay.getTime() - (millisecond * 6));  
  
        //添加至数组    
        startStop.push(priorWeekFirstDay);  
        startStop.push(priorWeekLastDay);  
  
        return startStop;  
    };  
  
    /**  
    * 得到上季度的起始日期  
    * year 这个年应该是运算后得到的当前本季度的年份  
    * month 这个应该是运算后得到的当前季度的开始月份  
    * */  
    this.getPriorSeasonFirstDay = function (year, month) {  
        var quarterMonthStart = 0;  
        var spring = 0; //春    
        var summer = 3; //夏    
        var fall = 6;   //秋    
        var winter = 9; //冬    
        //月份从0-11    
        switch (month) {//季度的其实月份    
            case spring:  
                //如果是第一季度则应该到去年的冬季    
                year--;  
                month = winter;  
                break;  
            case summer:  
                month = spring;  
                break;  
            case fall:  
                month = summer;  
                break;  
            case winter:  
                month = fall;  
                break;  
  
        };  
  
        return new Date(year, month, 1);  
    };  
  
    /**  
    * 得到上季度的起止日期  
    * **/  
    this.getPreviousSeason = function () {  
        //起止日期数组    
        var startStop = new Array();  
        //获取当前时间    
        var currentDate = this.getCurrentDate();  
        //获得当前月份0-11    
        var currentMonth = currentDate.getMonth();  
        //获得当前年份4位年    
        var currentYear = currentDate.getFullYear();  
        //上季度的第一天    
        var priorSeasonFirstDay = this.getPriorSeasonFirstDay(currentYear, currentMonth);  
        //上季度的最后一天    
        var priorSeasonLastDay = new Date(priorSeasonFirstDay.getFullYear(), priorSeasonFirstDay.getMonth() + 2, this.getMonthDays(priorSeasonFirstDay.getFullYear(), priorSeasonFirstDay.getMonth() + 2));  
        //添加至数组    
        startStop.push(priorSeasonFirstDay);  
        startStop.push(priorSeasonLastDay);  
        return startStop;  
    };  
  
    /**  
    * 得到去年的起止日期  
    * **/  
    this.getPreviousYear = function () {  
        //起止日期数组    
        var startStop = new Array();  
        //获取当前时间    
        var currentDate = this.getCurrentDate();  
        //获得当前年份4位年    
        var currentYear = currentDate.getFullYear();  
        currentYear--;  
        var priorYearFirstDay = new Date(currentYear, 0, 1);  
        var priorYearLastDay = new Date(currentYear, 11, 1);  
        //添加至数组    
        startStop.push(priorYearFirstDay);  
        startStop.push(priorYearLastDay);  
        return startStop;  
    };  
    return this;  
      
})();  

function convertDate(s) {
    var d = new Date(s);
    var month = "0" + (d.getMonth() + 1);
    var day = "0" + d.getDate();
    return d.getFullYear() + "年" + month.substring(month.length - 2) + "月" + day.substring(day.length - 2) + "日";
}

/**
 * 获得指定月份的起止时间  
 * wyp
 */  
 this.getDateMonth = function (date,mon) {  
	 Date.prototype.Format = function (fmt) { //author: meizz   
		 var o = {  
				 "M+": this.getMonth() + 1, //月份   
				 "d+": this.getDate(), //日   
				 "H+": this.getHours(), //小时   
				 "m+": this.getMinutes(), //分   
				 "s+": this.getSeconds(), //秒   
				 "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
				 "S": this.getMilliseconds() //毫秒   
		 };  
		 if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
		 for (var k in o)  
			 if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
		 return fmt;  
	 }  
     //起止日期数组    
     var startStop = new Array();  
     //获取时间    
     var currentDate = new Date(date);  
     //获得月份0-11    
     var currentMonth = currentDate.getMonth()+mon;
     //获得年份4位年    
     var currentYear = currentDate.getFullYear(); 
     if (currentMonth>=12) {
    	 currentMonth=0;
    	 currentYear++;
	}
     //求出本月第一天    
     var firstDay = new Date(currentYear, currentMonth, 1).Format("yyyy-MM-dd");  

     //当为12月的时候年份需要加1    
     //月份需要更新为0 也就是下一年的第一个月    
     if (currentMonth == 11) {  
         currentYear++;  
         currentMonth = 0; //就为    
     } else {  
         //否则只是月份增加,以便求的下一月的第一天    
         currentMonth++;  
     }  


     //一天的毫秒数    
     var millisecond = 1000 * 60 * 60 * 24;  
     //下月的第一天    
     var nextMonthDayOne = new Date(currentYear, currentMonth, 1);  
     //求出上月的最后一天    
     var lastDay = new Date(nextMonthDayOne.getTime() - millisecond).Format("yyyy-MM-dd");  

     //添加至数组中返回    
     startStop.push(firstDay);  
     startStop.push(lastDay);  
     //返回    
     return startStop;  
 };  
 
 /**
  * 获取指定起止时间的日期队列
  * wyp
  */
 this.getDatesOfMon=function(first,last){
	 Date.prototype.Format = function (fmt) { //author: meizz   
		 var o = {  
				 "M+": this.getMonth() + 1, //月份   
				 "d+": this.getDate(), //日   
				 "H+": this.getHours(), //小时   
				 "m+": this.getMinutes(), //分   
				 "s+": this.getSeconds(), //秒   
				 "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
				 "S": this.getMilliseconds() //毫秒   
		 };  
		 if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
		 for (var k in o)  
			 if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
		 return fmt;  
	 }  
	 var dateList=new Array();
	 var firstDay=new Date(first);
	 var lastDay=new Date(last);
	 while(firstDay<=lastDay){
		 dateList.push(firstDay.Format("yyyy-MM-dd"));
		 firstDay.setDate(firstDay.getDate()+1);
	 }
	 return dateList
 }
