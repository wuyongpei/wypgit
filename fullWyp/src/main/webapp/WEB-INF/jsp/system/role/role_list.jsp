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
</head>
<body>
  
	
<div class="container-fluid" id="main-container">

		
<div id="page-content">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
	 <div>
	<div id="breadcrumbs">
		<table class="center" style="width:100%;">
			<tr height="35">
				<c:if test="${QX.add == 1 }">
				<td style="width:69px;"><a href="javascript:addRole();" class="btn btn-small btn-success">新增组</a></td>
				</c:if>
					<c:choose>
					<c:when test="${not empty rlList}">
                        <c:forEach items="${rlList }" var="rlList">
						<td style="width:100px;" class="center" <c:choose><c:when test="${pd.Role_ID==rlList.role_ID}">bgcolor="#FFC926" onMouseOut="javascript:this.bgColor='#FFC926';"</c:when><c:otherwise>bgcolor="#E5E5E5" onMouseOut="javascript:this.bgColor='#E5E5E5';"</c:otherwise></c:choose>  onMouseMove="javascript:this.bgColor='#FFC926';" >
							<a href="role.do?Role_ID=${rlList.role_ID}" style="text-decoration:none; display:block;"><li class=" icon-group"></li>&nbsp;<font color="#666666"></font>${rlList.role_Name }</a>
						</td>
						<td style="width:5px;"></td>
					</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
						<td colspan="100">没有相关数据</td>
						</tr>
					</c:otherwise>
					</c:choose>
				<td></td>
			</tr>
		</table>
	</div>	
		<table>
			<tr height="7px;"><td colspan="100"></td></tr>
			<tr>
			<td><font color="#808080">本组：</font></td>
			<td>
			<c:if test="${QX.edit == 1 }">
			<a class="btn btn-mini btn-info" onclick="editRole('${pd.Role_ID }');">修改组名称<i class="icon-arrow-right  icon-on-right"></i></a>
			</c:if>
				<c:choose>
					<c:when test="${pd.Role_ID == '99'}">
					</c:when>
					<c:otherwise>
					<c:if test="${QX.edit == 1 }">
					<a class="btn btn-mini btn-purple" onclick="editRights('${pd.Role_ID }');"><i class="icon-pencil"></i>组菜单权限</a>
					</c:if>
					</c:otherwise>
				</c:choose>
				<c:choose> 
					<c:when test="${pd.Role_ID == '6' or pd.Role_ID == '4' or pd.Role_ID == '1' or pd.Role_ID == '7'}">
					</c:when>
					<c:otherwise>
					 <c:if test="${QX.del == 1 }">
					 <a class='btn btn-mini btn-danger' title="删除" onclick="delRole('${pd.Role_ID }','z','${pd.Role_Name }');"><i class='icon-trash'></i></a>
					 </c:if>
					</c:otherwise>
				</c:choose>
			</td>
			</tr>
			<tr height="7px;"><td colspan="100"></td></tr>
		</table>
		
		
	</div>
	<table id="table_report" class="table table-striped table-bordered table-hover">
		<thead>
		<tr>
			<th class="center">序号</th>
			<th>角色</th>
			<c:if test="${QX.edit == 1 }">
			<th class="center" bgcolor="#FFBF00">备用</th>
			<th class="center" bgcolor="#EFFFBF">备用</th>
<!-- 			<th class="center" bgcolor="#BFEFFF">邮件</th> -->
<!-- 			<th class="center" bgcolor="#EFBFFF">短信</th> -->
<!-- 			<th class="center" bgcolor="#BFEFFF" title="每天可发条数">站内信</th> -->
			<th class="center">增</th>
			<th class="center">删</th>
			<th class="center">改</th>
			<th class="center">查</th>
			</c:if>
			<th style="width:155px;"  class="center">操作</th>
		</tr>
		</thead>
		<c:choose>
			<c:when test="${not empty roleList_z}">
				<c:if test="${QX.cha == 1 }">
				<c:forEach items="${roleList_z}" var="var" varStatus="vs">
				
			
				<c:forEach items="${kefuqxlist}" var="varK" varStatus="vsK">
					<c:if test="${var.qx_Id == varK.GL_ID }">
						<c:set value="${varK.FX_QX }" var="fx_qx"></c:set>
						<c:set value="${varK.FW_QX }" var="fw_qx"></c:set>
						<c:set value="${varK.QX1 }" var="qx1"></c:set>
						<c:set value="${varK.QX2 }" var="qx2"></c:set>
					</c:if>
				</c:forEach>
				<c:forEach items="${gysqxlist}" var="varG" varStatus="vsG">
					<c:if test="${var.qx_Id == varG.U_ID }">
						<c:set value="${varG.C1 }" var="c1"></c:set>
						<c:set value="${varG.C2 }" var="c2"></c:set>
						<c:set value="${varG.Q1 }" var="q1"></c:set>
						<c:set value="${varG.Q2 }" var="q2"></c:set>
					</c:if>
				</c:forEach>
				
				<tr>
				<td class='center' style="width:30px;">${vs.index+1}</td>
				<td id="ROLE_NAMETd${var.role_ID }">${var.role_Name }</td>
				<c:if test="${QX.edit == 1 }">
				<td style="width:60px;" class="center"><label><input type="checkbox" class="ace-switch ace-switch-3" id="qx1${vs.index+1}" <c:if test="${qx1 == 1 }">checked="checked"</c:if> onclick="kf_qx(this.id,'${var.qx_Id}','kfqx1')" /><span class="lbl"></span></label></td>
				<td style="width:60px;" class="center"><label><input type="checkbox" class="ace-switch ace-switch-3" id="qx2${vs.index+1}" <c:if test="${qx2 == 1 }">checked="checked"</c:if>  onclick="kf_qx(this.id,'${var.qx_Id}','kfqx2')"/><span class="lbl"></span></label></td>
<%-- 				<td style="width:60px;" class="center"><label><input type="checkbox" class="ace-switch ace-switch-3" id="qx3${vs.index+1}" <c:if test="${fx_qx == 1 }">checked="checked"</c:if>  onclick="kf_qx3(this.id,'${var.qx_Id}','fxqx')"/><span class="lbl"></span></label></td> --%>
<%-- 				<td style="width:60px;" class="center"><label><input type="checkbox" class="ace-switch ace-switch-3" id="qx4${vs.index+1}" <c:if test="${fw_qx == 1 }">checked="checked"</c:if>  onclick="kf_qx4(this.id,'${var.qx_Id}','fwqx')"/><span class="lbl"></span></label></td> --%>
<%-- 				<td style="width:55px;" class="center"><input title="每天可发条数" name="xinjian" id="xj${vs.index+1}" value="${c1 }" style="width:30px;height:100%;text-align:center; padding-top: 0px;padding-bottom: 0px;" onkeyup="c1(this.id,'c1',this.value,'${var.qx_Id}')" type="number"/></td> --%>
				<td style="width:30px;"><a onclick="roleButton('${var.role_ID }','add_qx');" class="btn btn-warning btn-mini" title="分配新增权限"><i class="icon-wrench icon-2x icon-only"></i></a></td>
				<td style="width:30px;"><a onclick="roleButton('${var.role_ID }','del_qx');" class="btn btn-warning btn-mini" title="分配删除权限"><i class="icon-wrench icon-2x icon-only"></i></a></td>
				<td style="width:30px;"><a onclick="roleButton('${var.role_ID }','edit_qx');" class="btn btn-warning btn-mini" title="分配修改权限"><i class="icon-wrench icon-2x icon-only"></i></a></td>
				<td style="width:30px;"><a onclick="roleButton('${var.role_ID }','cha_qx');" class="btn btn-warning btn-mini" title="分配查看权限"><i class="icon-wrench icon-2x icon-only"></i></a></td>
				</c:if>
				<td style="width:155px;">
				
				<c:if test="${QX.edit != 1 && QX.del != 1 }">
				<div style="width:100%;" class="center">
				<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
				</div>
				</c:if>
				
				<c:if test="${QX.edit == 1 }">
				<a class="btn btn-mini btn-purple" onclick="editRights('${var.role_ID }');"><i class="icon-pencil"></i>菜单权限</a>
				<a class='btn btn-mini btn-info' title="编辑" onclick="editRole('${var.role_ID }');"><i class='icon-edit'></i></a>
				</c:if>
				<c:choose> 
					<c:when test="${var.role_ID == '2' or var.role_ID == '1'}">
					</c:when>
					<c:otherwise>
					 <c:if test="${QX.del == 1 }">
					 <a class='btn btn-mini btn-danger' title="删除" onclick="delRole('${var.role_ID }','c','${var.role_Name }');"><i class='icon-trash'></i></a>
					 </c:if>
					</c:otherwise>
				</c:choose>
				</tr>
				</c:forEach>
				</c:if>
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</c:if>
			</c:when>
			<c:otherwise>
				<tr>
				<td colspan="100" class="center" >没有相关数据</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
			
				
		<div class="page-header position-relative">
		<c:if test="${QX.add == 1 }">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;"><a class="btn btn-small btn-success" onclick="addRole2('${pd.Role_ID}');">新增</a></td>
			</tr>
		</table>
		</c:if>
		</div>
	</div>
 
	
	</div>
	</div>
	</div>
	</div>
  	
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>

	<!-- 引入 -->
		<script src="static/1.9.1/jquery.min.js"></script>
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
 <script type="text/javascript">
   
   top.hangge();
 
	//新增组
	function addRole(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增组";
		 diag.URL = '<%=basePath%>role/toAdd.do?parent_id=0';
		 diag.Width = 222;
		 diag.Height = 90;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts();
				setTimeout("self.location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	//新增角色
	function addRole2(pid){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增角色";
		 diag.URL = '<%=basePath%>role/toAdd.do?parent_id='+pid;
		 diag.Width = 222;
		 diag.Height = 90;
		 diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts();
				setTimeout("self.location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	//修改
	function editRole(ROLE_ID){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑";
		 diag.URL = '<%=basePath%>role/toEdit.do?ROLE_ID='+ROLE_ID;
		 diag.Width = 222;
		 diag.Height = 90;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts();
				setTimeout("self.location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
  
	//菜单权限
	function editRights(ROLE_ID){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag = true;
		 diag.Title = "菜单权限";
		 diag.URL = '<%=basePath%>role/auth.do?ROLE_ID='+ROLE_ID;
		 diag.Width = 280;
		 diag.Height = 370;
		 diag.CancelEvent = function(){ //关闭事件
			diag.close();
		 };
		 diag.show();
	}
	
	//删除
	function delRole(ROLE_ID,msg,ROLE_NAME){
		bootbox.confirm("确定要删除["+ROLE_NAME+"]吗?", function(result) {
			if(result) {
				var url = "<%=basePath%>role/delete.do?ROLE_ID="+ROLE_ID+"&guid="+new Date().getTime();
				top.jzts();
				$.get(url,function(data){
					if("success" == data.result){
						if(msg == 'c'){
							top.jzts();
							document.location.reload();
						}else{
							top.jzts();
							window.location.href="role.do";
						}
						
					}else if("false" == data.result){
						top.hangge();
						bootbox.dialog("删除失败，请先删除此部门下的职位!", 
								[
								  {
									"label" : "关闭",
									"class" : "btn-small btn-success",
									"callback": function() {
										//Example.show("great success");
										}
									}]
							);
					}else if("false2" == data.result){
						top.hangge();
						bootbox.dialog("删除失败，请先删除此职位下的用户!", 
								[
								  {
									"label" : "关闭",
									"class" : "btn-small btn-success",
									"callback": function() {
										//Example.show("great success");
										}
									}]
							);
					}
				});
			}
		});
	}
	
	//按钮权限
	function roleButton(ROLE_ID,msg){
		top.jzts();
		if(msg == 'add_qx'){
			var Title = "授权新增权限";
		}else if(msg == 'del_qx'){
			Title = "授权删除权限";
		}else if(msg == 'edit_qx'){
			Title = "授权修改权限";
		}else if(msg == 'cha_qx'){
			Title = "授权查看权限";
		}
		
		 var diag = new top.Dialog();
		 diag.Drag = true;
		 diag.Title = Title;
		 diag.URL = '<%=basePath%>role/button.do?ROLE_ID='+ROLE_ID+'&msg='+msg;
		 diag.Width = 200;
		 diag.Height = 370;
		 diag.CancelEvent = function(){ //关闭事件
			diag.close();
		 };
		 diag.show();
	}
	
	
	
	</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<script type="text/javascript">
	//扩展权限 ==============================================================
	var hcid1 = '';
	var qxhc1 = '';
	function kf_qx(id,kefu_id,msg){
		if(id != hcid1){
			hcid1 = id;
			qxhc1 = '';
		}
		var value = 1;
		var wqx = $("#"+id).attr("checked");
		if(qxhc1 == ''){
			if(wqx == 'checked'){
				qxhc1 = 'checked';
			}else{
				qxhc1 = 'unchecked';
			}
		}
		if(qxhc1 == 'checked'){
			value = 0;
			qxhc1 = 'unchecked';
		}else{
			value = 1;
			qxhc1 = 'checked';
		}
			var url = "<%=basePath%>role/kfqx.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
			$.get(url,function(data){
				if(data=="success"){
					
				}
			});
	}
	
	
	
	
	
	
	
 </script>





</body>
</html>