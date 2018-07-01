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
<%@ include file="../admin/top.jsp"%>
<%@include file="../../layouts/taglib.jsp"%>
<%@include file="../../includeCssAndJS/include_bootstrap.jsp"%>
 <script src="static/fullRC/js/jquery.contextify.js"></script>
 	<link rel="stylesheet" href="static/fullRC/css/zdialog.css" />
 	 <script src="static/fullRC/js/zdialog.js"></script>
<style type="text/css">
  html,body{
    height: 99%;
    overflow: hidden;
  }
  .dropdown-menu{
   min-width: 80px;
  }
</style>
</head>

<body>
<div style="height: 98%;">
<div>
  <button type="button" class="btn btn-mini btn-info" data-toggle="modal" data-target="#myModal" style="margin-left: 10px;">新增</button>
</div>
<div id="context" class="tree" data-toggle="context">
<ul>
  <c:forEach items="${wuList}" var="wuList">
	<li>
	 <span><i class="icon-folder-open"></i></span> <a href="javascript:editPage(1,'wu_${wuList.workUnitID}');"  class="panel-body" id="wu_${wuList.workUnitID}"  var="1">${wuList.workUnitName}</a>
		<ul>
		    <c:forEach items="${wuList.officeList}" var="ofList">
			<li>
				<span><i class="icon-minus-sign"></i></span> <a href="javascript:editPage(2,'of_${ofList.officeID}');" class="panel-body" id='of_${ofList.officeID}' var="2">${ofList.officeName}</a>
				<ul>
				 <c:forEach items="${ofList.workPList}" var="wpList">
					<li>
						<span><i class="icon-leaf"></i></span> <a href="javascript:editPage(3,'wp_${wpList.workPositionID}')" class="panel-body" id="wp_${wpList.workPositionID}" var ="3">${wpList.workPositionName}</a>
					</li>
					</c:forEach>
				</ul>
			</li>
			</c:forEach>
		</ul>
	</li>
  </c:forEach>
</ul>
</div>

<div class="eidt_content">
<iframe name="treeFrame" id="treeFrame" frameborder="0"src="" scrolling="auto"  style="margin:10px; width: 97%;" height="600px;">
</iframe>
</div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
      style="width: 250px;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					请选择新增类型
				</h4>
			</div>
			<div class="modal-body">
				<select name="addType" id="addType">
				   <option value="1" selected="selected">工作单位</option>
				   <option value="2">科室/部门</option>
				   <option value="3">二级科室/部门</option>
				</select>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="choseType();">
					确认
				</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
<div id="dialog" title="基本的对话框">
  <p>这是一个默认的对话框，用于显示信息。对话框窗口可以移动，调整尺寸，默认可通过 'x' 图标关闭。</p>
</div>
 <input type="hidden" name="addType" id="addType" value="">
 <input type="hidden" name="nodeId" id="nodeId" value="">
<script type="text/javascript">
$(top.hangge());
$(function(){
	var options = {items:[
		  {text: '新增', onclick: function(e) {
			  var addtype = $("#addType").val();
			$("#treeFrame").attr("src","waf/addPage?addType="+addtype);
		  }},
		  {divider: true},
		  {text: '修改', onclick: function(e) {
			  var edittype = $("#addType").val();
			  var nodeId = $("#nodeId").val();
			  $("#treeFrame").attr("src","waf/editPage?edittype="+edittype+"&nodeId="+nodeId);
		  }},
		  {divider: true},
		  {text: '<span style="color:red;">删除</span>', onclick: function(e) {
			  var edittype = $("#addType").val();
			  var nodeId = $("#nodeId").val();
			  if(edittype==1 ){
				  $.DialogByZ.Alert({Title: "提示", Content: "抱歉当前无法删除最顶级目录!",BtnL:"确定",FunL:alerts}) 
			  }
			  if(edittype==2){
				  $.DialogByZ.Confirm({Title: "删除确认", Content: "删除多级目录会将导致其子目录全部删除<br/>请确认是否进行操作!",FunL:confirmL,FunR:Immediate})
			  }
			 if(edittype==3){
				  $.DialogByZ.Confirm({Title: "删除确认", Content: "是否确认删除该目录!",FunL:confirmL,FunR:Immediate})
			  }
// 			 
		  }},
		]}
	
    $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', '左右点击有功能');
        var children = $('.tree li.parent_li > span').parent('li.parent_li').find(' > ul > li');
            children.hide('fast');
            $(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
             //鼠标左击下拉或者收回
            $('.tree li.parent_li > span').on('click', function (e) {
            	 var children = $(this).parent('li.parent_li').find(' > ul > li');
            	 if (children.is(":visible")) {
            	     children.hide('fast');
            	     $(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
            	 } else {
            	     children.show('fast');
            	     $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
            	 }
            	 e.stopPropagation();
            	});
         //鼠标右击进行操作
            $('a').mousedown(function(e){
     		   if(3==e.which){
     		   var nodeId =	$(this).attr('id');
     		   var type = $(this).attr("var");
     		   $("#addType").val(type);
     		   $("#nodeId").val(nodeId);
     		   $('.panel-body').contextify(options);
     		   }
     	  }) ;
    
});
     /*选择添加类型*/
     function choseType(){
    	var addType = $("#addType").val();
       $("#treeFrame").attr("src","waf/addPage?addType="+addType);
       $('#myModal').modal('hide')
     }
     /*跳转修改页面*/
     function editPage(edittype,nodeId){
    	  $("#treeFrame").attr("src","waf/editPage?edittype="+edittype+"&nodeId="+nodeId);
     }
     
     function confirmL(){
     	$.DialogByZ.Close();
     	  delById();
     }
     function Immediate(){
    	 $.DialogByZ.Close();
      }
     function alerts(){
      	  $.DialogByZ.Close();
      }
     function delById(){
    	  var edittype = $("#addType").val();
		  var nodeId = $("#nodeId").val();
		  $.post("waf/del.do",{
			  edittype:edittype, nodeId:nodeId
		  },function(result){
			  if(result.success=="success"){
				  alert("删除成功");
				  location.reload();
			  }
		  });
     }
     
</script>
</body>
</html>

