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
<title>无关注医生</title>
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/css/jquery-weui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/lib/weui.css">
<link rel="stylesheet" type="text/css" href="static/css/font-awesome.min.css">
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
	font-size: 14px;
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
	<div id="coverdiv" class="weui-mask weui-mask--visible" style="display: none;"></div>
	<div id="selectPatient" class="weui-navbar" style="position: fixed;height: 30px;z-index: 5000;">
		<!--  
		<div class="weui-cell" style="width: 100%;">
			<div class="weui-cell__hd"><label class="weui-laber">当前就诊人:</label></div>
			<div class="weui-cell__bd">
				<input id="selectPatient" class="weui-input" type="text">
			</div>
		</div> -->
		<div class="weui-cell weui-cell_access" style="width: 100%;">
			<div class="weui-cell__bd">当前就诊人：<label id="patientName">小菜</label></div>
			<i class="icon-angle-down"></i>
		</div>
	</div>
	
	<div id="selectAll" class="weui-cells weui-cells_radio" style="margin-top:30px;z-index: 5000;display: none;position: absolute;width: 100%;">
		  <label class="weui-cell weui-check__label" for="x11">
		    <div class="weui-cell__bd">
		      P2018001-0:小菜
		    </div>
		    <div class="weui-cell__ft">
		      <input type="radio" class="weui-check" name="medicalCard" id="x11" value="小菜" checked="checked">
		      <span class="weui-icon-checked"></span>
		    </div>
		  </label>
		  <label class="weui-cell weui-check__label" for="x12">
		    <div class="weui-cell__bd">
		      P2018001-1:小罗
		    </div>
		    <div class="weui-cell__ft">
		      <input type="radio" name="medicalCard" class="weui-check" id="x12"  value="小罗">
		      <span class="weui-icon-checked"></span>
		    </div>
		  </label>
		  <label class="weui-cell weui-check__label" for="x13">
		    <div class="weui-cell__bd">
		      P2018001-2:小吴
		    </div>
		    <div class="weui-cell__ft">
		      <input type="radio" name="medicalCard" class="weui-check" id="x13" value="小吴">
		      <span class="weui-icon-checked"></span>
		    </div>
		  </label>
	</div>
	
	<div class="bg_div">
		<div style="padding-top: 40%;">
			<img class="div_img" src="static/weixinImages/nodata.png">
			<p style="color: #808080;text-align: center;line-height: 2em;">左翻右翻，暂无发现您的关注医生</p>
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


		$("#selectPatient").on('click',function(){
			$("#coverdiv").fadeIn(200);
			$("#selectPatient").find('i').attr('class','icon-angle-up');
			$("#selectAll").css('display','block');
		});
		$("#coverdiv").on('click',function(){
			$("#coverdiv").fadeOut(200);
			$("#selectPatient").find('i').attr('class','icon-angle-up');
			$("#selectAll").css('display','none');
		});
		$("#selectAll").on('click',function(){
			$("#coverdiv").fadeOut(200);
			$("#selectPatient").find('i').attr('class','icon-angle-up');
			$("#selectAll").css('display','none');
			selectMedicalCard();//选择就诊人
		});
	});
	
	function selectMedicalCard(){
		$("#selectPatient").find('i').attr('class','icon-angle-down');
		var name=$("input[name='medicalCard']:checked").val();
		$("#patientName").html(name);
	}
	
</script>

</body>
</html>