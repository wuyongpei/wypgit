<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();//上下文路径
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>预约挂号选择时间</title>
<base href="<%=basePath%>">
<%@include file="/WEB-INF/jsp/layouts/taglib.jsp"%>
<link rel="stylesheet" type="text/css" href="static/jquery-weui/css/jquery-weui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/lib/weui.css">
<link rel="stylesheet" type="text/css" href="static/css/font-awesome.min.css">
<style type="text/css">
*{
	font-family: 微软雅黑;
	font-size: 14px;
}
.weui-btn-area a{
	background-color: #1E90FF;
	width: 70%;
	border-radius: 20px;
	font-size: 14px;
}
.weui-cell__bd p{
	font-weight: bold;
}
.weui-cell__bd label{
	font-weight: 100;
}
a.weui-btn.weui-btn_primary:active{
	background-color: #1E90FF;
}
.mui-table-view-cell.mui-active{
	background-color: #fff;
}
div.hidediv{
	display: none;
}
div.weui-cells:before{
	left: 15px;
}
/* 复选框颜色 */
.weui-cells_checkbox .weui-check:checked + .weui-icon-checked:before{
	color: #1E90FF;
}
/* 单选框颜色 */
.weui-cells_radio .weui-check:checked + .weui-icon-checked:before{
	color: #1E90FF;
}
/* 提示信息toast */
div.weui-toast{
	position:fixed;
	left:50%;
	top:25%;
	margin-top:54px;
	margin-left: 2px;
	
}
/* 改变提示框样式颜色 */
.weui-toast .weui-icon-warn{
	color: #f5f5f5;
}
.weui-toast .weui-icon-cancel{
	color: #f5f5f5;
}
</style>
</head>
<body>
	<div style="background-color: #F5F5F5;min-height: 100%;height: auto;">
	
		<div class="weui-pannel weui-panel_access" style="background-color: #00BFFF;">
			<div class="weui-pannel__bd">
				<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg" style="padding: 5px 10px;">
					<div class="weui-media-box__hd">
						<img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="width: 48px;height: 48px;margin-top: 8px;">
					</div>
					<div class="weui-media-box__bd" style="color: #fff;">
						<div class="weui-media-box__title" style="font-size: 14px;font-weight: bold;">${emp.E_Name }</div>
						<p class="weui-media-box__desc" style="color: #fff;font-size: 12px;">${doctorPosition }
						<c:if test="${emp.Doctor_Type!=''}">(${emp.Doctor_Type })</c:if>
						&nbsp;|&nbsp;${emp.OfficeName }</p>
					</div>
				</a>
			</div>
		</div>
		<div class="weui-cells" style="height: auto;margin: 5px 10px;border-radius: 15px;le">
			<div class="weui-cell">
				<div class="weui-cell__bd" >${emp.OfficeName }</div>
				<div class="weui-cell__ft" >${apppointTime.DutyDate }
						<c:if test="${apppointTime.SaveDay=='1' }">(周一)</c:if>
						<c:if test="${apppointTime.SaveDay=='2' }">(周二)</c:if>
						<c:if test="${apppointTime.SaveDay=='3' }">(周三)</c:if>
						<c:if test="${apppointTime.SaveDay=='4' }">(周四)</c:if>
						<c:if test="${apppointTime.SaveDay=='5' }">(周五)</c:if>
						<c:if test="${apppointTime.SaveDay=='6' }">(周六)</c:if>
						
					    <c:if test="${apppointTime.AppointEndTime <='12:00'}">上午</c:if>
					    <c:if test="${apppointTime.AppointEndTime >'12:00' && apppointTime.AppointEndTime<='18:00' }">下午</c:if>
					    <c:if test="${apppointTime.AppointEndTime >'18:00'}">晚上</c:if>
				</div>
			</div>
			<c:choose>
				<c:when test="${patientlist.size()<=1 }">
					<c:forEach items="${patientlist }" var="patientlist">
						<div class="weui-cell">
							<div class="weui-cell__bd">就诊人</div>
							<div id="alonename" class="weui-cell__ft">${patientlist.PatientName }</div>
							<input id="aloneid" name="aloneid" value="${patientlist.PatientID }">
						</div>
					</c:forEach>
				</c:when>
				<c:when test="${patientlist.size()>1 }">
					<div class="weui-cell" onclick="selectPatient(this);">
						<div class="weui-cell__bd">就诊人</div>
						<div class="weui-cell__ft"><label style="margin-right: 10px;"></label><i class="icon-angle-up"></i></div>		
					</div>
					<!-- 复选效果  实现单选 -->
					<div id="selectPatient" class="weui-cells weui-cells_checkbox" style="margin-top: 0;">
					  	<c:forEach items="${patientlist }" var="patientlist">			  		
						   <label class="weui-cell weui-check__label" for="${patientlist.RelationID }">
							    <div class="weui-cell__hd">
							      <input type="radio" class="weui-check" name="patient" id="${patientlist.RelationID }" value="${patientlist.PatientID }">
							      <i class="weui-icon-checked"></i>
							    </div>
							    <div class="weui-cell__bd">
							      <p>${patientlist.CardNo }</p>
							    </div>
						    	<div class="weui-cell__ft">${patientlist.PatientName }</div>
						   </label>
					  	</c:forEach>
					</div>
				</c:when>
			</c:choose>
			<!-- 单选效果 -->
<!-- 			<div id="selectPatient1" class="weui-cells weui-cells_radio" style="margin-top: 0px;">
			  <label class="weui-cell weui-check__label" for="x5">
			    <div class="weui-cell__bd" >
			    	<p>P2018052301<label style="position: absolute;left: 35%;">小罗</label></p>
			    </div>
			    <div id="xd5" class="weui-cell__ft">
			      <input type="radio" class="weui-check" name="radio2" id="x5" value="P2018052301">
			      <span class="weui-icon-checked"></span>
			    </div>
			  </label>
			</div> -->
			<!-- 复选效果  实现单选 -->
<!-- 			<div id="selectPatient" class="weui-cells weui-cells_checkbox" style="margin-top: 0;">
			   <label class="weui-cell weui-check__label" for="s11">
				    <div class="weui-cell__hd">
				      <input type="radio" class="weui-check" name="checkbox1" id="s11" value="P2018052301">
				      <i class="weui-icon-checked"></i>
				    </div>
				    <div class="weui-cell__bd">
				      <p>P2018052301</p>
				    </div>
			    	<div class="weui-cell__ft">小菜</div>
			   </label>
			</div> -->
			
<!-- 			<div class="weui-cell">
				<div class="weui-cell__bd">普通</div>
				<div class="weui-cell__ft">优惠<label style="color: #00BFFF;">&nbsp;0.0&nbsp;</label>元</div>
			</div> -->
		</div>
		<div class="weui-cells" style="margin: 5px 10px;border-radius: 15px;">
<!-- 			<div class="weui-cell">
				<div class="weui-cell__bd">08:00 ~ 08:05</div>
				<div class="weui-cell__ft">(已挂满)</div>
			</div> -->
			<div id="selectTime" class="weui-cells weui-cells_radio" style="margin-top: 0px;">
<!-- 			  <label class="weui-cell weui-check__label" for="x11">
			    <div class="weui-cell__bd">
			    	<p>09:50 ~ 09:55&nbsp;&nbsp;<label style="">余号<label style="color: #00BFFF;">&nbsp;1&nbsp;</label>个 </label></p>
			    </div>
			    <div class="weui-cell__ft">
			      <input type="radio" class="weui-check" name="radio" id="x11">
			      <span class="weui-icon-checked"></span>
			    </div>
			  </label> -->
			  <c:choose>
			    <c:when test="${not empty identicalList }">
			  	 	<c:forEach items="${identicalList }" var="identicalList">
				  	 <div class="weui-cell">
						<div class="weui-cell__bd" style="color: #999999;">${identicalList }</div>
						<div class="weui-cell__ft">(已挂满)</div>
					</div>
			  	 	</c:forEach>
			    </c:when>
			  </c:choose>
			  <c:forEach items="${timelist }" var="timelist" varStatus="index">
					<label class="weui-cell weui-check__label" for="use${timelist }">
				    <div class="weui-cell__bd">
				    	<p>${timelist }<label style="margin-left: 20px;">&nbsp;&nbsp;余号<label style="color: #00BFFF;">&nbsp;1&nbsp;</label>个 </label></p>
				    </div>
				    <div class="weui-cell__ft">
				      <input type="radio" class="weui-check" name="time" id="use${timelist }" value="${timelist }">
				      <span class="weui-icon-checked"></span>
				    </div>
				  </label>
			  </c:forEach>
			</div>
			
		</div>
		<div style="position: fixed;bottom: 0;width: 100%;height: auto;background: #F5F5F5;z-index: 5000;">
			<div class="weui-msg__opr-area" style="margin-bottom: 0px;">
				<p class="weui-btn-area" style="margin: 6px;">
					<a class="weui-btn weui-btn_primary" onclick="saveAppointment();return false;">确定</a>
				</p>
			</div>
		</div>
		<!-- 防止数据被 确定键 遮住 -->
		<div style="height: 8%;">
		</div>
	</div>
	<form action="" id="appointForm" method="post">
		<input type="hidden" id="patientID" name="patientID" value="">
		<input type="hidden" id="patientName" name="patientName" value="">
		<input type="hidden" id="officeID" name="officeID" value="${emp.OfficeID }">
		<input type="hidden" id="officeName" name="officeName" value="${emp.OfficeName }">
		<input type="hidden" id="emp_ID" name="emp_ID" value="${emp.Emp_ID }">
		<input type="hidden" id="e_Name" name="e_Name" value="${emp.E_Name }">
		<input type="hidden" id="doctor_Type" name="doctor_Type" value="${emp.Doctor_Type }">
		<input type="hidden" id="dutyDate" name="dutyDate" value="${apppointTime.DutyDate }">
		<input type="hidden" id="appointDay" name="appointDay" value="${apppointTime.SaveDay }"> 
		
	</form>
	
<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>

<script type="text/javascript">
	$(function(){
		
		
		//默认选中 第一条可预约时间段
		$("input[name='time']:first").attr('checked','checked');
		//单张就诊卡 赋值
		var aname=$("#alonename").html();
		var aid=$("#aloneid").val();
		$("#patientID").val(aid);
		$("#patientName").val(aname);
		//多张就诊卡 赋值
		$("#selectPatient label").on('click',function(){
			var pid=$("input[name='patient']:checked").val();
			var pname=$("input[name='patient']:checked").parent().parent().find('div.weui-cell__ft').html();
			$("#patientID").val(pid);
			$("#patientName").val(pname);
		});
		
	});
	
	
	//隐藏 就诊人 
	function selectPatient(e){
		var s=$(e).find('.weui-cell__ft i').attr('class');
		var cla=$("#selectPatient").attr('class');
		if(cla=="weui-cells weui-cells_checkbox"){	
			$(e).find('.weui-cell__ft i').attr('class','icon-angle-down');
			$("#selectPatient").addClass('hidediv');
		}else{
			$(e).find('.weui-cell__ft i').attr('class','icon-angle-up');
			$("#selectPatient").removeClass('hidediv');
		}
	}
	//确定预约挂号
	function saveAppointment(){
		
		var PatientID=$("#patientID").val();//病人id
		var PatientName=$("#patientName").val();//病人姓名
		var time=$("input[name='time']:checked").val();	//预约时间	
		if(PatientID==null || PatientID==""){
			$.toast("请选择就诊人","forbidden");
		}else if(time==null || time==""){
			$.toast("请选择预约时间","forbidden");
		}else{

			var Appointment_Time=time.substring(0,5);//时间点
			var OfficeID=$("#officeID").val();//科室id
			var OfficeName=$("#officeName").val();//科室名称
			var Emp_ID=$("#emp_ID").val();//医生id
			var E_Name=$("#e_Name").val();//医生名称
			var Doctor_Type=$("#doctor_Type").val();//医生类别
			var Appointment_Date=$("#dutyDate").val();//日期
			var AppointDay=$("#appointDay").val();//周几  数字 
						
  			$.ajax({
				url:"weixin/submit/appointment",
				type:'POST',
				data:{
					PatientID:PatientID,PatientName:PatientName,OfficeID:OfficeID,OfficeName:OfficeName,
					Emp_ID:Emp_ID,E_Name:E_Name,Doctor_Type:Doctor_Type,Appointment_Date:Appointment_Date,
					Appointment_Time:Appointment_Time,AppointDay:AppointDay
				},
				dataType:'json',
	       	    beforeSend:function(){
	       	    	$.showLoading("请稍后");	    	  
	     	    },
				success:function(data){
					$.hideLoading();//隐藏 加载提示
					//window.location.reload();//刷新页面 
					if(data.statue=="success"){
						$.toast("预约成功");
						//推送 再关闭   未做
					}else if(data.statue=="exist"){
						$.toast("该时间段已被预约","forbidden");
						
						var time=2;//2秒后刷新页面
						var t=setInterval(function(){
							time--;
							if(time==0){
								clearInterval(t);
								window.location.reload();
							}
						},1000)
					}else {
						$.toast("预约失败","cancel");
					}
				},
				error:function(data){
					$.hideLoading();//隐藏 加载提示
					$.toast("预约失败","cancel");
				}
			});  
		}
	}
	
</script>

</body>
</html>