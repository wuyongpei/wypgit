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
<title>预约挂号-->时间选择</title>
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/css/jquery-weui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/lib/weui.css">
<link rel="stylesheet" type="text/css" href="static/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/horizontalCalendar/common.css">
<script type="text/javascript" src="static/jquery-weui/horizontalCalendar/timebar.js"></script>
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
.h4_font{
	font-size: 16px;position: absolute;top: 50%;margin-top: -25px;left: 30%;
}
.btn-appoint{
	width: 60px;height: 30px;font-size: 14px;line-height: 2em;float: right;background-color: #1E90FF;position: absolute;right: 5px;top: 50%;margin-top: -15px;
}
a.weui-btn.weui-btn_primary.btn-appoint:active{
	background-color: #1E90FF;
}

/* 滑动日期 */
.week.week-hd li{
	font-size: 12px;
}
/* 提示信息toast */
div.weui-toast{
	position: fixed;
	left:50%;
	top: 25%;
	margin-top: 54px;
	margin-left: 2px;
}
/* 改变提示框样式颜色  */
.weui-toast .weui-icon-warn{
	color:#f5f5f5;
}
.weui-toast .weui-icon-cancel{
	color: #f5f5f5;
}
</style>
</head>
<body>
		<!-- 泉州妇幼 -->
			<div >	
				<!-- 日历控件 -->
				<div id="calendar" style="overflow-x:hidden;background: #FFFFFF;position: fixed;z-index: 100;width: 100%;top: 8%;border-bottom: 2px solid #e5e5e5; "></div>
					
				<div id="doctorlist" class="weui-panel weui-panel_access" style="margin-top: 26%;">

					
				</div>		
			</div>

		<input type="hidden" id="officeID" name="officeID" value="${officeID }">	
	<form action="" method="post" id="userForm">
		<input type="hidden" value="${openID}" name="openID"id="openID" >
	    <input type="hidden" value="${accessToken}" name="accessToken"id="accessToken" >
		<input id="Emp_ID" name="Emp_ID" type="hidden" value="${emp.Emp_ID }">
		<input type="hidden" id="appointNoID" name="appointNoID" value="">
	</form>
		
	
<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>

<script type="text/javascript">
	$(function(){
		openDes();//查看医生简介

	//横向滑动日期 初始化 
	timebar.init("calendar",null);
	//加载今天   预约医生列表  
	var dutyDate=$("#dli1 input").val();
	//截取字符串 2018-06-12
	dutyDate=dutyDate.substring(0,10);
	var officeID=$("#officeID").val();
	loadDoctor(officeID,dutyDate);
		
	$("#dul li").click(function(){
		var dutyDate=$(this).find('input').val();
		//截取字符串 2018-06-12
		dutyDate=dutyDate.substring(0,10);
		var officeID=$("#officeID").val();
		loadDoctor(officeID,dutyDate);
	});

	});

		//获取今天预约医生
	function loadDoctor(officeID,dutyDate){
		$.ajax({
			url:"weixin/time/register",
			type:'POST',
			data:{dutyDate:dutyDate,officeID:officeID},
			dataType:'json',
			beforeSend:function(){
				$.showLoading("正在加载...");
			},
			success:function(data){
				$.hideLoading();
				$("#doctorlist").empty();
				var watlist=data.watlist;
				if(watlist!="" && watlist!=null){
					var appointEndTime="";
					for(var i=0;i<watlist.length;i++){
						appointEndTime=watlist[i].AppointEndTime;
						//判断是否还有余号
						num=watlist[i].num;
						if(num>0){							
							if(appointEndTime <='12:00'){//上午
								var am=$("#amdiv").html();
								if(am!='上<br>午'){
									$("#doctorlist").append(
										"<div class='weui-panel__bd' style='position: relative;overflow: hidden;border-bottom: 2px solid #eee;'>"
										+ "<div class='weui-media-box__bd' style='height:100%;width:15%;float: left;position: absolute;'><div id='amdiv' class='h4_font'>上<br>午</div></div>"
										+ "<div id='amlist' class='weui-media-box__bd' style='width: 85%;float: right;'>"
										
									);
								}
								$("#amlist").append(
									"<div class='weui-panel__bd'>"	
									+ "<div class='weui-media-box weui-media-box_appmsg' style='border-bottom: 1px solid #F5F5F5;padding: 0;height: auto;'>"
									+ "<div class='weui-media-box__hd' style='position: relative;'><img class='weui-media-box__thumb' src='static/weixinImages/doctorHead.png' style='height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;'></div>"
									+ "<div style='text-align: left;width: 100%;position: relative;padding-top: 5px;'>"
									+ "<div class='weui-laber' style='line-height: 1.7em;float: left;width: 75%;'>"
									+ "<div class='weui-media-box__title' style='float: left;font-weight: bold;font-size: 14px;'>"+watlist[i].DocTorName+"&nbsp;</div>"
									+ "<label class='weui-laber' style='color: #808080;margin-left: 10px;font-size: 12px;'>"+watlist[i].DoctorPosition+"&nbsp;</label><br>"
									+ "<div class='weui-laber' style='color: #808080;text-align: left;font-size: 12px;'>科室：&nbsp;"+watlist[i].OfficeName+"</div>"
									+ "</div>"
									+ "<a href='javascript:;' class='weui-btn weui-btn_primary btn-appoint' onclick='selectTime(\""+watlist[i].DocTorID+"\",\""+watlist[i].AppointNoID+"\");return false;'>预约</a>"
									+ "</div>"
									+ "</div>"
									+ "</div>"
								);
							//判断  上午 是否存值了
							}else if(appointEndTime >'12:00' && appointEndTime <='18:00'){//下午
								var pm=$("#pmdiv").html();
								if(pm!='下<br>午'){	
									$("#doctorlist").append(
										"<div class='weui-panel__bd' style='position: relative;overflow: hidden;border-bottom: 2px solid #eee;'>"
										+ "<div class='weui-media-box__bd' style='height:100%;width:15%;float: left;position: absolute;'><div id='pmdiv' class='h4_font'>下<br>午</div></div>"
										+ "<div id='pmlist' class='weui-media-box__bd' style='width: 85%;float: right;'>"
										
									);
								}
								$("#pmlist").append(
									"<div class='weui-panel__bd'>"	
									+ "<div class='weui-media-box weui-media-box_appmsg' style='border-bottom: 1px solid #F5F5F5;padding: 0;height: auto;'>"
									+ "<div class='weui-media-box__hd' style='position: relative;'><img class='weui-media-box__thumb' src='static/weixinImages/doctorHead.png' style='height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;'></div>"
									+ "<div style='text-align: left;width: 100%;position: relative;padding-top: 5px;'>"
									+ "<div class='weui-laber' style='line-height: 1.7em;float: left;width: 75%;'>"
									+ "<div class='weui-media-box__title' style='float: left;font-weight: bold;font-size: 14px;'>"+watlist[i].DocTorName+"&nbsp;</div>"
									+ "<label class='weui-laber' style='color: #808080;margin-left: 10px;font-size: 12px;'>"+watlist[i].DoctorPosition+"&nbsp;</label><br>"
									+ "<div class='weui-laber' style='color: #808080;text-align: left;font-size: 12px;'>科室：&nbsp;"+watlist[i].OfficeName+"</div>"
									+ "</div>"
									+ "<a href='javascript:;' class='weui-btn weui-btn_primary btn-appoint' onclick='selectTime(\""+watlist[i].DocTorID+"\",\""+watlist[i].AppointNoID+"\");return false;'>预约</a>"
									+ "</div>"
									+ "</div>"
									+ "</div>"
								);
							}else if(appointEndTime >'18:00'){//晚上
								var night=$("#nightdiv").html();
								if(night!='晚<br>上'){	
									$("#doctorlist").append(
										"<div class='weui-panel__bd' style='position: relative;overflow: hidden;border-bottom: 2px solid #eee;'>"
										+ "<div class='weui-media-box__bd' style='height:100%;width:15%;float: left;position: absolute;'><div id='nightdiv' class='h4_font'>晚<br>上</div></div>"
										+ "<div id='nightlist' class='weui-media-box__bd' style='width: 85%;float: right;'>"
										
									);
								}
								$("#nightlist").append(
									"<div class='weui-panel__bd'>"	
									+ "<div class='weui-media-box weui-media-box_appmsg' style='border-bottom: 1px solid #F5F5F5;padding: 0;height: auto;'>"
									+ "<div class='weui-media-box__hd' style='position: relative;'><img class='weui-media-box__thumb' src='static/weixinImages/doctorHead.png' style='height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;'></div>"
									+ "<div style='text-align: left;width: 100%;position: relative;padding-top: 5px;'>"
									+ "<div class='weui-laber' style='line-height: 1.7em;float: left;width: 75%;'>"
									+ "<div class='weui-media-box__title' style='float: left;font-weight: bold;font-size: 14px;'>"+watlist[i].DocTorName+"&nbsp;</div>"
									+ "<label class='weui-laber' style='color: #808080;margin-left: 10px;font-size: 12px;'>"+watlist[i].DoctorPosition+"&nbsp;</label><br>"
									+ "<div class='weui-laber' style='color: #808080;text-align: left;font-size: 12px;'>科室：&nbsp;"+watlist[i].OfficeName+"</div>"
									+ "</div>"
									+ "<a href='javascript:;' class='weui-btn weui-btn_primary btn-appoint' onclick='selectTime(\""+watlist[i].DocTorID+"\",\""+watlist[i].AppointNoID+"\");return false;'>预约</a>"
									+ "</div>"
									+ "</div>"
									+ "</div>"
								);
							}
							
						}
					}
				}else{			
					$("#doctorlist").append(
						"<div class='weui-cell'>今日暂无医生排班</div>"		
					);
				}
			}
		});

	}

	function selectTime(doctorID,appointNoID){
		//alert(doctorID+","+appointNoID);
		$("#Emp_ID").val(doctorID);
		$("#appointNoID").val(appointNoID);
		$("#openID").val("o7d6S0csa33EBut2A2XDbbeY_Xk0");//测试  设置微信openid
		$("#userForm").attr("action","weixin/selectTime");
		$("#userForm").submit();
	}
	
</script>

</body>
</html>