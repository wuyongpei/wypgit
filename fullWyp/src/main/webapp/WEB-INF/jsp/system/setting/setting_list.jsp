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
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/fullRC/css/register.css" rel="stylesheet" />
<link href="static/fullRC/css/icon/iconfont.css" rel="stylesheet" />
<link rel="stylesheet" href="static/css/font-awesome.min.css" />
<link rel="stylesheet" href="static/css/ace.min.css" />
<link href="static/bootstrap/css/bootstrap-select.css" rel="stylesheet" />
<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="static/fullRC/js/pinyin_dict_withtone.js"></script>
<script type="text/javascript" src="static/fullRC/js/pinyinUtil.js"></script>
<script type="text/javascript" src="static/fullRC/js/jquery.form.js"></script>
<script type="text/javascript" src="static/fullRC/js/iconfont.js"></script>
<script type="text/javascript"
	src="static/bootstrap/js/bootstrap-select.js"></script>
<%@include file="../../layouts/taglib.jsp"%>
<style type="text/css">
body {
	/*  字体  */
	font-family: -apple-system, BlinkMacSystemFont, 'Microsoft YaHei',
		sans-serif;
	/*  字号 */
	font-size: 14px;
	/*  字体颜色  */
	color: #333;
	/* 行距 */
	line-height: 1.75;
}

.margin {
	margin: 5px 0 10px 15px;
}

th, td {
	width: 15%;
	border: 1px solid #ccc;
	padding: 10px 8px;
}

th {
	background-color: #F4F4F4;
}

.title {
	font-size: 16px;
	font-weight: 500;
	color: rgb(65, 178, 166);
	font-weight: 500;
}

.dn {
	display: none;
}

.mr30 {
	margin-right: 30px;
}

.yjz {
	background-color: #3DADA1 !important;
	color: #fff !important;
}

.panel-body {
	padding: 0;
}

.view {
	opacity: .8;
}

.fs18 {
	font-size: 18px;
}

li {
	cursor: pointer;
}

.row {
	margin: 0px;
}

.p_btn {
	background-color: rgb(65, 178, 166) !important;
	color: #fff;
}

.btn-group>.btn, .btn-group+.btn {
	border-width: 1px !important;
}

.btn {
	text-shadow: none !important;
}
</style>
</head>
<body>
	<button style="margin-left: 15px;" onclick="addClick('process');" class="btn btn-sm btn-primary"
		data-toggle="modal" data-target="#process">新增叫号设置</button>
	<button class="btn btn-sm btn-primary" onclick="addClick('voiceIPR');" data-toggle="modal"
		data-target="#voiceIPR">新增音频设备设置</button>
	</br>
	<div class="form-group margin">
		<label class="title">叫号设置</label>
		<table style="margin-left: 10px; width: 95%;" border="1">
			<thead>
				<tr>
					<th>院所名称</th>
					<th>叫号模式</th>
					<th>流程对接模式</th>
					<th>爽约次数</th>
					<th>等待时长</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty processSetList }">
						<c:forEach items="${processSetList }" var="processSet">
							<tr>
								<td>${processSet.WorkUnitName }</td>
								<td><c:if test="${processSet.CallModel==0 }">自动叫号</c:if> <c:if
										test="${processSet.CallModel==1 }">手动叫号</c:if></td>
								<td><c:if test="${processSet.ProcessTypeModel==0 }">接口模式</c:if>
									<c:if test="${processSet.ProcessTypeModel==1 }">独立模式</c:if></td>
								<td>${processSet.AbstainedTicket }</td>
								<td>${processSet.ObsoleteTime }</td>


								<td><div class="row" style="margin-left: 0px;">
										<a style="cursor: pointer; padding: 5px" data-toggle="modal"
											data-target="#process" title="编辑"
											onclick="editProcess('${processSet.ProcessSetID}','${processSet.CallModel}','${processSet.ProcessTypeModel}','${processSet.AbstainedTicket}','${processSet.ObsoleteTime}');"
											class="tooltip-success" data-rel="tooltip" title=""
											data-placement="left"><span class="green"><i
												class="icon-edit icon-large"></i></span></a><a
											style="cursor: pointer; padding: 5px" title="删除"
											onclick="del('${processSet.ProcessSetID}','ProcessSetID','process');"
											class="tooltip-error" data-rel="tooltip" title=""
											data-placement="left"><span class="red"><i
												class="icon-trash icon-large"></i></span> </a>
									</div></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="100" class="center">没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	<div class="form-group margin">
		<label class="title">叫号音频设备设置</label>
		<div style="margin: 0 5% 10px 10px;" class="row">
			<select style="width: 100px;" data-placeholder="选择医生"
				class="selectpicker chosen-select" id="officeID">
				<option selected="selected" value="">请选择</option>
				<c:forEach items="${officeList}" var="off" varStatus="status">
					<option value="${off.OfficeID}">${off.OfficeName}</option>
				</c:forEach>
			</select>
			<button class="btn p_btn" onclick="getVoiceIPR(1,1);">
				<i class="icon-search"></i>
			</button>
		</div>
		<table id="voice" style="margin-left: 10px; width: 95%;">
			<thead>
				<tr>
					<th>科室名</th>
					<th>IP</th>
					<th>端口号</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<div id="buttons" style="margin-left: 10px;">
			<button class="btn btn-default" onclick="setVoiceIPR(-1)">
				<i class="icon-chevron-left"></i>
			</button>
			<button class="btn btn-default">
				<span id="currentPage">1</span>/<span id="pageSize">1</span>
			</button>
			<button class="btn btn-default" onclick="setVoiceIPR(1)">
				<i class="icon-chevron-right"></i>
			</button>
			<input style="height: 30px; margin-top: 6px" size="5"
				placeholder="输入页数" type="text" />
			<button class="btn btn-default" onclick="turn(this)">go</button>
		</div>
	</div>

	<div class="modal fade" id="process" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel"></h4>
				</div>
				<div class="modal-body">
					<input id="ProcessSetID" type="hidden">
					<table>
						<tr>
							<td>叫号模式：</td>
							<td><select id="CallModel" class="form-control">
									<option value="" selected="selected"></option>
									<option value="0">自动叫号</option>
									<option value="1">手动叫号</option>
							</select></td>
						</tr>
						<tr>
							<td>流程对接模式：</td>
							<td><select id="ProcessTypeModel" class="form-control">
									<option value="" selected="selected"></option>
									<option value="0">接口模式</option>
									<option value="1">独立模式</option>
							</select></td>
						</tr>
						<tr>
							<td>爽约次数：</td>
							<td><input id="AbstainedTicket" class="form-control"></td>
						</tr>
						<tr>
							<td>等待时长：</td>
							<td><input id="ObsoleteTime" class="form-control"></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" name="processEdit" class="btn btn-primary"
						data-dismiss="modal" onclick="saveEditProcess();">提交更改</button>
					<button type="button" name="processAdd" class="btn btn-primary"
						data-dismiss="modal" onclick="insertProcess();">新建</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

	<div class="modal fade" id="voiceIPR" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel"></h4>
				</div>
				<div class="modal-body">
				<input type="hidden" id="ID">
					<table>
						<tr>
							<td>科室：</td>
							<td><select id="OfficeID" class="form-control">
									<option selected="selected" value="">请选择</option>
									<c:forEach items="${officeList}" var="off" varStatus="status">
										<option value="${off.OfficeID}">${off.OfficeName}</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr>
							<td>音频设备IP地址：</td>
							<td><input id="VoiceComputerIP" class="form-control"></td>
						</tr>
						<tr>
							<td>端口：</td>
							<td><input id="Port" class="form-control"></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" name="voiceIPREdit" class="btn btn-primary"
						data-dismiss="modal" onclick="saveEditVoice();">提交更改</button>
					<button type="button" name="voiceIPRAdd" class="btn btn-primary"
						data-dismiss="modal" onclick="insertVoice();">新建</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
<script type="text/javascript">
	$(top.hangge());

	$(function() {
		$('#officeID').selectpicker({
			liveSearch : true,
			maxOptions : 1
		});
		setVoiceIPR(0);
	})

	function addClick(modelID) {
		$('#' + modelID + ' input,#' + modelID + ' select').val('');
		if (modelID=='process') {
			$('#' + modelID + ' h4').text('新建叫号设置');
		} else {
			$('#' + modelID + ' h4').text('新建音频设备设置');
		}
		
		$('button[name=' + modelID + 'Add]').removeClass('dn');
		$('button[name=' + modelID + 'Edit]').addClass('dn');
	}

	/* 编辑按钮函数与保存函数 */
	//begin
	function editProcess(ProcessSetID, CallModel, ProcessTypeModel,
			AbstainedTicket, ObsoleteTime) {
		$('#process h4').text('编辑叫号设置');
		$('button[name=processAdd]').addClass('dn');
		$('button[name=processEdit]').removeClass('dn');
		$("#ProcessSetID").val(ProcessSetID);
		$("#CallModel").val(CallModel);
		$("#ProcessTypeModel").val(ProcessTypeModel);
		$("#AbstainedTicket").val(AbstainedTicket);
		$("#ObsoleteTime").val(ObsoleteTime);
	}

	function saveEditProcess() {
		var url = "setting/update.do?ProcessSetID=" + $("#ProcessSetID").val()
				+ '&CallModel=' + $("#CallModel").val() + '&ProcessTypeModel='
				+ $("#ProcessTypeModel").val() + '&AbstainedTicket='
				+ $("#AbstainedTicket").val() + '&ObsoleteTime='
				+ $("#ObsoleteTime").val() + '&param=process';
		$.get(url, function(result) {
			message(result);
		})

	}

	function insertProcess() {
		var url = 'setting/insert.do?&CallModel=' + $("#CallModel").val()
				+ '&ProcessTypeModel=' + $("#ProcessTypeModel").val()
				+ '&AbstainedTicket=' + $("#AbstainedTicket").val()
				+ '&ObsoleteTime=' + $("#ObsoleteTime").val() + '&param=process';
		$.get(url, function(result) {
			message(result);
		})
	}

	function editVoice(OfficeID, VoiceComputerIP, Port, ID) {
		$('#voiceIPR h4').text('编辑音频设备设置');
		$('button[name=voiceIPRAdd]').addClass('dn');
		$('button[name=voiceIPREdit]').removeClass('dn');
		$("#OfficeID").val(OfficeID);
		$("#VoiceComputerIP").val(VoiceComputerIP);
		$("#Port").val(Port);
		$("#ID").val(ID);
	}

	function insertVoice() {
		var OfficeName = $("#OfficeID option:selected").text();
		var url = "setting/insert.do?OfficeID=" + $("#OfficeID").val()
				+ '&VoiceComputerIP=' + $("#VoiceComputerIP").val() + '&Port='
				+ $("#Port").val() + '&OfficeName=' + OfficeName
				+ '&param="voice"';
		$.get(url, function(result) {
			message(result);
		})
	}

	function saveEditVoice() {
		var OfficeName = $("#OfficeID option:selected").text();
		var url = "setting/update.do?OfficeID=" + $("#OfficeID").val()
				+ '&VoiceComputerIP=' + $("#VoiceComputerIP").val() + '&Port='
				+ $("#Port").val() + '&ID=' + $("#ID").val() + '&OfficeName='
				+ OfficeName + '&param="voice"';
		$.get(url, function(result) {
			message(result);
		})
	}
	//end

	/* 删除函数 */
	function del(id, idName, param) {
		if (confirm('确认删除')) {
			var url = 'setting/delete.do?' + idName + '=' + id + "&param="
					+ param;
			$.get(url, function(result) {
				message(result);
			})
		}
	}

	/* 翻页函数*/
	function setVoiceIPR(num) {
		var currentPage = $("#currentPage").text();
		var defaultSize = $("#pageSize").text();
		currentPage = Number(currentPage) + num;
		defaultSize = Number(defaultSize);
		getVoiceIPR(currentPage, defaultSize);
	}

	/* 页数跳转 */
	function turn(thi) {
		var currentPage = $(thi).prev().val();
		if (currentPage != '') {
			var defaultSize = $("#pageSize").text();
			defaultSize = Number(defaultSize);
			currentPage = Number(currentPage);
			getVoiceIPR(currentPage, defaultSize);
		}
	}

	/* 获取音频数据 */
	function getVoiceIPR(currentPage, defaultSize) {
		if (0 < currentPage && currentPage <= defaultSize) {
			currentPage--;
			$('#voice tbody').empty();
			var OfficeID = $('#officeID').val();
			var officeID = '';
			if (OfficeID == '') {
				$('#officeID option[value!=""]').each(function() {
					officeID += $(this).val() + ',';
				})
				officeID = officeID.substring(0, officeID.length - 1)
			} else {
				officeID = OfficeID;
			}
			var url = 'setting/voiceIPRPage.do?officeID=' + officeID
					+ '&pageSize=10&pageStart=' + currentPage * 10;
			$
					.ajax({
						url : url,
						async : false,
						success : function(result) {
							var voiceList = new Array();
							voiceList = result.data;
							var tbody = $('#voice tbody');
							if (voiceList != null && voiceList.length > 0) {
								for (var i = 0; i < voiceList.length; i++) {
									var voice = voiceList[i];
									var str = '<tr><td>'
											+ voice.OfficeName
											+ '</td><td>'
											+ voice.VoiceComputerIP
											+ '</td><td>'
											+ voice.Port
											+ '</td><td><div class="row" style="margin-left: 0px;">'
											+ '<a data-toggle="modal" data-target="#voiceIPR" style="cursor: pointer; padding: 5px" title="编辑" onclick="editVoice('
											+ voice.OfficeID
											+ ','+"'"
											+ voice.VoiceComputerIP
											+ "','"
											+ voice.Port
											+ "','"
											+ voice.ID+"'"
											+ ')" class="tooltip-success" data-rel="tooltip" data-placement="left">'
											+ '<span class="green"><i class="icon-edit icon-large"></i></span></a>'
											+ '<a style="cursor: pointer; padding: 5px" title="删除" onclick="del('
											+ voice.ID
											+ ",'"
											+ 'ID'
											+ "','"
											+ 'voice'
											+ "'"
											+ ')" class="tooltip-error" data-rel="tooltip" title="" data-placement="left">'
											+ '<span class="red"><i class="icon-trash icon-large"></i></span> </a></div>';
									tbody.append(str);
								}
								$('#currentPage').text(currentPage + 1);
								$("#pageSize").text(result.size);
								$('#buttons').css('display', 'inline');
							} else {
								var str = '<tr><td  style="text-align: center;"'+
								' colspan="100">暂无数据</td></tr>';
								tbody.append(str);
								$('#buttons').css('display', 'none');
							}
						}
					})
		}
	}

	function message(result) {
		if (result == 'success') {
			alert('操作成功');
			top.jzts();
			window.location.reload();
		} else {
			alert('操作失败');
		}
	}
</script>
</html>