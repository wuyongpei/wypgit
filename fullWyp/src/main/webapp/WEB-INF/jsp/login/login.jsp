<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh">
<head>
<title>登录页面</title>
<meta charset="UTF-8" />
<base href="<%=basePath%>">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<link rel="icon" href="static/images/logo.ico">
<link rel="stylesheet" href="static/login/css/bootstrap.min.css" />
<link rel="stylesheet"href="static/login/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="static/login/css/camera.css" />
<link rel="stylesheet" href="static/login/css/font-awesome.css" />
<link rel="stylesheet" href="static/login/css/matrix-login.css" />
<script type="text/javascript" src="static/login/js/jquery-1.5.1.min.js"></script>
<script src="static/bootstrap/js/bootstrap.min.js"></script>
<script>
	//TOCMAT重启之后 点击左侧列表跳转登录首页 
	if (window != top) {
		top.location.href = location.href;
	}
</script>
</head>
<body style="background: url('static/login/images/1.png');">
   <div class="main-div">
       <div class="main-left">
        <img  src="static/login/images/left.png" style="width: 100%;height: 100%" >
       </div>
    
     <div class='main-right'>
           <div class='main-right-center'>
                <div ><img src="static/login/images/logo .png" width="25%"></div>
                <div class="main-right-form" >
                  <form action="" method="post" name="loginForm" id="loginForm">
                  
                  <div class="control-group d-s">
					<div class="controls">
						<div class="main_input_box">
							<span><i><img src="static/login/images/user1.png" /></i>
							</span><input class="input1" type="text" name="loginname" id="loginname" value=""placeholder="请输入用户名" />
						</div>
					</div>
				</div>
                  
                  <div class="control-group d-s">
					<div class="controls">
						<div class="main_input_box">
							<span > <i><img
		 							src="static/login/images/pwd.png" /></i>
							</span><input class="input1" type="password" name="password" id="password"
								placeholder="请输入密码" value="" />
						</div>
					</div>
				</div>
				  
				  <div class="form-group d-s">
		           <div class="col-sm-offset-2 col-sm-10">
			           <div class="checkbox main-check" >
			         	<label>
				     	<input name="form-field-checkbox" style="padding:0;float: left;"
				     	id="saveid" type="checkbox" onclick="savePaw();">
				     	<font color="#ccc" style="float: left;">记住密码</font>
				       </label>
			           </div> 
		              </div>
	               </div>  
				     <div class="d-s">
				     <button type="button" class="btn btn-primary btn-d"  onclick="severCheck();" id="login">登录</button>
				     </div>
                  </form>
                </div>
           </div>
     </div>  
   </div>
  



	<script type="text/javascript">
	
 //验证登录
 function severCheck(){
	 if(check()){
		var loginname = $("#loginname").val();
		var password = $("#password").val();
		var code =loginname+",FR,"+password; 
		 $.ajax({
			   type: "POST",
				url: 'login_login',
		    	data: {KEYDATA:code,tm:new Date().getTime()},
				dataType:'json',
				cache: false,   
				success: function(data){
					if("success"==data.result){
						saveCookie();
						window.location.href ="main/index";
					}else if("usererror" == data.result){
						$("#loginname").tips({
							side : 1,
							msg : "用户名或密码有误",
							bg : '#FF5080',
							time : 15
						});
						$("#loginname").focus();
					}else{
						$("#loginname").tips({
							side : 1,
							msg : "缺少参数",
							bg : '#FF5080',
							time : 15
						});
						$("#loginname").focus();
					}
					
				}
		 });
	 }
 }

//客户端校验
	function check() {

		if ($("#loginname").val() == "") {

			$("#loginname").tips({
				side : 2,
				msg : '用户名不得为空',
				bg : '#AE81FF',
				time : 3
			});

			$("#loginname").focus();
			return false;
		} else {
			$("#loginname").val(jQuery.trim($('#loginname').val()));
		}

		if ($("#password").val() == "") {

			$("#password").tips({
				side : 2,
				msg : '密码不得为空',
				bg : '#AE81FF',
				time : 3
			});

			$("#password").focus();
			return false;
		}
		$("#loginbox").tips({
			side : 1,
			msg : '正在登录 , 请稍后 ...',
			bg : '#68B500',
			time : 10
		});

		return true;
	}

	function saveCookie() {
		if ($("#saveid").attr("checked")) {
			$.cookie('loginname', $("#loginname").val(), {
				expires : 7
			});
			$.cookie('password', $("#password").val(), {
				expires : 7
			});
		}
	}
	function quxiao() {
		$("#loginname").val('');
		$("#password").val('');
	}
   
	$(function(){
		var loginname = $.cookie('loginname');
		var password = $.cookie('password');
		if (typeof(loginname) != "undefined"
				&& typeof(password) != "undefined") {
			$("#loginname").val(loginname);
			$("#password").val(password);
			$("#saveid").attr("checked", true);
		}
		$(document).keydown(function(event){ 
			if(event.keyCode==13){ 
			$("#login").click(); 
			} 
	      });
	});
 
 
 </script>

	<script src="static/login/js/jquery-1.7.2.js"></script>
	<script src="static/login/js/jquery.easing.1.3.js"></script>
	<script src="static/login/js/jquery.mobile.customized.min.js"></script>
	<script src="static/login/js/camera.min.js"></script>
	<script src="static/login/js/templatemo_script.js"></script>
	<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/jquery/js/jquery.cookie.js"></script>
</body>


</html>