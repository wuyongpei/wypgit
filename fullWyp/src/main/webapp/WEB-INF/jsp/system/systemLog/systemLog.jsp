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
<link rel="stylesheet" href="static/css/bootstrap-datetimepicker.css" />
<script type="text/javascript" src="static/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="static/fullRC/js/jquery.contextify.js"></script>
 	<link rel="stylesheet" href="static/fullRC/css/zdialog.css" />
 	 <script src="static/fullRC/js/zdialog.js"></script>
</head>
<body>
	<div class="row-fluid" style="margin-top: 10px;">
		<form action="system/log" method="post" id="logForm" class="form-inline">
			<table style="margin:5px 0 10px 5px;">
				<tbody>			
					<tr>
						<td>
							 <div class="form-group">
							    <label style="margin-bottom: 0;">操作人员姓名:</label>
							    <input type="text" class="form-control" id="operationName" name="operationName" value="${pd.operationName }" placeholder="输入操作人员姓名 ">
							 </div>
						</td>
						<td><label>&nbsp;&nbsp;开始日期:&nbsp;</label></td>
						<td>
							<div class="input-append date">
						     	<input id="startDateTime" name="startDateTime" type="text" placeholder="开始时间" title="开始时间" value="${pd.startDateTime}" readonly="readonly"></input>
						     	<span class="add-on">
								 	<i data-date-icon="icon-calendar" data-time-icon="icon-time" data-filtered="filtered" class="icon-calendar">
						     	 	</i>
						    	</span>
						  	</div>
						</td>
						<td><label>&nbsp;&nbsp;结束日期:&nbsp;</label></td>
						<td>
							<div class="input-append date">
						     	<input id="endDateTime" name="endDateTime" type="text" placeholder="结束时间" title="结束时间" value="${pd.endDateTime}" readonly="readonly"></input>
						     	<span class="add-on">
								 	<i data-date-icon="icon-calendar" data-time-icon="icon-time" data-filtered="filtered" class="icon-calendar">
						     	 	</i>
						    	</span>
						  	</div>
						</td>
						<td style="vertical-align: top;padding-left: 10px;">
							<button class="btn btn-success" onclick="search();"title="搜索">
								<i class="icon-search"></i>
							</button>
						</td>
			
					</tr>
				</tbody>
			</table>
			
			<table class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 5%;">序号</th>
						<th>操作人员</th>
						<th>创建日期</th>
						<th>更新日期</th>
						<th>IP地址</th>
						<th>端口</th>					
						<th>浏览器名称</th>
						<th style="width: 15%;">操作内容</th>
						<th style="width: 15%;">备注</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty logList }">
							<c:forEach items="${logList }" var="log" varStatus="vs">
								<tr>
									<td class="center" style="width: 30px;">${vs.index+1 }</td>
									<td>${log.OperationName }</td>
									<td>${log.CreateDateTime }</td>
									<td>${log.UpdateDateTime }</td>
									<td>${log.IpAddress }</td>
									<td>${log.Port }</td>
									<td>${log.ComputerName }</td>
									<td>${log.OperationContent }</td>
									<td>${log.Comment }</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:when test="${empty logList }">
							<tr class="main-info"><td colspan="100" class="center">没有相关数据</td></tr>
						</c:when>
					</c:choose>

				</tbody>
			</table>	
			<div class="page-header position-relative">
				<table style="width: 100%;">
					<tr>
						<td style="vertical-align: top;">
							<div class="pagination" style="float: right;padding-top: 0;margin-top: 0;">${page.pageStr }</div>
						</td>
					</tr>
				</table>
			</div>	
		</form>
		
		
	</div>

	<script type="text/javascript">
   $(top.hangge());
 
   $(function(){
		//日期框
		$('.input-append.date').datetimepicker({
			language:'zh-CN',
		    format: 'yyyy-mm-dd hh:ii:ss',
		    todayBtn:'linked',
		    todayHighlight:true,
		    autoclose: true
		});
   });
 	//根据 操作人员姓名 搜索
 	function search(){
 		$("#logForm").submit();
 	}
   
 </script>



</body>
</html>