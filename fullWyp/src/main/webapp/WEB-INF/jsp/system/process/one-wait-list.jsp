<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
<!-- <link rel="stylesheet" href="static/css/ace.min.css" /> -->
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/bootstrap/css/bootstrap-select.css" rel="stylesheet" />
<link href="static/fullRC/css/jquery.alertable.css" rel="stylesheet">
<link href="static/fullRC/css/register.css" rel="stylesheet" />
<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript"src="static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/fullRC/js/jquery.alertable.js"></script>
 <style type="text/css">
.t-thread tr th{
 text-align: center;
}
.t-body tr:hover{
  background-color: #ddd;
}
.t-body tr td{
 text-align: center;
}
.drop-ul{
  min-width: 100px !important;
}
.drop-li{
  width:100px;
}

 </style>
</head>
<body>
    <div>
      <table class="table" >
         <thead class="t-thread">
          <tr>
            <th>序号</th>
            <th>姓名</th>
            <th>编号</th>
            <th>预约时间</th>
            <th>叫号时间</th>
            <th>操作</th>
          </tr>
         </thead>      
         
         <tbody class="t-body">
          <c:choose>
			<c:when test="${not empty callList}">
				<c:forEach items="${callList}" var="call" varStatus="vs">
           <tr>
           <td style="display: none;"><label>
           <input type="hidden" name='ids' id="ids" value="${call.queueID}" 
               id="call${call.queueID}" /></label></td>
              <td>${vs.index+1}</td>
              <td>${call.patientName }</td>
              <td>${call.queueCode }</td>
              <td>${call.appointmentTime}</td>
              <td>${call.callTime}</td>
              <td>
                 <div class='hidden-phone visible-desktop btn-group'>
						<div class="inline position-relative">
							<i class="glyphicon glyphicon-cog" data-toggle="dropdown"></i>
								<ul class="dropdown-menu dropdown-light pull-right dropdown-caret dropdown-close drop-ul" >
								<c:if test="${sta==1 || sta==3}">
								 <li class="drop-li">
                                     <a class="" href="javascript:onclick=callPersion('${call.queueID}')"><i class="glyphicon glyphicon-volume-down" ></i>叫号</a>
                                     </li>
                                    <c:if test="${sta!=3}">
								 <li class="drop-li">
                                     <a class="" href="javascript:onclick=modifymzStatus('${call.queueID}',3)"><i class="glyphicon glyphicon-forward"></i>过号</a>
                                     </li>
								</c:if>  
								 <li class="drop-li">
                                     <a class="" href="javascript:onclick=modifymzStatus('${call.queueID}',2)"><i class="glyphicon glyphicon-check"></i>确认就诊</a>
                                     </li>
								</c:if>
								
								<c:if test="${sta==2}">
								 <li class="drop-li">
                                     <a class="" href="javascript:onclick=modifymzStatus('${call.queueID}',1)"><i class="glyphicon glyphicon-remove-circle" ></i>取消就诊</a>
                                     </li>
								</c:if>
								</ul>
				 </div>
				 </div>										
              </td>
           </tr>
           </c:forEach>
           </c:when>
          </c:choose> 
         </tbody>
      </table>
    </div>

 <script type="text/javascript">
    
    function callPersion(queueId){
    	$.post("process/callOneP.do",{
			queueId:queueId
       	},function(result){
       		if(result.status=="success"){
				   $.alertable.alert("呼叫成功");
			   }else{
				   $.alertable.alert("呼叫失败");
			   }
       	});		
    }
 
    function modifymzStatus(qid,status){
		  $.post("process/comfirmMz.do",{
			 queueID:qid,status:status
		  },function(result){
			   if(result.status=="success"){
				   $.alertable.alert("操作成功");
			   }else{
				   $.alertable.alert("操作失败");
			   }
		  });	
		}
 
 
 
 
 </script>


</body>


</html>