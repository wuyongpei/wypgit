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
<link href="static/fullRC/css/register.css" rel="stylesheet" />
<link rel="stylesheet" href="static/css/datepicker.css" />
<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/fullRC/js/pagePlugin.js"></script>
<script type="text/javascript" src="static/laydate/laydate.js"></script>
<style type="text/css">
body {
	overflow-x: hidden;
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

.input-sm2 {
	font-size: 14px;
	height: 35px !important;
}

.p09 {
	margin: 2%; ! important;
	border: 1px solid #ddd !important;
}

.text-nowrap {
	white-space: normal;
	word-break: hyphenate;
}

.btn-default {
	height: 35px;
}

.col-sm-6, .col-md-4, .col-lg-3 {
	display: inline-block !important;
	vertical-align: top;
	float: none;
	margin-left: -4px;
}
li{
cursor: pointer;
}
</style>

<script type="text/javascript">
	$(top.hangge());
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
</script>
</head>
<body>
	<div class="panel panel-default" style="border: none;">
		<div class="panel-heading head-panel">
			<div class="row">
				<div class="col-sm-12">
					<form action="sickPatient/registerlistPage.do"
						class="form-inline pull-left" method="post">
						<div class="form-group">
							<input id="time" type="text" size="35"
								class="form-control input-sm2 " placeholder="登记日期">
						</div>
						<div class="form-group">
							<input id="PatientName" value="${pd.PatientName }" name="PatientName" type="text"
								class="form-control input-sm2" placeholder="请输入姓名/手机号">
						</div>
						<input type="hidden" id="fromTime" name="fromTime"
							value="${pd.fromTime }"> <input type="hidden" id="toTime"
							name="toTime" value="${pd.toTime }">
						<div class="form-group">
							<a class="btn btn-default input-sm2" onclick="searchPatient();"> <i
								class="glyphicon glyphicon-search "></i></a>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<div class="row">
				<c:choose>
					<c:when test="${not empty sickList}">
						<div>
							<div class="row">
								<!-- 迭代起点 -->
								<c:forEach items="${sickList }" var="patient">
									<div class="col-sm-6 col-md-4 col-lg-3">
										<div class="panel p09">
											<div class="panel-heading">
												<div class="row">
													<div class="col-sm-4">
														<a href=""> <img alt="profile"
															src="static/images/male-avatar.png"
															class="img-sm img-border">
														</a>
													</div>
													<div class="col-sm-8 pl0">
														<h4>
															<a title="${patient.PatientName }" class="name-nowrap">${patient.PatientName }</a>
															<small class="media-span tooltips" data-toggle="tooltip"
																data-placement="bottom" data-original-title="23岁11月16天">（${patient.Sex }
																${patient.Age }岁）</small>
														</h4>
														<span>就诊卡类型 ：<c:if test="${patient.CardType==1 }">医/农保卡</c:if>
															<c:if test="${patient.CardType==0 }">就诊卡</c:if></span><br>
														<span class="text-nowrap">持卡卡号：${patient.CardCode }</span><br>
														<span class="text-nowrap">手机号码：${patient.MobileNO }</span><br>
														<span class="text-nowrap">身份证号：${patient.IDNumber }</span><br>
														<span class="text-nowrap">登记时间：${patient.CreateDateTime }</span>
													</div>
												</div>
											</div>
											<div class="panel-body text-center pt1">
												<ul class="photo-meta">
													<li><a onclick="edit('${patient}');">修改</a></li>
													<li><a onclick="del('${patient.PatientID }');">删除</a></li>
													<li><a onclick="view('${patient}');">查看</a></li>
												</ul>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
							<div id="buttons">
								<div class="base_page">
									<button
										onclick="nextPage('${page.currentPage -1}','${page.showCount}')"
										type="button" class="btn btn-default pull-left">
										<i class="glyphicon glyphicon-chevron-left"></i>
									</button>
									<button type="button"
										class="btn btn-default  base_page_info pull-left"
										disabled="disabled">${page.currentPage}/${page.totalPage}</button>
									<button
										onclick="nextPage('${page.currentPage +1}','${page.showCount}')"
										type="button" class="btn btn-default pull-left">
										<i class="glyphicon glyphicon-chevron-right"></i>
									</button>
									<input type="hidden" id="showCount" value="${page.showCount}"><input
										id="toGoPage" placeholder="页码" type="number"
										class="form-control  pull-left"
										style="width: 160px; height: 35px;" /> <a
										class="btn btn-default j_madule_page_search_submit pull-left ml5"
										type="button" onclick="toTZ();">Go</a>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="row text-center">
							<strong>暂无数据</strong>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			laydate.render({
				elem : '#time',
				range : true,
				type : 'datetime'
			});
			setTime();
			getTime();
		})

		function setTime() {
			var fromTime = $('#fromTime').val();
			var toTime = $('#toTime').val();
			if (fromTime != null && toTime != null && fromTime != ''
					&& toTime != '') {
				$('#time').val(fromTime + ' - ' + toTime);
			} else {
				$('#time').val('');
			}
		}
		
		//搜索函数
		function searchPatient() {
			getTime();
			$('form').submit();
		}

		function getTime() {
			var time = $('#time').val();
			if (time != null && time != '') {
				var times = time.split(' - ');
				 $('#fromTime').val(times[0]);
				 $('#toTime').val(times[1]);
				 $('#fromTime',parent.document).val(times[0]);
				 $('#toTime',parent.document).val(times[1]);
			} else {
				 $('#fromTime').val('');
				 $('#toTime').val('');
				 $('#fromTime',parent.document).val('');
				 $('#toTime',parent.document).val('');
			}
			$('#patientName',parent.document).val($('#PatientName').val());
		}

		//查看
		function view(data) {
			data = getdata(data);
			var url = 'sickPatient/view?data=' + data;
			parent.location.href = url;
		}

		//编辑
		function edit(data) {
			data = getdata(data);
			var json=$.parseJSON(data);
			parent.getdata(json);
			$("#regNew",parent.document).addClass('active in');
			$("#appointToday",parent.document).removeClass('active in');
			$("#regHistory",parent.document).removeClass('active in');
			$('#myTab li',parent.document).each(function (index) {
				if (index==0) {
					$(this).addClass('active');
				}else{
					$(this).removeClass('active');
				}
			})
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

		//删除
		function del(PatientID) {
			if (confirm('确认删除？')) {
				var url = "sickPatient/deletePatient.do?PatientID=" + PatientID;
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
	</script>
</body>
</html>