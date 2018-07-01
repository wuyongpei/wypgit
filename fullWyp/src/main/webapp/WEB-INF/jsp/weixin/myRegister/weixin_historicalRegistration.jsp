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
<title>无挂号信息</title>
<base href="<%=basePath%>">
<%@include file="/WEB-INF/jsp/layouts/taglib.jsp"%>
<link rel="stylesheet" type="text/css" href="static/jquery-weui/css/jquery-weui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/lib/weui.css">
<style type="text/css">
.weui-navbar__item{
	margin-left: 10px;
}
.weui-navbar{
	background-color: #fff;
}
.weui-navbar .weui-navbar__item:after{
	border:none;
}
.weui-navbar__item.weui-bar__item--on{
	color: #00BFFF;
	background-color: #fff;
	border-bottom: 3px solid #00BFFF;
}
*{
	font-family: 微软雅黑;
}
.weui-panel:first-child {
    margin-top: 5px;
}
.bg_div{
	background-color: #F5F5F5;
	width: 100%;
	min-height: 100%;
	height:auto;
	text-align: center;
	padding-bottom: 10px;
	margin-top: -5px;
}
span.weui-form-preview__value{
	color: #808080;
}

</style>
</head>
<body>
	<div class="bg_div" >
		<c:choose>
			<c:when test="${not empty visitlist }">
				<c:forEach items="${visitlist }" var="visitlist">
					<div class="weui-panel weui-panel_access">
						<div class="weui-panel__bd">
							<a class="weui-media-box weui-media-box_appmsg" style="padding: 0 10px;">
								<div class="weui-media-box__hd"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;margin-top: 10px;"></div>
								<div class="weui-media-box__bd">
									<div style="text-align: left;width: 70%;float: left;">	
									<div class="weui-laber" style="line-height: 1.5em;">
										<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">${visitlist.E_Name }</div><br>
										<label class="weui-laber" style="color: #808080;">${visitlist.OfficeName }</label><br>
									</div>
									<!-- <div class="weui-laber" style="color: #808080;text-align: left;">泉州市第一医院</div> -->
									</div>
									<div class="weui-laber" style="color: #808080;float: right;margin-top: 5%;">
										<c:if test="${visitlist.AppointmentStatus==0 }">已预约</c:if>
										<c:if test="${visitlist.AppointmentStatus==1 }">已就诊</c:if>
										<c:if test="${visitlist.AppointmentStatus==2 }">失约</c:if>
									</div>
								</div>
							</a>
						</div>
						<div class="weui-form-preview">
							<div class="weui-form-preview__bd">
								<div class="weui-form-preview__item">
									<label class="weui-form-preview__label" style="word-spacing: 25px;letter-spacing: 7.5px;margin-right: 10px;">来&nbsp;自:</label>
									<span class="weui-form-preview__value" >
										<c:if test="${visitlist.Appointment_Come==0 }">微信</c:if>
										<c:if test="${visitlist.Appointment_Come==1 }">平台</c:if>
										<c:if test="${visitlist.Appointment_Come==2 }">电话</c:if>
									</span>
								</div>
								<div class="weui-form-preview__item">
									<label class="weui-form-preview__label" style="word-spacing: 5px;letter-spacing: 4px;margin-right: 12px;">就&nbsp;诊&nbsp;人:</label>
									<span  class="weui-form-preview__value" >${visitlist.PatientName }</span>
								</div>
								<div class="weui-form-preview__item">
									<label class="weui-form-preview__label" style="word-spacing: 0px;letter-spacing: 1.7px;">就&nbsp;诊&nbsp;时&nbsp;间:</label>
									<span class="weui-form-preview__value" >${visitlist.Appointment_Date }&nbsp;
										<c:if test="${visitlist.Appointment_Time <='12:00'}">上午</c:if>
										<c:if test="${visitlist.Appointment_Time >'12:00' && visitlist.AppointEndTime<='18:00' }">下午</c:if>
										<c:if test="${visitlist.Appointment_Time >'18:00'}">晚上</c:if>
									&nbsp;${visitlist.Appointment_Time }</span>
								</div>
							</div>
			
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:when test="${empty visitlist }">
				<div class="bg_div">
					<div style="padding-top: 40%;">
						<img class="div_img" src="static/weixinImages/nodata.png">
						<p style="color: #808080;text-align: center;line-height: 2em;">暂无您的挂号记录</p>
					</div>
					<div class="weui-footer weui-footer_fixed-bottom">
						<p class="weui-footer__text">Copyright © 2013-2018 福建省扬子信息科技有限公司</p>
					</div>
				</div>
			</c:when>
		</c:choose>

		
		<input type="hidden" id="total" name="total" value="${histotal }">
	</div>
<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>

<script type="text/javascript">
	$(function(){
		//显示 历史挂号 总数
		var total=$("#total").val();
		total="("+total+")";
		$("#historytotal").html(total);
	});
	
	
</script>

</body>
</html>