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
 	<div class="container-fluid" id="main-container">
		<div id="page-content" class="clearfix">
			<div class="row-fluid">
				<div class="row-fluid"></div>
				   <form action="" method="post" name="callListForm"id="callListForm">
				     <table id="table_report"
						class="table table-striped table-bordered table-hover">
				         <thead>
							<tr>
								<th>序号</th>
								<th>编号</th>
								<th>姓名</th>
								<th>卡号</th>
								<th>预约时间</th>
								<c:if test="${pd.status==1}">
								<th>等待人数</th>
								</c:if>
								<c:if test="${pd.status==1 || pd.status==3 }">
								<th>大约等待时间</th>
								</c:if>
								<th>预约类型</th>
								<th>排队状态</th>
								<th>呼叫时间</th>
								<th class="center">操作</th>
							</tr>
						</thead>
				       <tbody>
				          <c:choose>
								<c:when test="${not empty callList }">
									<c:forEach items="${callList}" var="call" varStatus="vs">
										<tr>
											<td style="display: none;"><label><input
													type="hidden" name='ids' id="ids" value="${call.queueID}"
													id="call${call.queueID}" /></label></td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td>${call.queueCode }</td>
											<td>${call.patientName }</td>
											<td>${call.mnCardNO }</td>
											<td>${call.appointmentTime }</td>
											<c:if test="${pd.status==1}">
											<td>${vs.index}</td>
											</c:if>
											<c:if test="${pd.status==1 || pd.status==3 }">
											<td>${call.waitTime}</td>
											</c:if>
											<td>${call.appointmentType}</td>
											<td>${call.status }</td>
											<td>${call.callTime }</td>
											<td style="width: 150px;" class="center">
											 <c:if test="${pd.status==1 || pd.status==3 }">
											  <div class="hidden-phone visible-desktop btn-group">
<!--                                                    <a class="btn btn-mini btn-success" onclick="window.parent.test(121)">叫号</a>											   -->
                                                   <a class="btn btn-mini btn-success" onclick="callThis('${call.queueID}');">叫号</a>											  
											  </div>
<!-- 											  <div class="hidden-phone visible-desktop btn-group"> -->
<!--                                                    <a class="btn btn-mini btn-info" >重呼</a>											   -->
<!-- 											  </div> -->
											  <div class="hidden-phone visible-desktop btn-group">
                                                   <a class="btn btn-mini btn-warning" onclick="modifyStatusThis('${call.queueID}',2)" >确认就诊</a>											  
											  </div>
											 </c:if>
											  <c:if test="${pd.status==1}">
											  <div class="hidden-phone visible-desktop btn-group">
                                                   <a class="btn btn-mini btn-danger" onclick="modifyStatusThis('${call.queueID}',3)">过号</a>											  
											  </div>
											  </c:if>
											  <c:if test="${pd.status==2}">
											     <a class="btn btn-mini btn-danger" onclick="modifyStatusThis('${call.queueID}',1)" >取消就诊状态</a>		
											  </c:if>
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
				   </form>
				</div>
				</div>
				</div> 


 <script type="text/javascript">
     $(top.hangge());
     
     //呼叫选中人
     function callThis(queueID){
    	window.parent.callPersion(queueID);
     }
     //根据情况改变当前队列状态
     function modifyStatusThis(qid,status){
    	 window.parent.modifyMzStatus(qid,status);
     }
     
 
  </script>
</body>
</html>	
	