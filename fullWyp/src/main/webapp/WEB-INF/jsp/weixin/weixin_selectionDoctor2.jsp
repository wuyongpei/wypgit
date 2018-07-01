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
<title>预约挂号选择医生</title>
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

.weui-actionsheet__cell .weui-cell.weui-cell_access div{
	font-size: 14px;
	line-height: 1.47px;
}
.weui-actionsheet__title{
	height: auto;
	padding: 10px 0;
}
.btn-appoint{
	width: 60px;height: 30px;font-size: 14px;line-height: 2em;float: right;background-color: #1E90FF;position: absolute;right: 5px;top: 50%;margin-top: -15px;
}
a.weui-btn.weui-btn_primary.btn-appoint:active{
	background-color: #1E90FF;
}
p.weui-media-box__desc{
	-webkit-line-clamp:1;
	font-size: 12px;
}
div.hide{
	display: none;
}
div.bg_div{
	text-align: center;
}
</style>
</head>
<body>
		<!-- 泉州妇幼 -->
	<div class="weui-tab" style="background-color: #F5F5F5;min-height: 100%;height: auto;">
<%-- 		<div class="weui-navbar" style="position: fixed;z-index: 50;" >
			<div class="weui-navbar__item" href="#tab1" style="text-align: left;line-height: 10px;background-color: #fff;color: #000;margin-left: 10px;">科室:&nbsp;${workPositionName}(${total }名)</div>
		</div> --%>
		
<!-- 			<div class="weui-panel weui-panel_access" style="border-radius: 15px;margin: 2px 5px;">
				<div class="weui-panel__bd" >
					<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0 10px 5px 10px;height: auto;">
						<div class="weui-media-box__hd" style="position: relative;"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;"></div>
						<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
							<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
								<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;">林荣</div>
								<label class="weui-laber" style="color: #808080;margin-left: 10px;">主任医师</label><br>
								<div class="weui-laber" style="color: #808080;text-align: left;">诊查费:&nbsp;￥20.00</div>
								<p class="weui-media-box__desc">专长：擅长小儿神经系统疾病的治疗,擅长小儿癫疯等发作性事件的判断,儿童神经康复，儿童神经康复，儿童神经康复，儿童神经康复</p>
							</div>
							<span class="weui-btn weui-btn_primary btn-appoint" onclick="selectSchedule();return false;">预约</span>
						</div>
					</a> 
				</div>
			</div> -->
			<div id="doctorlist">	
				<c:choose>
					<c:when test="${not empty emplist }">	
					<div class="weui-navbar" style="position: fixed;z-index: 50;" >
						<div class="weui-navbar__item" href="#tab1" style="text-align: left;line-height: 10px;background-color: #fff;color: #000;margin-left: 10px;">科室:&nbsp;${officeName}(${total }名)</div>
					</div>
					<div style="padding-top: 36px;">
						<c:forEach items="${emplist }" var="emplist">
							<div class="weui-panel weui-panel_access" style="border-radius: 15px;margin: 2px 5px;">
								<div class="weui-panel__bd" >
									<div class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0 10px 5px 10px;height: auto;">
										<div class="weui-media-box__hd" style="position: relative;"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;"></div>
										<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
											<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
												<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">${emplist.E_Name }&nbsp;</div>
												<label class="weui-laber" style="color: #808080;margin-left: 10px;font-size: 12px;">${emplist.doctorPosition }&nbsp;</label><br>
												<div class="weui-laber" style="color: #808080;text-align: left;font-size: 12px;">医生类别：&nbsp;${emplist.Doctor_Type }</div>
												<p class="weui-media-box__desc">专长：&nbsp;${emplist.Comment }</p>
											</div>
											<a href="weixin/selectSchedule/${emplist.Emp_ID }" class="weui-btn weui-btn_primary btn-appoint">预约</a>
										</div>
									</div> 
								</div>
							</div>
						</c:forEach>
					</div>
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
		
	</div>
	
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

	
</script>

</body>
</html>