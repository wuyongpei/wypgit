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
<%@include file="../../layouts/taglib.jsp"%>
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="static/bootstrap/js/bootbox.min.js"></script>
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="static/fullRC/js/pinyin_dict_withtone.js"></script>
<script type="text/javascript" src="static/fullRC/js/pinyinUtil.js"></script>
<style type="text/css">
.d-title {
	text-align: center;
}
</style>
</head>
<body>
	<div style="width: 98%;">
		<div class="d-title">
			<h3>新增二级科室/部门</h3>
		</div>
		<form class="form-horizontal" role="form" method="post" id="wp_Form">
			<input type="hidden" name="workPositionID" id="workPositionID"
				value="${pd.WorkPositionID }"> <input type="hidden"
				name="officeID" id="officeID" value="${pd.OfficeID }"> <input
				type="hidden" name="workUnitID" id="workUnitID"
				value="${pd.WorkUnitID }" /> <input type="hidden" name="stu"
				id="stu" value="${pd.Status }" />

			<div class="form-group">
				<label class="col-sm-4 control-label">请选择相关单位:</label>
				<div class="col-sm-6">
					<select class="form-control" name="wuid" id="wuid"
						onchange="getOffices();">
						<c:forEach items="${pdlist}" var="pdlist">
							<option value="${pdlist.WorkUnitID}">${pdlist.WorkUnitName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">请选择相关科室:</label>
				<div class="col-sm-6">
					<select class="form-control" name="ofID" id="ofID">
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">二级科室/部门名称:</label>
				<div class="col-sm-6">
					<input class="form-control" id="workPositionName"
						name="workPositionName" type="text"
						value="${pd.WorkPositionName }" onchange="getPinYin();"
						placeholder="职位/职称名称">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">二级科室/部门编码:</label>
				<div class="col-sm-6">
					<input readonly="readonly" class="form-control"
						id="workPositionCode" name="workPositionCode" type="text"
						value="${pd.WorkPositionCode }" placeholder="职位/职称编码">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">二级科室/部门简拼:</label>
				<div class="col-sm-6">
					<input class="form-control" id="wnsell" name="wnsell" type="text"
						value="${pd.NameSpell }" placeholder="职位/职称简拼">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">备注:</label>
				<div class="col-sm-6">
					<input class="form-control" id="wcomment" name="wcomment"
						type="text" value="${pd.Comment }" placeholder="备注/说明">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">状态:</label>
				<div class="col-sm-6">
					<select class="form-control" id="wstatus" name="wstatus">
						<option value="0" selected="selected">启用</option>
						<option value="1">禁用</option>
					</select>
				</div>
			</div>
			<div style="text-align: center;">
				<button type="button" class="btn btn-primary" onclick="saveWp();">保存</button>
				<button type="reset" class="btn btn-danger">取消</button>
			</div>
		</form>
	</div>


	<script type="text/javascript">
		$(function() {
			var workUnitID = $("#workUnitID").val();
			var status = $("#stu").val();
			if (workUnitID != "") {
				$("#wuid").val(workUnitID);
			}
			if (status != "") {
				$("#wstatus").val(status);
			}
			var officeId = $("#officeID").val();
			var wuid = $("#wuid").val();
			$.post("waf/get/ofics.do", {
				wuid : wuid
			}, function(result) {
				var ofArray = new Object();
				ofArray = result;
				if (ofArray != '') {
					for (var i = ofArray.length - 1; i >= 0; i--) {
						$("#ofID").append(
								"<option value="+ofArray[i].OfficeID+">"
										+ ofArray[i].OfficeName + "</option>");
					}
					$("#ofID").val(officeId);
				}
			});
			getCode();

		});
		//获取单位的科室
		function getOffices() {
			var wuid = $("#wuid").val();
			$.post("waf/get/ofics.do", {
				wuid : wuid
			}, function(result) {
				$("#ofID").find("option").remove();
				var ofArray = new Object();
				ofArray = result;
				if (ofArray != '') {
					for (var i = ofArray.length - 1; i >= 0; i--) {
						$("#ofID").append(
								"<option value="+ofArray[i].OfficeID+" selected='selected'>"
										+ ofArray[i].OfficeName + "</option>");
					}
				}
			});
		}
		/*汉字转拼音*/
		function getPinYin() {
			var wpname = $("#workPositionName").val();
			var pv = pinyinUtil.getFirstLetter(wpname, false);
			$("#wnsell").val(pv);
		}

		//保存和修改
		function saveWp() {
			if ($("#ofID").val() == "") {
				$("#ofID").tips({
					side : 3,
					msg : '请选择科室/部门',
					bg : '#AE81FF',
					time : 2
				});
				$("#ofID").focus();
				return false;
			}
			if ($("#workPositionCode").val() == "") {
				$("#workPositionCode").tips({
					side : 3,
					msg : '请输入编码',
					bg : '#AE81FF',
					time : 2
				});

				$("#workPositionCode").focus();
				return false;
			}
			if ($("#workPositionName").val() == "") {
				$("#workPositionName").tips({
					side : 3,
					msg : '请输入职位名称',
					bg : '#AE81FF',
					time : 2
				});

				$("#workPositionName").focus();
				return false;
			}
			if ($("#wnsell").val() == "") {
				$("#wnsell").tips({
					side : 3,
					msg : '请输入简拼',
					bg : '#AE81FF',
					time : 2
				});

				$("#wnsell").focus();
				return false;
			}
			var formData = new FormData($("#wp_Form")[0]);
			$.ajax({
				url : 'waf/addWp.do',
				type : 'POST',
				data : formData,
				dataType : "json",
				async : false,
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) {
					alert("保存成功");
					parent.location.reload();

				},
				error : function(data) {
					alert("添加失败");
				}

			});

		}

		function getCode() {
			var code = $("#workPositionCode").val();
			if (code == null || code == '') {
				var url = 'waf/countWorkPosition.do';
				$.get(url, function(result) {
					$("#workPositionCode").val('SKS'+ result);
				})
			}
		}
	</script>

</body>
</html>