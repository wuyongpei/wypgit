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
<link href="static/bootstrap/css/bootstrap-select.css" rel="stylesheet" />
<link rel="stylesheet" href="static/css/datepicker.css" />
<link rel="stylesheet" href="static/css/font-awesome.min.css" />
<link href="static/fullRC/css/appoint-add.css" rel="stylesheet" />
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
<script type="text/javascript" src="static/laydate/laydate.js"></script>
<script type="text/javascript"
	src="<%=basePath%>static/fullRC/js/pagePlugin.js"></script>
<style type="text/css">
table td, table th {
	line-height: 1.5 !important;
	padding: 12px !important;
}

.table {
	margin: 15px 0 30px 0;
}

#info li {
	padding: 8px 0px 8px 0;
}
</style>
<script type="text/javascript">
	function getName(dictname, type) {
		var name = '';
		url = 'getByCode.do?dictname=' + dictname + '&dictcode=' + type;
		$.ajax({
			url : url,
			method : 'get',
			async : false,
			success : function(data) {
				name = data;
			}
		})
		document.write(name);
	}
</script>
</head>
<body style="background-color: #FCFCFC">
	<!-- 预约信息 -->
	<div>
		<form
			action="sickPatient/view/appointments.do?PatientID=${page.pd.PatientID }"
			method="post">
			<div class="panel panel-default" style="border: none;">
				<div class="panel-body">
					<table id="appsList" class="t_tab"
						style="border: none; width: 100%">
						<thead style="background: #f5f5f5;">
							<tr>
								<th style="width: 7%" class="fc-day-header">预约状态</th>
								<th style="width: 10%" class="fc-day-header">预约科室</th>
								<th style="width: 10%" class="fc-day-header">预约类型</th>
								<th style="width: 10%" class="fc-day-header">预约医生</th>
								<th style="width: 18%" class="fc-day-header">预约日期</th>
								<th style="width: 20%" class="fc-day-header">预约内容</th>
								<th style="width: 20%" class="fc-day-header">备注</th>
								<th style="width: 5%" class="fc-day-header">操作</th>
							</tr>
						</thead>
						<tbody id="appsData">
							<c:forEach var="app" items="${apps }">
								<tr>
									<td class="fc-day-header"><script type="text/javascript">
										getName('APPOINTMENTSTATE',
												'${app.AppointmentStatus }')
									</script></td>
									<td class="fc-day-header">${app.OfficeName }</td>
									<td class="fc-day-header"><script type="text/javascript">
										getName('APPOINTMENT',
												'${app.Appointment_Type }')
									</script><input type="hidden" value="${app.Appointment_Type }"></td>
									<td class="fc-day-header">${app.E_Name }</td>
									<td class="fc-day-header">${app.Appointment_Date }
										${app.Appointment_Time }</td>
									<td class="fc-day-header">${app.Appointment_Con }</td>
									<td class="fc-day-header">${app.Comment }</td>
									<td class="fc-day-header">
										<div class="row">
											<a style="cursor: pointer; padding: 5px" title="编辑"
												onclick="editApp('${app}','${pd.data }','${app.Appointment_Date }','${app.Appointment_Time }')"
												class="tooltip-success" data-rel="tooltip" title=""
												data-placement="left"><span class="green"><i
													class="icon-edit icon-large"></i></span></a><a
												style="cursor: pointer; padding: 5px" title="取消预约"
												onclick="deleteApp('${app.Appointment_ID}','${app.Appointment_Date }','${app.Appointment_Time }')"
												class="tooltip-error" data-rel="tooltip" title=""
												data-placement="left"><span class="red"><i
													class="icon-trash icon-large"></i></span> </a>
										</div>
									</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
					<!-- 分页 12条一页 -->
					<div>
						<div class="base_page">
							<a
								onclick="nextPage('${page.currentPage -1}','${page.showCount}')"
								type="button" class="btn btn-default pull-left"><i
								class="glyphicon glyphicon-chevron-left"></i></a>
							<button type="button"
								class="btn btn-default  base_page_info pull-left"
								disabled="disabled">${page.currentPage}/${page.totalPage}</button>
							<a
								onclick="nextPage('${page.currentPage +1}','${page.showCount}')"
								type="button" class="btn btn-default pull-left"><i
								class="glyphicon glyphicon-chevron-right"></i></a> <input
								type="hidden" id="showCount" value="${page.showCount}"><input
								id="toGoPage" placeholder="输入页数" style="width: auto;"
								type="number" class="form-control  num-input pull-left" /> <a
								class="btn btn-default j_madule_page_search_submit pull-left ml5"
								type="button" onclick="toTZ();">Go</a>
						</div>
					</div>
					<!-- 分页借宿 -->
				</div>
			</div>
			<input type="hidden" id="data" name="data" value="${pd.data }">
		</form>
	</div>
	<!-- 预约信息 -->
	<script type="text/javascript">
		$(top.hangge());
		$(function() {
			viewAddress();
		})

		function viewAddress() {
			var address = $("#address").text();
			if (address == '') {
				$("#address").text('');
			} else {
				$("#address").text(address.replace(/\|/g, ''));
			}
		}

		function editApp(data, patient, date, time) {
			var url='&patient='+patient;
			var isDelete = isBefore(date, time);
			data = getdata(data);
			patient = getdata(patient);
			var json = JSON.parse(data);
			var jsonP = JSON.parse(patient);
			json['Birthday'] = jsonP['Birthday'];
			json['Sex'] = jsonP['Sex'];
			json['Age'] = jsonP['Age'];
			json['MobileNO'] = jsonP['MobileNO'];
			json['WeChatNo'] = jsonP['WeChatNo'];
			json['IDNumber'] = jsonP['IDNumber'];
			json['MarriageState'] = jsonP['MarriageState'];
			json['Nation'] = jsonP['Nation'];
			json['Company'] = jsonP['Company'];
			json['Address'] = jsonP['Address'];
			json['Profession'] = jsonP['Profession'];
			delete json['CreateDateTime'];
			data = JSON.stringify(json);
			url = "appointment/editApp.do?url=patient&data=" + data+url;
			if (!isDelete) {
				url += '&view=view';
			}
			parent.location.href = url;
		}

		function deleteApp(appID, date, time) {
			var isDelete = isBefore(date, time);
			if (isDelete) {
				if (confirm('确认取消预约？')) {
					$.ajax({
						url : 'appointment/delete.do?Appointment_ID=' + appID,
						method : 'get',
						success : function() {
							alert('取消预约成功');
							top.jzts();
							document.location.reload();
						},
						error : function() {
							alert('取消预约失败');
						}
					})
				}
			} else {
				alert('预约时间小于当前时间，不可取消预约');
			}
		}

		function isBefore(data, time) {
			var str = data + ' ' + time;
			var date = new Date(str);
			var now = new Date;
			if (date > now) {
				return true;
			} else {
				return false;
			}
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
			return apps;
		}
	</script>
</body>

</html>