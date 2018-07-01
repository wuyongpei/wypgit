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
</head>
<body>
  
  <table id="table_report" class="table table-striped table-bordered table-hover">
		<thead>
		<tr>
			<th class="center"  style="width: 50px;">序号</th>
			<th class='center'>名称</th>
			<th class='center'>资源路径</th>
			<th class='center'>排序</th>
			<th class='center'>状态</th>
			<th class='center'>菜单等级</th>
			<th class='center'>操作</th>
		</tr>
		</thead>
		<c:choose>
			<c:when test="${not empty menuList}">
				<c:forEach items="${menuList}" var="menu" varStatus="vs">
				<tr id="tr${menu.menu_Id }">
				<td class="center">${vs.index+1}</td>
				<td class='left'><i class="${menu.menu_Icon }">&nbsp;</i>${menu.menu_Name }&nbsp;
					<c:if test="${menu.menu_Type == '1' }">
					<span class="label label-success arrowed">系统</span>
					</c:if>
					<c:if test="${menu.menu_Type != '1' }">
					<span class="label label-important arrowed-in">业务</span>
					</c:if>
				</td>
				<td>${menu.menu_Url == '#'? '': menu.menu_Url}</td>
				<td class='center'>${menu.menu_Order }</td>
				<c:if test="${menu.status==0}">
					<td class='center'>启用</td>
				</c:if>
				<c:if test="${menu.status==1 }">
					<td class='center'>停用</td>
				</c:if>
				<td class='center'>${menu.menu_Level }</td>
            	<td style="width: 25%;">  
			 	<a class='btn btn-mini btn-warning' onclick="openClose('${menu.menu_Id }',this,${vs.index })" >展开</a>
				<a class='btn btn-mini btn-purple' title="图标" onclick="editTb('${menu.menu_Id }')" ><i class='icon-picture'></i></a>
				<a class='btn btn-mini btn-info' title="编辑" onclick="editmenu('${menu.menu_Id }')" ><i class='icon-edit'></i></a>
				<a class='btn btn-mini btn-danger' title="删除"  onclick="delmenu('${menu.menu_Id }',true)"><i class='icon-trash'></i></a>
				</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
				<td colspan="100">没有相关数据</td>
				</tr>
			</c:otherwise> 
		</c:choose>
	</table>
	
	<div class="page_and_btn">
		<div>
			&nbsp;&nbsp;<a class="btn btn-small btn-success" onclick="addmenu();">新增</a>
		</div>
	</div>
	
	
	
	<script type="text/javascript">
	$(top.hangge());	
	
	//新增
	function addmenu(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增菜单";
		 diag.URL = '<%=basePath%>menu/toAdd.do';
		 diag.Width = 240;
		 diag.Height = 310;
		 diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts(); 
				setTimeout("location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	
	function openClose(menuId,curObj,trIndex){
		var txt = $(curObj).text();
		if(txt=="展开"){
			$(curObj).text("折叠");
			$("#tr"+menuId).after("<tr id='tempTr"+menuId+"'><td colspan='5'>数据载入中</td></tr>");
			if(trIndex%2==0){
				$("#tempTr"+menuId).addClass("main_table_even");
			}
			var url = "<%=basePath%>menu/sub.do?Menu_Id="+menuId+"&guid="+new Date().getTime();
			$.get(url,function(data){
				if(data.length>0){
					var html = "";
					$.each(data,function(i){
						html = "<tr style='height:24px;line-height:24px;' name='subTr"+menuId+"'>";
						html += "<td></td>";
						html += "<td><span style='width:80px;display:inline-block;'></span>";
						if(i==data.length-1)
							html += "<img src='static/images/joinbottom.gif' style='vertical-align: middle;'/>";
						else
							html += "<img src='static/images/join.gif' style='vertical-align: middle;'/>";
						html += "<span style='width:100px;text-align:left;display:inline-block;'>"+this.menu_Name+"</span>";
						html += "</td>";
						html += "<td>"+this.menu_Url+"</td>";
						html += "<td class='center'>"+this.menu_Order+"</td>";
						if(this.status==0){
						html += "<td class='center'>启用</td>";
						}else{
							html += "<td class='center'>禁用</td>";	
						}
						html += "<td class='center'>"+this.menu_Level+"</td>";
						html += "<td><a class='btn btn-mini btn-info' title='编辑' onclick='editmenu(\""+this.menu_Id+"\")'><i class='icon-edit'></i></a> <a class='btn btn-mini btn-danger' title='删除' onclick='delmenu(\""+this.menu_Id+"\",false)'><i class='icon-trash'></i></a></td>";
						html += "</tr>";
						$("#tempTr"+menuId).before(html);
					});
					$("#tempTr"+menuId).remove();
					if(trIndex%2==0){
						$("tr[name='subTr"+menuId+"']").addClass("main_table_even");
					}
				}else{
					$("#tempTr"+menuId+" > td").html("没有相关数据");
				}
			},"json");
		}else{
			$("#tempTr"+menuId).remove();
			$("tr[name='subTr"+menuId+"']").remove();
			$(curObj).text("展开");
		}
	}
	
	
	
	//编辑顶部菜单图标
	function editTb(menuId){
		 top.jzts();
	   	 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑图标";
		 diag.URL = '<%=basePath%>menu/toEditicon.do?menu_id='+menuId;
		 diag.Width = 530;
		 diag.Height = 150;
		 diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts(); 
				setTimeout("location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	
	//修改
	function editmenu(menuId){
		 top.jzts();
	   	 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑菜单";
		 diag.URL = '<%=basePath%>menu/toEdit.do?menu_Id='+menuId;
		 diag.Width = 240;
		 diag.Height = 310;
		 diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts(); 
				setTimeout("location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	
	function delmenu(menuId,isParent){
		var flag = false;
		if(isParent){
			if(confirm("确定要删除该菜单吗？其下子菜单将一并删除！")){
				flag = true;
			}
		}else{
			if(confirm("确定要删除该菜单吗？")){
				flag = true;
			}
		}
		if(flag){
			top.jzts();
			var url = "<%=basePath%>menu/del.do?menu_Id="+menuId+"&guid="+new Date().getTime();
			$.get(url,function(data){
				top.jzts();
				document.location.reload();
			});
		}
	}
	
	
	
	</script>
</body>
</html>