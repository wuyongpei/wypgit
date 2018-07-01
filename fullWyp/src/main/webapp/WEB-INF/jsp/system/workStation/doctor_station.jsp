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
<!-- <link href="static/fullRC/css/w_work_s.css" rel="stylesheet"> -->
<link href="static/fullRC/css/wyp_ysgzz.css" rel="stylesheet">
<style type="text/css">
a {
	text-decoration: none !important;
}

.point-red {
	margin: auto;
	width: 30px;
	border-radius: 15px;
	background-color: #D9534F !important;
	cursor: pointer;
}

.point-red a {
	color: #fff !important;
}

#myModal th, #myModal td {
	padding: 10px;
}
</style>
</head>
<body>
	<div>
		<div id="heading">
			<div id="left">
				<a href="index.html">
					<div class="visit">
						<div class="row">
							<i style="color: white; margin-top: 15px;"
								class="icon-user icon-4x pull-left"></i>
							<div style="margin-left: 50px">
								<font>今日就诊概况</font>
								<div class="row_secend">
									<font>总人数：12</font>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="row_third">
								<font>门诊人数</font><br /> <font>0</font>
							</div>
							<div class="row_four">
								<font>远程就诊人数</font><br /> <font>0</font>
							</div>
						</div>
					</div>
				</a>
			</div>
			<div id="center">
				<a href="index.html">
					<div class="visit">
						<div class="row">
							<i style="color: white; margin-top: 15px"
								class="icon-file-alt icon-4x pull-left"></i>
							<div style="margin-left: 50px">
								<font>患者库</font>
								<div class="row_secend">
									<font>患者信息</font>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="row_third">
								<font>门诊人数</font><br /> <font>4654</font>
							</div>
							<div class="row_four">
								<font>远程就诊人数</font><br /> <font>0</font>
							</div>
						</div>
					</div>
				</a>
			</div>
			<div id="right">
				<div class="visit">
					<div class="row_five">
						<span class="glyphicon glyphicon-user"> <i
							class="fa-arrow-circle-up"></i> <font>患者查询</font>
					</div>
					<div class="row_six">
						<input type="text" placeholder="患者姓名" />
						<button class="btn btn-lg btn-light" onclick="search();"
							title="检索">
							<i id="nav-search-icon" class="icon-search icon-large"> </i>
						</button>
					</div>
				</div>
			</div>
		</div>
		<div id="bottom">
			<div id="bottom_left">
				<div>
					<table class="table_first">
						<tbody>
							<tr>
								<td>
									<h4 class="bottom_left_h4">排班信息</h4>
								</td>
							</tr>
							<tr>
								<td>
									<div class="td_first">
										<button
											onclick="goWeekCirle(-1,'#firstdayR','#lastdayR','table_second')"
											class="btn btn-primary p_btn">上一周</button>
										<button
											onclick="goWeekCirle(1,'#firstdayR','#lastdayR','table_second')"
											class="btn btn-primary p_btn">下一周</button>
										<button
											onclick="goWeekCirle(0,'#firstdayR','#lastdayR','table_second')"
											class="btn btn-primary p_btn">今天</button>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div>
					<table class="table_second">
						<thead>
							<tr>
								<td>日期</td>
								<td>排班</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td id="table_second1">周一 <span></span></td>
								<td></td>
							</tr>
							<tr>
								<td id="table_second2">周二 <span></span></td>
								<td></td>
							</tr>
							<tr>
								<td id="table_second3">周三 <span></span></td>
								<td></td>
							</tr>
							<tr>
								<td id="table_second4">周四 <span></span></td>
								<td></td>
							</tr>
							<tr>
								<td id="table_second5">周五 <span></span></td>
								<td></td>
							</tr>
							<tr>
								<td id="table_second6">周六 <span></span></td>
								<td></td>
							</tr>
							<tr>
								<td id="table_second7">周日 <span></span></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div id="bottom_right">
				<div>
					<table class="table_first">
						<tbody>
							<tr>
								<td>
									<h4 class="bottom_left_h4">预约信息</h4>
								</td>
								<td>
									<div class="td_second">
										<button
											onclick="goWeekCirle(-1,'#firstdayL','#lastdayL','table_third')"
											class="btn btn-primary p_btn">上一周</button>
										<button
											onclick="goWeekCirle(1,'#firstdayL','#lastdayL','table_third')"
											class="btn btn-primary p_btn">下一周</button>
										<button
											onclick="goWeekCirle(0,'#firstdayL','#lastdayL','table_third')"
											class="btn btn-primary p_btn">今天</button>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div>
					<table id="appoint" class="table_third">
						<thead>
							<tr>
								<td></td>
								<td id="table_third1"><a href="index.html">星期一 <span></span></a></td>
								<td id="table_third2"><a href="index.html">星期二 <span></span></a></td>
								<td id="table_third3"><a href="index.html">星期三 <span></span></a></td>
								<td id="table_third4"><a href="index.html">星期四 <span></span></a></td>
								<td id="table_third5"><a href="index.html">星期五 <span></span></a></td>
								<td id="table_third6"><a href="index.html">星期六 <span></span></a></td>
								<td id="table_third7"><a href="index.html">星期日 <span></span></a></td>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
				<input id="nowdayMon" type="hidden"><input id="firstdayR"
					type="hidden"><input id="lastdayR" type="hidden"><input
					id="lastdayL" type="hidden"><input id="firstdayL"
					type="hidden">
			</div>
		</div>
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
	</div>
	<script type="text/javascript">
		$(function() {
			begin();

		})
		function begin() {
			var mon = dateRangeUtil.getCurrentWeekMon();
			var sun = dateRangeUtil.getCurrentWeekSun();
			$("#firstdayR").val(mon);
			$("#nowdayMon").val(mon);
			$("#lastdayR").val(sun);
			$("#firstdayL").val(mon);
			$("#lastdayL").val(sun);
			goWeekCirle(0, '#firstdayR', '#lastdayR', 'table_second');
			goWeekCirle(0, '#firstdayL', '#lastdayL', 'table_third');
		}

		function getBol() {
			var userID = $(window.parent.parent.parent.document).find('#empid')
					.val();
			$.post("scheduling/getSchedulByEmpID.do", {
				startDate : $('#firstdayR').val(),
				endDate : $('#lastdayR').val(),
				empID : userID
			}, function(result) {
				var array = new Array();
				array = result;
				if (array != null && array.length != 0) {
					for (var i = 0; i < array.length; i++) {
						var id = array[i].DutyDate;
						$("#table_second" + id).text(array[i].DutyTypeName);
					}
				}
			});
		}

		function getAppoint() {
			firstday = $("#firstdayL").val();
			if (firstday != '') {
				var Emp_ID = $(window.parent.parent.parent.document).find(
						'#empid').val();
				var url = 'appointment/refresh.do?firstday=' + firstday
						+ '&Emp_ID=' + Emp_ID;
				$
						.get(
								url,
								function(result) {
									$('#appoint tbody').empty();
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
											table += '<div class="point-red"><a data-toggle="modal" data-target="#myModal"  onclick="('
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
										$('#appoint tbody').append(table)
									}
								})
			}
		}

		//点击人数获取预约人的明细卡片
		function getAppList(timeCircle, day) {
			timeEnd = timeCircle.substring(0, 3) + "59";
			date = addDate($("#firstdayL").val(), day);
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
													'<tr style="cursor: pointer" onclick="editApp(this)" ><td style="width: 10%" class="fc-day-header">'
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

		function editApp(thi) {
			var data = $(thi).find('input').val();
			var url = "appointment/editApp.do?data=" + data;
			var appointTime = $(thi).find('td').eq(6).text();
			if (new Date() > new Date(appointTime)) {
				url += '&view=view';
			}
			location.href = url;
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

		function goWeekCirle(dayType, id1, id2, id3) {
			var id = '#' + id3;
			var dateTime;
			if (dayType == -1) {
				dateTime = $(id1).val();
			} else if (dayType == 1) {
				dateTime = $(id2).val();
			} else if (dayType == 0) {
				dateTime = $("#nowdayMon").val();
			}
			//標頭顯示
			var startStop = dateRangeUtil.getWeekCirle(dayType, dateTime);
			if (startStop.length != 0) {
				$(id1).val(startStop[0]);
				$(id2).val(startStop[1]);
			}
			//表行列日期顯示
			var startS = dateRangeUtil.getWeekSevenDayCirle(dayType, dateTime);
			var dateList = dateRangeUtil.getDatesOfMon(startStop[0],
					startStop[1]);
			if (startS.length != 0) {
				for (var i = 0; i < startS.length; i++) {
					$(id + (i + 1) + ' span').text(startS[i]);
					if (id3 == 'table_second') {
						$(id + (i + 1)).next().attr('id', id3 + dateList[i])
								.empty();
					}
				}
			} else {
				$(id + ' span').text('');
			}
			if (id3 == 'table_second') {
				getBol();
			} else {
				getAppoint();
			}
		}
	</script>
</body>
</html>