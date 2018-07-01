<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<meta charset="utf-8" />
<title></title>
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<%@ include file="../../admin/top.jsp"%>
<%@include file="../../../layouts/taglib.jsp"%>
<%@include file="../../../includeCssAndJS/include_bootstrap.jsp"%>
	<script type="text/javascript" src="static/fullRC/js/pinyin_dict_withtone.js"></script>
<script type="text/javascript" src="static/fullRC/js/pinyinUtil.js"></script>

</head>
<body>
	<form action="${msg}" name="empForm" id="empForm" method="post"
		style="margin: 15px;">
		<input type="hidden" name="empID" id="empID" value="${pd.Emp_ID }" />
		<input type="hidden" id="office" value="${pd.OfficeID }"/>
		<input type="hidden" id="wpID" value="${pd.WorkPositionID }"/>
		<div id="zhongxin">
			<table>
			<tr>
					<td class="center" colspan="4"><input name="WorkPositionName"
						id="WorkPositionName" type="text" value="${pd.WorkPositionName}"
						style="display: none;" /> <input name="OfficeName"
						id="OfficeName" type="text" value="${pd.OfficeName}"
						style="display: none;" /> <input name="WorkUnitName"
						id="WorkUnitName" type="text" value="${pd.WorkUnitName}"
						style="display: none;" /></td>
				</tr>
				<tr>
					<td><input type="text" name="empName" id="empName"
						value="${pd.Emp_Name}" placeholder="这里输入用户名" title="用户名" /></td>
					<td><input class="span10 date-picker" name="birthDay"
						id="birthDay" value="${pd.BirthDay}" type="text"
						data-date-format="yyyy-mm-dd" readonly="readonly"
						placeholder="出生日期" title="出生日期" onchange="getAge();" /></td>
				</tr>
				<tr>
					<td><input type="password" name="password" id="password"
						value="" placeholder="输入密码" title="密码" /></td>
					<td><input class="span10 date-picker" name="hireDate"
						id="hireDate" value="${pd.HireDate}" type="text"
						data-date-format="yyyy-mm-dd" readonly="readonly"
						placeholder="入职日期" title="入职日期" /></td>
				</tr>
				<tr>
					<td><input type="text" name="eName" id="eName"
						value="${pd.E_Name }" placeholder="这里输入姓名" title="姓名"
						 onchange="getPinYin();"/></td>
						 <td>
				    <input type="text" name="nameSpell" id="nameSpell"value="${pd.NameSpell}"
				     readonly="readonly" placeholder="姓名简拼" title="姓名简拼" />
				    </td>
				</tr>
				<tr>
					<td><select name="Sex" title="性别" id="sex">
							<option value="男" <c:if test="${pd.Sex =='男'}">selected</c:if>>男</option>
							<option value="女" <c:if test="${pd.Sex =='女'}">selected</c:if>>女</option>
					</select></td>
					<td>
						<select name="doctorPosition" id="doctorPosition">
			         	<c:forEach items="${doctypelist}" var="doct">
					     <option value="${doct.DictionaryID}" <c:if test="${doct.DictionaryID == pd.DoctorPosition}">selected</c:if>>${doct.DictionaryName}</option>
				         </c:forEach>
				         </select>
					</td>
				</tr>
				<tr>
				   <td><input type="text" name="age" id="age" value="${pd.Age }"
						placeholder="年龄" title="年龄" readonly="readonly" onclick="{
							$(this).tips({
								side : 3,
								msg : '请先选择出生日期',
								bg : '#AE81FF',
								time : 2
							});
					}" /></td>
					<td><select name="workUnitID" title="工作单位" id="workUnitID"
						onchange="getOffices();">
							<c:forEach items="${pdlist}" var="pdlist">
								<option value="${pdlist.WorkUnitID}" <c:if test="${pd.WorkUnitID ==pdlist.WorkUnitID}">selected</c:if>>${pdlist.WorkUnitName}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td><input type="text" name="phone" id="phone"
						value="${pd.Phone}" placeholder="电话/手机号码" title="电话/手机号码" /></td>
					<td><select name="officeID" title="科室/部门" id="officeID"
						onchange="getWp();">
					</select></td>
				</tr>
				<tr>
				    <td>
					<input type="text" name="iDNum" id="iDNum"value="${pd.ID_Num }" placeholder="身份证号码" title="身份证号码" />
					</td>
					<td><select name="workPositionID" title="职位职称"
						id="workPositionID">
					</select></td>
				</tr>
				<tr>
					<td><input type="text" name="email" id="email"
						value="${pd.Email}" placeholder="邮箱" title="邮箱" /></td>
					<td><select name="Status" title="状态" id="status">
							<option value="0" <c:if test="${pd.Status =='0'}">selected</c:if>>启用</option>
							<option value="1" <c:if test="${pd.Status =='1'}">selected</c:if>>禁用</option>
					</select></td>
				</tr>
				<tr>
				   <td>
				     <select name="isDoctor" title="职类" id="isDoctor" onchange="getType();">
							<option value="0" <c:if test="${pd.Is_Doctor =='0'}">selected</c:if>>管理</option>
							<option value="1" <c:if test="${pd.Is_Doctor =='1'}">selected</c:if>>医生</option>
							<option value="2" <c:if test="${pd.Is_Doctor =='2'}">selected</c:if>>其他</option>
					</select>
				   </td>
				</tr>
				<tr>
				<td>
				<select name="Doctor_Type" title="职业类型" id="Doctor_Type" >
							<option value="" <c:if test="${pd.Doctor_Type ==''}">selected</c:if>></option>
							<option value="专家" <c:if test="${pd.Doctor_Type =='专家'}">selected</c:if>>专家</option>
							<option value="普通" <c:if test="${pd.Doctor_Type =='普通'}">selected</c:if>>普通</option>
				</select>
				</td>
				<td>
				<select name="role_id" id="role_id">
				<c:forEach items="${roleList}" var="role">
					<option value="${role.role_ID}" <c:if test="${role.role_ID == pd.Role_ID}">selected</c:if>>${role.role_Name }</option>
				</c:forEach>
				</select>
				</td>	
				</tr>
				<tr>
					<td colspan="2"><input type="text" name="comment" id="comment"
						value="${pd.Comment}" placeholder="备注" title="备注"
						style="width: 97%" /></td>
				</tr>
				<tr>
					<td class="center" colspan="4"><a
						class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
						class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
					</td>
				</tr>
			</table>
		</div>

		<div id="zhongxin2" class="center" style="display: none">
			<br /> <br /> <br /> <br /> <br /> <img
				src="static/images/jiazai.gif" /> <br />
			<h4 class="lighter block green">提交中...</h4>
		</div>

	</form>

	<script type="text/javascript">
		$(top.hangge());
		
		function hasU(){
			var USERNAME = $.trim($("#empName").val());
			$.ajax({
				type:'POST',
				url:'emp/hasE.do',
				data:{USERNAME:USERNAME,tm:new Date().getTime()},
				dataType:'json',
				cache:false,
				success:function(data){
                    if("success" == data.result){
                    	$("#empForm").submit();
            			$("#zhongxin").hide();
            			$("#zhongxin2").show();
                    }else{
                    	$("#empName").tips({
        					side : 3,
        					msg : '该用户名已经存在',
        					bg : '#AE81FF',
        					time : 2
        				});
        				$("#empName").focus();
                    } 					
				}
			});
		}
		
		
		
		function getType(){
			   $("#Doctor_Type").empty();
			var isD = $("#isDoctor").val();
			if(isD==1){
			$("#Doctor_Type option[value='']").remove();
            $("#Doctor_Type").prepend("<option value='专家'>专家</option><option value='普通'>普通</option>")
			}else{
		     $("#Doctor_Type").prepend("<option value=''></option>")
			}
			
		}
		
		
		function getPinYin(){
			var ename =$("#eName").val();
			var pv = pinyinUtil.getFirstLetter(ename, false);
			$("#nameSpell").val(pv);
		}
		function save() {
			var empID=$("#empID").val();
			if ($("#empName").val() == "") {

				$("#empName").tips({
					side : 3,
					msg : '请输入用户名',
					bg : '#AE81FF',
					time : 2
				});
				$("#empName").focus();
				return false;
			}
			if ($("#birthDay").val() == "") {

				$("#birthDay").tips({
					side : 3,
					msg : '请选择出生日期',
					bg : '#AE81FF',
					time : 2
				});
					$("#birthDay").focus();
				return false;
			}
			if ($("#password").val() == "" && empID=="") {
				$("#password").tips({
					side : 3,
					msg : '请输入密码',
					bg : '#AE81FF',
					time : 2
				});
				$("#password").focus();
				return false;
			}
			if ($("#hireDate").val() == "") {

				$("#hireDate").tips({
					side : 3,
					msg : '请选择入职日期',
					bg : '#AE81FF',
					time : 2
				});

				$("#hireDate").focus();
				return false;
			}
			if ($("#eName").val() == "") {

				$("#eName").tips({
					side : 3,
					msg : '请输入姓名',
					bg : '#AE81FF',
					time : 2
				});
				$("#eName").focus();
				return false;
			}
			if ($("#workUnitID").val() == "") {

				$("#workUnitID").tips({
					side : 3,
					msg : '请选择工作单位',
					bg : '#AE81FF',
					time : 2
				});

				$("#workUnitID").focus();
				return false;
			}
			if ($("#officeID").val() == "") {

				$("#officeID").tips({
					side : 3,
					msg : '请选择科室/部门',
					bg : '#AE81FF',
					time : 2
				});
				$("#officeID").focus();
				return false;
			}
			if ($("#workPositionID").val() == "") {

				$("#workPositionID").tips({
					side : 3,
					msg : '请选择职位职称',
					bg : '#AE81FF',
					time : 2
				});

				$("#workPositionID").focus();
				return false;
			}
			
			$("#WorkUnitName").val($('#workUnitID option:selected').text());
			$("#WorkPositionName").val($('#workPositionID option:selected').text());
			$("#OfficeName").val($('#officeID option:selected').text());
			if(empID==""){
			hasU();
			}else{
			$("#empForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
			}	
		}

		$(function() {
			//日期框
			$('.date-picker').datepicker({
				autoclose:true
			});

			var wuid = $("#workUnitID").val();
			var officeID = $("#office").val();
			$.post("waf/get/ofics.do", {
				wuid : wuid
			}, function(result) {
				var ofArray = new Object();
				ofArray = result;
				if (ofArray != '') {
					for (var i = 0; i < ofArray.length; i++) {
						if (officeID == ofArray[i].OfficeID) {
							$("#officeID").append(
									"<option value="+ofArray[i].OfficeID+" selected='selected'>"
											+ ofArray[i].OfficeName
											+ "</option>");
							$("#officeID").val(ofArray[i].OfficeID);
						} else {
							$("#officeID").append(
									"<option value="+ofArray[i].OfficeID+">"
											+ ofArray[i].OfficeName
											+ "</option>");
						}
					}
					if ($("#officeID").val() == null
							|| $("#officeID").val() == '') {
						$("#officeID").val(ofArray[0].OfficeID);
						$("#officeID option").first().prop('selected',
								'selected');
					}
					getWp();
				}
			});

		var empid=	$("#empID").val();
			if(empid!=""){
				$("#empName").attr("readonly","readonly");
			}
			
		});

		function getWp() {
			var ofid = $("#officeID").val();
			var wpID = $("#wpID").val();
			$.post("waf/get/wps.do", {
				ofid : ofid
			}, function(result) {
				$("#workPositionID").find("option").remove();
				var wpArray = new Object();
				wpArray = result;
				if (wpArray != '') {
					for (var i = wpArray.length - 1; i >= 0; i--) {
						var selected = '';
						if (wpID == wpArray[i].WorkPositionID) {
							selected = " selected='selected'";
						}
						$("#workPositionID").append(
								"<option value="+wpArray[i].WorkPositionID+selected+">"
										+ wpArray[i].WorkPositionName
										+ "</option>");
					}
				}
			});
		}

		function getOffices() {
			var wuid = $("#workUnitID").val();
			$.post("waf/get/ofics.do", {
				wuid : wuid
			}, function(result) {
				$("#officeID").find("option").remove();
				var ofArray = new Object();
				ofArray = result;
				if (ofArray != '') {
					for (var i = 0; i < ofArray.length; i++) {
						if (i == 0) {
							$("#officeID").append(
									"<option value="+ofArray[i].OfficeID+" selected='selected'>"
											+ ofArray[i].OfficeName
											+ "</option>");
							$("#officeID").val(ofArray[i].OfficeID);
						} else {
							$("#officeID").append(
									"<option value="+ofArray[i].OfficeID+">"
											+ ofArray[i].OfficeName
											+ "</option>");
						}
					}
					getWp();
				}
			});
		}
		
		function getAge () {
            var date = new Date();
            var birthday = $("#birthDay").val();
            var startDate = new Date(birthday);
            var newDate = date.getTime() - startDate.getTime();
            var age = Math.ceil(newDate/(1000*60*60*24*365));
            if (isNaN(age)){
                age = "";
            }
            $("#age").val(age);
        }
	</script>





</body>


</html>