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
<title>就诊卡充值</title>
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
div.weui-panel__bd{
	line-height: 2em;
}
.btn-selectnum{
	height: 60px;
}
.btn-selectnum button{
	margin-top:15px;
	margin-left:10px;
	float: left;
	width: 30%;
	height:40px;
	background-color: #fff;
	color: #1E90FF;
	border: 1px solid #1E90FF;
	line-height: 2em;
	font-size: 14px;
}
button.weui-btn.weui-btn_primary{
	background-color: #1E90FF;
	width: 70%;
	height:40px;
	border-radius: 20px;
	font-size: 14px;
}
button.weui-btn.weui-btn_primary:active{
	background-color: #1E90FF;
}
button.btn-change{
	border:0px solid #00BFFF;
	background-color: #1E90FF;
	color: #fff;
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
		<div style="padding-top: 40px;margin: 0 10px;">
			<p style="color: #00bfff;text-align: left;font-size: 12px; ">
				温馨提示：门诊就诊卡充值不能超过2000！<br>
				缴纳住院预交金请去"我的住院"中预交金充值选项进行充值
			</p>
		</div>	
		<div class="weui-panel weui-panel_access" style="text-align: left;padding: 10px;">
			<div class="weui-panel__bd" >姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：小菜</div>
			<div class="weui-panel__bd">当前余额：<label style="font-weight: bold;">0.1</label>&nbsp;元</div>
			<div class="weui-panel__bd">
				<label style="float: left;">充值金额：</label>
				<input id="inputmoney" class="weui-input" placeholder="请输入金额" style="width: 75px;" oninput="removeSelectNum();">
				<label>(元)</label>
			</div>
			<div class="weui-panel__bd">
				<label style="color: #999999;">或选择充值金额(元)</label>
			</div>
			<div class="weui-panel__bd">
				<div class="btn-selectnum">		
					<button class="weui-btn weui-btn-primary">100</button>
					<button class="weui-btn weui-btn-primary">200</button>
					<button class="weui-btn weui-btn-primary">500</button>
				</div>
			</div>
			<div style="margin-top: 20px;">
				<button class="weui-btn weui-btn_primary" onclick="rechargeCard();return false;">立即充值</button>
			</div>
		</div>
	</div>
	<div class="weui-footer weui-footer_fixed-bottom">
		<p class="weui-footer__text">Copyright © 2013-2018 福建省扬子信息科技有限公司</p>
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
			$("#selectPatient").find('i').attr('class','icon-angle-down');
			$("#selectAll").css('display','none');
		});
		$("#selectAll").on('click',function(){
			$("#coverdiv").fadeOut(200);
			$("#selectPatient").find('i').attr('class','icon-angle-down');
			$("#selectAll").css('display','none');
			selectMedicalCard();//选择就诊人
		});
		selectRechargeNumber();//选择充值的数额
	});
	function selectMedicalCard(){
		var name=$("input[name='medicalCard']:checked").val();
		$("#patientName").html(name);
	}
	
	function selectRechargeNumber(){
		$(".btn-selectnum button").on('click',function(){
			$("#inputmoney").val("");//将输入的充值金额清空
			var cla=$(this).attr('class');
			if(cla=="weui-btn weui-btn-primary btn-change"){
				$(this).removeClass('btn-change');
			}else{
				$(".btn-selectnum button").removeClass('btn-change');
				$(this).addClass('btn-change');
			}
		});
	}
	//充值金额输入框值改变时 已出选中
	function removeSelectNum(){
		$(".btn-selectnum button").removeClass('btn-change');
	}
	//卡充值 
	function rechargeCard(){
		$.toast("充值成功");
	}
	
	
</script>

</body>
</html>