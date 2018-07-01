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
<link rel="stylesheet" href="plugins/zTree/css/style.css">
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


<style type="text/css">
  html,body{
    height: 99%;
    overflow: hidden;
  }
  .dropdown-menu{
   min-width: 80px;
  }
  li.btn_background{
  	background-color: #337ab7;
  }
  a.c_link{
  	cursor: pointer;
  }
</style>
</head>

<body>
	<div style="height: 97%;">
		<div style="margin-left: 10px;">
			<a class="btn btn-small btn-success" onclick="addDictionaryType();return false;">新增</a>
			<a class="btn btn-small btn-danger" onclick="deleteDicTypeWin();return false;">删除</a>
			<a class="btn btn-mini btn-info" onclick="editDic();return false;">修改</a>
		</div>
		<div id="context" class="tree" data-toggle="context" style="overflow: auto; ">
				<ul id="selectDicType" class="nav nav-pills nav-stacked" >
<!-- 					<li class="msg-type" onclick="openDesc();return false;"><a class="c_link"><i class="icon-list-ul"></i>&nbsp;病床级别</a></li>
					<li class="msg-type"><a class="c_link"><i class="icon-list-ul"></i>&nbsp;入库类型</a></li> -->
					<c:forEach items="${dicList }" var="dicList">
						<li class="msg-type" onclick="openDesc('${dicList.DictionaryID}','${dicList.DictionaryName}',this);return false;"><a class="c_link"><i class="icon-list-ul"></i>&nbsp;${dicList.DictionaryName }</a></li>
					</c:forEach>
				</ul>
		</div>
	
		<div class="eidt_content">
			<iframe name="treeFrame" id="treeFrame" frameborder="0"src="" scrolling="auto"  style="margin:10px; width: 99%;" height="98%">
			</iframe>
		</div>
	</div>
	<!-- 新增modal -->
	<div class="modal fade" id="mymodal" style="height: 100%;"></div>
	<!-- 删除字典类型modal -->
	<div id="deleteTypemodal" class="modal fade" style="height: 100%;">
		<div class="modal-dialog">
			<div class="modal-content">	
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">删除字典类型</h4>
				</div>
				<input type="hidden" id="dictionaryID" name="dictionaryID" value="">
				<input type="hidden" id="dictionaryName" name="dictionaryName" value="">
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
	<!-- 编辑字典类型modal -->
	<div id="edittypemodal" class="modal fade" style="height: 100%;">

	</div>
	
	
 <input type="hidden" name="addType" id="addType" value="">
 <input type="hidden" name="nodeId" id="nodeId" value="">
<script type="text/javascript">
	$(top.hangge());
	
	$(function(){
		

		
	});
	    //打开对应字典列表
	function openDesc(dictionaryID,dictionaryName,e){
	    	$("#selectDicType li").removeClass("active");
	    	$(e).addClass("active");
	    	//$("#dt_1").parent().addClass("btn_background");
		$("#treeFrame").attr("src","show/dictionary/desc/"+dictionaryID);
		$("#dictionaryID").val(dictionaryID);
		$("#dictionaryName").val(dictionaryName);
		
	}
	//新增字典类型
	function addDictionaryType(){
		$("#mymodal").modal();
		$("#mymodal").load('load/win/addType');
	}
	
	//打开删除字典类型窗口
	function deleteDicTypeWin(){
		
		var dictionaryID=$("#dictionaryID").val();
		var dictionaryName=$("#dictionaryName").val();
		if(dictionaryID!=null && dictionaryID!=''){
			$("#delspan").html(dictionaryName);
			$("#deleteTypemodal").modal();
		}else{
			bootbox.alert({
				message:"请选择要删除的字典类别",
				buttons:{
					ok:{label:'确定',className:'btn-default'}
				}
			});
		}

	}
	//关闭删除窗口
	function closewin(){
		$("#deleteTypemodal").modal('hide');
	}
	//删除字典类别
	function deleteDic(){
		var dictionaryID=$("#dictionaryID").val();
		if(dictionaryID!=null && dictionaryID!=''){	
			$.post("delete/dictionaryType",{dictionaryID:dictionaryID},function(result){
				if(result.statue=="success"){
					//alert("删除成功");
					window.location.reload();
				}else if(result.statue=="muchdata"){
					$("#deleteTypemodal").modal('hide');
					bootbox.alert({
						message:"该字典类别下还有字典，请删除子类别后再删除",
						buttons:{
							ok:{label:'确定',className:'btn-default'}
						}
					});
				}else{
					alert("删除失败");
				}
			});
		}
	}
	
	function editDic(){
		var dictionaryID=$("#dictionaryID").val();
		if(dictionaryID!=null && dictionaryID!=''){
			
			$("#edittypemodal").modal();
			$("#edittypemodal").load('load/win/edittype/'+dictionaryID);
			
		}else{
			bootbox.alert({
				message:"请选择要修改的字典类别",
				buttons:{
					ok:{label:'确定',className:'btn-default'}
				}
			});
		}
	}
	
</script>
</body>
</html>

