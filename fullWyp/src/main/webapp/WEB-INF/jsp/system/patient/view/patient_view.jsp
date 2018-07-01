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
<%@include file="../../../layouts/taglib.jsp"%>
<base href="<%=basePath%>">
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

<link rel="stylesheet" href="static/fullRC/css/zdialog.css" />
<script src="static/fullRC/js/zdialog.js"></script>

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
</head>
<body>
	<div>
		<div class="pageheader">
			<h4>
				<i class=" icon-user-md"></i>&nbsp;&nbsp;患者信息
			</h4>
			<button
				onclick="{
				var url='sickPatient/getPatients.do?PatientName=${pd.PatientName}&time=${pd.time }';
				location.href=url;
			}"
				class="btn btn-default breadcrumb-wrapper pull-right">返回</button>
		</div>

		<div class="contentpanel">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-sm-3 col-md-2">
							<div class="form-group" id="crop-avatar">
								<div class="J_image_upload mr0">
									<div class="image-select J_image_select avatar-view">
										<div class="image-preview">
											<img src="static/images/user-t.png" alt="" width="100%">
										</div>
									</div>
								</div>
								<ul id="info" class=list-unstyled>
									<li class="text-cente text-center"><h2>
											<strong>${data.PatientName }</strong>
										</h2></li>
									<li>性别：${data.Sex }</li>
									<li>年龄：${data.Age }</li>
									<li>出生年月：${data.Birthday }</li>
								</ul>

							</div>
						</div>

						<div class="col-sm-9 col-md-10">
							<ul id="myTab" class="nav nav-tabs">
								<li class="active"><a href="#regNew" data-toggle="tab">
										基本信息 </a></li>
								<li><a href="#appointToday" data-toggle="tab">预约信息</a></li>
							</ul>
							<div class="tab-content tab-div">
								<!--基本信息 -->
								<div class="tab-pane active" id="regNew"
									style="overflow: hidden;">
									<table class="table">
										<thead>
											<tr style="background: #f5f5f5;">
												<th>基本信息</th>
												<th><a style="cursor: pointer; padding: 5px" title="编辑"
													onclick="edit('${data}');" class="tooltip-success"
													data-rel="tooltip" title="" data-placement="left"><span
														class="green pull-right"><i
															class="icon-edit icon-large"></i></span></a></th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td width="40%"><strong>姓名：</strong>${data.PatientName }</td>
												<td width="60%"><strong>性别：</strong> ${data.Sex }</td>
											</tr>
											<tr>
												<td><strong>出生年月：</strong> ${data.Birthday }</td>
												<td><strong>年龄：</strong> ${data.Age }</td>
											</tr>
											<tr>
												<td><strong>手机号：</strong>${data.MobileNO }</td>
												<td><strong>微信号：</strong>${data.WeChatNo }</td>
											</tr>
											<tr>
												<td><strong>身份证号：</strong>${data.IDNumber }</td>
												<td><strong>邮箱：</strong>${data.Email }</td>
											</tr>
											<tr>
												<td><strong>婚姻状况：</strong>${data.MarriageState }</td>
												<td><strong>民族：</strong> ${data.Nation }</td>
											</tr>
											<tr>
												<td><strong>职业：</strong>${data.Profession }</td>
												<td><strong>工作单位：</strong>${data.Company }</td>
											</tr>
											<tr>
												<td><strong>持卡类型：</strong> <c:if
														test="${data.CardType==0 }">就诊卡</c:if> <c:if
														test="${data.CardType==1 }">医保卡</c:if></td>
												<td><strong>病人卡号：</strong>${data.CardCode }</td>
											</tr>
											<tr>
												<td><strong>医疗证号：</strong>${data.InsuranceNO }</td>
												<td><strong>医/农 保卡号：</strong>${data.MN_CardNO }</td>
											</tr>
											<tr>
												<td><strong>登记时间：</strong>${data.CreateDateTime }</td>
												<td><strong>通讯地址：</strong><span id="address">${data.Address}
												</span> <%-- <c:if test="${data.State==0 }">启用</c:if> <c:if
														test="${data.State!=0 }">禁用</c:if> --%></td>
											</tr>
											<tr>
												<td><strong>联系人：</strong>${data.Linkman }</td>
												<td><strong>联系人关系：</strong>${data.LinkmanRelation }</td>
											</tr>
											<tr>
												<td><strong>联系人电话：</strong>${data.LinkmanPhone }</td>
												<td><strong>联系人住址：</strong>${data.LinkmanAddress }</td>
											</tr>
											<tr>
												<td><strong>备注说明：</strong>${data.Comment }</td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- 基本信息 -->

								<!-- 预约信息 -->
								<div class="tab-pane fade" id="appointToday"
									style="background-color: #ddd;">
									<iframe id="ifr-set" scrolling="auto" frameborder="0"
										width="100%" style="min-height: 800px"
										src="sickPatient/view/appointments.do?PatientID=${data.PatientID }&data=${data}"></iframe>
								</div>
								<!-- 预约信息 -->

							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" value="${msg}" id="msg">



	</div>


	<script type="text/javascript">
		$(top.hangge());
		$(function() {
			viewAddress();
			tip();
		})

		function viewAddress() {
			var address = $("#address").text();
			if (address == '') {
				$("#address").text('');
			} else {
				$("#address").text(address.replace(/\|/g, ''));
			}
		}

		function tip() {
			var msg = $('#msg').val();
			if (msg == 'success') {
				$.DialogByZ.Alert({
					Title : "提示",
					Content : "保存成功",
					BtnL : "确定",
					FunL : alerts
				})
			}
			if (msg == 'faile') {
				$.DialogByZ.Alert({
					Title : "提示",
					Content : "保存失败",
					BtnL : "确定",
					FunL : alerts
				})
			}
			if (msg=='修改预约成功！') {
				$('#appointToday').addClass('active in');
				$('#regNew').removeClass('active in');
				$('#myTab li').each(function(){
					if ($(this).hasClass('active')) {
						$(this).removeClass('active in');
					} else {
						$(this).addClass('active in');
					}
				});
				$.DialogByZ.Alert({
					Title : "提示",
					Content : "修改预约成功！",
					BtnL : "确定",
					FunL : alerts
				});
			}
			$('#msg').val('');
		}
		function alerts() {
			$.DialogByZ.Close();
		}

		function edit(data) {
			data = getdata(data);
			var url = 'register/dengji?url=petientAppoint&data=' + data;
			location.href = url;
		}

		function editApp(data, patient, date, time) {
			var isDelete = isBefore(date, time);
			if (isDelete) {
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
				var url = "appointment/editApp.do?data=" + data;
				location.href = url;
			} else {
				alert('预约时间小于当前时间，不可编辑');
			}
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