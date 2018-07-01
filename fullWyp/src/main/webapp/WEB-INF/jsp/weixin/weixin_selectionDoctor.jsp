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
.weui-cell__bd p{
	font-size: 16px;color: #999999;text-align: center;line-height: 2em;
}
.weui-cell__bd div{
	font-size: 16px;text-align: center;line-height: 2em;font-weight: bold;
}
.weui-actionsheet__cell .weui-cell.weui-cell_access div{
	font-size: 14px;
	line-height: 1.47px;
}
.weui-actionsheet__title{
	height: auto;
	padding: 10px 0;
}
</style>
</head>
<body>
	<div class="weui-tab" style="height: 800px;background-color: #F5F5F5;padding-top: 10px;">
		<div class="weui-navbar" style="position: fixed;z-index: 50;" >
			<div class="weui-navbar__item" href="#tab1" style="text-align: left;line-height: 10px;background-color: #fff;color: #000;margin-left: 10px;">[东街]心血管内科(16名)</div>
		</div>
		
		<div class="weui-panel weui-panel_access" style="margin: 10px;top: 22px;border-radius: 15px;">
			<div class="weui-panel__bd" >
				<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg" style="margin: 5px;border-bottom: 1px solid #F5F5F5;">
					<div class="weui-media-box__hd"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 64px;width: 64px;"></div>
					<div style="text-align: left;width: 100%;">	
						<div class="weui-laber" style="line-height: 1.5em;">
							<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;">林荣</div>
							<label class="weui-laber" style="color: #808080;margin-left: 10px;">主任医师(诊查费:￥20.00)</label><br>
						</div>
						<div class="weui-laber" style="color: #808080;text-align: left;">线上接诊:2051</div>
					</div>
				</a> 
				<div class="weui-media-box__bd" style="color:#808080;margin: 15px;">
					<p class="weui-media-box__desc" >主任医师，教授，硕士生导师，中国心电学会常委、卫生部海峡两岸心血管学会常委、《临床心电学杂志》编委著作人主任医师，教授，硕士生导师，中国心电学会常委、卫生部海峡两岸心血管学会常委、《临床心电学杂志》编委著作人
					主任医师，教授，硕士生导师，中国心电学会常委、卫生部海峡两岸心血管学会常委、《临床心电学杂志》编委著作人主任医师，教授，硕士生导师，中国心电学会常委、卫生部海峡两岸心血管学会常委、《临床心电学杂志》编委著作人</p>
				</div>
				<div class="weui-cells" style="margin-top: 0;">
					<a class="weui-cell weui-cell_access">
						<div id="gua1" class="weui-cell__bd" onclick="registrationNotes();return false;">
							2018-04-04(星期三) 上午 余号: 23							
						</div>
						<div class="weui-cell__ft"></div>
					</a>
					<a class="weui-cell weui-cell_access" onclick="selectTime();return false;">
						<div class="weui-cell__bd">
							2018-04-04(星期三) 上午 余号: 23							
						</div>
						<div class="weui-cell__ft"></div>
					</a>			
				</div>
			</div>
		</div>
		
		<div class="weui-panel weui-panel_access" style="margin: 10px;top: 20px;border-radius: 15px;">
			<div class="weui-panel__bd" >
				<a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg" style="margin: 5px;border-bottom: 1px solid #F5F5F5;">
					<div class="weui-media-box__hd"><img class="weui-media-box__thumb" src="static/weixinImages/doctorHead.png" style="height: 64px;width: 64px;"></div>
					<div style="text-align: left;width: 100%;">	
						<div class="weui-laber" style="line-height: 1.5em;">
							<div id="doctorname" class="weui-media-box__title" style="float: left;font-weight: bold;">林荣</div>
							<label class="weui-laber" style="color: #808080;margin-left: 10px;">主任医师(诊查费:￥20.00)</label><br>
						</div>
						<div class="weui-laber" style="color: #808080;text-align: left;">线上接诊:2051</div>
					</div>
				</a> 
				<div class="weui-media-box__bd" style="color:#808080;margin: 15px;">
					<p id="doctordesc" class="weui-media-box__desc" style="line-height: 1.5em;" onclick="openDoctorDes();return false;">主任医师，教授，硕士生导师，中国心电学会常委、卫生部海峡两岸心血管学会常委、《临床心电学杂志》编委著作人主任医师，教授，硕士生导师，中国心电学会常委、卫生部海峡两岸心血管学会常委、《临床心电学杂志》编委著作人
					主任医师，教授，硕士生导师，中国心电学会常委、卫生部海峡两岸心血管学会常委、《临床心电学杂志》编委著作人主任医师，教授，硕士生导师，中国心电学会常委、卫生部海峡两岸心血管学会常委、《临床心电学杂志》编委著作人</p>
				</div>
				<div class="weui-cells" style="margin-top: 0;">
					<a class="weui-cell weui-cell_access">
						<div class="weui-cell__bd">
							2018-04-04(星期三) 上午 余号: 23							
						</div>
						<div class="weui-cell__ft"></div>
					</a>
					<a class="weui-cell weui-cell_access">
						<div class="weui-cell__bd">
							2018-04-04(星期三) 上午 余号: 23							
						</div>
						<div class="weui-cell__ft"></div>
					</a>
					<a class="weui-cell weui-cell_access">
						<div class="weui-cell__bd">
							2018-04-04(星期三) 上午 余号: 23							
						</div>
						<div class="weui-cell__ft"></div>
					</a>
					<a id="showIOSActionSheet" class="weui-cell weui-cell_access" onclick="lookmore();return false;">
						<div class="weui-cell__bd open-popup" data-target="">
							查看更多...							
						</div>
						<div class="weui-cell__ft"></div>
					</a>
				</div>	
			</div>
		</div>
		<div style="text-align: left;line-height: 4em;font-weight: bold;"></div>

		<div id="coverdiv" class="weui-mask weui-mask--visible" style="display: none;"></div>
		<div id="actionsheet" class="weui-actionsheet">
			<div class="weui-actionsheet__title" ><p style="font-size: 16px;">黄子厚(主任医师(诊查费:￥20.00))</p></div>
		    <div class="weui-actionsheet__menu">
		        <div class="weui-actionsheet__cell">
		        	<a class="weui-cell weui-cell_access">
						<div class="weui-cell__bd">
							2018-04-04(星期三) 上午 余号: 23							
						</div>
						<div class="weui-cell__ft"></div>
					</a>
		        </div>
		        <div class="weui-actionsheet__cell">
		        	<a class="weui-cell weui-cell_access">
						<div class="weui-cell__bd">
							2018-04-04(星期三) 上午 余号: 23							
						</div>
						<div class="weui-cell__ft"></div>
					</a>
		        </div>
		       	<div class="weui-actionsheet__cell">
		        	<a class="weui-cell weui-cell_access">
						<div class="weui-cell__bd">
							2018-04-04(星期三) 上午 余号: 23							
						</div>
						<div class="weui-cell__ft"></div>
					</a>
		        </div>
		    </div>
		    <div class="weui-actionsheet__action">
		        <div id="cancelActionsheet" class="weui-actionsheet__cell" onclick="closeActions();return false;">取消</div>
		    </div>
		</div>


		<!--  data-target="#bottomb"
		<div class="weui-popup__container popup-bottom" id="bottomb" style="z-index: 502;">
			<div class="weui-popup__overlay"></div>
			<div class="weui-popup__modal" >
				<div class="weui-cell__bd" style="background-color: #FFFFFF;"><p>黄子厚(主任医师(诊查费:￥20.00))</p></div>
				<div class="weui-cells">
					<a class="weui-cell weui-cell_access">
						<div class="weui-cell__bd">
							2018-04-04(星期三) 上午 余号: 23							
						</div>
						<div class="weui-cell__ft"></div>
					</a>
					<a class="weui-cell weui-cell_access">
						<div href="javascript:;" class="weui-cell__bd">
							2018-04-04(星期三) 上午 余号: 23							
						</div>
						<div class="weui-cell__ft"></div>
					</a>
				</div>
				<div class="weui-cell__bd" onclick="closePopup();return false;" style="border-top: 2px solid #CCCCCC;"><div>取消</div></div>
			</div>
		</div>
		-->
	</div>
	
<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>

<script type="text/javascript">
	$(function(){


	});
	function jumpSelectionSection(){
	//	alert();
		window.location.href='weixin/selectSection';

	}
	function openDoctorDes(){
		var cl=$("#doctordesc").attr('class');
		if(cl=='weui-media-box__desc'){		
			$("#doctordesc").addClass('p-desc__open');
		}else{
			$("#doctordesc").removeClass('p-desc__open');
		}
	}

	function registrationNotes(){
		var tit='<p style="font-family:微软雅黑;font-size:18px;font-weight: lighter;">挂号须知</p>';
		var object='<p style="color:#000;font-family:微软雅黑;text-align: left;line-height: 1.5em;">1、请携带接诊卡前往对应科室就诊、检验、治疗、取药等<br>2、当天当班未及时就诊，请您重新预约挂号<br>3、微信挂号：每个科室每天限挂一次号</p>';
		$.confirm({
			title:tit,
			text:object,
			onOK:function(){
				window.location.href='weixin/user/bindingcard';
			},
			onCancel:function(){
				
			}
		});
	}
	function selectTime(){
		var tit='<p style="font-family:微软雅黑;font-size:18px;font-weight: lighter;">挂号须知</p>';
		var object='<p style="color:#000;font-family:微软雅黑;text-align: left;line-height: 1.5em;">1、请携带接诊卡前往对应科室就诊、检验、治疗、取药等<br>2、当天当班未及时就诊，请您重新预约挂号<br>3、微信挂号：每个科室每天限挂一次号</p>';
		$.confirm({
			title:tit,
			text:object,
			onOK:function(){
				window.location.href='weixin/selectTime';
			},
			onCancel:function(){
				
			}
		});
	}
	function closeActions(){
		// $.closePopup();	
		//$.closeActions();
		 $("#actionsheet").removeClass("weui-actionsheet_toggle");
		 $("#coverdiv").fadeOut(200);
	}
	function lookmore(){
      //  $('#actionsheet').slideToggle("fast");// 快速弹出菜单
       // $('#coverDiv').show();
      $("#actionsheet").addClass("weui-actionsheet_toggle");
      $("#coverdiv").fadeIn(200);
	}
	
</script>

</body>
</html>