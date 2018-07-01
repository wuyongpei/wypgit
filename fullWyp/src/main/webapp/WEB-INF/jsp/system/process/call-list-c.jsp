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
<%-- 	<%@ include file="../admin/top.jsp"%>  --%>
	<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/bootstrap/css/bootstrap-select.css" rel="stylesheet" />
<link href="static/fullRC/css/jquery.alertable.css" rel="stylesheet">
<link href="static/fullRC/css/register.css" rel="stylesheet" />
<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript"src="static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/fullRC/js/jquery.alertable.js"></script>
<style type="text/css">
.s-d{
  margin:0 15px;
}

</style>	
<body>
	<div class="tab-content tab-div">
			<div class="tab-pane active" id="appointManager"
				style="overflow: hidden;">
				<div class="panel panel-default" style="border: none;">
				   <div class="panel-heading head-panel" style="border: none;">
						<div class="row">
							<div class="col-sm-3 col-md-4">
								<div class="btn-group">
									<a type="buttion" id="b1" class="btn btn-sm btn-default active"
										onclick="goCallList(1)">正在排队</a>
								</div>
								<div class="btn-group">
									<a id="b2" class="btn btn-sm btn-default"
										onclick="goCallList(2)">已就诊</a>
									<a id="b3" class="btn btn-sm btn-default"
										onclick="goCallList(3)">过号</a>
								</div>
							</div>
<!-- 							<div class='col-sm-9 cal-md-8'> -->
<!-- 							  <button onclick="goGetTickPage();">取票操作</button> -->
<!-- 							</div> -->
                            	<div class="col-sm-9 col-md-8 pull-right">
                            	 <input type="hidden" id='emp_ID' value="${pd.Emp_ID}">
                            	          <label>
                            	           <span class="s-d" id="d-name"><input id="queue_ID" name="queueID" value="${pd.Queue_ID}" type="hidden">
                            	                                  当前呼叫人：${pd.PatientName }</span>
                            	           <span class="s-d">当前排队：${countnl}</span>
                            	           <span class="s-d">过号数量：${countg}</span>
                            	           <span class="s-d">已经叫号：${countac}</span>
                            	           <span class="s-d">已经就诊：${countaj}</span>
                            	          </label>
                            	    	<div class="btn-group">
                            	    	  <a class="btn btn-sm btn-success" onclick="callWaitP(1)" >呼叫下一位</a>
                            	    	</div>
                            	    	<div class="btn-group">
                            	    	  <a class="btn btn-sm btn-primary" onclick="callWaitP(0)">重呼当前人</a>
                            	    	</div>
                            	    	<div class="btn-group">
                            	    	  <a class="btn btn-sm btn-warning" onclick="modifyMzStatus('${pd.Queue_ID}',2)" >确认就诊</a>
                            	    	</div>
                            	    	<div class="btn-group">
                            	    	  <a class="btn btn-sm btn-info" onclick="location.reload()">刷新</a>
                            	    	</div>
                            	</div>
						</div>
					</div>
				
				    	<div id="calendar" class="ap-div1" >
	   	                 <iframe id="ifr-call" scrolling="auto" frameborder="0" width="100%" 
	   	                 style="min-height: 700px;"src="process/calllists.do?status=1"></iframe>
						</div>
								
				</div>
              </div>
             </div> 
 
 <script type="text/javascript">
			$(top.hangge());
			
			
        function goGetTickPage(){
        	var url ="process/comfirm/win.do"
        	top.location.href=url;
        }
			
		function goCallList(status){
	      $("#ifr-call").attr("src","process/calllists.do?status="+status);		
	      if(status==1){
	    	 $("a").removeClass("active");
	    	 $("#b1").addClass("active");
	      }else if(status==2){
	    	  $("a").removeClass("active"); 
	    	  $("#b2").addClass("active");
	      }else if(status==3){
	    	  $("a").removeClass("active"); 
	    	  $("#b3").addClass("active");
	      }
		}	
	    
		//呼叫操作 0 呼叫当前人 1呼叫下一位
		function callWaitP(type){
            var eid =$("#emp_ID").val();
            var qid =$("#queue_ID").val();
           	$.post("process/callWaitP.do",{
           		type:type,queueID:qid,empID:eid
           	},function(result){
           		if(result.status=="success"){
 				   $.alertable.alert("呼叫成功");
 			   }else{
 				   $.alertable.alert("呼叫失败");
 			   }
           	});		
		}
		
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
		
		
		//就诊确认 lzd 改 状态改变
		function modifyMzStatus(qid,status){
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