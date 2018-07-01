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

<link rel="stylesheet" href="static/fullRC/css/zdialog.css" />
<script src="static/fullRC/js/zdialog.js"></script>

<%@include file="../../layouts/taglib.jsp"%>
<style type="text/css">
.p_btn {
	background-color: rgb(65, 178, 166) !important;
	color: #fff;
}

.p_btn:hover {
	background-color: #ccc !important;
	color: #fff !important;
}

.point-red {
	margin: 0 40%;
	width: 30px;
	border-radius: 15px;
	background-color: #D9534F !important;
}

.point-red a {
	color: #fff !important;
}

.btn-default {
	height: 30px !important;
}

.input-sm2 {
	font-size: 12px;
	height: 30px !important;
}

.fc-day-header {
	text-align: inherit;
}

#myModal th, #myModal td {
	padding: 10px 0;
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
				style="overflow: hidden;">
				<div class="panel panel-default" style="border: none;">
					<div class="panel-heading head-panel">
						<div class="row">
							<div class="col-sm-3 col-md-4">
								<div class="btn-group">
									<a type="buttion" class="btn btn-sm btn-default"
										onclick="goListPage('appointAdd')"><i
										class="glyphicon glyphicon-plus"></i>新增预约</a>
								</div>

								<div class="btn-group">
									<a class="btn btn-sm btn-default active"
										onclick="goListPage('yuyue');"><i
										class="glyphicon glyphicon-calendar"></i>日历</a> <a
										class="btn btn-sm btn-default"
										onclick="goListPage('appointpagelist');"><i
										class="glyphicon glyphicon-list-alt"></i>列表</a>
								</div>
							</div>

							<div class="col-sm-9 col-md-8 pull-right">
								<div class="form-inline pull-right">
									<div class="form-group">
										<select id="appointmentT" class="form-control input-sm2"
											data-placeholder="请选择预约类型">
											<option value="" selected="selected">预约类型</option>
											<c:forEach items="${appointment}" var="appoint">
												<option value="${appoint.DictionaryCode}">${appoint.DictionaryName}</option>
											</c:forEach>
										</select> <input id="msg" value="${msg }" style="display: none">
									</div>
									<div class="form-group">
										<select class="selectpicker" name="officeID" id="offid"
											data-placeholder="选择科室">
											<option value="" selected="selected"></option>
											<c:forEach items="${pdofList}" var="pof">
												<option value="${pof.OfficeID}">${pof.OfficeName}</option>
											</c:forEach>
										</select>
									</div>
									<div class="form-group">
										<select data-placeholder="选择医生" class="selectpicker"
											id="doctorName" name="doctorName">
											<option value="" selected="selected"></option>
										</select>
									</div>
									<button class="btn p_btn" onclick="search();">
										<i class="glyphicon glyphicon-search"></i>
									</button>
								</div>
							</div>
						</div>
					</div>

					<div class="panel-body">
						<div class="table-responsive">
							<table style="width: 100%;">
								<tbody>
									<tr>
										<td width="30%;">
											<div class="btn-group">
												<a type="button" class="btn btn-sm btn-default"
													data-type="prew" onclick="goWeekCirle(-1)"> <i
													class="glyphicon glyphicon-chevron-left"></i> 上一周
												</a> <a type="button" class="btn btn-sm btn-default"
													data-type="next" onclick="goWeekCirle(1)"> 下一周 <i
													class="glyphicon glyphicon-chevron-right"></i>
												</a>
											</div>
											<div class="btn-group">
												<a type="button" class="btn btn-sm btn-default"
													onclick="goWeekCirle(0)">今天</a>
											</div>
										</td>
										<td width="40%">
											<div class="btn-group">
												<h4 class=""></h4>
											</div>
										</td>
										<td width="30%" align="right" data-permission="14">
											<div class="btn-group">
												<button type="button" class="btn btn-sm btn-default">关闭预约</button>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>


						<div id="calendar" class="ap-div">
							<div>
								<div>
									<table border="1" class="t_tab">
										<thead>
											<tr>
												<th width="50"></th>
												<th class="fc-day-header"><a href="javascript:void(0);">星期一<span
														id="day1"></span><input type="hidden" id="dy1" /></a></th>
												<th class="fc-day-header"><a href="javascript:void(0);">星期二<span
														id="day2"></span><input type="hidden" id="dy2" /></a></th>
												<th class="fc-day-header"><a href="javascript:void(0);">星期三<span
														id="day3"></span><input type="hidden" id="dy3" /></a></th>
												<th class="fc-day-header"><a href="javascript:void(0);">星期四<span
														id="day4"></span><input type="hidden" id="dy4" /></a></th>
												<th class="fc-day-header"><a href="javascript:void(0);">星期五<span
														id="day5"></span><input type="hidden" id="dy5" /></a></th>
												<th class="fc-day-header"><a href="javascript:void(0);">星期六<span
														id="day6"></span><input type="hidden" id="dy6" /></a></th>
												<th class="fc-day-header"><a href="javascript:void(0);">星期日<span
														id="day7"></span><input type="hidden" id="dy7" /></a></th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td width="50" class="fc-axis"><span>预约</span></td>
												<td class="fc-day">上午<span id="1am"></span>人<br>下午<span
													id="1pm"></span>人
												</td>
												<td class="fc-day">上午<span id="2am"></span>人<br>下午<span
													id="2pm"></span>人
												</td>
												<td class="fc-day">上午<span id="3am"></span>人<br>下午<span
													id="3pm"></span>人
												</td>
												<td class="fc-day">上午<span id="4am"></span>人<br>下午<span
													id="4pm"></span>人
												</td>
												<td class="fc-day">上午<span id="5am"></span>人<br>下午<span
													id="5pm"></span>人
												</td>
												<td class="fc-day">上午<span id="6am"></span>人<br>下午<span
													id="6pm"></span>人
												</td>
												<td class="fc-day">上午<span id="7am"></span>人<br>下午<span
													id="7pm"></span>人
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<hr style="height: 2px; background-color: #ddd; margin-top: 0;">
							<div class="fc-day-state">
								<table id="dataList" border="1" class="t_tab"
									style="table-layout: fixed;">
									<tbody>
										<c:forEach items="${listac}" var="lac">
											<tr>
												<td class="fc-axis1" width="50">${lac.timeD}</td>
												<td class="fc-day1"><c:if test="${lac.monCount!=0 }">
														<div class="point-red">
															<a data-toggle="modal" data-target="#myModal"
																onclick="getAppList('${lac.timeD}',0)">${lac.monCount}人</a>
														</div>
													</c:if></td>
												<td class="fc-day1"><c:if test="${lac.tueCount!=0 }">
														<div class="point-red">
															<a data-toggle="modal" data-target="#myModal"
																onclick="getAppList('${lac.timeD}',1)">${lac.tueCount}人</a>
														</div>
													</c:if></td>
												<td class="fc-day1"><c:if test="${lac.wedCount!=0 }">
														<div class="point-red">
															<a data-toggle="modal" data-target="#myModal"
																onclick="getAppList('${lac.timeD}',2)">${lac.wedCount}人</a>
														</div>
													</c:if></td>
												<td class="fc-day1"><c:if test="${lac.thuCount!=0 }">
														<div class="point-red">
															<a data-toggle="modal" data-target="#myModal"
																onclick="getAppList('${lac.timeD}',3)">${lac.thuCount}人</a>
														</div>
													</c:if></td>
												<td class="fc-day1"><c:if test="${lac.friCount!=0 }">
														<div class="point-red">
															<a data-toggle="modal" data-target="#myModal"
																onclick="getAppList('${lac.timeD}',4)">${lac.friCount}人</a>
														</div>
													</c:if></td>
												<td class="fc-day1"><c:if test="${lac.satCount!=0 }">
														<div class="point-red">
															<a data-toggle="modal" data-target="#myModal"
																onclick="getAppList('${lac.timeD}',5)">${lac.satCount}人</a>
														</div>
													</c:if></td>
												<td class="fc-day1"><c:if test="${lac.sunCount!=0 }">
														<div class="point-red">
															<a data-toggle="modal" data-target="#myModal"
																onclick="getAppList('${lac.timeD}',6);">
																${lac.sunCount}人</a>
														</div>
													</c:if></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

						</div>
					</div>
				</div>
			</div>


			<div class="tab-pane fade" id="appointSet">
				<iframe id="ifr-set" scrolling="auto" frameborder="0" width="100%"
					style="min-height: 800px;" src="appointment/apSetPage.do"></iframe>
			</div>
		</div>












		<input type="hidden" id="firstdayT" value=""> <input
			type="hidden" id="lastdayT" value=""> <input type="hidden"
			id="nowdayMon" value="">


		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h4 class="modal-title" id="myModalLabel">预约信息</h4>
					</div>
					<div class="modal-body" style="max-height: 550px; overflow: auto;">
						<table id="appsList" class="t_tab" style="border: none;">
							<thead style="background: #F4F4F4;">
								<tr>
									<th style="width: 10%" class="fc-day-header">姓名</th>
									<th style="width: 5%" class="fc-day-header">性别</th>
									<th style="width: 5%" class="fc-day-header">年龄</th>
									<th style="width: 10%" class="fc-day-header">预约科室</th>
									<th style="width: 10%" class="fc-day-header">预约类型</th>
									<th style="width: 10%" class="fc-day-header">预约医生</th>
									<th style="width: 17%" class="fc-day-header">预约日期</th>
									<th style="width: 17%" class="fc-day-header">预约内容</th>
									<th style="width: 17%" class="fc-day-header">备注</th>
								</tr>
							</thead>
							<tbody id="appsData">

							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>


		<script type="text/javascript">
			$(top.hangge());

			$(function() {
				var ifSearch = true;
				initialization();
				$('#offid').change(function() {
					searchEmp();
					ifSearch = false;
				});
				$('button[data-id="doctorName"]').click(function() {
					if (ifSearch) {
						searchEmp();
					}
					ifSearch = false;
				});
				getAppointNumber();
			});

			function initialization() {
				if ($("#msg").val() != '') {
					$.DialogByZ.Alert({
						Title : "提示",
						Content : $("#msg").val(),
						BtnL : "确定",
						FunL : alerts
					})
				}
				if ($("#msg").val() == 'faile') {
					$.DialogByZ.Alert({
						Title : "提示",
						Content : "保存成功",
						BtnL : "确定",
						FunL : alerts
					})
				}
				$('#offid').selectpicker({
					liveSearch : true,
					maxOptions : 1
				});
				$('#doctorName').selectpicker({
					liveSearch : true,
					maxOptions : 1
				});
				var mon = dateRangeUtil.getCurrentWeekMon();
				var sun = dateRangeUtil.getCurrentWeekSun();
				$("#firstdayT").val(mon);
				$("#nowdayMon").val(mon);
				$("#lastdayT").val(sun);
				$("#dateCircle").html(
						convertDate(mon) + " - " + convertDate(sun));
				//初始化每周日期
				var startStop = dateRangeUtil.getCurrentWeekOtoS();
				var startS = dateRangeUtil.getCurrentWeekOtoSOtherType();
				if (startStop.length != 0) {
					for (var i = 0; i < startStop.length; i++) {
						$("#day" + (i + 1)).html(startStop[i]);
					}
				}
				if (startS.length != 0) {
					for (var i = 0; i < startS.length; i++) {
						$("#dy" + (i + 1)).val(startS[i]);
					}
				}
			}

			//根據時間點 獲取時間範圍
			function goWeekCirle(dayType) {
				var dateTime;
				if (dayType == -1) {
					dateTime = $("#firstdayT").val();
				} else if (dayType == 1) {
					dateTime = $("#lastdayT").val();
				} else if (dayType == 0) {
					dateTime = $("#nowdayMon").val();
					;
				}
				//標頭顯示
				var startStop = dateRangeUtil.getWeekCirle(dayType, dateTime);
				if (startStop.length != 0) {
					$("#firstdayT").val(startStop[0]);
					$("#lastdayT").val(startStop[1]);
				}
				//表行列日期顯示
				var startS = dateRangeUtil.getWeekSevenDayCirle(dayType,
						dateTime);
				if (startS.length != 0) {
					for (var i = 0; i < startS.length; i++) {
						$("#day" + (i + 1)).html(startS[i]);
					}
				}
				//錶行賦值
				var startS2 = dateRangeUtil.getWeekSevenDayCirle2(dayType,
						dateTime);
				if (startS2.length != 0) {
					for (var i = 0; i < startS2.length; i++) {
						$("#dy" + (i + 1)).val(startS2[i]);
					}
				}
				search();
			}

			//点击人数获取预约人的明细卡片
			function getAppList(timeCircle, day) {
				timeEnd = timeCircle.substring(0, 3) + "59";
				date = addDate($("#firstdayT").val(), day);
				$
						.ajax({
							url : "appointment/getAppByTime.do",
							type : "get",
							data : "startAppointTime=" + timeCircle
									+ "&endAppointTime=" + timeEnd
									+ "&appointmentDate=" + date,
							success : function(result) {
								$("#appsData").empty();
								var apps = new Array();
								apps = result;
								if (apps != '') {
									for (var i = 0; i < apps.length; i++) {
										var app = apps[i];
										var appV = app
										delete appV.CreateDateTime;
										$("#appsData")
												.append(
														'<tr style="cursor: pointer" onclick="editApp(this,\''
																+ app.Appointment_Date
																+ '\' ,\''
																+ app.Appointment_Time
																+ '\')" ><td style="width: 10%" class="fc-day-header">'
																+ app.PatientName
																+ '<input style="display:none" value='
																+ JSON
																		.stringify(appV)
																+ '></td><td style="width: 5%" class="fc-day-header">'
																+ app.Sex
																+ '</td><td style="width: 5%" class="fc-day-header">'
																+ app.Age
																+ '</td><td style="width: 10%" class="fc-day-header">'
																+ app.OfficeName
																+ '</td><td id="appointmentType" style="width: 10%" class="fc-day-header">'
																+ getName(app.Appointment_Type)
																+ '</td><td style="width: 10%" class="fc-day-header">'
																+ app.E_Name
																+ '</td><td style="width: 16%" class="fc-day-header">'
																+ app.Appointment_Date
																+ '&nbsp;'
																+ app.Appointment_Time
																+ '</td><td style="width: 17%" class="fc-day-header">'
																+ app.Appointment_Con
																+ '</td><td style="width: 17%" class="fc-day-header">'
																+ app.Comment
																+ '</td></tr>')
									}
								}
							}
						});
			}

			function editApp(thi, date, time) {
				var data = $(thi).find('input').val();
				var url = "appointment/editApp.do?data=" + data;
				var appointTime = date + ' ' + time;
				if (new Date() > new Date(appointTime)) {
					url += '&view=view';
				}
				location.href = url;
			}

			function goListPage(URL) {
				var url = "appointment/" + URL + ".do";
				location.href = url;
			}

			function searchEmp() {
				var id = $('#offid').val();
				if (id == '' || typeof (id) == 'undefined') {
					id = 0;
				}
				var url = "emp/getEmpByo.do?OfficeID=" + id;
				$.get(url, function(data) {
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

			function alerts() {
				$.DialogByZ.Close();
				$("#msg").val('');
			}

			function search() {
				firstday = $("#firstdayT").val();
				if (firstday != '') {
					var OfficeID = $('#offid').val();
					var Emp_ID = $('#doctorName').val();
					var Appointment_Type = $('#appointmentT').val();
					var url = 'appointment/refresh.do?firstday=' + firstday
							+ '&OfficeID=' + OfficeID + '&Emp_ID=' + Emp_ID
							+ '&Appointment_Type=' + Appointment_Type;
					$
							.get(
									url,
									function(result) {
										$('#dataList tbody').remove();
										var listac = new Array();
										listac = result;
										for (var i = 0; i < listac.length; i++) {
											var lac = listac[i];
											var table = '<tr><td class="fc-axis1" width="50">'
													+ lac.timeD
													+ '</td><td class="fc-day1">';
											if (lac.monCount != 0) {
												table += '<div class="point-red"><a data-toggle="modal" data-target="#myModal"  onclick="getAppList('
														+ "'"
														+ lac.timeD
														+ "'"
														+ ',0);">'
														+ lac.monCount
														+ '人</a></div>'
											}
											table += '</td><td class="fc-day1">';
											if (lac.tueCount != 0) {
												table += '<div class="point-red"><a data-toggle="modal" data-target="#myModal"  onclick="getAppList('
														+ "'"
														+ lac.timeD
														+ "'"
														+ ',1);">'
														+ lac.tueCount
														+ '人</a></div>'
											}
											table += '</td><td class="fc-day1">';
											if (lac.wedCount != 0) {
												table += '<div class="point-red"><a data-toggle="modal" data-target="#myModal"  onclick="getAppList('
														+ "'"
														+ lac.timeD
														+ "'"
														+ ',2);">'
														+ lac.wedCount
														+ '人</a></div>'
											}
											table += '</td><td class="fc-day1">';
											if (lac.thuCount != 0) {
												table += '<div class="point-red"><a data-toggle="modal" data-target="#myModal"  onclick="getAppList('
														+ "'"
														+ lac.timeD
														+ "'"
														+ ',3);">'
														+ lac.thuCount
														+ '人</a></div>'
											}
											table += '</td><td class="fc-day1">';
											if (lac.friCount != 0) {
												table += '<div class="point-red"><a data-toggle="modal" data-target="#myModal"  onclick="getAppList('
														+ "'"
														+ lac.timeD
														+ "'"
														+ ',4);">'
														+ lac.friCount
														+ '人</a></div>'
											}
											table += '</td><td class="fc-day1">';
											if (lac.satCount != 0) {
												table += '<div class="point-red"><a data-toggle="modal" data-target="#myModal"  onclick="getAppList('
														+ "'"
														+ lac.timeD
														+ "'"
														+ ',5);">'
														+ lac.satCount
														+ '人</a></div>'
											}
											table += '</td><td class="fc-day1">';
											if (lac.sunCount != 0) {
												table += '<div class="point-red"><a data-toggle="modal" data-target="#myModal"  onclick="getAppList('
														+ "'"
														+ lac.timeD
														+ "'"
														+ ',6);">'
														+ lac.sunCount
														+ '人</a></div>'
											}
											table += '</td></tr>';
											$('#dataList').append(table)
										}
										getAppointNumber();
									})
				}
			}

			function addDate(date, days) {
				var d = new Date(date);
				d.setDate(d.getDate() + days);
				var month = d.getMonth() + 1;
				var day = d.getDate();
				if (month < 10) {
					month = "0" + month;
				}
				if (day < 10) {
					day = "0" + day;
				}
				var val = d.getFullYear() + "-" + month + "-" + day;
				return val;
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

			function getAppointNumber() {
				for (var i = 1; i < 8; i++) {
					var amNum = 0;
					var pmNum = 0;
					$('#dataList tr').each(function(index) {
						var td = $(this).find('td').eq(i).find('a');
						if (td.length > 0) {
							var num = td.text();
							num = num.substring(0, num.length - 1);
							num = Number(num);
							if (index > 6) {
								pmNum += num;
							} else {
								amNum += num;
							}
						}
					})
					$('#' + i + 'am').text(amNum);
					$('#' + i + 'pm').text(pmNum);
				}
			}
		</script>






	</div>
</body>
</html>