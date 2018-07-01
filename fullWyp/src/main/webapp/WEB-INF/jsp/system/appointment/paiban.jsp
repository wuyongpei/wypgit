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
<%@ include file="../admin/top.jsp"%>
<%@include file="../../layouts/taglib.jsp"%>
<%@include file="../../includeCssAndJS/include_bootstrap.jsp"%>
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="static/bootstrap/css/bootstrap-select.css" rel="stylesheet" />
<link href="static/fullRC/css/wyp_qtgzz.css" rel="stylesheet">
<script type="text/javascript"
	src="<%=basePath%>static/fullRC/js/datetimeUtil.js"></script>
<script type="text/javascript"
	src="<%=basePath%>static/fullRC/js/pagePlugin.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap-select.js"></script>
<style type="text/css">
.p_btn {
	background-color: rgb(65, 178, 166) !important;
}

.p_btn:hover {
	background-color: #ccc !important;
	color: #333 !important;
}

.btn-group>.btn {
	border-width: 1px !important;
}

.dn {
	display: none;
}

.btn {
	text-shadow: none !important;
}

input[type="text"] {
	height: 26px;
}
</style>
</head>
<body>
	<div style="margin: 5px 0 30px 15px;">
		<div
			style="padding-top: 5px; border-bottom: 1px solid #EBEBEB; padding-bottom: 15px">
			<div style="display: inline-block; vertical-align: top;">
				<div class="btn-group">
					<a class="btn btn-sm btn-default active"
						style="border: 1px solid #DDD !important;"
						onclick="goListPage('listschedulings');"><i
						class="glyphicon glyphicon-calendar"></i>周排班</a> <a
						style="border: 1px solid #DDD !important;"
						class="btn btn-sm btn-default" onclick="goListPage('paibanM');"><i
						class="glyphicon glyphicon-list-alt"></i>月排班</a>
				</div>
			</div>
			<form id="form" class="pull-right" method="post"
				action="scheduling/listschedulings.do" name="p_Form"
				style="margin: 0; display: inline-block; vertical-align: top;">
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
								<option data-index="${status.index }" data-id="${emp.OfficeID}"
									value="${emp.Emp_ID}">${emp.E_Name}</option>
							</c:forEach>
					</select></li>
					<li>
						<button class="btn p_btn" onclick="searchByCon();">
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
			<table width="100%" style="margin: 10px 0 0 0">
				<tbody>
					<tr>
						<td width="30%">
							<button class="btn btn-primary p_btn" id="last_week"
								onclick="goWeekCirle(-1);">上一周</button>
							<button class="btn btn-primary p_btn" id="next_week"
								onclick="goWeekCirle(1);">下一周</button>
							<button class="btn btn-primary p_btn" id="to_day"
								onclick="goWeekCirle(0);">今天</button>
						</td>
						<td width="40%" style="text-align: center;"><span
							id="dateCircle" style="font-size: 15px; font-weight: 900"></span>
						</td>
						<td width="30%">
							<button class="btn btn-primary pull-right p_btn"
								onclick="getCopyLastWeekValue('${pd.officeID}');">复制上周</button>
						</td>
					</tr>
				</tbody>
			</table>
			<table class="table_first" style="margin: 20px 0 30px 0">
				<thead>
					<tr>
						<td></td>
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
							<td><img src='static/images/user.jpg'></td>
							<td>${emp.E_Name}</td>
							<td><select id="mon${emp.Emp_ID}" name="monday"
								class="s_sched"
								onchange="saveDoctorS('${emp.Emp_ID}',this,1,'mon${emp.Emp_ID}',1);">
									<option></option>
									<c:forEach items="${shiftList}" var="sl">
										<option value="${sl.ShiftID}" <c:if test="">selected</c:if>>${sl.ShiftName}</option>
									</c:forEach>
							</select></td>
							<td><select id="tue${emp.Emp_ID}" name="tuesday"
								class="s_sched"
								onchange="saveDoctorS('${emp.Emp_ID}',this,2,'tue${emp.Emp_ID}',2);">
									<option></option>
									<c:forEach items="${shiftList}" var="sl">
										<option value="${sl.ShiftID}">${sl.ShiftName}</option>
									</c:forEach>
							</select></td>
							<td><select id="wed${emp.Emp_ID}" name="wednesday"
								class="s_sched"
								onchange="saveDoctorS('${emp.Emp_ID}',this,3,'wed${emp.Emp_ID}',3);">
									<option></option>
									<c:forEach items="${shiftList}" var="sl">
										<option value="${sl.ShiftID}">${sl.ShiftName}</option>
									</c:forEach>
							</select></td>
							<td><select id="thu${emp.Emp_ID}" name="thursday"
								class="s_sched"
								onchange="saveDoctorS('${emp.Emp_ID}',this,4,'thu${emp.Emp_ID}',4);">
									<option></option>
									<c:forEach items="${shiftList}" var="sl">
										<option value="${sl.ShiftID}">${sl.ShiftName}</option>
									</c:forEach>
							</select></td>
							<td><select id="fri${emp.Emp_ID}" name="friday"
								class="s_sched"
								onchange="saveDoctorS('${emp.Emp_ID}',this,5,'fri${emp.Emp_ID}',5);">
									<option></option>
									<c:forEach items="${shiftList}" var="sl">
										<option value="${sl.ShiftID}">${sl.ShiftName}</option>
									</c:forEach>
							</select></td>
							<td><select id="sat${emp.Emp_ID}" name="saturday"
								class="s_sched"
								onchange="saveDoctorS('${emp.Emp_ID}',this,6,'sat${emp.Emp_ID}',6);">
									<option></option>
									<c:forEach items="${shiftList}" var="sl">
										<option value="${sl.ShiftID}">${sl.ShiftName}</option>
									</c:forEach>
							</select></td>
							<td><select id="sun${emp.Emp_ID}" name="sunday"
								class="s_sched"
								onchange="saveDoctorS('${emp.Emp_ID}',this,7,'sun${emp.Emp_ID}',0);">
									<option></option>
									<c:forEach items="${shiftList}" var="sl">
										<option value="${sl.ShiftID}">${sl.ShiftName}</option>
									</c:forEach>
							</select></td>
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
	<script type="text/javascript">
		$(top.hangge());
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
			if ($('#officeID').val() != '') {
				officeChange('#officeID', '#doctorName', $('#doctorName').val());
			}
			$('#officeID').change(function() {
				officeChange('#officeID', '#doctorName', '');
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

			//回显操作
			getBol($("#firstdayT").val(), $("#lastdayT").val());

		});
		//搜索操作
		function searchByCon() {
			top.jzts();
			$("#form").submit();
		}

		//根据传入的其实日期和结束日期获取对应得值
		function getBol(startDay, endDay) {
			$.post("scheduling/schedulBackData.do", {
				startDay : startDay,
				endDay : endDay
			}, function(result) {
				$('.table_first select').prop('disabled', false);
				$(".s_sched").val("");
				var array = new Array();
				array = result.data;
				if (array != null && array.length != 0) {
					for (var i = 0; i < array.length; i++) {
						var id = array[i].ValueID;
						$("#" + id).val(array[i].DutyTypeID);
						if (array[i].disabled) {
							$("#" + id).attr('disabled', true);
						}
					}
				} else {
					$(".s_sched").val("");
				}
				check();
			});
		}

		//选择保存  dayN 是指周一类型
		function saveDoctorS(empid, obj, dayN, valueId, saveDay) {
			var shiftId = $(obj).val();//选择规则iD
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
			$.post("scheduling/saveDoctorS.do", {
				empid : empid,
				shiftId : shiftId,
				dateT : day,
				valueId : valueId,
				saveDay : saveDay
			}, function(result) {
				if (result.status == "success") {
					alert("保存成功");
				} else if (result.status == "upsuccess") {
					alert("更新成功");
				} else {
					alert("排班失败");
				}
			});

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

		/*複製上週排班表*/
		function getCopyLastWeekValue(officeID) {
			var nowMonDay = $("#firstdayT").val();
			var nowSunDay = $("#lastdayT").val();
			if ((new Date() >= new Date(nowMonDay) && new Date() <= new Date(
					nowSunDay))
					|| new Date() <= new Date(nowMonDay)) {
				if (confirm('复制上周会覆盖当前设置，请谨慎操作？')) {
					var emp_ID = $('#doctorName').val();
					if (emp_ID == '') {
						var dataID = "";
						if (officeID != '') {
							dataID = '[data-id="' + officeID + '"]';
						}
						$('#doctorName option[value!=""]' + dataID).each(
								function() {
									emp_ID += $(this).attr('value') + ',';
								})
						emp_ID = emp_ID.substring(0, emp_ID.length - 1);
					}

					$.post("scheduling/copyLastSchedul.do", {
						nowMonDay : nowMonDay,
						nowSunDay : nowSunDay,
						emp_ID : emp_ID
					}, function(result) {
						if (result.status == "success") {
							alert("复制班表成功");
							getBol(nowMonDay, nowSunDay);
						} else {
							alert("复制失败");
						}
					});
				}
			} else {
				alert('该周日期小于当前日期，不能进行复制！');
			}

		}

		function check() {
			var firstday = new Date($('#firstdayT').val());
			var lastday = new Date($('#lastdayT').val());
			var now = new Date();
			if (lastday < now) {
				$('.table_first select').prop('disabled', true);
			}
			if (firstday <= now && now <= lastday) {
				var day = now.getDay();
				switch (day) {
				case 0:
					$('select:not([id^="sun"])').attr('disabled', true);
					break;
				case 1:
					break;
				case 2:
					$('select[id^="mon"]').attr('disabled', true);
					break;
				case 3:
					$('select[id^="mon"],select[id^="tue"]').attr('disabled',
							true);
					break;
				case 4:
					$('select[id^="mon"],select[id^="tue"],select[id^="wed"]')
							.attr('disabled', true);
					break;
				case 5:
					$(
							'select[id^="mon"],select[id^="tue"],select[id^="wed"],select[id^="thu"]')
							.attr('disabled', true);
					break;
				case 6:
					$(
							'select[id^="mon"],select[id^="tue"],select[id^="wed"],select[id^="thu"],select[id^="fri"]')
							.attr('disabled', true);
					break;
				default:
					break;
				}
			}
		}

		function goListPage(URL) {
			var url = "scheduling/" + URL + ".do";
			location.href = url;
		}

		/* 根据科室显示对应医生 */
		function officeChange(targetID, doctorID, doctorValue) {
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