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
<title>我的门诊</title>
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

a.weui-btn_primary{
	background-color: #1E90FF;
	width: 70%;
	font-size: 14px;
	border-radius: 20px;
}
a.weui-btn.weui-btn_primary:active{
	background-color: #1E90FF;
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

</style>
</head>
<body>
		
	<div class="weui-tab" style="min-height: 100%;height: auto;">
<%--  		<div class="weui-navbar" style="position: fixed;z-index: 50;" >
			<div class="weui-navbar__item" href="#tab1" style="text-align: left;line-height: 10px;background-color: #fff;color: #000;margin-left: 10px;">科室:&nbsp;${officeName}(${total }名)</div>
		</div>  --%>
			<div style="top: 2px;position: absolute;width: 100%;background-color: #F5F5F5;min-height: 100%;height: auto;">	
				<div id="outpatient">		
<!-- 		 			<div class="weui-panel weui-panel_access" style="border-radius: 15px;margin: 5px 5px;">
						<div class="weui-panel__bd" >
							<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0 10px 5px 10px;height: auto;"onclick="cancelBindCard();">
								<div class="weui-media-box__hd" style="position: relative;"><img class="weui-media-box__thumb" src="static/weixinImages/patient.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;"></div>
								<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
									<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
										<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">小菜</div><br>
										<div class="weui-laber" style="color: #808080;text-align: left;">就诊卡号:&nbsp;P4559251-0</div>
									</div>
									<div style="position: absolute;right: 4%;top: 50%;margin-top: -8px;"><i class="icon-angle-right"></i></div>
								</div>
							</a> 
						</div>
					</div>  -->
				<c:choose>
					<c:when test="${not empty wrclist }">
						<c:forEach items="${wrclist }" var="wrclist">
							<div class="weui-panel weui-panel_access" style="border-radius: 15px;margin: 5px 5px;">
								<div class="weui-panel__bd" >
									<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0 10px 5px 10px;height: auto;"onclick="cancelBindCard('${wrclist.RelationID}','${wrclist.PatientID }','${wrclist.PatientName }');">
										<div class="weui-media-box__hd" style="position: relative;">
											<img class="weui-media-box__thumb" src="static/weixinImages/patient.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;">
										</div>
										<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
											<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
												<div class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">${wrclist.PatientName }</div><br>
												<div class="weui-laber" style="color: #808080;text-align: left;">就诊卡号:&nbsp;${wrclist.CardNo }</div>
											</div>
											<div style="position: absolute;right: 4%;top: 50%;margin-top: -8px;"><i class="icon-angle-right"></i></div>
										</div>
									</a> 
								</div>
							</div>
						</c:forEach>
					</c:when>
				</c:choose>	 			
																			
				</div>	
			<a href="javascript:;" class="weui-btn weui-btn_primary" style="margin-top: 10px;margin-bottom: 10px;" onclick="addCard();">+&nbsp;&nbsp;添加就诊卡号</a>
			</div>
			
		</div>
		
		<form id="bindform" action="" method="post">
			<input type="hidden" id="jumpAddress" name="jumpAddress" value="weixin/outpatient">
		</form>
		
		<div style="text-align: left;line-height: 4em;font-weight: bold;"></div>

		<div id="coverdiv" class="weui-mask weui-mask--visible" style="display: none;"></div>
	</div>
	
<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>

<script type="text/javascript">
	$(function(){
		
	});

	function cancelBindCard(RelationID,PatientID,PatientName){

		$.actions({
			title:"<span style='font-size:16px;color:#000;'>"+PatientName+"</span>&nbsp;就诊卡是否进行解除绑定?",
			actions:[{
				text:"<p style='color:#00BFFF;font-size: 18px;'>确定</p>",
				onClick:function(){
					$.post('weixin/cancel/bind/card',{
						RelationID:RelationID,PatientID:PatientID			
					},
					function(result){
						if(result.status=="success"){							
							$.toast("解除绑定成功");
							window.location.reload();
						}else if(result.status=="reserved"){
							$.toast("<p style='font-size:12px;'>当前就诊卡存在已预约的挂号信息,请先取消挂号</p>","cancel");
						}else{
							$.toast("解除绑定失败","cancel");
						}
					});
				}
			}]
		});
	}

	//添加就诊卡
	function addCard(){
		//就诊卡绑定页面
		$("#bindform").attr("action","weixin/bind/page");
		$("#bindform").submit();
	}	
	
</script>

</body>
</html>