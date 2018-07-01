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
		<form action="menu/edit.do" name="menuForm" id="menuForm" method="post">
			<input type="hidden" name="Menu_Id" id="menuId" value="${pd.Menu_Id}"/>
			<input type="hidden" name="PId" id="pId" value="${pd.Parent_Id}"/>
			<input type="hidden" name="Menu_Type" id="menu_Type" value="${pd.Menu_Type }"/>
			<input type="hidden" name="stu" id="stu" value="${pd.Status }"/>
			<div id="zhongxin">
			<table>
				<tr>
					<td>
						<select name="Parent_Id" id="parentId" onchange="setMUR()" title="菜单">
							<option value="0">顶级菜单</option>
							<c:forEach items="${menuList}" var="menu">
								<option value="${menu.menu_Id }">${menu.menu_Name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<td><input type="text" name="Menu_Name" id="menuName" placeholder="这里输入菜单名称" value="${pd.Menu_Name }" title="名称"/></td>
				</tr>
				<tr>
					<td><input type="text" name="Menu_Url" id="menuUrl" placeholder="这里输入链接地址" value="${pd.Menu_Url }" title="地址"/></td>
				</tr>
				<tr>
					<td><input type="number" name="Menu_Order" id="menuOrder" placeholder="这里输入序号" value="${pd.Menu_Order}" title="序号"/></td>
				</tr>
					<tr>
				<td><input type="number" name="menu_Level" id="menuLevel" placeholder="这里输入菜单等级" value="${pd.Menu_Level}" title="登记"/></td>
			</tr>
			<tr>
				<td>
					<select name="Status" id="Status" class="input_txt"  title="状态">
						<option value="0">启用</option>
						<option value="1">禁用</option>
					</select>
				</td>
			</tr>
				<tr>
					<td style="text-align: center;">
						<label style="float:left;padding-left: 32px;"><input name="form-field-radio" id="form-field-radio1" onclick="setType('1');" <c:if test="${pd.Menu_Type == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">系统菜单</span></label>
						<label style="float:left;padding-left: 5px;"><input name="form-field-radio" id="form-field-radio2" onclick="setType('2');" <c:if test="${pd.Menu_Type != '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">业务菜单</span></label>
					</td>
				</tr>
				<tr>
				<td style="text-align: center; padding-top: 10px;">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
			</table>
			</div>
			<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
		</form>
		
		
		<script type="text/javascript">
		$(top.hangge());	
		$(document).ready(function(){
				if($("#menuId").val()!=""){
					var parentId = $("#pId").val();
					if(parentId=="0"){
						$("#parentId").attr("disabled",true);
					}else{
						$("#parentId").val(parentId);
						$("#form-field-radio1").attr("disabled",true);
						$("#form-field-radio2").attr("disabled",true);
						$("#form-field-radio1").attr("checked",false);
						$("#form-field-radio2").attr("checked",false);
					}
				}
			});
			
		$(function(){
			var stu =$("#stu").val();
			$("#status").val(stu);
		});
		
		
			var menuUrl = "";
			function setMUR(){
				menuUrly = $("#menuUrl").val();
				if(menuUrly != ''){menuUrl = menuUrly;}
				if($("#parentId").val()=="0"){
					$("#menuUrl").attr("readonly",true);
					$("#menuUrl").val("");
					$("#form-field-radio1").attr("disabled",false);
					$("#form-field-radio2").attr("disabled",false);
				}else{
					$("#menuUrl").attr("readonly",false);
					$("#menuUrl").val(menuUrl);
					$("#form-field-radio1").attr("disabled",true);
					$("#form-field-radio2").attr("disabled",true);
					$("#form-field-radio1").attr("checked",false);
					$("#form-field-radio2").attr("checked",false);
				}
			}
			
			//保存
			function save(){
				if($("#menuName").val()==""){
					
					$("#menuName").tips({
						side:3,
			            msg:'请输入菜单名称',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#menuName").focus();
					return false;
				}
				if($("#menuUrl").val()==""){
					$("#menuUrl").val('#');
				}
				if($("#menuOrder").val()==""){
					
					$("#menuOrder").tips({
						side:1,
			            msg:'请输入菜单序号',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#menuOrder").focus();
					return false;
				}
				
				if(isNaN(Number($("#menuOrder").val()))){
					
					$("#menuOrder").tips({
						side:1,
			            msg:'请输入菜单序号',
			            bg:'#AE81FF',
			            time:2
			        });
					
					$("#menuOrder").focus();
					$("#menuOrder").val(1);
					return false;
				}
				
				$("#menuForm").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
			}
			
			function setType(value){
				$("#menu_Type").val(value);
			}
		
		
		</script>
		
	</body>
</html>