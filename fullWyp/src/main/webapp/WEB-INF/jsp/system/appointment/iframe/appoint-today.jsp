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
<%@include file="../../../layouts/taglib.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/fullRC/css/register.css" rel="stylesheet" />
<link rel="stylesheet" href="static/css/datepicker.css" />
<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/fullRC/js/pagePlugin.js"></script>
<style type="text/css">
body {
	overflow-x: hidden;
}

.panel-default {
	border-color: #fff !important;
}

.panel-heading span {
	font-size: 12px !important;
	color: #808080 !important;
}

.hidden {
	display: none;
}

.input-sm2 {
	font-size: 14px;
	height: 35px !important;
}

.p09 {
	margin: 2%; ! important;
	border: 1px solid #ddd !important;
}

.text-nowrap {
	white-space: normal;
	word-break: hyphenate;
}

.btn-default {
	height: 35px;
}

.photo-meta li {
	cursor: pointer;
}
</style>

<script type="text/javascript">
	$(top.hangge());
	function getName(type) {
		var name = '';
		url = 'getByCode.do?dictname=APPOINTMENT&dictcode=' + type;
		$.ajax({
			url : url,
			method : 'get',
			async : false,
			success : function(data) {
				name = data;
			}
		})
		return name;
	}
</script>
</head>
<body>
	<div class="panel panel-default" style="border: none;">
		<div class="panel-heading head-panel">
			<div class="row">
				<div class="col-sm-9 col-md-8">
					<form action="appointment/appointToday.do"
						class="form-inline pull-left" method="post">
						<div class="form-group">
							<input style="height: 34px !important" id="name" name="name"
								value="${pd.name }" type="text" class="form-control input-sm2"
								placeholder="请输入姓名/手机号">
						</div>
						<div class="form-group">
							<a style="height: 34px !important"
								class="btn btn-default input-sm2"
								onclick="{
								$('form').submit();
							}"> <i
								class="glyphicon glyphicon-search "></i></a>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<div class="row">
				<c:choose>
					<c:when test="${not empty appointmentList}">
						<div>
							<div class="row">
								<!-- 迭代起点 -->
								<c:forEach items="${appointmentList }" var="appoint"
									varStatus="status">
									<div class="col-sm-6 col-md-4 col-lg-3">
										<div class="panel p09">
											<div class="panel-heading">
												<div class="row">
													<div class="col-sm-4">
														<a href=""> <img alt="profile"
															src="static/images/male-avatar.png"
															class="img-sm img-border">
														</a>
													</div>
													<div class="col-sm-8 pl0">
														<h4>
															<a href="" class="name-nowrap">${appoint.PatientName }</a>
															<small class="media-span tooltips" data-toggle="tooltip"
																data-placement="bottom" data-original-title="23岁11月16天">（${appoint.Sex }
																${appoint.Age }岁）</small>
														</h4>
														<span class="text-nowrap">创建时间：${appoint.CreateDateTime }</span><br>
														<span class="text-nowrap">预约：${appoint.E_Name }
															(${appoint.OfficeName }、<script>
																document
																		.write(
																				getName('${appoint.Appointment_Type }'))
															</script> )
														</span><br> <span class="text-nowrap">预约时间：${appoint.Appointment_Date }
															${appoint.Appointment_Time }</span><br> <span
															class="text-nowrap">预约内容：${appoint.Appointment_Con }</span><br>
														<span class="text-nowrap">备注：${appoint.Comment }</span>

													</div>
												</div>
											</div>
											<div class="panel-body text-center pt1">
												<ul class="photo-meta">
													<li><a
														onclick="editApp('${appoint}','${appoint.Appointment_Date }','${appoint.Appointment_Time }')">修改预约</a></li>
													<li><a onclick="deleteAppoint('${appoint.Appointment_ID}')">取消预约</a></li>
												</ul>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
						<!-- 分页 12条一页 -->
						<div id="buttons">
							<div class="base_page">
								<button
									onclick="nextPage('${page.currentPage -1}','${page.showCount}')"
									type="button" class="btn btn-default pull-left">
									<i class="glyphicon glyphicon-chevron-left"></i>
								</button>
								<button type="button"
									class="btn btn-default  base_page_info pull-left"
									disabled="disabled">${page.currentPage}/${page.totalPage}</button>
								<button
									onclick="nextPage('${page.currentPage +1}','${page.showCount}')"
									type="button" class="btn btn-default pull-left">
									<i class="glyphicon glyphicon-chevron-right"></i>
								</button>
								<input type="hidden" id="showCount" value="${page.showCount}"><input
									id="toGoPage" placeholder="页码" type="number"
									class="form-control  pull-left"
									style="width: 160px; height: 35px;" /> <a
									class="btn btn-default j_madule_page_search_submit pull-left ml5"
									type="button" onclick="toTZ();">Go</a>
							</div>
						</div>
						<!-- 分页接受 -->
					</c:when>
					<c:otherwise>
						<div class="row text-center">
							<strong>暂无数据</strong>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function editApp(data, date, time) {
			var appointTime = date + ' ' + time;
			data = getdata(data);
			var url = "appointment/editApp.do?data=" + data;
			if (new Date() > new Date(appointTime)) {
				url += '&view=view';
			}
			location.href = url;
		}
		function deleteAppoint(id) {
			var url = "appointment/updateAppintStatus.do?AppointmentStatus=3&Appointment_ID=" + id;
			$.get(url,function(result){
				if (result=='success') {
					alert('取消预约成功');
					location.reload();
				} else {
					alert('取消预约失败');
				}
			})
		}

		function getdata(data) {
			var apps = data;
			if (apps != '') {
				apps = apps.replace(/=/g, '":"');
				apps = apps.replace(/, /g, '","');
				apps = apps.replace(/{/g, '{"');
				apps = apps.replace(/}/g, '"}');
				apps = apps.replace(/}","{/g, '},{');
			}
			if (apps.indexOf('CreateDateTime') > -1) {
				var json = JSON.parse(apps);
				delete json["CreateDateTime"];
				apps = JSON.stringify(json)
			}
			return apps;
		}
	</script>
</body>
</html>