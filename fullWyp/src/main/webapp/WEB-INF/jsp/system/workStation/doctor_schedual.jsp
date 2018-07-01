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
<script type="text/javascript"
	src="<%=basePath%>static/fullRC/js/datetimeUtil.js"></script>
<script type="text/javascript"
	src="<%=basePath%>static/fullRC/js/pagePlugin.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap-select.js"></script>
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<style type="text/css">
.p_btn {
	background-color: rgb(65, 178, 166) !important;
}

.p_btn:hover {
	background-color: #ccc !important;
	color: #333 !important;
}

#schedual td, #schedual th {
	text-align: center;
	word-wrap: break-word;
	height: 75px;
	width: 100px;
}

th {
	font-weight: 900;
}

.dib {
	display: inline-block;
	vertical-align: top;
}

#schedual td, #schedual th {
	border: 1px solid #DDD;
}

#buttons th {
	text-align: center;
	word-wrap: break-word;
	padding: 8px 0 10px 0;
}

a {
	text-decoration: none;
	cursor: pointer;
}

.btn-group>.btn {
	border-width: 1px !important;
}

.btn {
	text-shadow: none !important;
}
</style>
</head>
<body>
	<div style="margin: 5px 5px 30px 15px;">
		<div
			style="border-bottom: 1px solid #EBEBEB; height: 55px; padding-top: 5px">
			<div class="pull-left">
				<h5 style="display: inline-block; margin: 10px 0;">当前医生：</h5>
				<h3 style="display: inline-block; margin: 10px 0;"></h3>
			</div>
			<div id="form" class="pull-right"
				style="margin: 0; display: inline-block; vertical-align: top;">
				<ul>
					<li class="dib"><select data-placeholder="选择科室"
						class="selectpicker chosen-select" name="officeID" id="officeID">
							<option value="" selected="selected">请选择</option>
							<c:forEach items="${pdofList}" var="pof">
								<option value="${pof.OfficeID}">${pof.OfficeName}</option>
							</c:forEach>
					</select></li>
					<li class="dib"><select data-placeholder="选择医生"
						class="selectpicker chosen-select" id="doctorName"
						name="doctorName">
							<option value="" selected="selected">请选择</option>
					</select></li>
					<li class="dib">
						<button class="btn p_btn" onclick="getBol();">
							<i class="icon-search"></i>
						</button>
					</li>
				</ul>
			</div>
		</div>
		<div style="text-align: center">
			<table id="buttons" style="margin: auto; width: 100%;">
				<thead>
					<tr>
						<th>
							<div class="dib pull-left">
								<button class="btn btn-primary p_btn" id="last_week"
									onclick="setDate(-1);">上一月</button>
								<button class="btn btn-primary p_btn" id="next_week"
									onclick="setDate(1);">下一月</button>
							</div>
						</th>
						<th id="dateCircle"></th>
						<th>
							<button class="btn btn-primary p_btn pull-right" id="to_day"
								onclick="setDate(2);" style="margin-right: 17px;">今天</button>
						</th>
					</tr>
				</thead>
			</table>
			<table id="schedual"
				style="margin: auto; width: 100%; text-align: center;">
				<thead>
					<tr>
						<th>日</th>
						<th>一</th>
						<th>二</th>
						<th>三</th>
						<th>四</th>
						<th>五</th>
						<th>六</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
		<input id="firstDay" type="hidden"> <input id="lastDay"
			type="hidden"> <input id="today" type="hidden">
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">班次详情</h4>
					</div>
					<div class="modal-body" style="font-size: 14px; text-align: center">
						<div id="shift" class="row" style="font-size: 15px"></div>
						<div id="shiftC" class="row"></div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</div>

	<script type="text/javascript">
		$(top.hangge());
		$(function() {
			var ifSearch = true;
			$('#officeID').selectpicker({
				liveSearch : true,
				maxOptions : 1
			});
			$('#doctorName').selectpicker({
				liveSearch : true,
				maxOptions : 1
			});
			dates = dateRangeUtil.getDateMonth(new Date(), 0);
			$('#today').val(dates[0]);
			$('#firstDay').val(dates[0]);
			$('#lastDay').val(dates[1]);
			setDate(0);
			$('#officeID').change(function() {
				offChange;
				ifSearch = true;
			});
			$('button[data-id="doctorName"]').click(function() {
				if (ifSearch) {
					searchEmp();
				}
				ifSearch = false;
			});
		})
		function setDate(mon) {
			var dates = new Array();
			if (mon == 2) {
				dates = dateRangeUtil.getDateMonth(new Date(), 0);
			} else {
				var currentDate = $('#firstDay').val();
				dates = dateRangeUtil.getDateMonth(currentDate, mon);
			}
			$('#dateCircle').text(dates[0].substring(0, 7));
			$('#firstDay').val(dates[0]);
			$('#lastDay').val(dates[1]);
			var dateList = dateRangeUtil.getDatesOfMon(dates[0], dates[1]);
			$('#schedual tbody').empty();
			var str = '<tr>';
			day = getweek(dateList[0]);
			for (var i = 0; i < day; i++) {
				str += '<td></td>';
			}
			var week = 0;
			for (var i = 0; i < dateList.length; i++) {
				var date = dateList[i];
				str += '<td id="'+date+'"><p>'
						+ getDate(date)
						+ '</p><a onclick="getDateByID(this);" style="text-decoration:none" data-toggle="modal" data-target="#myModal"><strong style="height:20px;width:100%;">" "</strong></a></td>';
				week = getweek(date);
				if (week == 6 && i < dateList.length - 1) {
					str += '</tr><tr>'
				}
				if (week == 6 && i == dateList.length - 1) {
					str += '</tr>'
				}
			}
			if (week < 6) {
				for (var i = 0; i < 6 - getweek(dateList[dateList.length - 1]); i++) {
					str += '<td></td>';
				}
				str += '</tr>'
			}
			$('#schedual tbody').append(str);
			getBol();
		}

		function getBol() {

			$('#schedual td strong').text('');
			var userID = $(window.parent.parent.parent.document).find('#empid')
					.val();
			var empID = $('#doctorName').val();
			if (empID == '') {
				empID = userID;
				$('h3').text(
						$(window.parent.parent.parent.document).find(
								'#user_info').text().substring(8));
			} else {
				$('h3').text($('#doctorName option:selected').text());
			}
			$.post("scheduling/getSchedulByEmpID.do", {
				startDate : $('#firstDay').val(),
				endDate : $('#lastDay').val(),
				empID : empID
			}, function(result) {
				var array = new Array();
				array = result;
				if (array != null && array.length != 0) {
					for (var i = 0; i < array.length; i++) {
						var id = array[i].DutyDate;
						$("#" + id + ' strong').text(array[i].DutyTypeName)
								.attr('id', array[i].DutyTypeID);
					}
				}
			});
		}

		function getDateByID(element) {
			$('#shift').empty();
			$('#shiftC').empty();
			var shiftID = $(element).find('strong').attr('id');
			var url = 'shift/getDateByID.do?shiftID=' + shiftID;
			$.get(url, function(result) {
				var array = new Array();
				array = result;
				for (var i = 0; i < array.length - 1; i++) {
					var shift = array[i];
					$('#shiftC').append(
							'<p><strong>' + shift.ShiftName + '</strong>：'
									+ shift.StartTime + '-' + shift.EndTime
									+ '</p>');
				}
				var shift = array[array.length - 1];
				$('#shift').append(
						'<p><strong>' + shift.ShiftName + '</strong>：'
								+ shift.StartTime + '-' + shift.EndTime
								+ '</p>');
			})
		}

		function searchEmp() {
			var id = $('#officeID').val();
			if (id == '' || typeof (id) == 'undefined') {
				id = 0;
			}
			var url = "emp/getEmpByo.do?OfficeID=" + id;
			$.get(url, function(data) {
				$('#doctorName').empty();
				$('#doctorName').append(
						'<option value="" selected="selected">请选择</option>');
				var emps = new Array();
				emps = data;
				if (emps != '') {
					for (var i = 0; i < emps.length; i++) {
						emp = emps[i];
						$('#doctorName').append(
								'<option value="'+emp.Emp_ID+'">' + emp.E_Name
										+ '</option>');
					}
				}
				$('#doctorName').selectpicker('refresh');
			})
		}

		function offChange() {
			$('#doctorName').empty();
			$('#doctorName').append(
					'<option value="" selected="selected">请选择</option>');
		}

		function getweek(str) {
			var date = new Date(str);
			return date.getDay();
		}

		function getDate(str) {
			var date = new Date(str);
			return date.getDate();
		}
	</script>
</body>
</html>