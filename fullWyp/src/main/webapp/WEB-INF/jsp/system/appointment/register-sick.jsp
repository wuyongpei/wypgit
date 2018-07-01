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
<%@include file="../../layouts/taglib.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/fullRC/css/register.css" rel="stylesheet" />
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

<link rel="stylesheet" href="static/fullRC/css/zdialog.css" />
<script src="static/fullRC/js/zdialog.js"></script>

<style type="text/css">
#liItems li, #liList li {
	list-style: none;
	padding: 5px 5px 5px 20px;
	cursor: pointer;
	display: list-item;
	text-align: -webkit-match-parent;
	font-size: 1.5rem;
	line-height: 1.6;
	color: rgb(51, 51, 51);
}

#liItems li:hover, #liList li:hover {
	background-color: #41b2a6;
}

#liItems, #liList {
	max-height: 400px;
	overflow-y: scroll;
	z-index: 1088;
}

.panel-default {
	border-color: #fff !important;
}

.panel-heading span {
	font-size: 12px !important;
	color: #808080 !important;
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

.input-sm2 {
	font-size: 12px;
	height: 30px !important;
}

.p09 {
	margin: 2%; ! important;
	border: 1px solid #ddd !important;
}

.text-nowrap {
	word-wrap: break-word;
	white-space: normal;
}
</style>
</head>
<body style="height: 100%;">
	<div>
		<ul id="myTab" class="nav nav-tabs">
			<li class="active"><a href="#regNew" data-toggle="tab"> 新增登记
			</a></li>
			<li><a href="#appointToday" data-toggle="tab">今日预约</a></li>
			<li><a href="#regHistory" data-toggle="tab">登记记录</a></li>
		</ul>

		<div class="tab-content tab-div">
			<!--登记操作 -->
			<div class="tab-pane active" id="regNew"
				style="overflow: hidden; min-height: 539px;">
				<form action="${action }" data-type="3" method="post">
				<input type="hidden" value="${pd.url }" id="url" name="url">
					<input style="min-height: 600px;" type="hidden" id="fromTime"
						name="fromTime"> <input type="hidden" id="toTime"
						name="toTime"> <input type="hidden" id="patientName"
						name="patientName"> <input id="PatientID" name="PatientID"
						style="display: none"> <input id="Sex" name="Sex"
						style="display: none"> <input id="Address" name="Address"
						style="display: none"><input id="NameSpell"
						name="NameSpell" style="display: none"><input id="msg"
						value="${msg }" style="display: none">
						<input id="CreateDateTime" name="CreateDateTime"
						value="${msg }" style="display: none">
					<div class="panel panel-default">
						<div class="container title-div">
							<div class="col-sm-2 col-md-2">
								<h3 style="padding-left: 0px;">患者信息</h3>
							</div>
							<div class="col-sm-10 col-md-10 pull-right">
								<div class="input-group input-group-md pull-right"
									style="width: 28%; padding: 1%;">
									<input id="cardCode" type="text" class="form-control"
										placeholder="请输入病人卡号或者手机号"> <span
										class="input-group-btn">
										<button id="searchCode" class="btn btn-default" type="button">
											<i class="glyphicon glyphicon-search"></i>
										</button>
									</span>
								</div>
								<div id="liList" class="form-group hidden search-block">
									<ul></ul>
								</div>
							</div>
						</div>

						<div class="container form-div">
							<div class="row">
								<div class="col-sm-9 col-md-10">
									<div class="row">

										<div class="col-sm-3">
											<div class="form-group">
												<label class="control-label"> 患者姓名<span
													style="color: red;">*</span>
												</label>
												<div class="input-group">
													<input id="PatientName" name="PatientName" type="text"
														class="form-control" required="required"
														autocomplete="off"> <span class="input-group-btn">
														<button id="search" onclick="liControl();"
															class="btn btn-default" type="button">
															<i class="glyphicon glyphicon-search"></i>
														</button>
													</span>
												</div>
											</div>
										</div>
										<div id="liItems" class="form-group hidden search-block">
											<div
												style="padding: 10px; border-bottom: 1px solid; font-size: 1.5rem;">请选择或者继续新增</div>
											<ul></ul>
										</div>


										<div class="col-sm-2 col-md-2">
											<div class="form-group">
												<label class="control-label"> 出生年月<span
													style="color: red;">*</span>
												</label>
												<div class="input-group">
													<input id="Birthday" name="Birthday" type="text"
														class="form-control date-picker"
														data-date-format="yyyy-mm-dd" placeholder="__年__月__日"
														required="required" autocomplete="off">
												</div>
											</div>
										</div>

										<div class="col-sm-2 col-md-2">
											<div class="form-group">
												<label class="control-label"> 年龄<span
													style="color: red;">*</span>
												</label>
												<div class="input-group">
													<input id="Age" name="Age" type="text" class="form-control"
														placeholder="__岁" required="required" readonly="readonly"
														autocomplete="off">
												</div>
											</div>
										</div>

										<div class="col-sm-4 col-md-4">
											<div class="form-group">
												<label class="control-label"> 性别<span
													style="color: red;">*</span>
												</label>
												<div class="radio">
													<label class="radio-inline radio-j"> <input
														checked="checked" type="radio" name="optionsRadios"
														value="男"> 男
													</label> <label class="radio-inline radio-j"> <input
														type="radio" name="optionsRadios" value="女">女
													</label> <label class="radio-inline"> <input type="radio"
														name="optionsRadios" value="不详">不详
													</label>
												</div>

											</div>
										</div>
									</div>

									<div class="row">

										<div class="col-sm-3">
											<div class="form-group">
												<label class="control-label"> 手机号<span
													style="color: red;">*</span>
												</label>
												<div class="form-group">
													<input id="MobileNO" name="MobileNO" type="text"
														required="required" class="form-control"
														autocomplete="off">
												</div>
											</div>
										</div>

										<div class="col-sm-2 col-md-2">
											<div class="form-group">
												<label class="control-label">住址</label>
												<div class="form-group">
													<select id="provice" class="form-control">
														<option value="">请选择</option>
														<c:forEach items="${provice}" var="pro" varStatus="status">
															<option value="${pro.ID}">${pro.CName}</option>
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
										<div class="col-sm-2 col-md-2">
											<div class="form-group">
												<label class="control-label">&nbsp;</label>
												<div class="form-group">
													<select id="country" class="form-control">

													</select>
												</div>
											</div>
										</div>

										<div class="col-sm-4">
											<div class="form-group">
												<label class="control-label">&nbsp;</label>
												<div class="form-group">
													<input id="city" type="text" class="form-control"
														autocomplete="off">
												</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-sm-3">
											<div class="form-group">
												<label class="control-label"> 病人卡号 <span
													style="color: red;">*</span></label>
												<div class="form-group">
													<input id="CardCode" name="CardCode" type="text"
														required="required" class="form-control"
														autocomplete="off">
												</div>
											</div>
										</div>


										<div class="col-sm-2 col-md-2">
											<div class="form-group">
												<label class="control-label">持卡类型</label>
												<div class="form-group">
													<select id="CardType" name="CardType" class="form-control">
														<option value="0">就诊卡</option>
														<option value="1">医/农保卡</option>
													</select>
												</div>
											</div>
										</div>

										<div class="col-sm-2 col-md-2">
											<div class="form-group">
												<label class="control-label">民族</span></label>
												<div class="form-group">
													<select id="Nation" name="Nation" class="form-control">
														<option value="">请选择</option>
														<c:forEach items="${nation }" var="na">
															<option value="${na.DictionaryName }">${na.DictionaryName }</option>
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
										<div class="col-sm-4">
											<div class="form-group">
												<label class="control-label">身份证号码</label>
												<div class="form-group">
													<input id="IDNumber" name="IDNumber" type="text"
														class="form-control" autocomplete="off">
												</div>
											</div>
										</div>
									</div>


									<!-- 隐藏下拉面板 -->
									<div class="row">
										<div class="panel-heading">
											<a data-toggle="collapse" class="text-color"
												href="#moreDetail">
												<h4 class="panel-title green pull-left">更多信息</h4> <i
												class="glyphicon glyphicon-chevron-down" id="xiala"></i>
											</a>
										</div>
									</div>

									<div class="row">
										<div id="moreDetail" class="panel-collapse collapse">
											<div class="panel-body">
												<div class="row">
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label">医/农保卡号</label>
															<div class="form-group">
																<input id="MN_CardNO" name="MN_CardNO" type="text"
																	class="form-control" autocomplete="off">
															</div>
														</div>
													</div>

													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label">医疗证号</label>
															<div class="form-group">
																<input id="InsuranceNO" name="InsuranceNO" type="text"
																	class="form-control" autocomplete="off">
															</div>
														</div>
													</div>
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label">邮箱</span></label>
															<div class="form-group">
																<input id="Email" name="Email" type="text"
																	class="form-control" autocomplete="off">
															</div>
														</div>
													</div>

													<div class="col-sm-2 col-md-2">
														<div class="form-group">
															<label class="control-label">邮编</label>
															<div class="form-group">
																<input id="Zip" name="Zip" type="text"
																	class="form-control" autocomplete="off">
															</div>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label">工作单位</label>
															<div class="form-group">
																<input id="Company" name="Company" type="text"
																	class="form-control" autocomplete="off">
															</div>
														</div>
													</div>
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label">职业</label>
															<div class="form-group">
																<select id="Profession" class="form-control"
																	name="Profession">
																	<option value="">请选择</option>
																	<c:forEach items="${occupation }" var="occupa">
																		<option value="${occupa.DictionaryName }">${occupa.DictionaryName }</option>
																	</c:forEach>
																</select>
															</div>
														</div>
													</div>
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label">微信号</label>
															<div class="form-group">
																<input id="WeChatNo" name="WeChatNo" type="text"
																	class="form-control" autocomplete="off">
															</div>
														</div>
													</div>
													<div class="col-sm-2 col-md-2">
														<div class="form-group">
															<label class="control-label">婚姻状况</label>
															<div class="form-group">
																<select id="MarriageState" class="form-control"
																	name="MarriageState">
																	<option value="">请选择</option>
																	<c:forEach items="${marriagestate }" var="marriage">
																		<option value="${marriage.DictionaryName }">${marriage.DictionaryName }</option>
																	</c:forEach>
																</select>
															</div>
														</div>
													</div>
													<div class="col-sm-11">
														<div class="form-group">
															<label class="control-label">备注</label>
															<div class="form-group">
																<input id="Comment" type="text" class="form-control"
																	name="Comment" autocomplete="off">
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>

									<!-- 隐藏第二段 -->
									<div class="row">
										<div class="panel-heading">
											<a data-toggle="collapse" class="text-color"
												href="#morelinkDetail">
												<h4 class="panel-title green pull-left">添加联系人</h4> <i
												class="glyphicon glyphicon-chevron-down" id="xiala"></i>
											</a>
										</div>
									</div>

									<div class="row">
										<div id="morelinkDetail" class="panel-collapse collapse">
											<div class="panel-body">
												<div class="row">
													<div class="col-sm-2 col-md-2">
														<div class="form-group">
															<label class="control-label">联系人关系</label>
															<div class="form-group">
																<select id="LinkmanRelation" class="form-control"
																	name="LinkmanRelation">
																	<option value="">请选择</option>
																	<c:forEach items="${relationship }" var="relation">
																		<option value="${relation.DictionaryName }">${relation.DictionaryName }</option>
																	</c:forEach>
																</select>
															</div>
														</div>
													</div>

													<div class="col-sm-2 col-md-2">
														<div class="form-group">
															<label class="control-label">联系人名字</label>
															<div class="form-group">
																<input id="Linkman" type="text" class="form-control"
																	name="Linkman" autocomplete="off">
															</div>
														</div>
													</div>
													<div class="col-sm-2 col-md-2">
														<div class="form-group">
															<label class="control-label">联系人电话</label>
															<div class="form-group">
																<input id="LinkmanPhone" type="text"
																	class="form-control" name="LinkmanPhone"
																	autocomplete="off">
															</div>
														</div>
													</div>

													<div class="col-sm-5">
														<div class="form-group">
															<label class="control-label">联系人地址</label>
															<div class="form-group">
																<input id="LinkmanAddress" type="text"
																	class="form-control" name="LinkmanAddress"
																	autocomplete="off">
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>


								</div>
								<div class="col-sm-3 col-md-2 img-div">
									<div class="form-group">
										<div class="image-preview">
											<img src="static/images/user-t.png" width="100%;">
										</div>
										<div class="image-upload">
											<input type="file" name="file" id="f-image-upload"
												style="display: none;"> <a
												class="btn btn-default btn-sm" onclick="getfiles();">
												上传头像 </a>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
					<div class="container form-div">
						<div class="row">
							<button id="save" class="btn btn-green btn-b">完成登记</button>
						</div>
					</div>
				</form>


			</div>
			<!-- 登记操作 -->

			<!-- 今日预约 -->
			<div class="tab-pane fade" id="appointToday">
				<iframe id="ifr-set" scrolling="auto" frameborder="0" width="100%"
					src="appointment/appointToday.do"></iframe>
			</div>
			<!-- 今日预约 -->

			<!-- 当日登记记录 -->
			<div class="tab-pane fade" id="regHistory" style="overflow: hidden;">
				<c:choose>
					<c:when
						test="${!empty pd.fromTime && pd.fromTime!=''&&!empty pd.fromTime && pd.fromTime!=''&&!empty pd.patientName }">
						<iframe id="ifr-set" scrolling="auto" frameborder="0" width="100%"
							src="sickPatient/registerlistPage.do?fromTime=${pd.fromTime}&toTime=${pd.toTime}&PatientName=${pd.patientName}"></iframe>
					</c:when>
					<c:when
						test="${!empty pd.fromTime && pd.fromTime!=''&&!empty pd.fromTime && pd.fromTime!=''}">
						<iframe id="ifr-set" scrolling="auto" frameborder="0" width="100%"
							src="sickPatient/registerlistPage.do?fromTime=${pd.fromTime}&toTime=${pd.toTime}"></iframe>
					</c:when>
					<c:when test="${!empty pd.patientName }">
						<iframe id="ifr-set" scrolling="auto" frameborder="0" width="100%"
							src="sickPatient/registerlistPage.do?PatientName=${pd.patientName}"></iframe>
					</c:when>
					<c:otherwise>
						<iframe id="ifr-set" scrolling="auto" frameborder="0" width="100%"
							src="sickPatient/registerlistPage.do"></iframe>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- 当日登记记录 -->
		</div>

	</div>







	<script type="text/javascript">
		$(top.hangge());
		var nameBlur="no";
		var searchBlur="no";
		$(function() {
			var ifSearch=false;
			getdata(${pd.data});
			tip();
			$('.date-picker').datepicker();
			$('#PatientName').bind({
				'input propertychange' : getOptions,
				click:liControl
			});
			$('#PatientName,#search').bind({
				mouseover:function(){
					if ($(this).attr('id')=='PatientName') {
						nameBlur="yes";
					} else {
						searchBlur='yes';
					}
				},
				mouseout:function(){
					if ($(this).attr('id')=='PatientName') {
						nameBlur="no";
					} else {
						searchBlur='no';
					}
				},
				blur:function(){
					if (nameBlur=='no'&&searchBlur=='no') {
					$('#liItems').slideUp();
					}
				}
			})
			$('#Birthday').change(getAge);
			$('#Age').click(function () {
				$(this).tips({
					side : 3,
					msg : '请先选择出生日期',
					bg : '#AE81FF',
					time : 2
				});
			})
			$("#provice").change(getCountry);
			$("#save").click(save);
			$("iframe").css("height",$(window).height()-7-$("#myTab").height());
			$(window).resize(function() { 
				$("#myTabContent *").css("height",$(window).height()-7-$("#myTab").height());
				liControl();
				listControl();
			   });
			$('#cardCode').change(function () {
				ifSearch=true;
			})
			$('#searchCode').click(function () {
				if (ifSearch) {
					getByPhoneOrCard();
				}else{
					listControl();
				}
				ifSearch=false;
			}).blur(function () {
				$("#liList").slideUp();
			});
		});
		
		function tip() {
			if ($("#msg").val() == 'success') {
				$.DialogByZ.Alert({
					Title : "提示",
					Content : "保存成功",
					BtnL : "确定",
					FunL : alerts
				})
			};
			if ($("#msg").val() == 'faile') {
				$.DialogByZ.Alert({
					Title : "提示",
					Content : "保存失败",
					BtnL : "确定",
					FunL : alerts
				})
			};
		}
		
		function getdata(data) {
			if (data != '') {
				for ( var key in data) {
					$('#' + key).val(data[key]);
				}
				getAddress($("#Address").val());
				$("input[name='optionsRadios']").each(function() {
					if ($(this).val() == $("#Sex").val()) {
						$(this).prop("checked", "checked");
						return false;
					}
				});
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
				if (confirm("保存确认")) {
					$("input[name='optionsRadios']").each(function() {
						if ($(this).prop("checked") == true) {
							$("#Sex").val($(this).val());
							return false;
						}
					});
					getPinYin();
					var provice = $("#provice").find("option:selected").text();
					provice = provice == '请选择' ? '' : provice;
					if (provice!='') {
						$("#Address").val(
								provice +'|'+ $("#country").val() +'|'+ $("#city").val());
					} else {
						$("#Address").val('');
					}
					
					$('form').submit();
				}
			} else {
				return false;
			}
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
									'<li onclick="getLiValue(this,true);" title='
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

		function getLiValue(thi,ifName) {
			if (ifName) {
			$('#PatientName').val($(thi).attr("title"));
			}else{
				$("#liList").slideUp();
			}
			var json = JSON.parse($(thi).attr('value'));
			for ( var key in json) {
				$('#' + key).val(json[key]);
			}
			getAddress($("#Address").val());
			$("input[name='optionsRadios']").each(function() {
				if ($(this).val() == $("#Sex").val()) {
					$(this).prop("checked", "checked");
					return false;
				}
			});
			getOptions(false);
		}

		function getAddress(address) {
			if (address!="") {
			var city = new Array();
			city=address.split('|');
			var length=city.length;
			if (length>0) {
			$("#provice option[value!='']").each(function() {
				if ($(this).get(0).innerText == city[0]) {
					$("#provice").val($(this).attr('value'))
					return false;
				}
			});
			if (length>1) {
			getCountry(city[1]);
			}else{
				getCountry();
			}
			if (length>2) {
			$("#city").val(city[2]);
				}
			}
			}
		}

		function getCountry(coun) {
			var provice = $("#provice").val();
			$("#country option").remove();
			$.post('zone/getCity.do', {
				parentID : provice
			}, function(result) {
				var countrys = new Object();
				countrys = result;
				if (countrys != '') {
					$("#country").append('<option selected="selected" value="">请选择 </option>');
					for (var i = 0; i < countrys.length; i++) {
						country = countrys[i];
						$("#country").append(
								'<option value='+country.CName+'>'
										+ country.CName + '</option>');
					}
				}
				if (coun != '') {
					$('#country').val(coun);
				}
			})
		}

		/*汉字转拼音*/
		function getPinYin() {
			var pname = $("#PatientName").val();
			var pn = pinyinUtil.getFirstLetter(pname, false);
			$("#NameSpell").val(pn);
		}
		
		function getAge () {
            var date = new Date();
            var birthday = $("#Birthday").val();
            var startDate = new Date(birthday);
            var newDate = date.getTime() - startDate.getTime();
            var age = Math.ceil(newDate/(1000*60*60*24*365));
            if (isNaN(age)){
                age = "";
            }
            $("#Age").val(age);
        }

		function getfiles() {
			$("#f-image-upload").click();

		}

		function alerts() {
			$.DialogByZ.Close();
			$("#msg").val('');
		}
		
		function getByPhoneOrCard() {
			$("#liList>ul").empty();
			var cardCode=$('#cardCode').val();
			if (cardCode!='') {
			var url='sickPatient/getByPhoneOrCard.do?cardCode='+cardCode;
			$.get(url,function(result){
				var patientList=result;
				if (patientList!=null&&patientList.length>0) {
					if (patientList.length==1) {
						var patient=patientList[0];
						for (var key in patient) {
							$('#' + key).val(patient[key]);
						}
					} else {
						for (var i = 0; i < patientList.length; i++) {
							var patient=patientList[i];
							$("#liList>ul").append(
									'<li style="padding-left:20px;" onclick="getLiValue(this,false);" title='
											+ patient.PatientName
											+ ' value='
											+ JSON.stringify(patient)
													.toString() + '>'
											+ patient.PatientName
											+ "&nbsp;&nbsp;" + patient.Sex
											+ "&nbsp;&nbsp;" + patient.Age
											+ "<br/>" + patient.MobileNO
											+ "</option>");
						}
						listControl();
					}
				}
			})
			}
		}
		
		function listControl() {
			if ($("#liList li").size() > 0) {
				$("#liList").removeClass('hidden');
				$("#liList").slideDown();
				$('#liList').css("top", $('#cardCode').position().top+34);
				$('#liList').css("right",
						$('#cardCode').position().left+55);
				$('#liList').css("width", $('#cardCode').outerWidth());
			} else {
				$("#liList").slideUp();
			}
		}
	</script>



</body>





</html>