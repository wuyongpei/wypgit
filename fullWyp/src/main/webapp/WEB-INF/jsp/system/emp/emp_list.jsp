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
</head>
<body>
	<div class="container-fluid" id="main-container">
		<div id="page-content" class="clearfix">
			<div class="row-fluid">
				<div class="row-fluid"></div>
				<form action="emp/listEmps" method="post" name="empForm"
					id="userForm">
					<table>
						<tr>
							<td><span class="input-icon"> <input
									autocomplete="off" id="nav-search-input" type="text"
									name="emp_Name" value="${pd.emp_Name }" placeholder="这里输入关键词" />
									<i id="nav-search-icon" class="icon-search"></i>
							</span></td>
							<td style="vertical-align: top;">
								<button class="btn btn-mini btn-light" onclick="search();"
									title="检索">
									<i id="nav-search-icon" class="icon-search"> </i>
								</button>
							</td>
						</tr>
					</table>

					<table id="table_report"
						class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th class="center"><label><input type="checkbox"
										id="zcheckbox" /><span class="lbl"></span></label></th>
								<th>序号</th>
								<th>登录名</th>
								<th>角色</th>
								<th>姓名</th>
								<th>性别</th>
								<th>年龄</th>
								<th>Email</th>
								<th>电话</th>
								<th>出生日期</th>
								<th>身份证</th>
								<th>入职日期</th>
								<th>工作单位</th>
								<th>科室/部门</th>
								<th>子级科室部门</th>
								<th>职称</th>
								<th>职类级别</th>
								<th>状态</th>
								<th>备注</th>
								<th class="center">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty empList }">
									<c:forEach items="${empList}" var="emp" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;"><label><input
													type='checkbox' name='ids' id="ids" value="${emp.Emp_ID }"
													id="user${emp.Emp_ID}" /><span class="lbl"></span></label></td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td>${emp.Emp_Name }</td>
											<td>${emp.Role_Name }</td>
											<td>${emp.E_Name }</td>
											<td>${emp.Sex }</td>
											<td>${emp.Age }</td>
											<td>${emp.Email }</td>
											<td>${emp.Phone }</td>
											<td>${emp.BirthDay }</td>
											<td>${emp.ID_Num }</td>
											<td>${emp.HireDate }</td>
											<td>${emp.WorkUnitName }</td>
											<td>${emp.OfficeName }</td>
											<td>${emp.WorkPositionName }</td>
											<td>${emp.DictionaryName }</td>
											<td>${emp.Doctor_Type }</td>
											<c:if test="${emp.Status==0}">
												<td>启用</td>
											</c:if>
											<c:if test="${emp.Status==1 }">
												<td>停用</td>
											</c:if>
											<td>${emp.Comment }</td>
											<td style="width: 30px;" class="center">
												<div class='hidden-phone visible-desktop btn-group'>
													<div class="inline position-relative">
														<button class="btn btn-mini btn-info"
															data-toggle="dropdown">
															<i class="icon-cog icon-only"></i>
														</button>
														<ul
															class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
															<li><a style="cursor: pointer;" title="编辑"
																onclick="editEmp('${emp.Emp_ID}');"
																class="tooltip-success" data-rel="tooltip" title=""
																data-placement="left"><span class="green"><i
																		class="icon-edit"></i></span></a></li>
															<li><a style="cursor: pointer;" title="删除"
																onclick="delEmp('${emp.Emp_ID }');"
																class="tooltip-error" data-rel="tooltip" title=""
																data-placement="left"><span class="red"><i
																		class="icon-trash"></i></span> </a></li>
														</ul>
													</div>
												</div>
											</td>
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

					<div class="page-header position-relative">
						<table style="width: 100%;">
							<tr>
								<td style="vertical-align: top;"><a
									class="btn btn-small btn-success" onclick="add();">新增</a> <a
									class="btn btn-small btn-danger"
									onclick="delEmps();" title="批量删除"><i
										class='icon-trash'></i></a></td>
								<td style="vertical-align: top;"><div class="pagination"
										style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
					</div>

				</form>
			</div>
		</div>
	</div>
	<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse"> <i
		class="icon-double-angle-up icon-only"></i>
	</a>

	<script type="text/javascript">
   $(top.hangge());
   
   $(function (){
	   $("#zcheckbox").click(function (){
		   changeCheck($(this),"input[name='ids']");
	   });
	   $("input[name='ids']").click(function (){
		   changeCheck($(this),"#zcheckbox");
	   });
   })
  
   function changeCheck(own,other){
	   if ($(own).is(":checked")) {
		   if ($(own).attr("id")=='zcheckbox') {
			   $(other).prop("checked","checked");
		} else {
			$(other).prop("checked",false);
		}
		} else {
			$(other).prop("checked",false);
		}
   }
   
 //检索
	function search(){
		top.jzts();
		$("#empForm").submit();
	}
  
 //新增
    function add(){
    	 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增用户";
		 diag.URL = '<%=basePath%>emp/goAddE';
		 diag.Width = 480;
		 diag.Height =500;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				 if('${page.currentPage}' == '0'){
					 top.jzts();
					 setTimeout("self.location=self.location",100);
				 }else{
					 nextPage(${page.currentPage}); 
				 }
			}
			diag.close();
		 };
		 diag.show();	
     	
    }
 
 //删除
 
 function delEmp(emp_ID){
	 if (confirm("确认删除？")) {
		var url = "<%=basePath%>emp/deleteE.do?empID="+emp_ID;
		$.get(url,function(data){
			top.jzts();
			document.location.reload();
		});
	}
 }
 
//批量删除  需要修改 2018-05-09注
 
 function delEmps(){
	var empIDs="";
	var num=0;
	 $("input[name='ids']:checked").each(function (){
		 empIDs+=($(this).val())+",";
		 num++;
	 });
	 if (num>0) {
	 if (confirm("确认删除"+num+"条数据？")) {
		 var url = "<%=basePath%>emp/deleteEs.do?empIDs="+empIDs;
		$.get(url,function(data){
			document.location.reload();
		    alert("成功删除"+num+"条数据");
		});
	}
	} else {
		$.DialogByZ.Alert({Title: "提示", Content: "请选择要删除的用户!",BtnL:"确定",FunL:alerts}) 
	}
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
 
//编辑
 function editEmp(emp_ID){
 	 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑用户";
		 diag.URL = '<%=basePath%>emp/editE.do?emp_ID='+emp_ID;
		 diag.Width = 480;
		 diag.Height = 500;
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