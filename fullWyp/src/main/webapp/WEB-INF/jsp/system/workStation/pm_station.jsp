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
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="static/bootstrap/css/bootstrap-select.css" rel="stylesheet" />
<link href="static/fullRC/css/wyp_qtgzz.css" rel="stylesheet">
<link rel="stylesheet" href="static/fullRC/css/wyp_base.css" />
<script type="text/javascript" src="static/fullRC/js/wyp.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap-select.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var message;
		$(".top_first span").click(function() {
			slideNext($(this).parent());
		});
	});
</script>
<style>
.dn {
	display: none;
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

a {
	text-decoration: none !important;
	cursor: pointer;
}

#myModal th, #myModal td {
	padding: 10px;
}

.btn-group>.btn {
	border-width: 1px !important;
}

.modal {
	position: fixed !important;
}

.cp {
	font-size: 16px;
}

.btn {
	text-shadow: none !important;
}
</style>
</head>
<body>
	<div>
		<div id="qt_top">
			<div class="top_first">
				<span class="cp"> <font>所医生预约信息</font> <i
					class="icon-chevron-down dpn"></i><i class="icon-chevron-up "></i>
				</span>
			</div>
			<div style="margin: 10px 20px">
				<div style="width: 25%; margin-left: -4px" class="dpib">
					<button class="btn  btn-primary p_btn"
						onclick="goWeekCirle(-1,'#firstdayT','#lastdayT','#appoints');">上一周</button>
					<button class="btn  btn-primary p_btn"
						onclick="goWeekCirle(1,'#firstdayT','#lastdayT','#appoints');">下一周</button>
					<button class="btn  btn-primary p_btn"
						onclick="goWeekCirle(0,'#firstdayT','#lastdayT','#appoints');">今天</button>
				</div>
				<div style="width: 25%; margin-left: -4px" class="dpib">
					<span id="dateRangeT" style="font-size: 15px; font-weight: 900"></span>
				</div>
				<div class="dpib" style="width: 50%">
					<ul class="pull-right">
						<li class="dpib"><select style="width: 100px;"
							data-placeholder="选择科室" class="selectpicker chosen-select"
							name="offID" id="offID">
								<option selected="selected" value="">请选择</option>
								<c:forEach items="${pdofList}" var="pof">
									<option value="${pof.OfficeID}">${pof.OfficeName}</option>
								</c:forEach>
						</select></li>
						<li class="dpib"><select style="width: 100px;"
							data-placeholder="选择医生" class="selectpicker chosen-select"
							id="doctorID" name="doctorName">
								<option selected="selected" value="">请选择</option>
								<c:forEach items="${empList2}" var="emp" varStatus="status">
									<option data-index="${status.index }" data-id="${emp.OfficeID}"
										value="${emp.Emp_ID}">${emp.E_Name}</option>
								</c:forEach>
						</select></li>
						<li class="dpib">
							<button class="btn p_btn" onclick="search('T');">
								<i class="icon-search"></i>
							</button>
						</li>
					</ul>

				</div>
				<table id="appoints" class="table_first">
					<thead>
						<tr>
							<td></td>
							<td>人员</td>
							<td id="appoints1">周一 <span></span></td>
							<td id="appoints2">周二 <span></span></td>
							<td id="appoints3">周三 <span></span></td>
							<td id="appoints4">周四 <span></span></td>
							<td id="appoints5">周五 <span></span></td>
							<td id="appoints6">周六 <span></span></td>
							<td id="appoints7">周日 <span></span></td>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<div>
					<button class="btn btn-default"
						onclick="setEmps('#appoints', $('#offID').val(), $('#doctorID').val(),$('#firstdayT').val(), $('#lastdayT').val(),'#currentPageT', '#pageSizeT', -1)">
						<i class="icon-chevron-left"></i>
					</button>
					<button class="btn btn-default">
						<span id="currentPageT"></span>/<span id="pageSizeT"></span>
					</button>
					<button class="btn btn-default"
						onclick="setEmps('#appoints', $('#offID').val(), $('#doctorID').val(),$('#firstdayT').val(), $('#lastdayT').val(),'#currentPageT', '#pageSizeT', 1)">
						<i class="icon-chevron-right"></i>
					</button>
					<input style="height: 30px; margin-top: 6px" size="5"
						placeholder="输入页数" type="text" />
					<button class="btn btn-default"
						onclick="turn(this,'#appoints', $('#offID').val(), $('#doctorID').val(),$('#firstdayT').val(), $('#lastdayT').val(),'#currentPageT', '#pageSizeT')">go</button>
				</div>
			</div>

		</div>
		<div id="qt_bottom">
			<div class="top_first">
				<span class="cp"> <font>所有人员排班信息</font> <i
					class="icon-chevron-down dpn"></i><i class="icon-chevron-up"></i>
				</span>
			</div>
			<div style="margin: 10px 20px">
				<div style="width: 25%; margin-left: -4px" class="dpib">
					<button class="btn  btn-primary p_btn"
						onclick="goWeekCirle(-1,'#firstdayB','#lastdayB','#schduels');">上一周</button>
					<button class="btn  btn-primary p_btn"
						onclick="goWeekCirle(1,'#firstdayB','#lastdayB','#schduels');">下一周</button>
					<button class="btn  btn-primary p_btn"
						onclick="goWeekCirle(0,'#firstdayB','#lastdayB','#schduels');">今天</button>
				</div>
				<div style="width: 25%; margin-left: -4px" class="dpib">
					<span id="dateRangeB" style="font-size: 15px; font-weight: 900"></span>
				</div>
				<div class="dpib" style="width: 50%">
					<ul class="pull-right">
						<li class="dpib"><select style="width: 100px;"
							data-placeholder="选择科室" class="selectpicker chosen-select"
							name="officeID" id="officeID">
								<option selected="selected" value="">请选择</option>
								<c:forEach items="${pdofList}" var="pof">
									<option value="${pof.OfficeID}">${pof.OfficeName}</option>
								</c:forEach>
						</select></li>
						<li class="dpib"><select style="width: 100px;"
							data-placeholder="选择医生" class="selectpicker chosen-select"
							id="doctorName" name="doctorName">
								<option selected="selected" value="">请选择</option>
								<c:forEach items="${empList2}" var="emp" varStatus="status">
									<option data-id="${emp.OfficeID}" data-index="${status.index }"
										value="${emp.Emp_ID}">${emp.E_Name}</option>
								</c:forEach>
						</select></li>
						<li class="dpib">
							<button class="btn p_btn" onclick="search('B');">
								<i class="icon-search"></i>
							</button>
						</li>
					</ul>

				</div>
				<table id="schduels" class="table_first">
					<thead>
						<tr>
							<td></td>
							<td>人员</td>
							<td id="schduels1">周一 <span></span></td>
							<td id="schduels2">周二 <span></span></td>
							<td id="schduels3">周三 <span></span></td>
							<td id="schduels4">周四 <span></span></td>
							<td id="schduels5">周五 <span></span></td>
							<td id="schduels6">周六 <span></span></td>
							<td id="schduels7">周日 <span></span></td>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>

				<div>
					<button class="btn btn-default"
						onclick="setEmps('#schduels', $('#officeID').val(), $('#doctorName').val(),$('#firstdayB').val(), $('#lastdayB').val(),'#currentPageB', '#pageSizeB',-1)">
						<i class="icon-chevron-left"></i>
					</button>
					<button class="btn btn-default">
						<span id="currentPageB"></span>/<span id="pageSizeB"></span>
					</button>
					<button class="btn btn-default"
						onclick="setEmps('#schduels', $('#officeID').val(), $('#doctorName').val(),$('#firstdayB').val(), $('#lastdayB').val(),'#currentPageB', '#pageSizeB',1)">
						<i class="icon-chevron-right"></i>
					</button>
					<input style="height: 30px; margin-top: 6px" size="5"
						placeholder="输入页数" type="text" />
					<button class="btn btn-default"
						onclick="turn(this,'#schduels', $('#officeID').val(), $('#doctorName').val(),$('#firstdayB').val(), $('#lastdayB').val(),'#currentPageB', '#pageSizeB')">go</button>
				</div>
			</div>
			<input id="nowdayMon" type="hidden"><input id="firstdayT"
				type="hidden"><input id="lastdayT" type="hidden"><input
				id="lastdayB" type="hidden"><input id="firstdayB"
				type="hidden">
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
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
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
				$('#officeID').selectpicker({
					liveSearch : true,
					maxOptions : 1
				});
				$('#doctorName').selectpicker({
					liveSearch : true,
					maxOptions : 1
				});
				$('#offID').selectpicker({
					liveSearch : true,
					maxOptions : 1
				});
				$('#doctorID').selectpicker({
					liveSearch : true,
					maxOptions : 1
				});
				var mon = dateRangeUtil.getCurrentWeekMon();
				var sun = dateRangeUtil.getCurrentWeekSun();
				$("#nowdayMon").val(mon);
				$("#firstdayT").val(mon);
				$("#lastdayT").val(sun);
				$("#firstdayB").val(mon);
				$("#lastdayB").val(sun);
				goWeekCirle(0, '#firstdayT', '#lastdayT', '#appoints');
				goWeekCirle(0, '#firstdayB', '#lastdayB', '#schduels');
				setEmps('#appoints', $('#offID').val(), $('#doctorID').val(),
						$('#firstdayT').val(), $('#lastdayT').val(),
						'#currentPageT', '#pageSizeT', 1);
				setEmps('#schduels', $('#officeID').val(), $('#doctorName')
						.val(), $("#firstdayB").val(), $("#lastdayB").val(),
						'#currentPageB', '#pageSizeB', 1);
				$('#offID').change(function() {
					officeChange('#offID', '#doctorID')
				})
				$('#officeID').change(function() {
					officeChange('#officeID', '#doctorName')
				})
				getAppointment();
				getSchdual();
			}

			/* 上周，下周，今天按钮函数 */
			function goWeekCirle(dayType, id1, id2, id) {
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
				var startS = dateRangeUtil.getWeekSevenDayCirle(dayType,
						dateTime);
				if (startS.length != 0) {
					for (var i = 0; i < startS.length; i++) {
						$(id + (i + 1) + ' span').text(startS[i]);
					}
				} else {
					$(id + ' span').text('');
				}

				var dateList = dateRangeUtil.getDatesOfMon(startStop[0],
						startStop[1]);
				if (id == '#appoints') {
					$('#appoints .point-red').remove();
					changeTdID('#appoints', dateList);
					getAppointment();
					$('#dateRangeT').text(
							convertDate(startStop[0]) + " - "
									+ convertDate(startStop[1]));
				} else {
					$('#schduels .dutyTypeName').remove();
					changeTdID('#schduels', dateList);
					getSchdual();
					$('#dateRangeB').text(
							convertDate(startStop[0]) + " - "
									+ convertDate(startStop[1]));
				}
			}

			/* 翻页函数*/
			function setEmps(elementID, officeID, empID, fromDate, toDate,
					currentPageID, pageSizeID, num) {
				var currentPage = $(currentPageID).text() == '' ? 0 : $(
						currentPageID).text();
				var defaultSize = $(pageSizeID).text() == '' ? 1
						: $(pageSizeID).text();
				currentPage = Number(currentPage) + num;
				defaultSize = Number(defaultSize);
				getEmps(currentPage, defaultSize, elementID, officeID, empID,
						fromDate, toDate, currentPageID, pageSizeID);
			}

			/* 页数跳转 */
			function turn(thi, elementID, officeID, empID, fromDate, toDate,
					currentPageID, pageSizeID) {
				var currentPage = $(thi).prev().val();
				if (currentPage != '') {
					var defaultSize = $(pageSizeID).text() == '' ? 1 : $(
							pageSizeID).text();
					defaultSize = Number(defaultSize);
					currentPage = Number(currentPage);
					getEmps(currentPage, defaultSize, elementID, officeID,
							empID, fromDate, toDate, currentPageID, pageSizeID);
				}
			}

			/* 获取医生并在目标表格显示 */
			function getEmps(currentPage, defaultSize, elementID, officeID,
					empID, fromDate, toDate, currentPageID, pageSizeID) {
				if (0 < currentPage && currentPage <= defaultSize) {
					currentPage--;
					var dateList = dateRangeUtil
							.getDatesOfMon(fromDate, toDate);
					$(elementID + ' tbody').empty();
					var url = 'emp/getEmpsPage.do?officeID=' + officeID
							+ '&doctorName=' + empID
							+ '&pageSize=10&pageStart=' + currentPage * 10;
					$
							.ajax({
								url : url,
								async : false,
								success : function(result) {
									var emps = result.data;
									if (emps != null && emps.length > 0) {
										for (var i = 0; i < emps.length; i++) {
											var emp = emps[i];
											var id = elementID.substring(1);
											var elementStr = '<tr><td><img src="static/images/user.jpg"></td><td class="'
												+id+'" id="'+emp.Emp_ID+'">'
													+ emp.E_Name
													+ '</td><td id="'
													+id+dateList[0]+emp.Emp_ID+'"></td><td id="'+id+dateList[1]+emp.Emp_ID+
						'"></td><td id="'+id+dateList[2]+emp.Emp_ID+'"></td><td id="'+id+dateList[3]+emp.Emp_ID+
						'"></td><td id="'+id+dateList[4]+emp.Emp_ID+'"></td><td id="'+id+dateList[5]+emp.Emp_ID+
						'"></td><td id="'+id+dateList[6]+emp.Emp_ID+'"></td></tr>';
											$(elementID + ' tbody').append(
													elementStr);
											var pageSize = result.size;
											$(pageSizeID).text(pageSize);
											if (currentPage + 1 <= pageSize) {
												$(currentPageID).text(
														currentPage + 1);
											} else {
												$(currentPageID).text(pageSize);
											}
										}
									} else {
										$(currentPageID).text('1');
										$(pageSizeID).text('1');
									}
								}
							})
				}
			}

			/* 获取预约信息 */
			function getAppointment() {
				var empIDs = '';
				$('.appoints').each(function() {
					empIDs += $(this).attr('id') + ','
				})
				if (empIDs != '') {
					empIDs = empIDs.substring(0, empIDs.length - 1);
					url = 'appointment/countAppointByTimes.do?fromDate='
							+ $('#firstdayT').val() + '&toDate='
							+ $('#lastdayT').val() + '&empIDs=' + empIDs;
					$
							.get(
									url,
									function(result) {
										var emps = new Array();
										emps = result;
										if (emps != null && emps.length > 0) {
											for (var i = 0; i < emps.length; i++) {
												var emp = emps[i];
												var id = '#appoints'
														+ emp.Appointment_Date
														+ emp.Emp_ID;
												var date = new Date(
														emp.Appointment_Date);
												var day = date.getDay();
												day = day - 1;
												if (day == -1) {
													day = 6;
												}
												var element = '<div class="point-red"><a data-toggle="modal" data-target="#myModal" onclick="getAppList('
														+ day
														+ ')">'
														+ emp.number
														+ '人</a></div>';
												$(id).append(element);
											}

										}
									})
				}
			}

			//点击人数获取预约人的明细卡片
			function getAppList(day) {
				date = addDate($("#firstdayT").val(), day);
				$
						.ajax({
							url : "appointment/getAppByTime.do",
							type : "get",
							data : "startAppointTime=00:00&endAppointTime=23:59&appointmentDate="
									+ date,
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

			/* 获取排班信息 */
			function getSchdual() {
				var empIDs = "";
				$('.schduels').each(function() {
					empIDs += $(this).attr('id') + ','
				})
				if (empIDs != '') {
					empIDs = empIDs.substring(0, empIDs.length - 1);
					url = 'scheduling/getScheduls.do?startDate='
							+ $('#firstdayB').val() + '&endDate='
							+ $('#lastdayB').val() + '&emps=' + empIDs;
					$.get(url, function(result) {
						var schduels = new Array();
						schduels = result;
						if (schduels != null && schduels.length > 0) {
							for (var i = 0; i < schduels.length; i++) {
								var schduel = schduels[i];
								var id = '#schduels' + schduel.DutyDate
										+ schduel.Emp_ID;
								$(id).append(
										'<span class="dutyTypeName">'
												+ schduel.DutyTypeName
												+ '</span>');
							}

						}
					})
				}
			}

			/* 搜索函数 */
			function search(type) {
				$('#currentPage' + type).text('');
				$('#pageSize' + type).text('');
				if (type == 'T') {
					setEmps('#appoints', $('#offID').val(), $('#doctorID')
							.val(), $('#firstdayT').val(),
							$('#lastdayT').val(), '#currentPageT',
							'#pageSizeT', 1);
					getAppointment();
				} else {
					setEmps('#schduels', $('#officeID').val(), $('#doctorName')
							.val(), $("#firstdayB").val(),
							$("#lastdayB").val(), '#currentPageB',
							'#pageSizeB', 1);
					getSchdual();
				}
			}

			/* 根据科室显示对应医生 */
			function officeChange(targetID, doctorID) {
				var officeID = $(targetID).val();
				$(doctorID).next().find('li').removeClass('dn');
				if (officeID != '') {
					$(doctorID).find(
							'option[data-id!="' + officeID + '"][value!=""]')
							.each(
									function() {
										var index = Number($(this).attr(
												'data-index')) + 1;
										$(doctorID).next().find(
												'li[data-original-index='
														+ index + ']')
												.addClass('dn');
									})
				}
				$(doctorID).selectpicker('val', '');
			}

			/* 日期跳转时更新td的ID */
			function changeTdID(elementID, dateList) {
				$(elementID + ' tbody tr')
						.each(
								function() {
									$(this)
											.find('td')
											.each(
													function(index) {
														if (index >= 2) {
															var empID = $(this)
																	.attr('id')
																	.substring(
																			18)
															$(this)
																	.attr(
																			'id',
																			elementID
																					.substring(1)
																					+ dateList[index - 2]
																					+ empID);
														}
													});
								})
			}
		</script>
	</div>
</body>
</html>