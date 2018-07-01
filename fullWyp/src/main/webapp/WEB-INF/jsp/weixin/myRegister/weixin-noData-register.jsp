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

.bg_div{
	background-color: #F5F5F5;
	width: 100%;
	height: 100%;
	text-align: center;
}
.div_img{
	width: 64px;
	height: 64px;
}
</style>
</head>
<body>
	<div class="bg_div" >
		<div style="padding-top: 40%;">
			<img class="div_img" src="static/weixinImages/nodata.png">
			<p style="color: #808080;text-align: center;line-height: 2em;">暂无发现您的挂号信息</p>
		</div>
		<div class="weui-footer weui-footer_fixed-bottom">
			<p class="weui-footer__text">Copyright © 2013-2018 福建省扬子信息科技有限公司</p>
		</div>
	</div>
<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>

<script type="text/javascript">
	$(function(){
		
	});
	
	
</script>

</body>
</html>