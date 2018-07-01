<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh">
<head>
<base href="<%=basePath%>">
<link rel="icon" href="static/images/logo.ico">
<!-- jsp文件头和头部 -->
<%@ include file="top.jsp"%>
<style type="text/css">
.commitopacity {
	position: absolute;
	width: 100%;
	height: 100px;
	background: #7f7f7f;
	filter: alpha(opacity = 50);
	-moz-opacity: 0.8;
	-khtml-opacity: 0.5;
	opacity: 0.5;
	top: 0px;
	z-index: 99999;
}
</style>
<link rel="stylesheet" type="text/css"
	href="static/plugins/websocketInstantMsg/ext4/resources/css/ext-all.css">
<link rel="stylesheet" type="text/css"
	href="static/plugins/websocketInstantMsg/css/websocket.css" />
<script type="text/javascript"
	src="static/plugins/websocketInstantMsg/ext4/ext-all-debug.js"></script>
<script type="text/javascript"
	src="static/plugins/websocketInstantMsg/websocket.js"></script>
</head>
<body>
	<!-- 页面顶部¨ -->
	<%@ include file="head.jsp"%>
	<div id="websocket_button"></div>
	<div class="container-fluid" id="main-container">
		<a href="#" id="menu-toggler"><span></span></a>

		<!-- 左侧菜单 -->
		<%@ include file="left.jsp"%>
		<div id="main-content" class="clearfix">

			<div id="jzts"
				style="display: none; width: 100%; position: fixed; z-index: 99999999;">
				<div class="commitopacity" id="bkbgjz"></div>
				<div style="padding-left: 70%; padding-top: 1px;">
					<div style="float: left; margin-top: 3px;">
						<img src="static/images/loadingi.gif" />
					</div>
					<div style="margin-top: 5px;">
						<h4 class="lighter block red">&nbsp;加载中 ...</h4>
					</div>
				</div>
			</div>

			<div>
				<iframe name="mainFrame" id="mainFrame" frameborder="0" src="tab"
					style="margin: 0 auto; width: 100%; height: 100%;"></iframe>
			</div>

			<!-- 换肤 -->
<!-- 			<div id="ace-settings-container"> -->
<!-- 				<div class="btn btn-app btn-mini btn-warning" id="ace-settings-btn"> -->
<!-- 					<i class="icon-cog"></i> -->
<!-- 				</div> -->
<!-- 				<div id="ace-settings-box"> -->
<!-- 					<div> -->
<!-- 						<div class="pull-left"> -->
<!-- 							<select id="skin-colorpicker" class="hidden"> -->
<!-- 								<option data-class="skin-3" value="#D0D0D0" selected="selected">#D0D0D0</option> -->
<!-- 							</select> -->
<!-- 						</div> -->
<!-- 						<span>&nbsp; 选择皮肤</span> -->
<!-- 					</div> -->
<!-- 					<div> -->
<!-- 						<label><input type='checkbox' name='menusf' id="menusf" -->
<!-- 							onclick="menusf();" /><span class="lbl" -->
<!-- 							style="padding-top: 5px;">菜单缩放</span></label> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<!--/#ace-settings-container-->

		</div>
	</div>
	<input id="empid" type="hidden" value="${user.emp_ID }">



	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<!-- 引入 -->
	<script type="text/javascript" src="static/jquery/js/jquery.cookie.js"></script>
	<script type="text/javascript" src="static/jquery/myjs/menusf.js"></script>
	<!--引入属于此页面的js -->
	<script type="text/javascript" src="static/jquery/myjs/index.js"></script>
	<script type="text/javascript">
		$(function(){

		});
		function editUserH(){
			var emp_ID=$("#empid").val();
			var diag =new top.Dialog();
			diag.Drag=true;
			diag.Title="修改资料";
			diag.URL = '<%=basePath%>emp/editE.do?emp_ID='+emp_ID;
			 diag.Width = 480;
			 diag.Height = 420;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 top.jzts(); 
						setTimeout("location.reload()",100);
				}
				diag.close();
			 };
			 diag.show();
		}
	</script>
</body>
</html>