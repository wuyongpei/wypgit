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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/bootstrap/css/bootstrap-select.css" rel="stylesheet" />
<link href="static/fullRC/css/register.css" rel="stylesheet" />
<link href="static/fullRC/css/icon/iconfont.css" rel="stylesheet" />
<link rel="stylesheet" href="static/css/datepicker.css" />
<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="static/fullRC/js/pinyin_dict_withtone.js"></script>
<script type="text/javascript" src="static/fullRC/js/pinyinUtil.js"></script>
<script type="text/javascript" src="static/fullRC/js/jquery.form.js"></script>
<script type="text/javascript"
	src="static/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap-select.js"></script>
<script type="text/javascript" src="static/fullRC/js/datetimeUtil.js"></script>
<script type="text/javascript" src="static/fullRC/js/iconfont.js"></script>
<script type="text/javascript" src="static/laydate/laydate.js"></script>
<script type="text/javascript" src="static/fullRC/js/pagePlugin.js"></script>
<%@include file="../../layouts/taglib.jsp"%>
<style type="text/css">
.p_btn {
	font-size: 12px;
	background-color: rgb(65, 178, 166) !important;
	color: #fff;
}

.p_btn:hover {
	font-size: 12px;
	background-color: #ccc !important;
	color: #fff !important;
}

.input-sm2 {
	font-size: 12px;
	height: 30px !important;
}

.btn-default {
	height: 30px !important;
}

.panel-body {
	padding: 0;
}

.yyy {
	background-color: #D55D5D !important;
}

.yjz {
	background-color: #3DADA1 !important;
}

.sy {
	background-color: #4289C7 !important;
}

.yqx {
	background-color: #666666 !important;
}

.col-xs-6, .col-sm-4, .col-md-3 {
	display: inline-block !important;
	vertical-align: top;
}

li {
	cursor: pointer;
}
</style>

</head>
<body>
	<div>
		<ul id="myTab" class="nav nav-tabs">
			<li class="active"><a href="#appointManager" data-toggle="tab">预约管理
			</a></li>
			<li><a href="#appointSet" data-toggle="tab">预约设置</a></li>
		</ul>

		<div class="tab-content tab-div">
			<div class="tab-pane active" id="appointManager"
				style="overflow-x: hidden;">
				<form id="form" method="post"
					action="appointment/appointpagelist.do">
					<div class="panel panel-default" style="border: none;">
						<div class="panel-heading head-panel">
							<div class="row">
								<div class="col-sm-3 col-md-4">
									<div class="btn-group">
										<a class="btn btn-sm btn-default"
											onclick="goListPage('appointAdd')"><i
											class="glyphicon glyphicon-plus"></i>新增预约</a>
									</div>

									<div class="btn-group">
										<a class="btn btn-sm btn-default"
											onclick="goListPage('yuyue');"><i
											class="glyphicon glyphicon-calendar"></i>日历</a> <a
											class="btn btn-sm btn-default active"
											onclick="goListPage('appointpagelist');"><i
											class="glyphicon glyphicon-list-alt"></i>列表</a>
									</div>
								</div>
								<input autocomplete="off" id="office" type="text"
									style="display: none" name="OfficeID" value="${pd.OfficeID }">
								<input autocomplete="off" id="fromDate" type="text"
									style="display: none" name="fromDate" value="${pd.fromDate }">
								<input autocomplete="off" id="toDate" type="text"
									style="display: none" name="toDate" value="${pd.toDate }">
								<input autocomplete="off" id="fromTime" name="fromTime"
									type="text" style="display: none" value="${pd.fromTime }">
								<input autocomplete="off" id="toTime" type="text"
									style="display: none" name="toTime" value="${pd.toTime }">
								<input autocomplete="off" id="status" type="text"
									style="display: none" name="AppointmentStatus"
									value="${pd.AppointmentStatus }"> <input
									autocomplete="off" id="type" type="text" style="display: none"
									name="Appointment_Type" value="${pd.Appointment_Type }">
								<input autocomplete="off" id="empID" type="text"
									style="display: none" name="Emp_ID" value="${pd.Emp_ID }">
								<div class="col-sm-9 col-md-8 pull-right">
									<div action="" class="form-inline pull-right" method="post">
										<div class="form-group">
											<input name="PatientName" autocomplete="off" id="PatientName"
												type="text" value="${pd.PatientName }"
												class="form-control input-sm2" placeholder="输入患者姓名">
										</div>
										<div class="form-group">
											<select class="selectpicker select-sm2" id="offid"
												data-placeholder="选择科室">
												<option value="" selected="selected"></option>
												<c:forEach items="${pd.pdofList}" var="pof">
													<option value="${pof.OfficeID}">${pof.OfficeName}</option>
												</c:forEach>
											</select> <input name="pdofList" value="${pd.pdofList}"
												style="display: none">
										</div>
										<div class="form-group">
											<select data-placeholder="选择医生" class="selectpicker"
												id="doctorName">
												<option value="" selected="selected"></option>
												<c:if test="${not empty pd.empList}">
													<c:forEach items="${pd.empList}" var="emp">
														<option value="${emp.Emp_ID}">${emp.E_Name}</option>
													</c:forEach>
												</c:if>
											</select> <input value="${pd.empList}" id="empList" name="empList"
												style="display: none">
										</div>
										<button class="btn p_btn " onclick="searchApps();">
											<i class="glyphicon glyphicon-search"></i>
										</button>
									</div>
								</div>

							</div>

							<div class="row">
								<div class="col-sm-3 col-md-4">
									<h4 style="margin-left: 0.5%">预约信息</h4>
								</div>
								<div class="col-sm-9 col-md-8 pull-right">
									<div action="" class="form-inline pull-right" method="post">
										<div class="form-group ">
											<input autocomplete="off" id="Appointment_Date" type="text"
												class="form-control input-sm2" placeholder="预约日期">
										</div>
										<div class="form-group ">
											<input autocomplete="off" id="CreateDateTime" type="text"
												class="form-control input-sm2" placeholder="创建日期">
										</div>
										<div class="form-group ">
											<select id="Appointment_Type" class="form-control input-sm2"
												data-placeholder="请选择预约类型">
												<option value="" selected="selected">预约类型</option>
												<c:forEach items="${pd.appointment}" var="appoint">
													<option value="${appoint.DictionaryCode}">${appoint.DictionaryName}</option>
												</c:forEach>
											</select> <input name="appointment" value="${pd.appointment}"
												style="display: none">
										</div>
										<div class="form-group">
											<select id="AppointmentStatus" class="form-control input-sm2"
												data-placeholder="请选择预约状态">
												<option value="" selected="selected">预约状态</option>
												<c:forEach items="${pd.appointmentState}" var="appoint">
													<option value="${appoint.DictionaryCode}">${appoint.DictionaryName}</option>
												</c:forEach>
											</select>
										</div>
										<div class="form-group">
											<a class="btn btn-default" onclick="excelReport()"><i
												class="glyphicon glyphicon-download-alt"></i>导出</a>
										</div>
									</div>
								</div>
							</div>

						</div>
						<input id="apps" style="display: none" value="${listApps }">
						<!-- 病人列表 -->
						<div class="panel-body" style="min-height: 483px;">
							<div id="list" class="panel-body row">
								<div class="row">
									<!-- 始 -->
									<div class="col-xs-6 col-sm-6 col-md-4">
										<div class="blog-item shadow-none">
											<div class="blog-details">
												<div
													class="panel panel-danger panel-alt widget-photoday img-list">
													<div class="panel-heading">
														<div class="row">
															<div class="col-sm-4">
																<a href="" class="" target="_blank"> <img
																	src="static/images/male-avatar.png"
																	class="img-sm img-border" alt="profile">
																</a>
															</div>
															<div class="col-sm-8 p10">
																<span class="badge badge-end room-tag"
																	style="float: right;"><i
																	class="iconfont icon-weiXin-copy"></i>已预约</span>
																<h4>
																	<a href="" class="white">大大大 </a> <small
																		class="white media-span tooltips"
																		data-toggle="tooltip" data-placement="bottom"
																		title="30岁10月8天"> (女 30岁)</small>
																</h4>
																<a class="white" href=""> <span>创建时间：2018-05-14
																		19:16:49</span><br> <span class="text-nowrap">预约：(科室、初诊)</span><br>
																	<span>预约时间：2018-05-14 19:20:00</span><br> <span
																	class="text-nowrap">预约内容：</span><br> <span
																	class="text-nowrap">备注：</span>
																</a>
															</div>
														</div>
													</div>

													<div class="panel-body text-center">
														<ul class="photo-meta">
															<li><a href="">修改</a></li>
															<li><a href="">查看</a></li>
														</ul>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 终 -->
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
										class="form-control  num-input pull-left" /> <a
										class="btn btn-default j_madule_page_search_submit pull-left ml5"
										type="button" onclick="toTZ();">Go</a>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<!-- 预约设置 -->
			<div class="tab-pane fade" id="appointSet">
				<iframe id="ifr-set" scrolling="auto" frameborder="0" width="100%"
					style="min-height: 800px;" src="appointment/apSetPage.do"></iframe>
			</div>
		</div>


	</div>


	<script type="text/javascript">
		$(function() {
			var ischange = false;
			$('#offid').selectpicker({
				liveSearch : true,
				maxOptions : 1
			});
			$('#offid').change(function() {
				ischange = true;
				ischange = searchEmp(ischange);
				$('#doctorName').selectpicker('val', '');
				$('#doctorName').selectpicker('refresh');
			})
			$('#doctorName').selectpicker({
				liveSearch : true,
				maxOptions : 1
			});
			laydate.render({
				elem : '#Appointment_Date',
				type : 'date',
				range : true,
				theme : 'molv'
			})
			laydate.render({
				elem : '#CreateDateTime',
				type : 'datetime',
				range : true,
				theme : 'molv'
			})
			getAppsList();
			begin();
		});

		function begin() {
			var office = $('#office').val();
			var fromDate = $('#fromDate').val();
			var toDate = $('#toDate').val();
			var fromTime = $('#fromTime').val();
			var toTime = $('#toTime').val();
			var status = $('#status').val();
			var type = $('#type').val();
			var empID = $('#empID').val();
			if (office != '') {
				$('#offid').selectpicker('val', office);
				$('#offid').selectpicker('refresh');
			}
			if (empID != '') {
				$('#doctorName').selectpicker('val', empID);
				$('#doctorName').selectpicker('refresh');
			}
			if (fromDate != '' && toDate != '') {
				$('#Appointment_Date').val(fromDate + ' - ' + toDate);
			}
			if (fromTime != '' && toTime != '') {
				$('#CreateDateTime').val(fromTime + ' - ' + toTime);
			}
			if (type != '') {
				$('#Appointment_Type').val(type);
			}
			if (status != '') {
				$('#AppointmentStatus').val(status);
			}
		}

		function goListPage(URL) {
			var url = "appointment/" + URL + ".do";
			location.href = url;
		}

		function editApp(thi, date, time) {
			var data = $(thi).parent().parent().find('input').val();
			var url = "appointment/editApp?data=" + data;
			if ($(thi).text() == '查看') {
				url += '&view=view';
			} else {
				var time = date + ' ' + time;
				if (new Date() > new Date(time)) {
					url += '&view=view';
				}
			}
			location.href = url;
		}

		function searchEmp(ischange) {
			if (ischange) {
				var id = $('#offid').val();
				if (id == '' || typeof (id) == 'undefined') {
					id = 0;
				}
				var url = "emp/getEmpByo.do?OfficeID=" + id;
				$.get(url, function(data) {
					$('#empList').val(JSON.stringify(data));
					$('#doctorName').empty();
					$('#doctorName').append(
							'<option value="" selected="selected"></option>');
					var emps = new Array();
					emps = data;
					if (emps != '') {
						for (var i = 0; i < emps.length; i++) {
							emp = emps[i];
							$('#doctorName').append(
									'<option value="'+emp.Emp_ID+'">'
											+ emp.E_Name + '</option>');
						}
					}
					$('#doctorName').selectpicker('refresh');
				})
			}
			return false;
		}

		function searchApps() {
			var PatientName = $('#PatientName').val();
			var OfficeID = $('#offid').val();
			var Emp_ID = $('#doctorName').val();
			var Appointment_Date = new Array();
			var CreateDateTime = new Array();
			if ($('#Appointment_Date').val() == '') {
				Appointment_Date = [ '', '' ];
			} else {
				Appointment_Date = $('#Appointment_Date').val().split(' - ');
			}
			if ($('#CreateDateTime').val() == '') {
				CreateDateTime = [ '', '' ];
			} else {
				CreateDateTime = $('#CreateDateTime').val().split(' - ');
			}
			var Appointment_Type = $('#Appointment_Type').val();
			var AppointmentStatus = $('#AppointmentStatus').val();
			$('#office').val(OfficeID);
			$('#fromDate').val(Appointment_Date[0]);
			$('#toDate').val(Appointment_Date[1]);
			$('#fromTime').val(CreateDateTime[0]);
			$('#toTime').val(CreateDateTime[1]);
			$('#status').val(AppointmentStatus);
			$('#type').val(Appointment_Type);
			$('#empID').val(Emp_ID);
			$('#from').submit();
		}

		function getAppsList() {
			var apps = $('#apps').val();
			if (apps != '') {
				apps = apps.replace(/=/g, '":"');
				apps = apps.replace(/, /g, '","');
				apps = apps.replace(/{/g, '{"');
				apps = apps.replace(/}/g, '"}');
				apps = apps.replace(/}","{/g, '},{');
				var appList = JSON.parse(apps);
				handleApps(appList);
			}
		}

		function handleApps(appList) {
			$('#list').empty();
			if (appList != null && appList.length > 0) {
				var str = '<div class="row">';
				for (var i = 0; i < appList.length; i++) {
					app = appList[i];
					var appV = new Object();
					for ( var key in app) {
						appV[key] = app[key];
					}
					delete appV.CreateDateTime;
					var status = new Array();
					if (app.AppointmentStatus == 0) {
						status[0] = '已预约';
						status[1] = 'yyy';
					} else if (app.AppointmentStatus == 1) {
						status[0] = '已就诊';
						status[1] = 'yjz';
					} else if (app.AppointmentStatus == 2) {
						status[0] = '失约';
						status[1] = 'sy';
					} else {
						status[0] = '已取消';
						status[1] = 'yqx';
					}
					str += '<div class="col-xs-6 col-sm-4 col-md-3" style="float:none;">'
							+ '<div class="blog-item shadow-none">'
							+ '<div class="blog-details">'
							+ '<div class="panel panel-danger panel-alt widget-photoday img-list">'
							+ '<div class="panel-heading '+status[1]+'">'
							+ '<div class="row">'
							+ '<div class="col-sm-4">'
							+ '<a href="" class="" target="_blank">'
							+ '<img  src="static/images/male-avatar.png" class="img-sm img-border" alt="profile"></a></div>'
							+ '<div class="col-sm-8 p10"><span class="badge badge-end room-tag" style="float:right;"><i class="iconfont icon-weiXin-copy"></i>'
							+ status[0]
							+ '</span><h4><a href="" class="white">'
							+ app.PatientName
							+ '</a><small class="white media-span tooltips" data-toggle="tooltip"data-placement="bottom" title="'+
                 status[0]+'">('
							+ app.Sex
							+ '&nbsp;'
							+ app.Age
							+ '岁)</small></h4><a class="white" href="" ><span>创建时间：'
							+ app.CreateDateTime
							+ '</span><br><span class="text-nowrap">预约：('
							+ app.OfficeName
							+ '、'
							+ getName(app.Appointment_Type)
							+ ')</span><br><span>预约时间：'
							+ app.Appointment_Date
							+ '&nbsp;'
							+ app.Appointment_Time
							+ '</span><br> <span class="text-nowrap">预约内容：'
							+ app.Appointment_Con
							+ '</span><br><span class="text-nowrap">备注：'
							+ app.Comment
							+ '</span></a> </div></div></div><div class="panel-body text-center"><ul class="photo-meta">'
							+ '<input style="display:none;" value='
							+ JSON.stringify(appV)
							+ '><li><a onclick="editApp(this,'
							+ "'"
							+ app.Appointment_Date
							+ "','"
							+ app.Appointment_Time
							+ "'"
							+ ');">修改</a></li><li><a onclick="editApp(this);">查看</a></li></ul></div></div></div> </div></div>';
				}
				$('#list').append(str);
				$('#buttons').css('display', 'inline');
			} else {
				$('#buttons').css('display', 'none');
			}
		}

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
</body>
</html>