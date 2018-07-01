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
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<title>就诊卡充值</title>
<base href="<%=basePath%>">
<!-- <link rel="stylesheet" type="text/css" -->
<!-- 	href="static/weixin/css/mui.min.css" /> -->
<link rel="stylesheet" type="text/css"
	href="static/weixin/css/mui.min1.css" />
<link rel="stylesheet" type="text/css"
	href="static/weixin/css/icons-extra.css" />	
<script type="text/javascript" src="static/weixin/js/mui.min.js"></script>

<style type="text/css">
.p-head{
 line-height: 15px;
}
.p-name{
  font-size:14px;
}
.w-f{
  margin:0px 15px;
  color: blue;
  font-size: 7px;
}
.mui-input-row{
  font-size:14px;
}
.mui-input-group .mui-input-row:after{
    background-color: rgba(0, 0, 0, 0);
}
.mui-input-group:after{
 background-color: rgba(0, 0, 0, 0);
}
.mui-input-row label{
  width:29%;
  float: left;
}
.mui-input-row .input-mui{
    float: left;
    width: 30%;
     font-size: 14px;
}
.div-form{
  height: 270px;
  background-color: #fff;
}
.d-warin{
   font-size: 11px;
   margin-left: 15px;
   color: #b0b0b0;
}
.mui-my{
   width: 30%;
}
</style>
	</head>
	<body>
	<ul class="mui-table-view">
		<li class="mui-table-view-cell mui-collapse p-head">
	        <a class="mui-navigate-right p-name" href="#">当前就诊人：罗振达</a>
	         <div class="mui-collapse-content">
				<form class="mui-input-group">
					<div class="mui-input-row">
					 <input type="text" placeholder="卡号" readonly="readonly">
					</div>
				</form>
			</div>
	</li>
	</ul>
	<div class="w-f">
	          温馨提示：门诊就诊卡微信充值一次不能超过2000！
	   <br>
	           缴纳住院预交金情趣"我的住院"中预交金充值选项进行充值
	</div>
	<div class="div-form">
	<form class="mui-input-group" name="chargeFrom" id="chargeFrom" method="post" >
	 <div class="mui-input-row">
     <label>姓&nbsp;&nbsp;&nbsp;&nbsp;名：</label>
    <input type="text" class="mui-input-clear input-mui" value="罗振达" readonly="readonly">
    </div>
     <div class="mui-input-row">
         <label>当前余额：</label>
    <input type="text" class="mui-input-clear input-mui" value="0.0元" readonly="readonly">
    </div>
      <div class="mui-input-row">
         <label>充值金额：</label>
    <input type="text" class="mui-input-clear input-mui" value="" placeholder="请输入金额" >   
         <label>(元)</label>
    </div>
   </form>
   <p>
	<div class="d-warin">
	   <label>或选择充值金额(元)</label> 
	    <br/><br/>
	   <div>
	    <button type="button" class="mui-btn mui-btn-primary mui-btn-outlined mui-my">100</button>
	    <button type="button" class="mui-btn mui-btn-primary mui-btn-outlined mui-my">300</button>
	    <button type="button" class="mui-btn mui-btn-primary mui-btn-outlined mui-my">500</button>
	   </div>
	   <div style="margin-top: 1em">
	   <button type="button" class="mui-btn mui-btn-primary"
	    style="width:60%;margin-left: 18%; border-radius: 50px;" >立即充值</button>
	   </div>
	</div>
	</div>
	
   <footer style="bottom: 0px;">
       <div style="text-align: center;">
        <span style="color: #586c94;font-size: 12px;">扬子信息科技有限公司</span><br>
       <span style="font-size: 10px;">copyright © 2017-2020 </span>
       </div>
  </footer>
	  
	
	<script type="text/javascript">
	mui.init({
		swipeBack:true //启用右滑关闭功能
	});
	
	</script>
	
	
	</body>
	</html>