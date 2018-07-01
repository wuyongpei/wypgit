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
<title>预约挂号-->医生选择</title>
<base href="<%=basePath%>">
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

</style>
</head>
<body>

		<div id="doctorlist" class="weui-panel weui-panel_access" style="margin-top: 26%;">
			<!-- 上午医生 -->
			<div class="weui-panel__bd" style="position: relative;overflow: hidden;border-bottom: 2px solid #eee;">
				<div class="weui-media-box__bd" style="height:100%;width:15%;float: left;position: absolute;"><div class="h4_font">上<br>午</div></div>	
				<div id="amlist" class="weui-media-box__bd" style="width: 85%;float: right;">				
					<div class="weui-panel__bd">
						<div class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0;height: auto;">
							<div class="weui-media-box__hd" style="position: relative;"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;"></div>
							<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
								<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
									<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">1菜医生&nbsp;</div><br>
									<div class="weui-laber" style="color: #808080;text-align: left;font-size: 12px;">科室：&nbsp;儿科</div>
								</div>
								<a href="weixin/selectSchedule/${emplist.Emp_ID }" class="weui-btn weui-btn_primary btn-appoint">预约</a>
							</div>
						</div>  
					</div>
					<div class="weui-panel__bd">
						<div class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0;height: auto;">
							<div class="weui-media-box__hd" style="position: relative;"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;"></div>
							<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
								<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
									<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">菜医生&nbsp;</div><br>
									<div class="weui-laber" style="color: #808080;text-align: left;font-size: 12px;">科室：&nbsp;儿科</div>
								</div>
								<a href="weixin/selectSchedule/${emplist.Emp_ID }" class="weui-btn weui-btn_primary btn-appoint">预约</a>
							</div>
						</div> 
					</div>
					<div class="weui-panel__bd">
						<div class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0;height: auto;">
							<div class="weui-media-box__hd" style="position: relative;"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;"></div>
							<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
								<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
									<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">菜医生&nbsp;</div><br>
									<div class="weui-laber" style="color: #808080;text-align: left;font-size: 12px;">科室：&nbsp;儿科</div>
								</div>
								<a href="weixin/selectSchedule/${emplist.Emp_ID }" class="weui-btn weui-btn_primary btn-appoint">预约</a>
							</div>
						</div> 
					</div>
					
				</div>
			</div>
			<!-- 下午医生 -->
			<div id="pmlist" class="weui-panel__bd" style="position: relative;overflow: hidden;border-bottom: 2px solid #eee;">
				<div class="weui-media-box__bd" style="height:100%;width:15%;float: left;position: absolute;"><div class="h4_font">下<br>午</div></div>	
				<div class="weui-media-box__bd" style="width: 85%;float: right;">				
					<div class="weui-panel__bd">
						<div class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0;height: auto;">
							<div class="weui-media-box__hd" style="position: relative;"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;"></div>
							<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
								<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
									<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">菜医生&nbsp;</div><br>
									<div class="weui-laber" style="color: #808080;text-align: left;font-size: 12px;">科室：&nbsp;儿科</div>
								</div>
								<a href="weixin/selectSchedule/${emplist.Emp_ID }" class="weui-btn weui-btn_primary btn-appoint">预约</a>
							</div>
						</div> 
					</div>
					<div class="weui-panel__bd">
						<div class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0;height: auto;">
							<div class="weui-media-box__hd" style="position: relative;"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;"></div>
							<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
								<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
									<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">菜医生&nbsp;</div><br>
									<div class="weui-laber" style="color: #808080;text-align: left;font-size: 12px;">科室：&nbsp;儿科</div>
								</div>
								<a href="weixin/selectSchedule/${emplist.Emp_ID }" class="weui-btn weui-btn_primary btn-appoint">预约</a>
							</div>
						</div>  
					</div>
					<div class="weui-panel__bd">
						<div class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0;height: auto;">
							<div class="weui-media-box__hd" style="position: relative;"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;"></div>
							<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
								<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
									<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">菜医生&nbsp;</div><br>
									<div class="weui-laber" style="color: #808080;text-align: left;font-size: 12px;">科室：&nbsp;儿科</div>
								</div>
								<a href="weixin/selectSchedule/${emplist.Emp_ID }" class="weui-btn weui-btn_primary btn-appoint">预约</a>
							</div>
						</div> 
					</div>
					<div class="weui-panel__bd">
						<div class="weui-media-box weui-media-box_appmsg" style="border-bottom: 1px solid #F5F5F5;padding: 0;height: auto;">
							<div class="weui-media-box__hd" style="position: relative;"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;"></div>
							<div style="text-align: left;width: 100%;position: relative;padding-top: 5px;">	
								<div class="weui-laber" style="line-height: 1.7em;float: left;width: 75%;">
									<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;font-size: 14px;">菜医生&nbsp;</div><br>
									<div class="weui-laber" style="color: #808080;text-align: left;font-size: 12px;">科室：&nbsp;儿科</div>
								</div>
								<a href="weixin/selectSchedule/${emplist.Emp_ID }" class="weui-btn weui-btn_primary btn-appoint">预约</a>
							</div>
						</div>  
					</div>						
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
	//选择医生排班日期
	function selectSchedule(){
		window.location.href='weixin/selectSchedule';
	}
	
</script>

</body>
</html>