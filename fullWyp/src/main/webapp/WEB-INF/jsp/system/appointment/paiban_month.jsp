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
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<style type="text/css">
.p_btn {
	background-color: rgb(65, 178, 166) !important;
}

.p_btn:hover {
	background-color: #ccc !important;
	color: #333 !important;
}

td, th {
	text-align: center;
	padding: 6px 8px 6px 8px;
	word-wrap: break-word;
	height: 31px;
	width: 100px;
	border: 1px solid #DDD
}

.operation {
	text-align: center;
	z-index: 50;
	position: fixed;
	cursor: pointer;
}

.success {
	background-color: #DFF0D8;
}

.dib {
	display: inline-block;
	vertical-align: top;
}

.center {
	position: fixed;
	margin: auto;
	left: 0;
	right: 0;
	z-index: -1;
}

#heard th span {
	font-weight: 900;
}

.btn-group>.btn {
	border-width: 1px !important;
}

.modal-dialog {
	position: fixed;
	margin: auto;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
}

#operation li {
	margin-bottom: 20px;
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
<body style="overflow: auto; margin-bottom: 30px;">
	<div style="margin: 5px 0 30px 15px;">
		<div style="border-bottom: 1px solid #EBEBEB; height: 55px">
			<div id="page" style="position: fixed; top: 10px; left: 17px;">
				<div class="btn-group">
					<a class="btn btn-sm btn-default "
						style="border: 1px solid #DDD !important;"
						onclick="goListPage('listschedulings');"><i
						class="glyphicon glyphicon-calendar"></i>周排班</a> <a
						style="border: 1px solid #DDD !important;"
						class="btn btn-sm btn-default active"
						onclick="goListPage('paibanM');"><i
						class="glyphicon glyphicon-list-alt"></i>月排班</a>
				</div>
			</div>
			<div id="form" name="p_Form"
				style="position: fixed; top: 10px; right: 0px;">
				<ul>
					<li class="dib"><select data-placeholder="选择科室"
						class="selectpicker chosen-select" name="officeID" id="officeID">
							<option selected="selected" value="">请选择</option>
							<c:forEach items="${pdofList}" var="pof">
								<option value="${pof.OfficeID}">${pof.OfficeName}</option>
							</c:forEach>
					</select></li>
					<li class="dib"><select data-placeholder="选择医生"
						class="selectpicker chosen-select" id="doctorName"
						name="doctorName">
							<option selected="selected" value="">请选择</option>
							<c:forEach items="${empList2}" var="emp" varStatus="status">
								<option data-index="${status.index }" data-id="${emp.OfficeID}"
									value="${emp.Emp_ID}">${emp.E_Name}</option>
							</c:forEach>
					</select></li>
					<li class="dib">
						<button class="btn p_btn" onclick="searchByCon();">
							<i class="icon-search"></i>
						</button>
					</li>
				</ul>
			</div>

		</div>
		<div>
			<div id="tableP" style="height: 66px; width: 100%">
				<div class="dib fixed" style="position: fixed;">
					<button class="btn btn-primary p_btn" id="last_week"
						onclick="setDate(-1);">上一月</button>
					<button class="btn btn-primary p_btn" id="next_week"
						onclick="setDate(1);">下一月</button>
					<button class="btn btn-primary p_btn" id="to_day"
						onclick="setDate(2);">今天</button>
				</div>
				<span id="dateCircle" class="center fixed"
					style="font-size: 15px; font-weight: 900; padding: 6px"></span>
				<div style="position: fixed; right: 5px" class="fixed">
					<button class="btn btn-primary pull-right p_btn" onclick="copyM();">复制上月</button>
				</div>
			</div>
			<div style="width: 100%">
				<div style="height: 31px;">
					<div id="left"
						style="width: 115px; position: fixed; left: 0px; z-index: 21; background-color: #FFFFFF; padding-left: 15px">
						<table border="1"
							style="margin: 0; border-right: none; color: #707070; background-color: #F4F4F4">
							<tbody>
								<tr>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div id="heard"
						style="margin-left: 100px; z-index: 20; background-color: #FFFFFF;">
						<table border="1"
							style="margin: 0; width: 100%; color: #707070; background-color: #F4F4F4; font-weight: 900">
							<thead>
								<tr>
									<c:forEach items="${empList }" var="emp">
										<th style="width: 100px"><span id="${emp.Emp_ID }">${emp.E_Name }</span></th>
									</c:forEach>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				<div id="body">
					<div id="left_body"
						style="width: 115px; position: fixed; left: 0px; z-index: 19; background-color: #FFFFFF; padding-left: 15px">
						<table border="1"
							style="margin: 0; border-right: none; color: #707070; background-color: #F4F4F4">
							<tbody></tbody>
						</table>
					</div>
					<div id="right_body"
						style="margin-left: 100px; z-index: 18; background-color: #FFFFFF;">
						<table style="width: 100%; margin: 0;">
							<tbody></tbody>
						</table>
					</div>
					<ul id="operation" class="operation"
						style="display: none; margin: 0; right: 50px; bottom: 100px">
						<li><a onclick="removeCheck();" title="清空选中"><span
								style="color: #69aa46;"><i
									class="icon-screenshot icon-3x"></i></span></a></li>
						<li><a title="排班" data-toggle="modal" data-target="#myModal">
								<span style="color: #69aa46;"><i
									class="icon-edit icon-3x"></i></span>
						</a></li>
					</ul>
				</div>
				<div style="color: red; padding-top: 10px">
					<span>温馨提示：复制上月功能所能复制的天数为该月与上月天数较少的那个月为准。例：5月31天，6月30天，在6月复制上月班表只能复制30天。6月30天，7月31天，在7月复制班表只能复制30天.</span>
				</div>
			</div>
		</div>
		<input id="firstDay" type="hidden"> <input id="lastDay"
			type="hidden"> <input id="today" type="hidden">

		<!-- 模态框（Modal） -->
		<div style="position: fixed;" class="modal fade" id="myModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">月排班</h4>
					</div>
					<div class="modal-body">
						<label>请选择班次：</label> <select id="shift" style="width: 50%">
							<option value="" selected="selected">请选择</option>
							<c:forEach items="${shiftList}" var="sl">
								<option value="${sl.ShiftID}" <c:if test="">selected</c:if>>${sl.ShiftName}</option>
							</c:forEach>
						</select>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" onclick="update();" class="btn btn-primary">提交更改</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
		<script type="text/javascript">
			$(top.hangge());
			$(function() {
				$('#officeID').selectpicker({
					liveSearch : true,
					maxOptions : 1
				});
				$('#doctorName').selectpicker({
					liveSearch : true,
					maxOptions : 1
				});

				$('#officeID').change(function() {
					officeChange('#officeID', '#doctorName', '');
				})

				var oTop = $("#heard").offset().top - 1;
				var bTop = $("#body").offset().top;
				var tTop = $('#tableP').offset().top + 10;
				var sTop = 0;
				$('#left').css("top", oTop);
				$('#left_body').css("top", bTop);
				$(".fixed").css("top", tTop);
				$(window).scroll(
						function() {
							sTop = $(this).scrollTop();
							var oLeft = -Math.max(document.body.scrollLeft,
									document.documentElement.scrollLeft);
							$('#left_body').css("top", bTop - sTop);
							if (sTop >= oTop) {
								$("#heard").css({
									"position" : "fixed",
									"top" : "0",
									"left" : oLeft + 15,
								});
								$('#left').css("top", "0");
							} else {
								$('#fix').css('magin', '0!importants');
								$("#heard").css({
									"position" : "static"
								});
								$('#left').css("top", oTop - sTop);
							}
							$(".fixed").css("top", tTop - sTop);
							$('#form').css('top', 10 - sTop);
							$('#page').css('top', 10 - sTop);
						});
				dates = dateRangeUtil.getDateMonth(new Date(), 0);
				$('#today').val(dates[0]);
				$('#firstDay').val(dates[0]);
				$('#lastDay').val(dates[1]);
				setDate(0);
			});

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
				$('#left_body tbody').empty();
				$('#right_body tbody').empty();
				for (var i = 0; i < dateList.length; i++) {
					date = dateList[i]
					$('#left_body tbody').append(
							'<tr><td>' + date + '</td></tr>');
					var str = "<tr>";
					$('#heard th span')
							.each(
									function() {
										var id = date + $(this).attr('id');
										str += '<td id="' + id + '" style="width: 100px"><span></span></td>';
									})
					str += '</tr>'
					$('#right_body tbody').append(str);
				}
				getBol(dates[0], dates[1]);
			}

			function setHeight() {
				$('#left').css('height', $('#heard tr').outerHeight() + 1);
				$('#left_body td').each(
						function() {
							var id = $('td[id^="' + $(this).text() + '"]')
									.attr('id');
							$(this).css('height',
									$('td[id="' + id + '"]').outerHeight());
						})
			}

			function getTd() {
				if ($(this).hasClass('success')) {
					$(this).removeClass('success');
					if ($('#right_body td[class="success"]').length == 0) {
						$('#operation').css('display', 'none');
					}
				} else {
					$(this).addClass('success');
					$('#operation').css('display', 'inline');
				}
				$('#operation').css('bottom', getTop($(this))).css('right',
						getLeft($(this)));
			}

			//获取元素的纵坐标（相对于窗口）
			function getTop(e) {
				var offset = e.offsetTop;
				if (e.offsetParent != null)
					offset += getTop(e.offsetParent);
				return offset;
			}
			//获取元素的横坐标（相对于窗口）
			function getLeft(e) {
				var offset = e.offsetLeft;
				if (e.offsetParent != null)
					offset += getLeft(e.offsetParent);
				return offset;
			}

			function removeCheck() {
				$('#right_body td[class="success"]').each(function() {
					$(this).removeClass('success');
				})
				$('#operation').css('display', 'none');
			}

			function getBol(startDay, endDay) {
				$.post("scheduling/schedulBackData.do", {
					startDay : startDay,
					endDay : endDay
				}, function(result) {
					$("#right_body td").click(getTd);
					var array = new Array();
					array = result.data;
					if (array != null && array.length != 0) {
						for (var i = 0; i < array.length; i++) {
							var id = array[i].DutyDate + array[i].Emp_ID;
							$("#" + id + ' span').text(array[i].DutyTypeName)
									.attr('id', array[i].Duty_ID);
							if (array[i].disabled) {
								$("#" + id).unbind("click").click(function() {
									$(this).tips({
										side : 3,
										msg : '该班次已被预约，不能修改',
										bg : '#AE81FF',
										time : 2
									});
								});
							}
						}
					}
					check(startDay, endDay);
					setHeight();
				});
			}

			function check(startDay, endDay) {
				var firstday = new Date(startDay + ' 00:00:00');
				var lastday = new Date(endDay + ' 23:59:59');
				var now = new Date();
				if (lastday < now) {
					$('#right_body td').unbind("click").click(function() {
						$(this).tips({
							side : 3,
							msg : '小于当前时间不能选中修改',
							bg : '#AE81FF',
							time : 2
						});
					});
				}
				if (firstday <= now <= lastday) {
					var dates = dateRangeUtil.getDatesOfMon(firstday, now);
					for (var i = 0; i < dates.length - 1; i++) {
						var date = dates[i]
						$('td[id^="' + date + '"]').unbind("click").click(
								function() {
									$(this).tips({
										side : 3,
										msg : '小于当前时间不能选中修改',
										bg : '#AE81FF',
										time : 2
									});
								});
					}
				}
			}

			function searchByCon() {
				var off = $('#officeID').val();
				var patient = $("#doctorName").val();

				$
						.ajax({
							url : 'scheduling/searchM.do?officeID=' + off
									+ '&doctorName=' + patient,
							method : 'get',
							success : function(data) {
								$('#heard th').remove();
								$('#left td').remove();
								var result = new Array();
								result = data;
								var str = '';
								for (var i = 0; i < result.length; i++) {
									var emp = result[i];
									str += '<th  style="width: 100px"><span id="'+emp.Emp_ID+'">'
											+ emp.E_Name + '</span></th>';
								}
								$('#heard tr').append(str);
								if (str == '') {
									$('#left_body tr').remove();
									$('#right_body tr').remove();
									$('#right_body tbody')
											.append(
													'<tr><td style="border-style:none" colspan="100"><strong>暂无数据<strong></td></tr>');
								} else {
									$('#left tr').append('<td></td>');
									setDate(0);
								}
							},
							error : function(xhr) {
								alert('查询失败');
								console.log('error:' + JSON.stringify(xhr));
							}
						})
			}

			function update() {
				var array = new Array();
				var option = $('#shift option:selected');
				var value = option.val();
				var text = option.text();
				var i = 0;
				var del = true;
				if (value == '') {
					if (!confirm('确认删除所选的班次吗')) {
						del = false;
					}
				}
				if (del) {
					$('#right_body td[class="success"] span').each(function() {
						var json = new Object();
						if ($(this).text() == '' && value != '') {
							var id = $(this).parent().attr('id');
							var date = id.substring(0, 10);
							var emp_ID = id.substring(10);
							var e_name = $('#' + emp_ID).text();
							var dateDate = new Date(date);
							var saveDate = dateDate.getDay();
							var valueID = ''
							switch (saveDate) {
							case 0:
								valueID = 'sun' + emp_ID;
								break;
							case 1:
								valueID = 'mon' + emp_ID;
								break;
							case 2:
								valueID = 'tue' + emp_ID;
								break;
							case 3:
								valueID = 'wed' + emp_ID;
								break;
							case 4:
								valueID = 'thu' + emp_ID;
								break;
							case 5:
								valueID = 'fri' + emp_ID;
								break;
							case 6:
								valueID = 'sat' + emp_ID;
								break;
							default:
								break;
							}
							json.DutyDate = date;
							json.Emp_ID = emp_ID;
							json.E_Name = e_name;
							json.SaveDay = saveDate;
							json.ValueID = valueID;
							json.DutyTypeID = value;
							json.DutyTypeName = text;
						} else if ($(this).text() != '') {
							var dutyID = $(this).attr('id');
							json.Duty_ID = dutyID;
							json.DutyTypeID = value;
							json.DutyTypeName = text;
						}
						array[i] = JSON.stringify(json);
						i++;
					})
					var data = '[' + array.toString() + ']';
					$.ajax({
						url : 'scheduling/updateM.do?data=' + data,
						method : 'get',
						error : function() {
							alert('更新失败');
						},
						success : function(result) {
							if (result == 'error') {
								alert('更新失败');
								$('#myModal').modal('hide');
							} else {
								alert('更新成功');
								setDate(0);
								$('#myModal').modal('hide');
								removeCheck();
							}
						}
					})
				}
			}

			function copyM() {
				var currentDate = $('#firstDay').val();
				var lastDate = $('#lastDay').val();
				if ((new Date() >= new Date(currentDate) && new Date() <= new Date(
						lastDate))
						|| new Date() <= new Date(currentDate)) {
					if (confirm('此操作会覆盖当前设置，请谨慎操作？')) {
						var empS = '';
						var size = 0;
						$('#heard th span').each(function() {
							empS += $(this).attr('id') + ',';
							size++;
						})
						empS = empS.substring(0, empS.length - 1);
						if (empS == '') {
							alert('当月没有医生可以复制');
						} else {
							var dates = dateRangeUtil.getDateMonth(currentDate,
									0);
							var ldates = dateRangeUtil.getDateMonth(
									currentDate, -1);

							if ((new Date(dates[1])).getDate() > (new Date(
									ldates[1])).getDate()) {
								var day = (new Date(ldates[1])).getDate();
								dates[1] = dates[1].substring(0, 8) + day;
							} else {
								var day = (new Date(dates[1])).getDate();
								ldates[1] = ldates[1].substring(0, 8) + day;
							}
							var url = 'scheduling/copyM.do?fromDate='
									+ dates[0] + '&toDate=' + dates[1]
									+ '&lastFromDate=' + ldates[0]
									+ '&lastToDate=' + ldates[1] + '&emps='
									+ empS + '&size=' + size;
							$.get(url, function(result) {
								if (result == 'error') {
									alert('复制上月班表失败');
								} else {
									alert('复制上月班表成功');
									setDate(0);
								}
							})
						}
					}
				} else {
					alert('该月日期小于当前日期，不能进行复制！');
				}
			}

			function goListPage(URL) {
				var url = "scheduling/" + URL + ".do";
				location.href = url;
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
		</script>
</body>

</html>