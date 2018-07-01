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
<title>医生排班</title>
<base href="<%=basePath%>">
<%@include file="/WEB-INF/jsp/layouts/taglib.jsp"%>
<link rel="stylesheet" type="text/css" href="static/jquery-weui/css/jquery-weui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/lib/weui.css">
<style type="text/css">
*{
	font-family: 微软雅黑;
	font-size: 14px;
}
.p-desc__open{
	display: block;
	height: auto;
}
.weui-cell__bd p{
	font-size: 16px;color: #999999;text-align: center;line-height: 2em;
}
.weui-cell__bd div{
	font-size: 14px;text-align: left;line-height: 1.5em;
}
.weui-actionsheet__cell .weui-cell.weui-cell_access div{
	font-size: 14px;
	line-height: 1.47px;
}
.weui-actionsheet__title{
	height: auto;
	padding: 10px 0;
}
.btn-appoint{
	width: 60px;height: 30px;font-size: 14px;line-height: 2em;float: right;margin: 5px 10px 5px 5px;background-color: #1E90FF;
}
a.weui-btn.weui-btn_primary.btn-appoint:active{
	background-color: #1E90FF;
}
p.weui-media-box__desc{
	-webkit-line-clamp:1;
}

</style>
</head>
<body>
		<!-- 泉州妇幼 -->
	<div class="weui-tab container" style="height: auto;background-color: #F5F5F5;overflow-y: auto;overflow-x:hidden; ">
		
		<div class="weui-msg" style="padding-top: 15px;">
			<div class="weui-msg__icon-area" style="margin-bottom: 5px;"><img src="static/weixinImages/doctorHead.png" style="height: 48px;width: 48px;"></img></div>
			<div class="weui-msg__text-area" style="margin-bottom: 0px;">
				<div id="doctorname" class="weui-msg__title" style="font-weight: bold;font-size: 16px;">${emp.E_Name }&nbsp;
				<label class="weui-laber" style="color: #808080;margin-left: 10px;">${doctorPosition }&nbsp;
					<c:if test="${emp.Doctor_Type!=''}">(${emp.Doctor_Type })&nbsp;</c:if>
				</label><br>
				<label class="weui-laber" style="color: #808080;margin-left: 10px;">科室：${emp.OfficeName }&nbsp;</label>
				</div>
			</div>
		</div>
		<div class="weui-panel weui-panel_access" style="padding-top: 0px;">
			<div class="weui-panel__bd">
				<div class="weui-media-box__bd" style="color:#808080;margin: 10px;">
					<p id="doctordesc" class="weui-media-box__desc" >专长：&nbsp;${emp.Comment }</p>
				</div>	
			</div>
		</div>
		<div class="weui-cells__title">医生排班</div>
		<div class="weui-cells">
<!-- 			<div class="weui-cell weui-cell_access" style="padding: 5px 15px;">
				<div class="weui-cell__bd">
					<div style="width: auto;float: left;">				
						<div class="weui-label" style="font-weight: bold;">周一&nbsp;上午</div>
						<div class="weui-label" style="color: #999999;">2018-04-07</div>						
					</div>
					<div style="float: left;margin-left: 30px;">余号<label style="color: #00BFFF;">&nbsp;23&nbsp;</label>个</div>
				</div>
				<a href="javascript:selectTime();" class="weui-btn weui-btn_primary btn-appoint" >预约</a>
			</div> -->
			<c:choose>
				<c:when test="${not empty atlist }">
					<c:forEach items="${atlist }" var="atlist">		
						<div class="weui-cell weui-cell_access" style="padding: 5px 15px;">
							<div class="weui-cell__bd">
								<div style="width: auto;float: left;">				
									<div class="weui-label" style="font-weight: bold;">
									<c:if test="${atlist.SaveDay=='0' }">周日</c:if>
									<c:if test="${atlist.SaveDay=='1' }">周一</c:if>
									<c:if test="${atlist.SaveDay=='2' }">周二</c:if>
									<c:if test="${atlist.SaveDay=='3' }">周三</c:if>
									<c:if test="${atlist.SaveDay=='4' }">周四</c:if>
									<c:if test="${atlist.SaveDay=='5' }">周五</c:if>
									<c:if test="${atlist.SaveDay=='6' }">周六</c:if>
									&nbsp;
									 <c:if test="${atlist.AppointEndTime <='12:00'}">上午</c:if>
									 <c:if test="${atlist.AppointEndTime >'12:00' && atlist.AppointEndTime<='18:00' }">下午</c:if>
									 <c:if test="${atlist.AppointEndTime >'18:00'}">晚上</c:if>
									</div>
									<div class="weui-label" style="color: #999999;">${atlist.DutyDate }</div>						
								</div>
							</div>
							<div style="width: 80%;">
								<c:if test="${atlist.num>0 }">							
									<div style="float: left;margin-left: 30px;">余号<label style="color: #00BFFF;">&nbsp;${atlist.num }&nbsp;</label>个</div>							
									<a href="javascript:selectTime('${atlist.AppointNoID }');" class="weui-btn weui-btn_primary btn-appoint" >预约</a>
								</c:if>
								<c:if test="${atlist.num<=0 }">
									<div style="float: left;margin-left: 30px;color: #999999;">已挂满</div>	
								</c:if>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:when test="${empty atlist }">
					<div style="color: #808080;line-height: 2em;text-indent: 1em;">该医生未进行排班</div>
				</c:when>
			</c:choose>

		</div>
	</div>
	<form action="" method="post" id="userForm">
		<input type="hidden" value="${openID}" name="openID"id="openID" >
	    <input type="hidden" value="${accessToken}" name="accessToken"id="accessToken" >
		<input id="Emp_ID" name="Emp_ID" type="hidden" value="${emp.Emp_ID }">
		<input type="hidden" id="appointNoID" name="appointNoID" value="">
	</form>
	
	
<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>

<script type="text/javascript">
	$(function(){
	openDes();//查看医生简介
		
	});
	
	function openDes(){

		$("p.weui-media-box__desc").click(function(){
			var cla=$(this).attr('class');
			if(cla=='weui-media-box__desc'){
				$('p.weui-media-box__desc').removeClass('p-desc__open');
				$(this).addClass('p-desc__open');
			}else{
				$(this).removeClass('p-desc__open');
			}
		});

	}
	function selectTime(appointNoID){
		var tit='<p style="font-family:微软雅黑;font-size:18px;font-weight: lighter;">挂号须知</p>';
		var object='<p style="color:#000;font-family:微软雅黑;text-align: left;line-height: 1.5em;">1、请携带接诊卡前往对应科室就诊、检验、治疗、取药等<br>2、当天当班未及时就诊，请您重新预约挂号<br></p>';
		$.confirm({
			title:tit,
			text:object,
			onOK:function(){
				
				$("#appointNoID").val(appointNoID);
				$("#openID").val("o7d6S0csa33EBut2A2XDbbeY_Xk0");//测试  设置微信openid
				$("#userForm").attr("action","weixin/selectTime");
				$("#userForm").submit();
			},
			onCancel:function(){
				
			}
		});
	}

</script>

</body>
</html>