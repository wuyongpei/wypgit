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
<title>我的挂号</title>
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
/* 隐藏微信页面滚动条 */
::-webkit-scrollbar{
	display:none;
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
.weui-panel:first-child {
    margin-top: 5px;
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
			<a id="nowNavbar" class="weui-navbar__item weui-bar__item--on" href="javascript:;" onclick="loadNowRegister();return false;">当前挂号(${nowtotal })</a>
			<a id="historyNavbar" class="weui-navbar__item " href="javascript:;" onclick="loadHistoryRegister();return false;">历史挂号<label id="historytotal"></label></a>
		</div>
		<div class="weui-tab__bd">
			<div id="nowRegister" class="weui-tab__bd-item weui-tab__bd-item--active" style="background-color: #F5F5F5;margin-top: -5px;padding-bottom: 10px;">			
<!-- 					<div class="weui-panel weui-panel_access">
						<div class="weui-panel__bd">
							<a class="weui-media-box weui-media-box_appmsg">
								<div class="weui-media-box__hd"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png"></div>
								<div class="weui-media-box__bd">
									<div style="text-align: left;width: 60%;float: left;">	
									<div class="weui-laber" style="line-height: 1.5em;">
										<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">朱熊鹏</div>
										<label class="weui-laber" style="color: #808080;margin-left: 10px;">[东街]血液内科</la
										bel><br>
									</div>
									<div class="weui-laber" style="color: #808080;text-align: left;">泉州市第一医院东街院区</div>
									</div>
									<div class="weui-laber" style="color: #00BFFF;float: right;margin-top: 5%;">已预约</div>
								</div>
							</a>
						</div>
						<div class="weui-form-preview">
							<div class="weui-form-preview__bd" onclick="openRegisterDesc();return false;">
								<div class="weui-form-preview__item">
									<label class="weui-form-preview__label">来自:</label>
									<span class="weui-form-preview__value">微信</span>
								</div>
								<div class="weui-form-preview__item">
									<label class="weui-form-preview__label">就诊人:</label>
									<span id="pname" class="weui-form-preview__value">小菜</span>
								</div>
								<div class="weui-form-preview__item">
									<label class="weui-form-preview__label">就诊时间&nbsp;:</label>
									<span class="weui-form-preview__value">2018-04-04&nbsp;上午&nbsp;08:06-08:12</span>
								</div>
							</div>
							<div style="position: absolute;right: 2%;top: 50%;margin-top: -16px;"><img src="static/weixinImages/right.png"></div>
						</div>
						<div style="background-color: #fff;height: 10%;position: relative;">
							<div class="btn_cannel" onclick="cancelRegister();return false;">取消预约</div>
						</div>
					</div>	 -->
			<c:choose>
				<c:when test="${not empty appointlist }">
					<c:forEach items="${appointlist }" var="appointlist">
						<div class="weui-panel weui-panel_access">
							<div class="weui-panel__bd">
								<a class="weui-media-box weui-media-box_appmsg" style="padding: 0 10px;">
									<div class="weui-media-box__hd"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;margin-top: 10px;"></div>
									<div class="weui-media-box__bd">
										<div style="text-align: left;width: 70%;float: left;">	
										<div class="weui-laber" style="line-height: 1.5em;">
											<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">${appointlist.E_Name }</div><br>
											<label class="weui-laber" style="color: #808080;">${appointlist.OfficeName }&nbsp;</label><br>
										</div>
										<!-- <div class="weui-laber" style="color: #808080;text-align: left;">泉州市第一医院</div> -->
										</div>
										<div class="weui-laber" style="color: #00BFFF;float: right;margin-top: 5%;">
											<c:if test="${appointlist.AppointmentStatus==0 }">已预约</c:if>
											<c:if test="${appointlist.AppointmentStatus==1 }">已就诊</c:if>
											<c:if test="${appointlist.AppointmentStatus==2 }">失约</c:if>
										</div>
									</div>
								</a>
							</div>
							<div class="weui-form-preview">
								<div class="weui-form-preview__bd">
									<div class="weui-form-preview__item">
										<label class="weui-form-preview__label" style="word-spacing: 25px;letter-spacing: 7.5px;margin-right: 10px;">来&nbsp;自:</label>
										<span class="weui-form-preview__value">
											<c:if test="${appointlist.Appointment_Come==1 }">微信</c:if>
											<c:if test="${appointlist.Appointment_Come==2 }">平台</c:if>
											<c:if test="${appointlist.Appointment_Come==3 }">电话</c:if>
										</span>
									</div>
									<div class="weui-form-preview__item">
										<label class="weui-form-preview__label" style="word-spacing: 5px;letter-spacing: 4px;margin-right: 12px;">就&nbsp;诊&nbsp;人:</label>
										<span id="pname" class="weui-form-preview__value">${appointlist.PatientName }</span>
									</div>
									<div class="weui-form-preview__item">
										<label class="weui-form-preview__label" style="word-spacing: 0px;letter-spacing: 1.7px;">就&nbsp;诊&nbsp;时&nbsp;间:</label>
										<span class="weui-form-preview__value">${appointlist.Appointment_Date }&nbsp;
										 <c:if test="${appointlist.Appointment_Time <='12:00'}">上午</c:if>
										 <c:if test="${appointlist.Appointment_Time >'12:00' && appointlist.AppointEndTime<='18:00' }">下午</c:if>
										 <c:if test="${appointlist.Appointment_Time >'18:00'}">晚上</c:if>
										&nbsp;${appointlist.Appointment_Time }</span>
									</div>
								</div>
								<!-- <div style="position: absolute;right: 4%;top: 50%;margin-top: -16px;"><i class="icon-angle-right"></i></div> -->
							</div>
							<div style="background-color: #fff;height: 8%;position: relative;">
								<div class="btn_cannel" onclick="cancelRegister('${appointlist.Appointment_ID}');return false;">取消预约</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:when test="${empty appointlist }">
					<div class="bg_div">
						<div style="padding-top: 40%;">
							<img class="div_img" src="static/weixinImages/nodata.png">
							<p style="color: #808080;text-align: center;line-height: 2em;">暂无您的挂号信息</p>
						</div>
						<div class="weui-footer weui-footer_fixed-bottom">
							<p class="weui-footer__text">Copyright © 2013-2018 福建省扬子信息科技有限公司</p>
						</div>
					</div>
				</c:when>
			</c:choose>			
				
			</div>
			
			<div id="historyRegister" class="weui-tab__bd-item">
				
			</div>
		</div>
	</div>
	<form id="hisForm" action="" method="post">
		<input type="hidden" id="OpenID" name="OpenID" value="${OpenID }">
	</form>
<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>

<script type="text/javascript">
	$(function(){
		
	});

	//点击当前挂号
	function loadNowRegister(){
		//导航栏样式改变
		$("#nowNavbar").addClass("weui-bar__item--on");
		$("#historyNavbar").removeClass("weui-bar__item--on");
		//加载内容显示  切换
		$("#historyRegister").removeClass("weui-tab__bd-item--active");
		$("#nowRegister").addClass("weui-tab__bd-item--active");
	}
	//点击历史挂号
	function loadHistoryRegister(){
		//导航栏样式改变
		$("#historyNavbar").addClass("weui-bar__item--on");
		$("#nowNavbar").removeClass("weui-bar__item--on");
		//加载内容显示 切换 
		$("#nowRegister").removeClass("weui-tab__bd-item--active");
		$("#historyRegister").addClass("weui-tab__bd-item--active");
		
		var OpenID=$("#OpenID").val();
		$("#historyRegister").load("weixin/history/register",{OpenID:OpenID});
	}
	

	//点击打开挂号单详情 
	function openRegisterDesc(){
		var name=$("#pname").text();
		var doctorname=$("#doctorname").text();
		var pdesc=$("#pdesc").text();
		var title="<p style='font-size:18px;font-weight: lighter;'>挂号单</p>";
		var text="<div style='color:#000;text-align: left;line-height: 1.5em;'>"+name+"&nbsp;您好，您已预约成功。订单详情如下:<p></p><br>医生："+doctorname
		+"<br>院区：泉州市第一医院东街院区<br>科室：[东街]血液内科<br>就诊时间：2018-04-04 星期三 08:06~08:12<br>订单号：w001372018040300976<br>就诊位置：门诊部二楼，血液内科第三诊室一诊位<p></p><br>"
		+"请携带就诊卡(卡号：P4701915-0)准时前往医院自助机报道('到院确认'),再到预约科室就诊。"+"</div>";
		$.modal({
			title:title,
			text:text,
			buttons:[
				{text:"关闭",className:"default",onClick:function(){
					
				}},
				{text:"确定",onClick:function(){
					
				}},
			]
		});
	}
	function cancelRegister(Appointment_ID){
		$.actions({
			title:'是否取消该挂号单?',
			actions:[{
				text:"<p style='color:#00BFFF;font-size: 18px;'>确认取消</p>",
				onClick:function(){
					$.post('weixin/cancel/registration',{
						Appointment_ID:Appointment_ID			
					},
					function(result){
						if(result.statue=="success"){
							
							$.toast("取消挂号成功");
							window.location.reload();
						}else{
							$.toast("取消挂号失败","cancel");
						}
					});
				}
			}]
		});
	}
	
</script>

</body>
</html>