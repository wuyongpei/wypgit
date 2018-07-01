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
<title>医生选择</title>
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
.weui-form-preview__item label,span{
	float:left;
	color: #000;
}
.btn_cannel{
	position:absolute;
	width: 20%;
	top:50%;
	margin-top:-4%;
	right:10px;
	border: 1px solid #A9A9A9;
	border-radius: 20px;
	text-align: center;
	line-height: 2em;
}
.weui-panel.weui-panel_access{
	top:10px;
	margin: 10px 5px;
}

a.btn-appoint{
	width: 60px;height: 30px;font-size: 14px;line-height: 2em;float: right;background-color: #1E90FF;position: absolute;right: 5px;top: 50%;margin-top: -15px;
}
a.weui-btn.weui-btn_primary.btn-appoint:active{
	background-color: #1E90FF;
}
p.weui-media-box__desc{
	-webkit-line-clamp:1;
}
.bg_div{
	background-color: #F5F5F5;
	width: 100%;
	height: 100%;
	text-align: center;
}
</style>
</head>
<body>
	<div class="weui-tab">
		<div class="weui-navbar" >
			<a id="doctorNavbar" class="weui-navbar__item weui-bar__item--on" href="javascript:;" onclick="loadDoctorRegisterPage();return false;">按医生挂号</a>
			<a id="timeNavbar"  class="weui-navbar__item " href="javascript:;" onclick="loadTimeRegisterPage();return false;">按时间挂号</a>
		</div>
		<div class="weui-tab__bd">
			<div id="doctorRegister" class="weui-tab__bd-item weui-tab__bd-item--active" style="background-color: #F5F5F5;">						
				<div >	
					<c:choose>
						<c:when test="${not empty emplist }">	
	<%-- 					<div class="weui-navbar" style="position: fixed;z-index: 50;" >
							<div class="weui-navbar__item" href="#tab1" style="text-align: left;line-height: 10px;background-color: #fff;color: #000;margin-left: 10px;">科室:&nbsp;${officeName}(${total }名)</div>
						</div> --%>
								<c:forEach items="${emplist }" var="emplist">
									<div class="weui-panel weui-panel_access" style="border-radius: 15px;margin: 2px 5px;">
										<div class="weui-panel__bd" >
											<div class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0 10px 5px 10px;height: auto;">
												<div class="weui-media-box__hd" style="position: relative;"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;"></div>
												<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
													<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
														<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">${emplist.E_Name }&nbsp;</div>
														<label class="weui-laber" style="color: #808080;margin-left: 10px;font-size: 12px;">${emplist.doctorPosition }&nbsp;</label><br>
														<div class="weui-laber" style="color: #808080;text-align: left;font-size: 12px;">科室：&nbsp;${emplist.OfficeName }</div>
														<p class="weui-media-box__desc">专长：&nbsp;${emplist.Comment }</p>
													</div>
													<a href="weixin/selectSchedule/${emplist.Emp_ID }" class="weui-btn weui-btn_primary btn-appoint">预约</a>
												</div>
											</div> 
										</div>
									</div>
								</c:forEach>
						</c:when>
						<c:when test="${empty emplist }">
							<div class="bg_div">
								<div style="padding-top: 40%;">
									<img class="div_img" src="static/weixinImages/nodata.png">
									<p style="color: #808080;text-align: center;line-height: 2em;">该科室下暂无医生</p>
								</div>
								<div class="weui-footer weui-footer_fixed-bottom">
									<p class="weui-footer__text">Copyright © 2013-2018 福建省扬子信息科技有限公司</p>
								</div>
							</div>
						</c:when>
					</c:choose>
				</div>				
			</div>
			
			<div id="timeRegister" class="weui-tab__bd-item" style="background-color: #F5F5F5;">
				<!-- <h4>我是历史挂号</h4> -->
			</div>
		</div>
	</div>
	
	<form action="">
		<input type="hidden" id="officeID" name="officeID" value="${officeID }">
	</form>
	
<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>

<script type="text/javascript">
	$(function(){

		openDes();//查看医生简介
		
	});
	//点击按医生挂号 
	function loadDoctorRegisterPage(){		
		//导航栏样式改变
		$("#doctorNavbar").addClass("weui-bar__item--on");
		$("#timeNavbar").removeClass("weui-bar__item--on");
		//加载内容显示  切换
		$("#timeRegister").removeClass("weui-tab__bd-item--active");
		$("#doctorRegister").addClass("weui-tab__bd-item--active");
	}
	//点击按时间挂号
	function loadTimeRegisterPage(){
		//导航栏样式改变
		$("#timeNavbar").addClass("weui-bar__item--on");
		$("#doctorNavbar").removeClass("weui-bar__item--on");
		//加载内容显示 切换 
		$("#doctorRegister").removeClass("weui-tab__bd-item--active");
		$("#timeRegister").addClass("weui-tab__bd-item--active");
		//加载选择时间挂号页面 
		var officeID=$("#officeID").val();
		$("#timeRegister").load("weixin/time/register/page",{officeID:officeID});
	}
	function openDes(){
		//var cl=$("#doctordesc").attr('class');
		//alert(cl);
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
	
</script>

</body>
</html>