<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();//上下文路径
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>用户绑定</title>
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css"
	href="static/weixin/css/mui.min.css" />
<link rel="stylesheet" type="text/css"
	href="static/weixin/css/icons-extra.css" />	
<style type="text/css">
  .text-con{
    margin:0px 0px 10px 10px;
  }
  .text-con p{
    font-size: 12px;
  }
   .text-con p span{
    color:blue;
   }
   .b-btn{
    width: 200px;
    border-radius: 15px;
   }
</style>	
</head>
<body style="background-color: #ffffff">
     
     <form class="mui-input-group">
    <div class="mui-input-row">
        <label><span class="mui-icon-extra mui-icon-extra-peoples"></span></label>
    <input type="text" class="mui-input-clear" name="patientName" style="font-size: 15px;" placeholder="请输入就诊人姓名" >
    </div>
    <div class="mui-input-row">
        <label> <span class="mui-icon-extra mui-icon-extra-card"></span></label>
        <input type="text" class="mui-input-clear"name="cardNo" style="font-size: 15px;" placeholder="请输入就诊卡号">
    </div>
    <div class="mui-input-row">
        <label> <span class="mui-icon mui-icon-compose"></span></label>
        <input type="text" class="mui-input-clear" name="IDNo" style="font-size: 15px;" placeholder="请输入您的身份证号码">
    </div>
    <div class="mui-input-row">
        <label> <span class="mui-icon-extra mui-icon-extra-phone"></span></label>
        <input type="text" class="mui-input-clear"name="phoneNo" style="font-size: 15px;" placeholder="请输入您的手机号">
    </div>
     <div class="text-con">
     <p>温馨提示：又卡患者请直接在该界面绑卡，绑定的信息将作为就诊参考凭证。
      <br>
       <span>1、已持有医保卡的患者，请直接输入医保卡卡号进行绑定；如果持有的是本院就诊卡，请根据预缴票据上的卡号进行绑定。</span>
      <br>
       <span>2、初次持医保卡来院患者，请到医院人工窗口或者自助机终端进行注册再绑卡。</span>
     </p>
    </div> 
</form>
   <div class="mui-button-row">
        <button type="button" class="mui-btn mui-btn-primary b-btn" >绑定</button>
    </div>




</body>

</html>