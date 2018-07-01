<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh">
<head>
<base href="<%=basePath%>">
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<%@ include file="../admin/top.jsp"%>
<%@include file="../../layouts/taglib.jsp"%>
<%@include file="../../includeCssAndJS/include_bootstrap.jsp"%>

<link rel="stylesheet" href="static/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="static/fullRC/css/wyp_base.css" />
<link rel="stylesheet" href="static/fullRC/css/wyp_yuyue.css" />
</head>
<body>
	<div id="yyliebiao" class="mt10 w100b">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tal">
			<span class="input-icon m0"> <input autocomplete="off"
				class="m0" style="height: 30px !important" id="nav-search-input"
				type="text" name="emp_Name" placeholder="这里输入关键词" /> <i
				id="nav-search-icon" class="icon-search"></i>
			</span>
			<button class="btn btn-lg btn-light p0 tac" style="width: 39.328px;"
				onclick="search();" title="检索">
				<i id="nav-search-icon" class="icon-search icon-large"> </i>
			</button>
		</div>
		<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 bg00  mt30 p0">
			<div class="vip">vip</div>
			<div class="yyzhuangtai">已预约</div>
			<div class="p16">
			<div class="dpib" style="margin: 10px 26px 0 10px;">
				<img src="img/people.png" />
			</div>
			<div class="dpib cfff o08 fs14 fw600 tal">
				<div>
					<div>
						<font class="dpib o1 fs20 fw900">吴先生 </font> <i class="fa fa-mars"></i>
						<font>（23岁）</font>
					</div>
					<div>
						<font>预约：全科</font> <font>初诊</font>
					</div>
					<div>
						<font>预约医生：吴医生</font>
					</div>
					<div>
						<font>预约时间：2018-04-19 00:00:00</font>
					</div>
					<div>
						<font>创建时间：2018-04-19 00:00:00</font>
					</div>
				</div>
			</div>
			</div>
			<div class="w100b mt10 c333 fs14 fw600">
				<div class="dpib mr_4 w50b tac br">
					<button class="btn tac w100b btn-info h34">登记</button>
				</div>
				<div class="dpib w50b tac">
					<button class="btn tac w100b btn-info h34">取消预约</button>
				</div>
			</div>
		</div>
		
	</div>

	<div  class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tal mt30">
		<button class="btn btn-primary">
			<i class="icon-chevron-left"></i>
		</button>
		<button class="btn btn-primary">5/30</button>
		<button class="btn btn-primary">
			<i class="icon-chevron-right"></i>
		</button>
		<input style="height: 30px; margin-top: 6px" size="5"
			placeholder="输入页数" type="text" />
		<button class="btn btn-primary">go</button>
	</div>
</body>
</hml>