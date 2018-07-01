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
<%@include file="../../../layouts/taglib.jsp"%>

<link rel="stylesheet" href="static/css/font-awesome.min.css" />
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="static/bootstrap/css/bootstrap-select.css" rel="stylesheet" />
<link href="static/css/timePicker.css" rel="stylesheet">
<link rel="stylesheet" href="static/css/datepicker.css" />
<link href="static/fullRC/css/wyp_qtgzz.css" rel="stylesheet">
<link href="static/fullRC/css/appoint-select-modal.css" rel="stylesheet">
<link href="static/fullRC/css/jquery.alertable.css" rel="stylesheet">
<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="static/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap-select.js"></script>

<script type="text/javascript" src="static/fullRC/js/datetimeUtil.js"></script>
<script type="text/javascript" src="static/fullRC/js/pagePlugin.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap-select.js"></script>
<script type="text/javascript" src="static/js/jquery-timepicker.js"></script>
<script type="text/javascript"
	src="static/fullRC/js/appoint-select-modal.js"></script>
<script type="text/javascript"
	src="static/fullRC/js/jquery.alertable.js"></script>
<script type="text/javascript" src="static/fullRC/js/velocity.min.js"></script>
<script type="text/javascript" src="static/fullRC/js/velocity.ui.min.js"></script>

<style type="text/css">
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
}

.p_btn {
	background-color: rgb(65, 178, 166) !important;
}

.p_btn:hover {
	background-color: #ccc !important;
	color: #333 !important;
}

.p_btn1 {
	margin: 0 5px;
}

.input-sm-p i {
	color: #000;
}

.s-t {
	float: left;
	margin: 2px;
}

.input1 {
	width: 140px;
	height: 30px;
	font-size: 14px;
}

.input2 {
	width: 50px !important;
	height: 30px !important;
	font-size: 14px;
}

.input3 {
	width: 200px;
	height: 30px;
	font-size: 14px;
}

.f-t {
	font-size: 14px;
}

.t_td {
	text-align: left !important;
}

.bt1 {
	background-color: transparent;
	border: none;
	margin: 0 15px;
}

h3 {
	margin-top: 5px;
}

.dn {
	display: none;
}
</style>

</head>
<body>
	<div style="margin: 0px 0 30px 15px;">
		<div style="padding-top: 10px; border-bottom: 1px solid #EBEBEB;">
			<form id="form" method="post" action="appointment/apSetPage.do"
				name="p_Form">
				<div style="float: left;">
					<h3>预约时段设置</h3>
				</div>
				<ul>
					<li><select data-placeholder="选择科室"
						class="selectpicker chosen-select" name="officeID" id="officeID">
							<option value="">请选择</option>
							<c:forEach items="${pdofList}" var="pof">
								<option value="${pof.OfficeID}">${pof.OfficeName}</option>
							</c:forEach>
					</select></li>
					<li><select data-placeholder="选择医生"
						class="selectpicker chosen-select" id="doctorName"
						name="doctorName">
							<option value="">请选择</option>
							<c:forEach items="${empList2}" var="emp" varStatus="status">
								<option data-index="${status.index }" data-id="${emp.OfficeID}" value="${emp.Emp_ID}">${emp.E_Name}</option>
							</c:forEach>
					</select></li>
					<li>
						<button class="btn p_btn btn-primary" style="margin: 0 5px 0 5px;"
							onclick="searchByCon();">
							<i class="icon-search"></i>
						</button>
					</li>
				</ul>
				<input type="hidden" id="firstdayT" name="firstdayT"
					value="${pd.firstdayT }"> <input type="hidden"
					id="lastdayT" name="lastdayT" value="${pd.lastdayT }"> <input
					type="hidden" id="nowdayMon" name="nowdayMon"
					value="${pd.nowdayMon }">
			</form>

		</div>
		<div>
			<table width="100%">
				<tbody>
					<tr>
						<td width="30%">
							<button class="btn btn-primary p_btn" id="last_week"
								onclick="goWeekCirle(-1);">上一周</button>
							<button class="btn btn-primary p_btn" id="next_week"
								onclick="goWeekCirle(1);">下一周</button>
							<button class="btn btn-primary p_btn" id="to_day"
								onclick="goWeekCirle(0);">今天</button>
							<button class="btn btn-default" data-toggle="modal"
								data-target="#setModal2" onclick="">批量设置</button>
						</td>
						<td width="40%" style="text-align: center;"><span
							id="dateCircle" style="font-size: 15px; font-weight: 900"></span>
						</td>
						<td width="30%">
							<!-- 								<button class="btn btn-primary pull-right p_btn" onclick="getCopyLastWeekValue();">复制上周</button> -->
							<!-- 								<button class="btn btn-primary pull-right p_btn1" onclick="">月设置</button> -->
							<!-- 								<button class="btn btn-success pull-right" onclick="">周设置</button> -->
						</td>
					</tr>
				</tbody>
			</table>
			<table class="table_first" style="width: 100%;">
				<thead>
					<tr>
						<td>人员</td>
						<td>周一<span id="day1"></span><input type="hidden" id="dy1" /></td>
						<td>周二<span id="day2"></span><input type="hidden" id="dy2" /></td>
						<td>周三<span id="day3"></span><input type="hidden" id="dy3" /></td>
						<td>周四<span id="day4"></span><input type="hidden" id="dy4" /></td>
						<td>周五<span id="day5"></span><input type="hidden" id="dy5" /></td>
						<td>周六<span id="day6"></span><input type="hidden" id="dy6" /></td>
						<td>周日<span id="day7"></span><input type="hidden" id="dy7" /></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${empList}" var="emp">
						<tr id="${emp.Emp_ID}">
							<td>${emp.E_Name}</td>
							<td id="mon${emp.Emp_ID}" class="td_text">
								<%-- 							  <button class="btn btn-default" data-toggle="modal" data-target="#setModal" onclick="getModel('${emp.Emp_ID}','${emp.E_Name}',1,'mon${emp.Emp_ID}',1);">设置预约时间段</button> --%>
							</td>
							<td id="tue${emp.Emp_ID}" class="td_text">
								<%-- 							<button class="btn btn-default"  data-toggle="modal" data-target="#setModal" onclick="getModel('${emp.Emp_ID}','${emp.E_Name}',2,'tue${emp.Emp_ID}',2);">设置预约时间段</button> --%>
							</td>
							<td id="wed${emp.Emp_ID}" class="td_text">
								<%-- 							<button class="btn btn-default"  data-toggle="modal" data-target="#setModal" onclick="getModel('${emp.Emp_ID}','${emp.E_Name}',3,'wed${emp.Emp_ID}',3);">设置预约时间段</button> --%>
							</td>
							<td id="thu${emp.Emp_ID}" class="td_text">
								<%-- 							<button class="btn btn-default"  data-toggle="modal" data-target="#setModal" onclick="getModel('${emp.Emp_ID}','${emp.E_Name}',4,'thu${emp.Emp_ID}',4);">设置预约时间段</button> --%>
							</td>
							<td id="fri${emp.Emp_ID}" class="td_text">
								<%-- 							<button class="btn btn-default"  data-toggle="modal" data-target="#setModal" onclick="getModel('${emp.Emp_ID}','${emp.E_Name}',5,'fri${emp.Emp_ID}',5);">设置预约时间段</button> --%>
							</td>
							<td id="sat${emp.Emp_ID}" class="td_text">
								<%-- 							<button class="btn btn-default"  data-toggle="modal" data-target="#setModal" onclick="getModel('${emp.Emp_ID}','${emp.E_Name}',6,'sat${emp.Emp_ID}',6);">设置预约时间段</button> --%>
							</td>
							<td id="sun${emp.Emp_ID}" class="td_text">
								<%-- 							<button class="btn btn-default"  data-toggle="modal" data-target="#setModal" onclick="getModel('${emp.Emp_ID}','${emp.E_Name}',7,'sun${emp.Emp_ID}',0);">设置预约时间段</button> --%>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="anniu">
				<button class="btn btn-primary p_btn"
					onclick="nextPage('${page.currentPage -1}','${page.showCount}')">
					<i class="icon-chevron-left"></i>
				</button>
				<div class="btn btn-primary p_btn" id="pageText">
					${page.currentPage}/${page.totalPage}</div>
				<button class="btn btn-primary p_btn"
					onclick="nextPage('${page.currentPage +1}','${page.showCount}')">
					<i class="icon-chevron-right"></i>
				</button>
				<input type="hidden" id="showCount" value="${page.showCount}">
				<input style="height: 30px; margin-top: 6px" size="5" id="toGoPage"
					placeholder="输入页数" type="number" />
				<button class="btn btn-primary p_btn" onclick="toTZ();">go</button>
			</div>
		</div>
	</div>

	<!-- 模态框1-->
	<div class="modal fade" id="setModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="timeSet"></h4>
				</div>
				<div class="modal-body" style="width: 100%">
					<form action="" id="modal_Form">
						<input type="hidden" name="appointNoID" id="appointNoID" value="">
						<input type="hidden" name="empId" id="empId" value=""> <input
							type="hidden" name="empName" id="empName" value=""> <input
							type="hidden" name="dateT" id="dateT" value=""> <input
							type="hidden" name="valueId" id="valueId" value=""> <input
							type="hidden" name="saveDay" id="saveDay" value="">
						<table id="seTable" class="table table-hover table-bordered f-t"
							style="margin-top: 0px">
							<thead>
								<tr>
									<th width="60%">允许预约时间段</th>
									<th width="15%">间隔(分)</th>
									<th width="30%"></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input name="tstart"
										class="form-control input1 s-t time-picker" /><span
										class="s-t">-</span> <input name="estart"
										class="form-control input1 s-t time-picker" /></td>
									<td><input type="number" name="interTime"
										class="form-control input2 s-t" /></td>
									<td><a class="s-t btn input-sm-p hidden p-min"
										type="button" onclick="delTr(this)"><i
											class="glyphicon glyphicon-minus"></i></a> <a
										class="s-t btn input-sm-p p-add" type="button"
										onclick="plusTD();"><i class="glyphicon glyphicon-plus"></i></a>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="saveOne();">提交更改</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 模态框 1-->
	<!-- 模态框2-->
	<div class="modal fade" id="setModal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel2" aria-hidden="true">
		<div class="modal-dialog" style="width: 650px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">批量设置预约</h4>
				</div>
				<div class="modal-body" style="width: 100%;">
					<table style="margin-top: 0px; margin-left: 30px;">
						<tr>
							<td><label>预约日期<span style="color: red">*</span></label></td>
							<td><input name="startDateTime"
								class="form-control input3 s-t date-picker t0input"
								placeholder="起始时间" data-date-format="yyyy-mm-dd"
								readonly="readonly" id="startDateTime" /><span class="s-t">-</span>
								<input name="endDateTime"
								class="form-control input3 s-t date-picker t0input"
								placeholder="起始时间" data-date-format="yyyy-mm-dd"
								readonly="readonly" id="endDateTime" /></td>
						</tr>
						<tr>
							<td><label>间隔时间<span style="color: red">*</span></label></td>
							<td><input type="number" name="intervalTime"
								id="intervalTime" class="form-control input2 s-t" /> <label
								style="margin-top: 8px;">分钟 <span style="color: red;">(注:间隔时间将作用于时间范围内的所有考勤规则的工作时间段)</span></label></td>
						</tr>
					</table>
					<div class="selection-container"
						style="margin-left: 30px; overflow-y: hidden;">
						<div class="select-box left">
							<div class="select-box-title">
								未选择 -医生列表<input type="checkbox" class="checkbox-all" />
							</div>
							<div class="select-content" style="z-index: 9999;">
								<ul class="unselect-ul">
									<c:forEach items="${empList}" var='listem'>
										<li><input type="checkbox" class="checkboxs"
											value="${listem.Emp_ID}" /> <span>${listem.E_Name}</span></li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div class="arrows-box">
							<div class="arrow-btns">
								<div class="arrow-btn right">
									<i></i>
								</div>
								<div class="arrow-btn left">
									<i></i>
								</div>
							</div>
						</div>
						<div class="select-box right">
							<div class="select-box-title">
								已选择 -医生列表<input type="checkbox" class="checkbox-all" />
							</div>
							<div class="select-content">
								<ul class="selected-ul" id="getDorList">

								</ul>
							</div>
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="saveList();">提交更改</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 模态框 2-->

	<script type="text/javascript">
		$(top.hangge());
		$(".time-picker").hunterTimePicker();
		$('.date-picker').datepicker({
			todayBtn : "linked",
			autoclose : true,
			todayHighlight : true,
			startDate : new Date()
		}).on('changeDate', function(e) {
			var startTime = e.date;
			$('.t0input').datepicker('setStartDate', startTime);
		});
		//模态框关闭事件
		$('#setModal')
				.on(
						'hide.bs.modal',
						function() {
							var tbo = $("#seTable tbody");
							tbo.empty();
							var addHtml = "<tr><td><input name='tstart' class='form-control input1 s-t time-picker'/><span class='s-t'>-</span>"
									+ "<input name='estart' class='form-control input1 s-t time-picker ' /></td><td><input type='number' name='interTime' class='form-control input2 s-t' /></td>"
									+ "<td> <a  class='s-t btn input-sm-p p-min hidden' type='button' onclick='delTr(this)'><i class='glyphicon glyphicon-minus'></i></a>"
									+ "<a class='s-t btn input-sm-p p-add' type='button' onclick='plusTD();'><i class='glyphicon glyphicon-plus'></i></a></td></tr>";
							tbo.append(addHtml);
							$(".time-picker").hunterTimePicker();
						});
		//搜索操作
		function searchByCon() {
			top.jzts();
			$("#form").submit();
		}

		$(function() {
			$('#officeID').val('${pd.officeID}');
			$('#doctorName').val('${pd.doctorName}');
			$('#officeID').selectpicker({
				liveSearch : true,
				maxOptions : 1
			});
			$('#doctorName').selectpicker({
				liveSearch : true,
				maxOptions : 1
			});
			if ($('#officeID').val()!='') {
				officeChange('#officeID', '#doctorName',$('#doctorName').val());
			}
			$('#officeID').change(function() {
				officeChange('#officeID', '#doctorName','');
			})

			if ($("#firstdayT").val() == ''
					|| typeof ($("#firstdayT").val()) == 'undefined') {
				var mon = dateRangeUtil.getCurrentWeekMon();
				var sun = dateRangeUtil.getCurrentWeekSun();
				$("#firstdayT").val(mon);
				$("#nowdayMon").val(mon);
				$("#lastdayT").val(sun);
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
			} else {
				var dateList = dateRangeUtil.getDatesOfMon($("#firstdayT")
						.val(), $("#lastdayT").val());
				for (var i = 0; i < dateList.length; i++) {
					$("#dy" + (i + 1)).val(dateList[i]);
				}
				var startS = dateRangeUtil.getWeekSevenDayCirle(0, $(
						"#firstdayT").val());
				if (startS.length != 0) {
					for (var i = 0; i < startS.length; i++) {
						$("#day" + (i + 1)).html(startS[i]);
					}
				}
			}
			$("#dateCircle").html(
					convertDate($("#firstdayT").val()) + " - "
							+ convertDate($("#lastdayT").val()));

			//回显
			getBol($("#firstdayT").val(), $("#lastdayT").val());

		});

		//根据传入起始日期和结束日期获取对应的值进行显示
		function getBol(startDay, endDay) {
			$(".td_text").empty();
			$(".td_text").removeClass("t_td");
			$
					.post(
							"appointment/appointTimeBackData.do",
							{
								startDay : startDay,
								endDay : endDay
							},
							function(result) {
								var arr1 = new Array();
								var arr2 = new Array();
								arr1 = result.data;
								arr2 = result.appData;
								if (arr1.length != 0) {
									for (var i = 0; i < arr1.length; i++) {
										var id = arr1[i].ValueID;
										var str;
										if (arr1[i].SaveDay == 0) {
											str = '<button class="btn btn-default" data-toggle="modal" data-target="#setModal"'
													+ ' onclick="getModel(\''
													+ arr1[i].Emp_ID
													+ '\',\''
													+ arr1[i].E_Name
													+ '\',7,\''
													+ id
													+ '\','
													+ arr1[i].SaveDay
													+ ');">设置预约时间段</button>'
										} else {
											str = '<button class="btn btn-default" data-toggle="modal" data-target="#setModal"'
													+ ' onclick="getModel(\''
													+ arr1[i].Emp_ID
													+ '\',\''
													+ arr1[i].E_Name
													+ '\','
													+ arr1[i].SaveDay
													+ ',\''
													+ id
													+ '\','
													+ arr1[i].SaveDay
													+ ');">设置预约时间段</button>'
										}
										$("#" + id).empty();
										$("#" + id).append(str);
									}
								}
								if (arr2.length != 0) {
									for (var i = 0; i < arr2.length; i++) {
										var id = arr2[i].ValueID;
										var docID = arr2[i].DocTorID;
										var dutydate = arr2[i].DutyDate;
										$('#' + id).empty();
										$("#" + id).append(arr2[i].TimeText);
										$("#" + id)
												.append(
														' <div class=""><button class="bt1" onclick="editAppTime(\''
																+ docID
																+ '\',\''
																+ dutydate
																+ '\')"><i class="glyphicon glyphicon-pencil"></i></button>'
																+ '<button class="bt1"  onclick="delAppTime(\''
																+ docID
																+ '\',\''
																+ dutydate
																+ '\')"><i class="glyphicon glyphicon-remove"></i></button></div>');
									}
								}
								check();
							});
		}

		function getModel(empID, empName, dayN, valueId, saveDay) {
			$("#timeSet").html(
					"<span style='color:blue'>" + empName + "</span>预约时间段设置");
			$("#empId").val(empID);
			$("#empName").val(empName);
			var day;
			if (dayN == 1) {
				day = $("#dy1").val();
			} else if (dayN == 2) {
				day = $("#dy2").val();
			} else if (dayN == 3) {
				day = $("#dy3").val();
			} else if (dayN == 4) {
				day = $("#dy4").val();
			} else if (dayN == 5) {
				day = $("#dy5").val();
			} else if (dayN == 6) {
				day = $("#dy6").val();
			} else if (dayN == 7) {
				day = $("#dy7").val();
			}
			$("#dateT").val(day);
			$("#valueId").val(valueId);
			$("#saveDay").val(saveDay);
		}

		// 		$.fn.stringify = function(array) {
		// 			  return JSON.stringify(this);
		// 			}

		function plusTD() {
			var addHtml = "<tr><td><input name='tstart' class='form-control input1 s-t time-picker'/><span class='s-t'>-</span>"
					+ "<input name='estart' class='form-control input1 s-t time-picker' /></td><td><input type='number' name='interTime' class='form-control input2 s-t date-picker' /></td>"
					+ "<td> <a  class='s-t btn input-sm-p p-min' type='button' onclick='delTr(this)'><i class='glyphicon glyphicon-minus'></i></a>"
					+ "<a class='s-t btn input-sm-p p-add' type='button' onclick='plusTD();'><i class='glyphicon glyphicon-plus'></i></a></td></tr>";
			var $tr = $("#seTable tbody tr").eq(-1);
			$(".p-add").addClass("hidden");
			$(".p-min").removeClass("hidden");
			$tr.after(addHtml);
			$(".time-picker").hunterTimePicker();
		}

		function delTr(obj) {
			var tbo = $("#seTable tbody").find("tr").length;
			if (tbo > 1) {
				var hang = $(obj).parents("tr");
				var len = tbo - 1;
				if (len > 1) {
					if (len == hang.index()) {
						//删除的是最后一行，改变其上一行的相关控件状态
						hang.remove();
						var tbo1 = $("#seTable tbody").find("tr").length;
						var hang1 = $("#seTable tbody").find("tr")[tbo1 - 1];
						$(hang1).children("td").eq(2).children('a')
								.removeClass("hidden");
					} else {
						hang.remove();
					}
				} else {
					hang.remove();
					var hang1 = $("#seTable tbody").find("tr")[0];
					$(hang1).children("td").eq(2).children('.p-add')
							.removeClass("hidden");
					$(hang1).children("td").eq(2).children('.p-min').addClass(
							"hidden");
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
				$("#dateCircle").html(
						convertDate(startStop[0]) + " - "
								+ convertDate(startStop[1]));
				$("#firstdayT").val(startStop[0]);
				$("#lastdayT").val(startStop[1]);
			}
			//表行列日期顯示
			var startS = dateRangeUtil.getWeekSevenDayCirle(dayType, dateTime);
			if (startS.length != 0) {
				for (var i = 0; i < startS.length; i++) {
					$("#day" + (i + 1)).html(startS[i]);
				}
			}
			//錶行賦值
			var startS2 = dateRangeUtil
					.getWeekSevenDayCirle2(dayType, dateTime);
			if (startS2.length != 0) {
				for (var i = 0; i < startS2.length; i++) {
					$("#dy" + (i + 1)).val(startS2[i]);
				}
			}
			//顯示操作
			getBol(startStop[0], startStop[1]);
		}

		function saveOne() {
			var att = {};
			var Array = [];
			var flag = true;
			$("#seTable tbody tr")
					.each(
							function() {
								var st = [];
								var chil = $(this).children('td');
								var startTime = chil.eq(0).children(
										'input[name="tstart"]').val();
								var endTime = chil.eq(0).children(
										'input[name="estart"]').val();
								var interTime = chil.eq(1).children(
										'input[name="interTime"]').val();
								if (startTime == "") {
									chil.eq(0).children('input[name="tstart"]')
											.tips({
												side : 3,
												msg : '请选择起始时间',
												bg : '#AE81FF',
												time : 2
											});
									chil.eq(0).children('input[name="tstart"]')
											.focus();
									return;
								}
								if (endTime == "") {
									chil.eq(0).children('input[name="estart"]')
											.tips({
												side : 3,
												msg : '请选择结束时间',
												bg : '#AE81FF',
												time : 2
											});
									chil.eq(0).children('input[name="estart"]')
											.focus();
									return;
								}
								if (interTime == "") {
									chil.eq(1).children(
											'input[name="interTime"]').tips({
										side : 3,
										msg : '请填写时间段',
										bg : '#AE81FF',
										time : 2
									});
									chil.eq(1).children(
											'input[name="interTime"]').focus();
									return;
								}
								att = {
									'startTime' : startTime,
									'endTime' : endTime,
									'interTime' : interTime
								};
								Array.push(att);
							});

			var empId = $("#empId").val();
			var empName = $("#empName").val();
			var dateT = $("#dateT").val();
			var valueId = $("#valueId").val();
			var saveDay = $("#saveDay").val();
			var arrayJson = JSON.stringify(Array);
			$.post("appointment/saveOne.do", {
				empId : empId,
				empName : empName,
				dateT : dateT,
				valueId : valueId,
				saveDay : saveDay,
				arrayJson : arrayJson
			}, function(result) {
				if (result.status == "success") {
					alert("设置成功");
					$('#setModal').modal('hide')
					searchByCon();
				} else if (result.status == "emptyData") {
					alert("重要的数据未填写");
				} else {
					alert("保存失败");
				}
			});
		}

		/*批量设置*/
		function saveList() {
			var startDate = $("#startDateTime").val();
			var endDate = $("#endDateTime").val();
			var intervalTime = $("#intervalTime").val();
			var att = {};
			var Array = [];
			$("#getDorList li").each(function() {
				var st = [];
				var empID = $(this).children('input').val();
				att = {
					'empId' : empID
				}
				Array.push(att);
			});
			if (startDate == "") {

				$("#startDateTime").tips({
					side : 3,
					msg : '请选择起始时间',
					bg : '#AE81FF',
					time : 2
				});
				$("#startDateTime").focus();
				return;
			}
			if (endDate == "") {

				$("#endDateTime").tips({
					side : 3,
					msg : '请选择结束时间',
					bg : '#AE81FF',
					time : 2
				});
				$("#endDateTime").focus();
				return;
			}
			if (intervalTime == "") {

				$("#intervalTime").tips({
					side : 3,
					msg : '请输入间隔时间段',
					bg : '#AE81FF',
					time : 2
				});
				$("#intervalTime").focus();
				return;
			}
			var arrayJson = JSON.stringify(Array);
			$.post("appointment/saveList.do", {
				startDate : startDate,
				endDate : endDate,
				intervalTime : intervalTime,
				arrayJson : arrayJson
			}, function(result) {
				if (result.status == "success") {
					alert("批量设置成功");
					$('form').submit();
				} else {
					alert("保存失败");
				}
			});
		}

		/*点击修改操作*/
		function editAppTime(docID, dutyDate) {
			var tbo = $("#seTable tbody");
			tbo.empty();
			if (docID != '' && dutyDate != '') {
				$
						.post(
								"appointment/edit/setTime.do",
								{
									docID : docID,
									dutyDate : dutyDate
								},
								function(result) {
									var array = new Array();
									array = result.data;
									if (array.length != 0) {
										$("#setModal").modal('show');
										$("#timeSet").html(
												"<span style='color:blue'>"
														+ array[0].DocTorName
														+ "</span>预约时间段设置");
										//赋值
										$("#empId").val(array[0].DocTorID);
										$("#empName").val(array[0].DocTorName);
										$("#dateT").val(array[0].DutyDate);
										$("#valueId").val(array[0].ValueID);
										$("#saveDay").val(array[0].SaveDay);
										for (var i = 0; i < array.length; i++) {
											var isEdit = "";
											if (array[i].disabled) {
												isEdit = 'disabled="true"';
											}
											var addHtml;
											if (i == array.length - 1) {
												addHtml = "<tr><td><input name='tstart' class='form-control input1 s-t time-picker' "+isEdit+" value="+array[i].AppointStartTime+"><span class='s-t'>-</span>"
														+ "<input name='estart' class='form-control input1 s-t time-picker'  "+isEdit+" value="+array[i].AppointEndTime+"></td>"
														+ "<td><input type='number' name='interTime' class='form-control input2 s-t date-picker' "+isEdit+"  value="+array[i].TimeInterval+" ></td>"
														+ "<td> <button  class='s-t btn input-sm-p p-min' type='button'  onclick='delTr(this)'"
														+ isEdit
														+ "><i class='glyphicon glyphicon-minus'></i></button>"
														+ "<button class='s-t btn input-sm-p p-add' type='button'  onclick='plusTD();'><i class='glyphicon glyphicon-plus'></i></button></td></tr>";
											} else {
												addHtml = "<tr><td><input name='tstart' class='form-control input1 s-t time-picker'  "+isEdit+"  value="+array[i].AppointStartTime+"><span class='s-t'>-</span>"
														+ "<input name='estart' class='form-control input1 s-t time-picker'  "+isEdit+" value="+array[i].AppointEndTime+"></td>"
														+ "<td><input type='number' name='interTime' class='form-control input2 s-t date-picker' "+isEdit+"  value="+array[i].TimeInterval+" ></td>"
														+ "<td> <button  class='s-t btn input-sm-p p-min' type='button'  "
														+ isEdit
														+ "   onclick='delTr(this)'><i class='glyphicon glyphicon-minus'></i></button>"
														+ "<button class='s-t btn input-sm-p p-add hidden' type='button' onclick='plusTD();'><i class='glyphicon glyphicon-plus'></i></button></td></tr>";
											}
											tbo.append(addHtml);
										}
									}
								});
			}
		}
		/*删除修改操作*/
		function delAppTime(docID, dutyDate) {
			$.alertable.confirm('确定删除发布的预约号吗？').then(function() {
				$.post("appointment/del/setTime.do", {
					docID : docID,
					dutyDate : dutyDate
				}, function(result) {
					if (result.status == "success") {
						$.alertable.alert('清理成功!');
						$('form').submit();
					} else if (result.status == "cannotdel") {
						$.alertable.alert('该预约组已经被使用,无法删除!');
					} else {
						$.alertable.alert('删除失败!');
					}
				});
			});
		}

		function check() {
			var firstday = new Date($('#firstdayT').val());
			var lastday = new Date($('#lastdayT').val());
			var now = new Date();
			$('.table_first button').css("cursor", "pointer");
			if (lastday < now) {
				$('.table_first button').prop('disabled', true).css("cursor",
						"not-allowed");
			}
			if (firstday <= now && now <= lastday) {
				var day = now.getDay();
				switch (day) {
				case 0:
					$('td:not([id^="sun"]) button').attr('disabled', true).css(
							"cursor", "not-allowed");
					setDelButton('td[id^="sun"]', 7);
					break;
				case 1:
					setDelButton('td[id^="mon"]', 1);
					break;
				case 2:
					$('td[id^="mon"] button').attr('disabled', true).css(
							"cursor", "not-allowed");
					setDelButton('td[id^="tue"]', 2);
					break;
				case 3:
					$('td[id^="mon"] button,td[id^="tue"] button').attr(
							'disabled', true).css("cursor", "not-allowed");
					setDelButton('td[id^="wed"]', 3);
					break;
				case 4:
					$(
							'td[id^="mon"] button,td[id^="tue"] button,td[id^="wed"] button')
							.attr('disabled', true)
							.css("cursor", "not-allowed");
					setDelButton('td[id^="thu"]', 4);
					break;
				case 5:
					$(
							'td[id^="mon"] button,td[id^="tue"] button,td[id^="wed"] button,td[id^="thu"] button')
							.attr('disabled', true)
							.css("cursor", "not-allowed");
					setDelButton('td[id^="fri"]', 5);
					break;
				case 6:
					$(
							'td[id^="mon"] button,td[id^="tue"] button,td[id^="wed"] button,td[id^="thu"] button,td[id^="fri"] button')
							.attr('disabled', true)
							.css("cursor", "not-allowed");
					setDelButton('td[id^="sat"]', 6);
					break;
				default:
					break;
				}
			}
		}

		function setDelButton(id, num) {
			$(id).each(
					function() {
						var text = $(this).text();
						text = $.trim(text);
						if (text != '' && text != '设置预约时间段') {
							var textList = text.split(')');
							if (textList != null && textList != ''
									&& textList.length > 0) {
								for (var i = 0; i < textList.length - 1; i++) {
									var time = textList[i];
									var date = dateRangeUtil
											.getCurrentOtherDay(num)
											+ ' '
											+ time.substring(0, 5)
											+ ':00';
									if (new Date() >= new Date(date)) {
										$(this).find('button').eq(1).attr(
												'disabled', true).attr('title',
												'小于当前时间，不可删除，请在编辑页面中修改').css(
												"cursor", "not-allowed");
									}
								}
							}
						}
					})
		}

		/* 根据科室显示对应医生 */
		function officeChange(targetID, doctorID,doctorValue) {
			var officeID = $(targetID).val();
			$(doctorID).next().find('li').removeClass('dn');
			if (officeID != '') {
				$(doctorID).find(
						'option[data-id!="' + officeID + '"][value!=""]').each(
						function() {
							var index = Number($(this).attr('data-index')) + 1;
							$(doctorID).next().find(
									'li[data-original-index=' + index + ']')
									.addClass('dn');
						})
			}
			$(doctorID).selectpicker('val', doctorValue);
		}
	</script>


</body>


</html>