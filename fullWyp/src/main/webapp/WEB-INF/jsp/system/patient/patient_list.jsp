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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="static/css/ace.min.css" />
<link href="static/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="static/css/font-awesome.min.css" />
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/bootstrap/css/bootstrap-select.css" rel="stylesheet" />
<link href="static/fullRC/css/register.css" rel="stylesheet" />
<link href="static/fullRC/css/icon/iconfont.css" rel="stylesheet" />
<link href="static/fullRC/css/appoint_list.css" rel="stylesheet" />
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

.btn-default {
	height: 30px !important;
}

.input-sm2 {
	font-size: 12px;
	height: 30px !important;
}

.pagination ul>li>a, .pagination ul>li>span {
	background-color: none;
}

.pagination ul>li>input {
	height: 30px !important;
	margin: 0px !important;
}

.fc-day-header {
	text-align: left;
	font-weight: normal;
	font-size: 1.01em;
	padding: 10px 8px !important;
}
</style>
</head>
<body>
	<div class="tab-pane active" style="overflow: hidden;">
		<div class="panel panel-default" style="border: none;">
			<div class="panel-heading head-panel">
				<form action="${action }" method="post" name="empForm">
					<div class="row">
						<div class="col-sm-3 col-md-4">
							<div class="btn-group">
								<a type="buttion"
									style="font-weight: normal; border: 1px solid #ccc !important; text-shadow: none !important;"
									class="btn btn-sm btn-default" onclick="goListPage()"><i
									class="glyphicon glyphicon-plus"
									style="font-size: 100% !important;"></i>新增病人</a>
							</div>
						</div>

						<div class="col-sm-9 col-md-8  form-inline">
							<div class="pull-right">
								<div class="form-group">
									<input value="${pd.PatientName }" name="PatientName"
										autocomplete="off" id="PatientName" type="text"
										class="form-control input-sm2" placeholder="输入患者姓名">
								</div>
								<div class="form-group">
									<input value="${pd.time }" size="35" autocomplete="off"
										id="CreateDateTime" name="time" type="text"
										class="form-control input-sm2" placeholder="登记日期">
								</div>
								<div class="form-group">
									<button class="btn p_btn" onclick="search();">
										<i class="glyphicon glyphicon-search"></i>
									</button>
								</div>
							</div>
						</div>
					</div>


					<div id="calendar">
						<hr style="height: 2px; background-color: #ddd; margin-top: 10px;">
						<div class="fc-day-state">
							<table id="dataList" border="1" class="t_tab"
								style="table-layout: fixed; text-align: left">
								<thead>
									<tr style="color: #707070; background-color: #F4F4F4;">
										<th class="fc-day-header"
											style="width: 10%; font-weight: 900;">姓名</th>
										<th class="fc-day-header" style="width: 5%; font-weight: 900;">性别</th>
										<th class="fc-day-header" style="width: 5%; font-weight: 900;">年龄</th>
										<th class="fc-day-header"
											style="width: 10%; font-weight: 900;">出生日期</th>
										<th class="fc-day-header"
											style="width: 10%; font-weight: 900;">手机号码</th>
										<th class="fc-day-header"
											style="width: 15%; font-weight: 900;">持卡卡号</th>
										<th class="fc-day-header"
											style="width: 10%; font-weight: 900;">持卡类型</th>
										<th class="fc-day-header"
											style="width: 10%; font-weight: 900;">民族</th>
										<th class="fc-day-header"
											style="width: 15%; font-weight: 900;">登记日期</th>
										<th class="fc-day-header"
											style="width: 10%; text-align: center; font-weight: 900;">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${patients}" var="patient">
										<tr>
											<td class="fc-day-header"><a
												style="cursor: pointer; padding: 5px"
												onclick="view('${patient}');">${patient.PatientName }</a></td>
											<td class="fc-day-header">${patient.Sex }</td>
											<td class="fc-day-header">${patient.Age }</td>
											<td class="fc-day-header">${patient.Birthday }</td>
											<td class="fc-day-header">${patient.MobileNO }</td>
											<td class="fc-day-header">${patient.CardCode }</td>
											<td class="fc-day-header"><c:if
													test="${patient.CardType==1 }">医/农保卡</c:if>
												<c:if test="${patient.CardType==0 }">就诊卡</c:if></td>
											<td class="fc-day-header">${patient.Nation }</td>
											<td class="fc-day-header">${patient.CreateDateTime }</td>
											<td class="fc-day-header" style="text-align: center;">
												<div class="row">
													<a style="cursor: pointer; padding: 5px"
														onclick="appoint('${patient}');" class="tooltip-primary"
														data-rel="tooltip" title="预约" data-placement="left"><span
														class="green"><i class="icon-plus icon-large"></i>
													</span></a> <a style="cursor: pointer; padding: 5px" title="编辑"
														onclick="edit('${patient}');" class="tooltip-success"
														data-rel="tooltip" title="" data-placement="left"><span
														class="green"><i class="icon-edit icon-large"></i></span></a><a
														style="cursor: pointer; padding: 5px" title="删除"
														onclick="del('${patient.PatientID }');"
														class="tooltip-error" data-rel="tooltip" title=""
														data-placement="left"><span class="red"><i
															class="icon-trash icon-large"></i></span> </a>
												</div>

											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="page-header position-relative">
						<table style="width: 100%;">
							<tr>
								<td style="vertical-align: top;"><div
										class="pagination pull-right"
										style="padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>

		<script type="text/javascript">
			$(top.hangge());

			$(function() {
				laydate.render({
					elem : '#CreateDateTime',
					range : true,
					type : 'datetime'
				});
				tip('${msg}');
			})

			function tip(msg) {
				if (msg == 'success') {
					$.DialogByZ.Alert({
						Title : "提示",
						Content : "保存成功",
						BtnL : "确定",
						FunL : alerts
					})
				}
				;
				if (msg == 'faile') {
					$.DialogByZ.Alert({
						Title : "提示",
						Content : "保存失败",
						BtnL : "确定",
						FunL : alerts
					})
				}
				;
			}
			function alerts() {
				$.DialogByZ.Close();
			}

			function goListPage() {
				var url = "register/dengji.do";
				location.href = url;
			}
			function search() {
				top.jzts();
				$("#empForm").submit();
			}

			function view(data) {
				data = getdata(data);
				var url = 'sickPatient/view?PatientName='
						+ $('#PatientName').val() + '&time='
						+ $('#CreateDateTime').val() + '&data=' + data;
				location.href = url;
			}
			function del(PatientID) {
				if (confirm('确认删除？')) {
					var url = "sickPatient/deletePatient.do?PatientID="
							+ PatientID;
					$.ajax({
						url : url,
						method : 'GET',
						success : function(data) {
							alert('删除成功');
							top.jzts();
							document.location.reload();
						},
						error : function(xhr) {
							alert('删除失败');
							console.log('error:' + JSON.stringify(xhr));
						}
					})
				}
			}

			function edit(data) {
				data = getdata(data);
				var url = 'register/dengji?url=patientList&data=' + data;
				location.href = url;
			}
			function appoint(data) {
				data = getdata(data);
				var json = JSON.parse(data);
				delete json.CreateDateTime;
				data = JSON.stringify(json);
				var url = 'sickPatient/appoint?data=' + data;
				location.href = url;
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