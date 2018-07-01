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
<title>微信端</title>
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/css/jquery-weui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/lib/weui.css">
<style type="text/css">
*{
	font-family: 微软雅黑;
	font-size: 14px;
}
</style>
</head>
<body>
	<div class="weui-cells" style="margin-top: 0px;">
		<a href="weixin/selectdepartment" class="weui-cell weui-cell_access">
			<div class="weui-cell__hd"><img src="static/weixinImages/hospital.png" style="width: 16px;height: 16px;"></div>
			<div class="weui-cell__bd">
				<p>预约挂号</p>
			</div>
			<div class="weui-cell__ft"></div>
		</a>
<!-- 		<a href="weixin/selectdepartment2" class="weui-cell weui-cell_access">
			<div class="weui-cell__hd"><img src="static/weixinImages/hospital.png" style="width: 16px;height: 16px;"></div>
			<div class="weui-cell__bd">
				<p>泉州市第一医院城东院区</p>
			</div>
			<div class="weui-cell__ft"></div>
		</a>
		<a href="javascript:;" class="weui-cell weui-cell_access">
			<div class="weui-cell__hd"><img src="static/weixinImages/hospital.png" style="width: 16px;height: 16px;"></div>
			<div class="weui-cell__bd">
				<p>泉州市第一医院妇产分院</p>
			</div>
			<div class="weui-cell__ft"></div>
		</a> -->
		<a href="weixin/myregisteration" class="weui-cell weui-cell_access">
			<div class="weui-cell__bd"><p>我的挂号</p></div>
		</a>
		<a href="weixin/outpatient" class="weui-cell weui-cell_access">
			<div class="weui-cell__bd"><p>我的门诊</p></div>
		</a>
	</div>
<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.mini.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>

<script type="text/javascript">
	$(function(){
		
	});
	function jumpSelectionSection(){
	//	alert();
		window.location.href='weixin/selectSection';

	}
</script>

</body>
</html>