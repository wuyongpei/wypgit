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
<!-- css -->
<link rel="stylesheet" type="text/css"
	href="static/plugins/websocketInstantMsg/ext4/resources/css/ext-all.css">
<link rel="stylesheet" type="text/css"
	href="static/plugins/websocketInstantMsg/css/websocket.css" />
<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
<link rel="stylesheet" href="static/css/font-awesome.min.css" />
<!-- bootstrap表单验证css -->
<link rel="stylesheet" href="static/bootstrapValidator/css/bootstrapValidator.css">
<!-- js -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
<!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script>
<!-- bootbox -->
<script type="text/javascript" src="static/bootbox4.4.0/bootbox.min.js"></script>
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<link rel="stylesheet" href="static/bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="static/bootstrap/js/bootstrap.min.js"></script>
<!-- bootstrap表单验证js -->
<script type="text/javascript" src="static/bootstrapValidator/js/bootstrapValidator.js"></script>
<!-- 简拼js -->
<script type="text/javascript" src="static/fullRC/js/pinyin_dict_withtone.js"></script>
<script type="text/javascript" src="static/fullRC/js/pinyinUtil.js"></script>

</head>
<body>
  	<div class="page_and_btn">
	
		<div style="margin-bottom: 10px;">
			&nbsp;&nbsp;<a class="btn btn-small btn-primary" title="添加" onclick="addDictionary('${DictionaryID}');return false;">添加</a>
		</div>
	</div>
  <table id="table_report" class="table table-hover table-bordered table-condensed">
		<thead>
		<tr>
			<th class="center"  style="width: 50px;">序号</th>
			<th class="center">字典名称</th>
			<th class="center">字典编码</th>
			<th class="center">字典类型</th>
			<th class="center">简拼</th>
			<th class="center">字典序号</th>
			<th class="center">备注</th>
			<th class="center">操作</th>
		</tr>
		</thead>
		<tbody>
<!-- 			<tr id="tr1" class='showdown'>	
				<td class='center'>1</td>
				<td onclick="openClose();return false;">普通病床</td>
				<td class='center'>001</td>
				<td class='center'>床位级别</td>
				<td class='center'>1</td>
				<td class='center'>PTBF</td>
				<td class='center'>备注111</td>
				<td class='center'>
					<div>
						<a class='btn btn-mini btn-info' title='编辑' onclick='edit();return false;'><i class='icon-edit'></i></a> 
						<a class='btn btn-mini btn-danger' title='删除'><i class='icon-trash'></i></a>
					</div>
				</td>
			</tr> -->
			<c:forEach items="${dicList }" var="dicList" varStatus="vs">
				<tr id="tr_${dicList.DictionaryID }">
					<td class="center">${vs.count }</td>
					<td class="center">${dicList.DictionaryName }</td>
					<td class="center">${dicList.DictionaryCode }</td>
					<td class="center">${DictionaryName}</td>
					<td class="center">${dicList.SimpleCode }</td>
					<td class="center">${dicList.OrderIndex }</td>
					<td class="center">${dicList.Comment }</td>
					<td class='center'>
						<div>
							<a class="btn btn-mini btn-info" title="编辑" onclick="editDic('${dicList.DictionaryID }');return false;"><i class='icon-edit'></i></a> 
							<a class="btn btn-mini btn-danger" title="删除" onclick="deleteDicWin('${dicList.DictionaryID }','${dicList.DictionaryName }');return false;"><i class='icon-trash'></i></a>
						</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<input type="hidden" id="dictionaryName" name="dictionaryName" value="${DictionaryName}">
	<!-- 添加字典模态框 -->
	<div id="addmodal" class="modal fade" style="height: 100%;"></div>
	<!-- 编辑字典模态框 -->
	<div id="editmodal" class="modal fade" style="height: 100%;"></div>
	<!-- 删除字典模态框 -->
	<div id="deletemodal" class="modal fade" style="height: 100%;">
		<div class="modal-dialog">
			<div class="modal-content">	
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">删除</h4>
				</div>
				<input type="hidden" id="dictionaryID" name="dictionaryID" value="">
				<div class="modal-body">
					<p>是否删除&nbsp;&nbsp;<span id="delspan" style="color: #337ab7;font-size: 18px;"></span></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" onclick="deleteDic();return false;">删除</button>
					<button type="button" class="btn btn-default" onclick="closewin();return false;">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	$(top.hangge());	

	$(function(){

	});
	//添加字典
	function addDictionary(dictionaryID){
		$("#addmodal").modal();
		$("#addmodal").load('load/win/add/'+dictionaryID);
	}

	//编辑字典
	function editDic(dictionaryID){
		$("#editmodal").modal();
		$("#editmodal").load('load/win/edit/'+dictionaryID);
	}
	//弹出删除字典弹窗
	function deleteDicWin(dictionaryId,dictionaryName){
		$("#delspan").html(dictionaryName);
		$("#dictionaryID").val(dictionaryId);
		$("#deletemodal").modal();
		
	}
	//关闭删除弹窗
	function closewin(){
		$("#deletemodal").modal('hide');
	}
	//删除字典
	function deleteDic(){
		var dictionaryID=$("#dictionaryID").val();
		if(dictionaryID!=null && dictionaryID!=''){	
			$.post("delete/dictionary",{dictionaryID:dictionaryID},function(result){
				if(result.statue=="success"){
					//alert("删除成功");
					window.location.reload();
				}else{
					alert("删除失败");
				}
			});
		}
		
	}
	
	</script>
</body>
</html>