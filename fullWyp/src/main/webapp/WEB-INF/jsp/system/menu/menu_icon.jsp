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
		<form action="menu/editicon.do" name="menuForm" id="menuForm" method="post">
			<input type="hidden" name="menu_Id" id="menuId" value="${pd.menu_Id}"/>
			<input type="hidden" name="menu_icon" id="menu_icon" value=""/>
			<div id="zhongxin">
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<tr>
					<td><label onclick="seticon('icon-desktop');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-desktop"></i></span></label></td>
					<td><label onclick="seticon('icon-list');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-list"></i></span></label></td>
					<td><label onclick="seticon('icon-edit');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-edit"></i></span></label></td>
					<td><label onclick="seticon('icon-list-alt');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-list-alt"></i></span></label></td>
					<td><label onclick="seticon('icon-calendar');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-calendar"></i></span></label></td>
					<td><label onclick="seticon('icon-picture');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-picture"></i></span></label></td>
					<td><label onclick="seticon('icon-th');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-th"></i></span></label></td>
					<td><label onclick="seticon('icon-file');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-file"></i></span></label></td>
					<td><label onclick="seticon('icon-folder-open');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-folder-open"></i></span></label></td>
				</tr>
				<tr>
					<td><label onclick="seticon('icon-book');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-book"></i></span></label></td>
					<td><label onclick="seticon('icon-cogs');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-cogs"></i></span></label></td>
					<td><label onclick="seticon('icon-comments');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-comments"></i></span></label></td>
					<td><label onclick="seticon('icon-envelope-alt');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-envelope-alt"></i></span></label></td>
					<td><label onclick="seticon('icon-film');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-film"></i></span></label></td>
					<td><label onclick="seticon('icon-heart');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-heart"></i></span></label></td>
					<td><label onclick="seticon('icon-lock');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-lock"></i></span></label></td>
					<td><label onclick="seticon('icon-exclamation-sign');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-exclamation-sign"></i></span></label></td>
					<td><label onclick="seticon('icon-facetime-video');"><input name="form-field-radio" type="radio" value="icon-edit"><span class="lbl">&nbsp;<i class="icon-facetime-video"></i></span></label></td>
				</tr>
				<tr>
				<td style="text-align: center;" colspan="100">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
			</table>
			</div>
			<div id="zhongxin2" class="center" style="display:none"><img src="static/images/jzx.gif" /></div>
		</form>
		
		
		<script type="text/javascript">
				
				$(top.hangge());
				//保存
				function save(){
					if($("#menu_icon").val()==""){
						alert('请选择图标');
						return false;
					}
					$("#menuForm").submit();
					$("#zhongxin").hide();
					$("#zhongxin2").show();
				}
			function seticon(icon){
				$("#menu_icon").val(icon);
			}	
			
		</script>
	</body>
</html>