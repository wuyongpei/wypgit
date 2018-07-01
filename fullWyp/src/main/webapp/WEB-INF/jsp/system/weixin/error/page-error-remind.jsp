<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();//上下文路径
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
		<title>链接打开提示</title>
	<base href="<%=basePath%>">
<%-- <%@include file="../../layouts/include_minui.jsp" %> --%>
</head>

<body style="background-color: #ffffff">
      <header>
		<!--页面标题栏开始-->
		<div class="mui-navbar-inner mui-bar yz-login-bar"
			style="height: 35px;"></div>
		<!--页面标题栏结束-->
	</header>
           <div class="register-logo" >
		<div class="yzui-icon icon-xl" style="margin: 30px auto 30px;">
			<img src="static/weixin/images/remind.png" style="width: 90px;height: 90px;margin-top: 20px;margin-left: 38px;"" />
		</div>
	</div>
   <div style="text-align: center;margin-top: -10px;"">
		<div>
			<font style="font-size: 25px;">请在微信客户端打开链接</font><br>
		</div>
	</div>


</body>

</html>
