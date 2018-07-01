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
<title>在线建卡</title>
<base href="<%=basePath%>">
<%@include file="/WEB-INF/jsp/layouts/taglib.jsp"%>
<link rel="stylesheet" type="text/css" href="static/jquery-weui/css/jquery-weui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/lib/weui.css">

<!-- 简拼js -->
<script type="text/javascript" src="static/fullRC/js/pinyin_dict_withtone.js"></script>
<script type="text/javascript" src="static/fullRC/js/pinyinUtil.js"></script>
<style type="text/css">


*{
	font-family: 微软雅黑;
	font-size: 14px;
}

.weui-cell__bd input{
	font-size: 14px;
	color: #D3D3D3;
}
.weui-msg__text-area p{
	font-size: 12px;
}
.weui-btn-area a{
	background-color: #1E90FF;
	width: 90%;
	border-radius: 20px;
	font-size: 14px;
}
a.weui-btn.weui-btn_primary:active{
	background-color: #1E90FF;
}
div.weui-toast.weui-toast--visible{
	margin-left: 2%;
}
input.weui-input{
	color: #000;
}
/* 改变提示框样式颜色 */
.weui-toast .weui-icon-warn{
	color: #f5f5f5;
}
.weui-toast .weui-icon-cancel{
	color: #f5f5f5;
}
.msgbtn{
	color: #808080;
	background: #E6E6E6;
}
</style>
</head>
<body>
	<div style="height: 100%;background: #F5F5F5;">
		<form action="" id="cardForm" name="cardForm" method="post">	
			<div class="weui-cells weui-cells_form" style="margin-top: 0;">
				<div class="weui-cell">
					<div class="weui-cell__hd"><img src="static/weixinImages/user2.png" style="height: 20px;width: 20px;text-align: center;"></div>
					<div class="weui-cell__bd">
						<input id="patientName" name="patientName" class="weui-input" type="text" placeholder="请输入就诊人姓名" >
					</div>
				</div>
	 			<div class="weui-cell">
					<div class="weui-cell__hd"><img src="static/weixinImages/idNumber.png" style="height: 20px;width: 20px;text-align: center;"></div>
					<div class="weui-cell__bd">
						<input id="idNumber" name="idNumber" class="weui-input" type="text" placeholder="请输入身份证号" >
					</div>
				</div> 
	<!-- 			<div class="weui-cell">
					<div class="weui-cell__hd"><img src="static/weixinImages/medicalCard.png" style="height: 20px;width: 20px;text-align: center;"></div>
					<div class="weui-cell__bd">
						<input id="medicalCode"  name="medicalCode"  class="weui-input" type="text" placeholder="请输入就诊卡号">
					</div>
				</div> -->
				<div class="weui-cell">
					<div class="weui-cell__hd"><img src="static/weixinImages/phone.png" style="height: 20px;width: 20px;text-align: center;"></div>
					<div class="weui-cell__bd">
						<input id="phoneNumber" name="phoneNumber" class="weui-input" type="text"  placeholder="请输入您的手机号">
					</div>
<!-- 					<div class="weui-cell__ft">
						<span id="sendCode" class="weui-btn weui-btn_default" style="width: auto;height: 30px;font-size: 12px;" onclick="sendIdentifyingCode();return false;">发送验证码</span>
					</div> -->
				</div>
<!-- 				<div class="weui-cell">
					<div class="weui-cell__hd"><img src="static/weixinImages/sendCode.png" style="height: 20px;width: 20px;text-align: center;"></div>
					<div class="weui-cell__bd">
						<input id="code" name="code" class="weui-input" type="text"  placeholder="请输入短信验证码">
					</div>			
				</div> -->
			</div>
			 <input type="hidden" value="${openID}" name="openID"id="openID" >
	         <input type="hidden" value="${accessToken}" name="accessToken"id="accessToken" >
	         <input type="hidden" value="${jumpAddress }" name="jumpAddress" id="jumpAddress">
		</form>
	
		<div class="weui-msg" style="margin-top: 0px;padding-top:10px;text-align: left;font-size: 14px;background-color:#F5F5F5;height: auto;">
			<div class="weui-msg__text-area">
				<p class="weui-msg__desc">
					温馨提示：有卡患者请直接在该界面绑卡，绑定的信息将作为就诊参考凭证。
				</p>
				<p class="weui-msg__desc" style="color: #1E90FF;">
					1、已持有院内就诊卡或医保卡的患者，请直接输入'就诊卡号，就诊卡号为卡面号码，如绑定失败，也可使用IP号绑定，IP号可在小票，发票，报告单中查询，（例如P123456-0'）进行绑卡操作；<br>
					2、无就诊卡患者，点屏幕右下方的'在线建卡'功能；<br>
					3、持医保卡初次来院患者，请到医院人工窗口或者自助机终端进行注册再绑卡。<br>
				</p>
				<p class="weui-msg__desc" style="color: #FF0000;">
					"儿童请用儿童的具体信息进行绑卡"
					<a href="javascript:void(0);" style="color:#1E90FF; ">(用户绑卡说明？)</a>
				</p>
			</div>
			<div class="weui-msg__opr-area">
				<p class="weui-btn-area">
					<a id="bindcard" class="weui-btn weui-btn_primary" onclick="bindMedicalCard();return false;">确定</a>
				</p>
	<!-- 			<p class="weui-footer__links">
					<div class="weui-footer">
					<label >无就诊卡患者？</label>
						<a class="weui-footer__link" style="color:#1E90FF; ">在线建卡</a>
					</div>
				</p> -->
			</div>
	 		<div class="weui-footer" style="bottom: 0px;position: absolute;left: 10%;">
				<p class="weui-footer__text" >Copyright © 2013-2018 福建省扬子信息科技有限公司</p>
			</div> 
	
		</div>
	</div>

	
<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>

<script type="text/javascript">
	$(function(){

		
	});
	
	//发送短信验证码
	function sendIdentifyingCode(){
		var reg = /^1[3|4|5|7|8][0-9]{9}$/;//手机号正则
		var phoneNumber=$("#phoneNumber").val();
		 if(phoneNumber==null || phoneNumber==""){
				$.toast("手机号不能为空","forbidden");
		 }else if(!reg.test(phoneNumber)){
				$.toast("请输入正确手机号","forbidden");
		 }else{
			 
			var validCode=true;
			$("#sendCode").click(function(){
				var time=60;		
				if(validCode){
					//查询手机号是否被使用  未用发短信
	//				$.post('weixin/send/identifyingCode',{phoneNumber:phoneNumber},function(data){
						
	//				});
					
					validCode=false;
					$("#sendCode").addClass("msgbtn");
					var t=setInterval(function(){
						time--;
						$("#sendCode").html(time+"s");
						if(time==0){
							clearInterval(t);
							$("#sendCode").html("重新发送");
							validCode=true;
							$("#sendCode").removeClass("msgbtn");
						}
					},1000)
				}
			});
		 }
	}
	
	//绑定就诊卡
	function bindMedicalCard(){
		var patientName=$("#patientName").val();
		var nameSpell=pinyinUtil.getFirstLetter(patientName,false);//简拼首字母
		var idNumber=$("#idNumber").val();
		//var medicalCode=$("#medicalCode").val();就诊卡号
		var phoneNumber=$("#phoneNumber").val();
		//var openid=$("#openid").val();
				//个人微信openid
		var openID="o7d6S0csa33EBut2A2XDbbeY_Xk0";
		//var accessToken=$("#accessToken").val();
		var reg = /^1[3|4|5|7|8][0-9]{9}$/;//手机号正则
		var pattern = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;//身份证正则   未加入 
		if(patientName==null || patientName==""){
			$.toast("姓名不能为空","forbidden");
		}else if(idNumber==null || idNumber==""){
			$.toast("身份证不能为空","forbidden");
		}else if(!pattern.test(idNumber)){
			$.toast("身份证号码不正确","forbidden");
		}else if(phoneNumber==null || phoneNumber==""){
			$.toast("手机号不能为空","forbidden");
		}else if(!reg.test(phoneNumber)){
			$.toast("请输入正确手机号","forbidden");
		}else{
			
            $.ajax({
				  url:"weixin/build/card",
         		  type: 'POST',
         	      data: {
      				patientName:patientName,
    				phoneNumber:phoneNumber,idNumber:idNumber,
    				openID:openID,nameSpell:nameSpell			
    			  }, 
         	      dataType: "json", 
         	      beforeSend:function(){
         	    	  $.showLoading("请稍后");
         	      },
         		  success:function(result){
      					$.hideLoading();
      				if(result.statue=="success"){
    					$("#cardForm")[0].reset();
    					$.toast("就诊卡号绑定成功");
   						//跳转相应页面      
   						var jumpAddress=$("#jumpAddress").val();
   						if(jumpAddress!=null && jumpAddress!=""){		
    						window.location.href=jumpAddress;
   						}
    				}else if(result.statue=="idNumberExist"){
    					$.toast("身份证号已被使用","forbidden");
    				}else if(result.statue=="phoneExist"){
    					$.toast("手机号已被使用","forbidden");
    				}
         		  },
         		  error:function(){
         			 $.hideLoading();
         			$.toast("绑定失败","cancel");
         		  }
		   });
			
/*   			$.post("weixin/bind/card",{
				patientName:patientName,medicalCode:medicalCode,
				phoneNumber:phoneNumber,idNumber:idNumber,
				openID:openID			
			},function(result){
				if(result.statue=="success"){
					$("#cardForm")[0].reset();
					$.toast("就诊卡号绑定成功");
				}else if(result.statue=="exist"){//被占用
					$.toast("该就诊卡号已被绑定","forbidden");
				}else if(result.statue=="invalid"){//无效卡号
					$.toast("该就诊卡号不存在或未登记","forbidden");
				}
			});   */
		}
		
	}
	
</script>

</body>
</html>