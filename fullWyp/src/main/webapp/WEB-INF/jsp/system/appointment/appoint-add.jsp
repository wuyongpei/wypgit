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
<%@include file="../../layouts/taglib.jsp"%>
<base href="<%=basePath%>">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/bootstrap/css/bootstrap-select.css" rel="stylesheet" />
<link href="static/fullRC/css/appoint-add.css" rel="stylesheet" />
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
<script type="text/javascript" src="static/laydate/laydate.js"></script>
<style type="text/css">
.btn-green {
	background-color: #41b2a6;
	border-color: #41b2a6;
	color: #fff;
}

.btn-green:hover {
	background-color: #2da094;
	border-color: #41b2a6;
	color: #fff;
}

#liItems li {
	list-style: none;
	padding: 10px 5px;
	cursor: pointer;
	display: list-item;
	text-align: -webkit-match-parent;
	font-size: 1.5rem;
	line-height: 1.6;
	color: rgb(51, 51, 51);
}

#liItems li:hover {
	background-color: #41b2a6;
}

.hidden {
	display: none;
}

.search-block {
	position: absolute;
	max-height: 600px;
	overflow-y: auto;
	background-color: #fff;
	border: 1px solid #ccc;
	box-shadow: #ececec 2px 2px 3px;
	border-radius: 0 0 5px 5px;
	z-index: 99;
}

.search-block::-webkit-scrollbar {
	width: 0px;
	opacity: 0;
	-webkit-overflow-scrolling: touch;
}
</style>
</head>
<body>
	<div>
		<div class="pageheader">
			<h4>
				<i class="glyphicon glyphicon-th"></i>&nbsp;&nbsp;预约
			</h4>
			<button onclick="javascript:history.go(-1);"
				class="btn btn-default breadcrumb-wrapper">返回</button>
		</div>

		<div class="contentpanel">
			<form action="${action }" id="appoint_Form" method="post">
				<input style="display: none" id="Appointment" value=${data }>
				<input style="display: none" id="view" value=${view }> <input
					style="display: none" id="Appointment_ID" name="Appointment_ID">
				<input style="display: none" id="AppointDay" name="AppointDay">
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-btns">
							<a href="javascript:refresh();" class="minimize">刷新</a>
						</div>
						<h5 class="panel-title">预约</h5>
					</div>

					<div class="panel-body">
						<div class="row">
							<div class="col-sm-9 col-md-10">
								<div class="row">
									<div class="col-sm-4 col-md-4">
										<div class="form-group pos-relative">
											<label class="control-label">患者姓名<span
												style="color: red">*</span></label>
											<div class="from-group input-group">
												<input id="PatientID" name="PatientID" style="display: none">
												<input id="PatientName" name="PatientName" type="text"
													class="form-control J-patient-name" autocomplete="off">
												<span class="input-group-btn">
													<button id="search" onclick="refleshPatient();"
														type="button" class="btn btn-default">
														<i class="glyphicon glyphicon-repeat"></i>
													</button>
												</span>
											</div>
										</div>
									</div>
									<div id="liItems"
										class="col-sm-4 form-group hidden search-block">
										<div
											style="padding: 10px; border-bottom: 1px solid; font-size: 1.5rem;">请选择</div>
										<ul></ul>
									</div>
									<div class="col-sm-2 col-md-2">
										<div class="form-group">
											<label class="control-label">出生年月<span
												style="color: red">*</span></label> <input id="Birthday"
												readonly="readonly" class="form-control"
												placeholder="____年__月__日" type="text">
										</div>
									</div>
									<div class="col-sm-2 col-md-2">
										<div class="form-group">
											<label class="control-label">年龄<span
												style="color: red">*</span></label> <input readonly="readonly"
												id="Age" class="form-control" placeholder="__岁" type="text">
										</div>
									</div>
									<div class="col-sm-4 col-md-4">
										<div class="form-group">
											<label class="control-label">性别<span
												style="color: red">*</span></label>
											<div class="row mt10">
												<div class="col-xs-3 col-sm-4 col-pad-sm">
													<div class="rdio rdio-default">
														<input class="" type="radio" disabled="disabled"
															name="sex" id="radioDefault0" value="男"><label
															for="radioDefault0">男</label>
													</div>
												</div>
												<div class="col-xs-3 col-sm-4 col-pad-sm">
													<div class="rdio rdio-default">
														<input disabled="disabled" class="" type="radio"
															name="sex" id="" value="女"><label>女</label>
													</div>
												</div>
												<div class="col-xs-3 col-sm-4 col-pad-sm">
													<div class="rdio rdio-default">
														<input disabled="disabled" class="" type="radio"
															name="sex" id="" value="不详"><label>不详</label>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-4 col-md-4">
										<div class="form-group">
											<label class="control-label">手机号<span
												style="color: red">*</span></label> <input id="MobileNO"
												readonly="readonly" type="text" value=""
												class="form-control">
										</div>
									</div>
									<div class="col-sm-4 col-md-4">
										<div class="form-group">
											<label class="control-label">微信号</label> <input id="WeChatNo"
												readonly="readonly" type="text" value=""
												class="form-control">
										</div>
									</div>
									<div class="col-sm-4 col-md-4">
										<div class="form-group">
											<label class="control-label">身份证号</label> <input
												id="IDNumber" readonly="readonly" type="text" value=""
												class="form-control">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-4">
										<div class="form-group">
											<label class="control-label">职业</label> <input
												id="Profession" readonly="readonly" class="form-control">
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label class="control-label">婚姻状况</label> <input
												id="MarriageState" readonly="readonly" class="form-control">
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label class="control-label">民族</label> <input
												class="form-control" id="Nation" readonly="readonly">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-4 col-md-4">
										<div class="form-group">
											<label class="control-label">工作单位</label> <input
												readonly="readonly" id="Company" type="text" value=""
												class="form-control">
										</div>
									</div>
									<div class="col-sm-2 col-md-2">
										<div class="form-group">
											<label class="control-label">住址</label> <input
												readonly="readonly" class="form-control" id="provice">
										</div>
									</div>
									<div class="col-sm-2 col-md-2">
										<div class="form-group">
											<label class="control-label">&nbsp;&nbsp;</label> <input
												readonly="readonly" class="form-control" id="country">
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label class="control-label">&nbsp;&nbsp;</label> <input
												readonly="readonly" type="text" id="city"
												class="form-control">
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-sm-4 col-md-4">
										<div class="form-group">
											<label class="control-label">预约科室<span
												style="color: red;">*</span></label> <select required="required"
												id="OfficeID" class="form-control" name="OfficeID">
												<option value="">请选择</option>
												<c:forEach items="${pdofList}" var="pof">
													<option value="${pof.OfficeID}">${pof.OfficeName}</option>
												</c:forEach>
											</select> <input id="OfficeName" name="OfficeName"
												style="display: none" autocomplete="off">
										</div>
									</div>
									<div class="col-sm-4 col-md-4">
										<div class="form-group">
											<label class="control-label">预约日期<span
												style="color: red;">*</span></label> <input required="required"
												id="Appointment_Date" name="Appointment_Date"
												data-date-format="yyyy-mm-dd" class="form-control"
												autocomplete="off">
										</div>
									</div>
									<div class="col-sm-4 col-md-4">
										<div class="form-group">
											<label class="control-label">预约类型<span
												style="color: red;">*</span></label> <select required="required"
												id="Appointment_Type" class="form-control"
												autocomplete="off" name="Appointment_Type">
												<option value="">请选择</option>
												<c:forEach items="${appointment}" var="appoint">
													<option value="${appoint.DictionaryCode}">${appoint.DictionaryName}</option>
												</c:forEach>
											</select>
										</div>
									</div>

								</div>

								<div class="row">
									<div class="col-sm-4 col-md-4">
										<div class="form-group">
											<label class="control-label">医生类型<span
												style="color: red;">*</span></label> <select required="required"
												id="Doctor_Type" class="form-control" name="Doctor_Type"
												autocomplete="off">
												<option value="">请选择</option>
												<option value="1">专家</option>
												<option value="2">普通</option>
											</select>
										</div>
									</div>

									<div class="col-sm-4 col-md-4">
										<div class="form-group">
											<label class="control-label">预约医生<span
												style="color: red;">*</span></label> <select required="required"
												id="Emp_ID" class="form-control" name="Emp_ID">
												<option value="">请选择</option>
											</select> <input id="E_Name" name="E_Name" style="display: none">
										</div>
									</div>

									<div class="col-sm-4 col-md-4">
										<div class="form-group">
											<label class="control-label">预约时间<span
												style="color: red;">*</span></label> <select required="required"
												id="Appointment_Time" name="Appointment_Time"
												autocomplete="off" class="form-control">
												<option value="" selected="selected">请选择</option>
											</select>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-sm-7 col-md-7">
										<div class="form-group">
											<label class="control-label">预约内容</label> <input
												id="Appointment_Con" name="Appointment_Con"
												autocomplete="off" class="form-control" type="text">
										</div>
									</div>
									<div class="col-sm-5 col-md-5">
										<div class="form-group">
											<label class="control-label">预约来源</label> <select
												id="Appointment_Come" class="form-control"
												name="Appointment_Come">
												<option value="">请选择</option>
												<option value="1">微信预约</option>
												<option value="2" selected="selected">平台预约</option>
												<option value="3">电话预约</option>
											</select>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12 col-md-12">
										<div class="form-group">
											<label class="control-label">备注</label> <input type="text"
												autocomplete="off" name="Comment" id="Comment" value=""
												class="form-control">
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-3 col-md-2">
								<div class="form-group" id="crop-avatar">
									<div class="J_image_upload mr0">
										<div class="image-select J_image_select avatar-view">
											<div class="image-preview">
												<img src="static/images/user-t.png" alt="" width="100%">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 提交内容 -->
						<div class="panel-footer panel-btn-col2">
							<button type="button" onclick="save();" class="btn btn-green mr5">保存</button>
							<a class="btn btn-default" href="">取消</a>
						</div>
					</div>
					<input type="hidden" id="url" name="url" value="${pd.url }">
					<input type="hidden" id="patient" name="patient" value="${pd.patient }">
			</form>
		</div>




	</div>


	<script type="text/javascript">
		function refresh() {
			window.location.reload();
		}

		function goListPage() {
			var url = "appointment/yuyue.do";
			location.href = url;
		}

		$(function() {
			var officeC = false;
			var dateC = false;
			$("#OfficeID").change(function() {
				officeC = true;
				var result = getEmp(officeC, dateC);
				officeC = result[0];
				dateC = result[1];
			});
			$('#Appointment_Date').change(function() {
				dateC = true;
				var result = getEmp(officeC, dateC);
				officeC = result[0];
				dateC = result[1];
			});
			$('#Doctor_Type').change(function() {
				if ($(this).val() != '') {
					dateC = true;
					getEmp(officeC, dateC);
				}
			});
			$('#PatientName').bind({
				'input propertychange ' : getOptions,
				click : liControl,
				blur : function() {
					$("#liItems").slideUp();
				}
			});
			$("#Emp_ID").change(getDuty);
			setApp($('#Appointment').val(), true);
			if ($('#Appointment_ID').val()!='') {
				$('#search').prop('disabled', 'disabled');
			}
		})

		function setApp(app, change) {
			if (app != '') {
				var json = JSON.parse(app);
				setPatient(json);
				if (change) {
					$('#Appointment_Date').change();
					$('#Emp_ID').val(json['Emp_ID']);
					var time = json['Appointment_Time'].substring(0, 5);
					getTimes(time);
					$('#Appointment_Time').val(time);
				}
				if ($('#view').val() == 'view') {
					$('form :input').prop('disabled', 'disabled');
					$('form a').removeAttr('href').removeAttr('onclick');
				}
			}
		}

		function setPatient(json) {
			for ( var key in json) {
				$('#' + key).val(json[key]);
			}
			getAddress(json['Address']);
			$("input[name='sex']").each(function() {
				var sex = json['Sex'];
				if ($(this).val() == sex) {
					$(this).prop("checked", "checked");
					return false;
				}
			});
			$('#PatientName').attr('readonly', 'readonly');
		}

		function refleshPatient() {
			if ($('#PatientName').val() != '') {
				$('#PatientName').removeAttr('readonly');
				$('#PatientName').val('');
				getOptions();
				$('#Birthday').val('');
				$('#Age').val('');
				$('#MobileNO').val('');
				$('#WeChatNo').val('');
				$('#IDNumber').val('');
				$('#Profession').val('');
				$('#MarriageState').val('');
				$('#Nation').val('');
				$('#Company').val('');
				$('#provice').val('');
				$('#country').val('');
				$('#city').val('');
			}
		}

		function save() {
			ifSubmit = true;
			$('form').find('[required="required"]').each(function() {
				if ($(this).val() == '' || $(this).val() == null) {
					$(this).tips({
						side : 3,
						msg : '这是必填字段',
						bg : '#AE81FF',
						time : 2
					});

					if (ifSubmit) {
						$(this).focus();
						ifSubmit = false;
					}
				}
			});
			if (ifSubmit) {
				if (confirm("确认保存")) {
					$("#OfficeName").val(
							$("#OfficeID").find('option:selected').text());
					$("#E_Name").val(
							$("#Emp_ID").find('option:selected').text());
					var date = new Date($('#Appointment_Date').val());
					$('#AppointDay').val(date.getDay());
					$('form').submit();
				}
			}
		}

		function getDuty() {
			var duty = $(this).find('option:selected').attr('data-duty');
			var type = $("#Emp_ID").find('option:selected').attr('data-type');
			if (type != '' && typeof (type) != 'undefined') {
				$('#Doctor_Type option').each(function() {
					if ($(this).text() == type) {
						$(this).prop('selected', true);
						return false;
					}

				})
			} else {
				$('#Doctor_Type option:first').prop('selected', true);
			}
			getTimes();
		}

		function getEmp(officeC, dateC) {
			$("#Appointment_Time option[value!='']").remove();
			if ($("#OfficeID").val() == ''
					|| $('#Appointment_Date').val() == '') {
				$("#Emp_ID option").remove();
				$("#Emp_ID").append('<option value="">请选择</option>');
			} else if ((officeC || dateC) && $("#OfficeID").val() != ''
					&& $('#Appointment_Date').val() != '') {
				$
						.ajax({
							url : 'emp/getEmpBydate.do',
							data : {
								officeID : $("#OfficeID").val(),
								date : $('#Appointment_Date').val(),
								type : $('#Doctor_Type').val()
							},
							async : false,
							success : function(result) {
								dateC = false;
								officeC = false;
								$("#Emp_ID option").remove();
								$("#Emp_ID").append(
										'<option value="">请选择</option>');
								var emps = new Object();
								emps = result;
								if (emps != '') {
									for (var i = 0; i < emps.length; i++) {
										emp = emps[i];
										$("#Emp_ID")
												.append(
														'<option value='+emp.Emp_ID+' data-duty='+emp.Duty_ID+' data-type='+emp.Doctor_Type+'>'
																+ emp.E_Name
																+ '</option>');
									}
								}

							}
						})
			}
			var result = new Array();
			result[0] = officeC;
			result[1] = dateC;
			return result;
		}

		function getOptions(isShow) {
			$("#liItems li").remove();
			var PatientName = $('#PatientName').val();
			if (PatientName != '') {
				$.post("sickPatient/getPatientByName.do", {
					PatientName : PatientName
				}, function(result) {
					var patients = new Object();
					patients = result;
					if (patients != '') {
						for (var i = 0; i < patients.length; i++) {
							$("#liItems>ul").append(
									'<li onclick="getLiValue(this);" data-id='
											+ patients[i].PatientID
											+ ' title='
											+ patients[i].PatientName
											+ ' value='
											+ JSON.stringify(patients[i])
													.toString() + '>'
											+ patients[i].PatientName
											+ "&nbsp;" + patients[i].Sex
											+ "&nbsp;" + patients[i].Age
											+ "<br/>" + patients[i].MobileNO
											+ "</option>");
						}
						if (isShow) {
							liControl();
						}
					}
				})
			} else {
				$("#liItems").slideUp();
			}

		}

		function liControl() {
			if ($("#liItems li").size() > 0) {
				$("#liItems").removeClass('hidden');
				$("#liItems").slideDown();
				$('#liItems').css("top", $('#PatientName').position().top + 57);
				$('#liItems').css("left",
						$('#PatientName').position().left + 15);
				$('#liItems').css("width", $('#PatientName').outerWidth());
			} else {
				$("#liItems").slideUp();
			}
		}

		function getLiValue(thi) {
			$('#PatientName').val($(thi).attr("title"));
			$('#PatientID').val($(thi).attr("data-id"));
			$('#PatientName').attr('readonly', 'readonly');
			getOptions(false);
			setApp($(thi).attr('value'))
		}

		function getAddress(address) {
			if (address != "") {
				var city = new Array();
				if (city != '') {
					city = address.split('|');
					var length = city.length;
					if (length > 0) {
						$("#provice").val(city[0])
						if (length > 1) {
							$("#country").val(city[1])
						}
						if (length > 2) {
							$("#city").val(city[2]);
						}
					}
				}
			}
		}

		function getTimes(time) {
			url = 'appointment/getTimes?Appointment_Date='
					+ $("#Appointment_Date").val() + '&Emp_ID='
					+ $("#Emp_ID").val();
			$
					.get(
							url,
							function(data) {
								$('#Appointment_Time').empty();
								if (data != '') {
									$('#Appointment_Time')
											.append(
													'<option value="" selected="selected">请选择</option>');
									var appointDate = new Date($(
											'#Appointment_Date').val()
											+ ' 00:00:00');
									var list = new Array();
									list = data;
									if (appointDate < new Date()) {
										for (var i = 0; i < list.length; i++) {
											var appointTime = list[i];
											var appointDate1 = new Date($(
													'#Appointment_Date').val()
													+ ' ' + appointTime + ':00');
											if (appointDate1 > new Date()) {
												$('#Appointment_Time').append(
														'<option value="'+list[i]+'">'
																+ list[i]
																+ '</option>');
											}
										}
									} else {
										for (var i = 0; i < list.length; i++) {
											$('#Appointment_Time').append(
													'<option value="'+list[i]+'">'
															+ list[i]
															+ '</option>');
										}
									}
								}
								if (typeof (time) != 'undefined' && time != '') {
									$('#Appointment_Time').append(
											'<option selected="selected" value="'+time+'">'
													+ time + '</option>');
								}
							})
		}

		$('#Appointment_Date').datepicker({
			todayBtn : "linked",
			autoclose : true,
			todayHighlight : true,
			startDate : new Date((new Date()).getTime() - 86400000)
		})
	</script>



</body>

</html>