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
<style type="text/css">
.btn-r{
 float: right;
 margin-right: 10%;
}
.btn-l{
 float: left;
}
.input-icon1 {
	position: relative
}
span.input-icon1 {
	display: inline-block
}
.input-icon1>input, .input-icon1>input {
	padding-left: 24px;
	padding-right: 6px
}
.input-icon1>[class*="icon-"] {
	padding: 0 3px;
	z-index: 2;
	position: absolute;
	top: 1px;
	bottom: 1px;
	left: 3px;
	line-height: 28px;
	display: inline-block;
	color: #909090;
	font-size: 16px
}
</style>
</head>

<body>
    <div class="container-fluid" id="main-container">
		<div id="page-content" class="clearfix">
			<div class="row-fluid">
				<div class="row-fluid"></div>
				<form action="shift/listshifts" method="post" name="shiftForm"
					id="shiftForm">
					<div>
					<div class="btn-l"> 
					<a class="btn btn-small btn-primary" onclick="add();"><i class=""></i>新增规则</a>
					<a class="btn btn-small btn-default" onclick="refresh();"><i class=""></i>刷新</a>
								</div>
					    <span class="input-icon1"> <input
									autocomplete="off" id="nav-search-input" type="text"
									name="shiftName" value="" placeholder="这里输入关键词" />
									<i id="nav-search-icon" class="icon-search"></i> 
							</span>
					<button class="btn btn-mini btn-light" style="margin-top: -10px;" onclick="search();"
									title="检索">
									<i id="nav-search-icon" class="icon-search"> </i>
								</button>		
 					<div class="btn-r">
					<a class="btn btn-small btn-info " onclick="addnextLevel();" id="addlevel"><i class=""></i>新增下级</a>
					<a class="btn btn-small btn-warning " onclick="modifyRule();" id="mdf"><i class=""></i>编辑</a>			
					<a class="btn btn-small btn-danger " onclick="deleteR();" id="del"><i class=""></i>删除</a>			
					</div>			
					</div>
					<table id="table_report"
						class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>序号</th>
								<th>规则名称</th>
								<th>开始时间</th>
								<th>结束时间</th>
								<th>取值类型</th>
								<th>排序号</th>
								<th>需考勤？</th>
								<th>工作时间段？</th>
								<th>是否启用</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty shiftlist }">
									<c:forEach items="${shiftlist}" var="shift" varStatus="vs">
										<tr id="${shift.shiftId}" lv="${shift.shiftLevel}">
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<c:if test="${shift.shiftLevel==1}">
											<td><i class="icon-folder-open"></i>${shift.shiftName }</td>
											</c:if>
											<c:if test="${shift.shiftLevel==2}">
											<td>&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-envelope-alt"></i>${shift.shiftName }</td>
											</c:if>
											<c:if test="${shift.shiftLevel==3}">
											<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-file"></i>${shift.shiftName }</td>
											</c:if>
											
											<td>${shift.startTime }</td>
											<td>${shift.endTime }</td>
											<c:if test="${shift.shiftLevel==1}">
											<td></td>
											</c:if>
											<c:if test="${shift.shiftLevel!=1}">
											<c:if test="${shift.shiftValueType==0 || shift.shiftValueType==null ||shift.shiftValueType=='' }">
											<td>最小值</td>
											</c:if>
											<c:if test="${shift.shiftValueType==1}">
											<td>最大值</td>
											</c:if>
											</c:if>
											<td>${shift.shiftOrder}</td>
											
											<c:if test="${shift.shiftLevel!=1 && shift.shiftLevel!=3}">
											<c:if test="${shift.isWorkAttendance==true}">
											  <td>√</td>
											</c:if>
											<c:if test="${shift.isWorkAttendance==false}">
											<td>否</td>
											</c:if>
											<c:if test="${shift.isWorkAttendance==null}">
											  <td></td>
											</c:if>
											</c:if>
											<c:if test="${shift.shiftLevel==1 || shift.shiftLevel==3}">
											<td></td>
											</c:if>
											
											<c:if test="${shift.shiftLevel!=1 && shift.shiftLevel!=3}">
											<c:if test="${shift.isWorkTime==true}">
												  <td>√</td>
											</c:if>
											<c:if test="${shift.isWorkTime==false}">
												<td>否</td>
											</c:if>
											<c:if test="${shift.isWorkTime==null}">
											  <td>√</td>
											</c:if>
											</c:if>
											<c:if test="${shift.shiftLevel==1 || shift.shiftLevel==3 }">
											<td></td>
											</c:if>
											<c:if test="${shift.status==0}">
												<td>启用</td>
											</c:if>
											<c:if test="${shift.status==1 }">
												<td>停用</td>
											</c:if>
										</tr>

									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center">没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</form>
				<p style="color: #CCC;">此结构为3级结构，顶级为考勤规则名称，第2级为此规则下每天考勤的名称，第3级为考勤名称对应状态值取值时间。</p>
			</div>
		</div>
	</div>
	<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse"> <i
		class="icon-double-angle-up icon-only"></i>
	</a>
  <script type="text/javascript">
    $(top.hangge());
    $(function(){
    	
    	$('#table_report tbody>tr').on("click", function (){  
    		     $(this).parent().find("tr.success").removeClass("success");//取消原先选中行
    	         $(this).addClass("success");//设定当前行为选中行
    	});  
    	
    });
    
    //新增下级
    function addnextLevel(){
        var tid = $(".success").attr("id");
        var level = $(".success").attr("lv");
        if(tid!= null && level!=3){
        	 top.jzts();
    		 var diag = new top.Dialog();
    		 diag.Drag=true;
    		 diag.Title ="新增下一级";
    		 diag.URL = '<%=basePath%>shift/goAddSon/'+tid+'/'+level;
    		 diag.Width = 350;
    		 diag.Height = 470;
    		 diag.CancelEvent = function(){ //关闭事件
    			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
    					 top.jzts();
    						setTimeout("location.reload()",100);
    			}
    			diag.close();
    		 };
    		 diag.show();	
        }
    }
    
    //修改
    function modifyRule(){
    	 var tid = $(".success").attr("id");
    	  if(tid!= null ){
    	 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="修改";
		 diag.URL = '<%=basePath%>shift/toEditR.do?shiftId='+tid;
		 diag.Width = 350;
		 diag.Height = 470;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 top.jzts();
						setTimeout("location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
    	  }
         
         
    }
    
    //删除操作
    function deleteR(){
    	var tid = $(".success").attr("id");
    	 var flag = false;
 		if(confirm("确定要删除该菜单吗？其下子菜单将一并删除！")){
 				flag = true;
 		}
 		if(flag){
 			top.jzts();
 			var url = "<%=basePath%>shift/del.do?shiftId="+tid;
 			$.get(url,function(data){
 				top.jzts();
 				document.location.reload();
 			});
 		}
    }
    
  //检索
	function search(){
		top.jzts();
		$("#shiftForm").submit();
	}
  
	//新增
    function add(){
    	 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增班次规则";
		 diag.URL = '<%=basePath%>shift/goAddS';
		 diag.Width = 350;
		 diag.Height = 470;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 top.jzts();
					 setTimeout("location.reload()",100);
			}
			diag.close();
		 }; 
		 diag.show();	
    }    
     
  
     
  
  
  </script>



</body>
</html>