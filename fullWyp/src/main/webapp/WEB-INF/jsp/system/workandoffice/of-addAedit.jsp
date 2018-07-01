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
			<h3>新增科室/部门</h3>
		</div>
		<form class="form-horizontal" role="form" method="post" id="of_Form">
			    <input type="hidden" name="officeID" id="officeID"value="${pd.OfficeID}">
				 <input type="hidden"name="workUnitID" id="workUnitID" value="${pd.WorkUnitID}" />
				 <input type="hidden" name="stu" id="stu" value="${pd.Status}" /> 
				 <input type="hidden" name="ofType" id="ofType" value="${pd.OfficeType}" /> 
				 <input type="hidden" name="officeLevel" id="officeLevel"value="${pd.OfficeLevel}">
			<div class="form-group">
				<label class="col-sm-4 control-label">请选择挂钩单位:</label>
				<div class="col-sm-6">
					<select class="form-control" name="wuid" id="wuid">
						<c:forEach items="${pdlist}" var="pdlist">
							<option value="${pdlist.WorkUnitID}">${pdlist.WorkUnitName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">科室/部门名称:</label>
				<div class="col-sm-6">
					<input class="form-control" id="officeName" name="officeName"
						type="text" value="${pd.OfficeName}" onchange="getPinYin();"
						placeholder="请输入科室或部门名称">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">科室/部门编码:</label>
				<div class="col-sm-6">
					<input readonly="readonly" class="form-control" id="officeCode" name="officeCode"
						type="text" value="${pd.OfficeCode }" placeholder="请输入科室或部门编码">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">科室/部门简拼:</label>
				<div class="col-sm-6">
					<input class="form-control" id="ospell" name="ospell" type="text"
						value="${pd.NameSpell}" placeholder="请输入科室或部门简拼">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">序号:</label>
				<div class="col-sm-6">
					<input class="form-control" id="officeSort" name="officeSort"
						type="number" value="${pd.OfficeSort}" placeholder="请输入科室或部门序号">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">科室类型:</label>
				<div class="col-sm-6">
					<select class="form-control" id="officeType" name="officeType">
						<option value="1" selected="selected">预约类</option>
						<option value="2">非预约类</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">备注:</label>
				<div class="col-sm-6">
					<input class="form-control" id="ofcom" name="ofcom" type="text"
						value="${pd.Comment}" placeholder="备注说明">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">状态:</label>
				<div class="col-sm-6">
					<select class="form-control" id="ostatus" name="ostatus">
						<option value="0" selected="selected">启用</option>
						<option value="1">禁用</option>
					</select>
				</div>
			</div>
			<div style="text-align: center;">
				<button type="button" class="btn btn-primary" onclick="saveWu();">保存</button>
				<button type="reset" class="btn btn-danger">取消</button>
			</div>
		</form>
	</div>


	<script type="text/javascript">
		$(function() {
			var workUnitID = $("#workUnitID").val();
			var status = $("#stu").val();
			var ofType =$("#ofType").val();
			if (workUnitID != "") {
				$("#wuid").val(workUnitID);
			}
			if (status != "") {
				$("#ostatus").val(status);
			}
			if(ofType !=""){
				$("#officeType").val(ofType);
			}
			getCode();

		});

		function getPinYin() {
			var ofic = $("#officeName").val();
			var pv = pinyinUtil.getFirstLetter(ofic, false);
			$("#ospell").val(pv);
		}

		//保存
		function saveWu() {
			if ($("#officeCode").val() == "") {
				$("#officeCode").tips({
					side : 3,
					msg : '请输入编号',
					bg : '#AE81FF',
					time : 2
				});

				$("#officeCode").focus();
				return false;
			}
			if ($("#officeName").val() == "") {
				$("#officeName").tips({
					side : 3,
					msg : '请输入名称',
					bg : '#AE81FF',
					time : 2
				});

				$("#officeName").focus();
				return false;
			}

			if ($("#officeSort").val() == "") {
				$("#officeSort").tips({
					side : 3,
					msg : '请输入联系方式',
					bg : '#AE81FF',
					time : 2
				});

				$("#officeSort").focus();
				return false;
			}
			var formData = new FormData($("#of_Form")[0]);
			$.ajax({
				url : 'waf/addOf.do',
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
			var code = $("#officeCode").val();
			if (code == null || code == '') {
				var url = 'waf/countOffice.do';
				$.get(url, function(result) {
					$("#officeCode").val('KS'+ result);
				})
			}
		}
	</script>

</body>
</html>