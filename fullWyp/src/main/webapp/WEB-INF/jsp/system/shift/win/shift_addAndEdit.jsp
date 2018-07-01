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
<%@include file="../../../layouts/taglib.jsp"%>
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/fullRC/js/laydate.js"></script>
<style type="text/css">
.f_l{
  float: left;
  margin-top: 5px;
}
.foot{
  position:fixed;
  background-color:rgb(238,238,238);
  width:100%;
  height:50px;
  bottom: 0px;
}

</style>

</head>
<body>
     <div id="zhongxin">
      <form class="form-horizontal" action="${msg}" name="shiftForm" id="shiftForm" method="post"
		style="margin: 15px;">
        <input type="hidden" name="shiftId" id="shiftId" value="${pd.ShiftID}">
        <input type="hidden" name="addType" id="addType" value="${addType}">
        <input type="hidden" name="parent_Id" id="parent_Id" value="${parent_Id}">
        <input type="hidden" name="shiftLevel" id="shiftLevel" value="${level}">
        <input type="hidden" id="crossD" value="${pd.CrossDayType}">
        <input type="hidden" id="svType" value="${pd.ShiftValueType}">
        <input type="hidden"  id="isWA" value="${pd.IsWorkAttendance}">
        <input type="hidden"  id="isWT" value="${pd.IsWorkTime}">
        <input type="hidden"  id="stu" value="${pd.Status}">
		 <div class="form-group" style="margin-left: 15%;">
            <label class="f_l"> <span style="color: red;">*</span>名称</label>
             <div class="col-sm-4" style="float: left;">
              <input class="form-control" id="shiftName" name="shiftName" type="text" 
              value="${pd.ShiftName}" placeholder="考勤规则名称">
              </div>
            </div>
		 <div class="form-group" style="margin-left: 8%;">
            <label class="f_l">开始时间</label>
             <div class="col-sm-4" style="float: left;">
              <input class="form-control" id="startTime" name="startTime" readonly="readonly"
               type="text" value="${pd.StartTime}" placeholder="" >
              </div>
            </div>
		 <div class="form-group" style="margin-left: 8%;">
            <label class="f_l">结束时间</label>
             <div class="col-sm-4" style="float: left;">
              <input class="form-control" id="endTime" name="endTime" readonly="readonly"
              type="text" value="${pd.EndTime}" placeholder="">
              </div>
            </div>
		 <div class="form-group" style="margin-left: 8%;">
            <label class="f_l">跨天类型</label>
             <div class="col-sm-4" style="float: left;">
               <select class="form-control"  name="crossDayType" id="crossDayType" >
                 <option value="0">不跨天</option>
                 <option value="1">开始时间-1天</option>
                 <option value="2">开始时间+1天</option>
                  </select>
              </div>
            </div>
		 <div class="form-group" style="margin-left: 8%;">
            <label class="f_l">取值类型</label>
             <div class="col-sm-4" style="float: left;">
            <select class="form-control"  name="shiftValueType" id="shiftValueType" >
                 <option value="0">最小值</option>
                 <option value="1">最大值</option>
                  </select>
              </div>
            </div>
			 <div class="form-group" style="margin-left: 25%;">
                   <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                     <label>
                       <input type="checkbox" name="isWorkAttendance" id="isWorkAttendance" value="1">需考勤？
                     </label>
                    </div>
                  </div>
                  
                  <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                     <label>
                       <input type="checkbox" name="isWorkTime" id="isWorkTime" value="0">非工作时间段
                     </label>
                    </div>
                  </div>
             </div>
			<div class="form-group" style="margin-left: 15%;">
            <label class="f_l">序号</label>
             <div class="col-sm-4" style="float: left;">
              <input class="form-control" id="shiftOrder" name="shiftOrder" type="text" value="${pd.ShiftOrder}" placeholder="序号">
              </div>
            </div>
			 <div class="form-group" style="margin-left: 15%;">
            <label class="f_l">状态</label>
             <div class="col-sm-4" style="float: left;">
               <select class="form-control"  name="status" id="status" >
                 <option value="0">启用</option>
                 <option value="1">禁用</option>
                  </select>
              </div>
            </div>
            
		</form>
		
		<footer  class="foot">
		    <div style="float: right;margin: 10px;">
             <a class="btn btn-small btn-primary" onclick="saveRuleN();"><i class=""></i>确定</a>
             <a class="btn btn-small btn-default" onclick="rs();"><i class=""></i>取消</a>
		    </div>
		</footer>
		</div>
  		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
  <script type="text/javascript">
      $(top.hangge());
  
	  laydate.render({
	      elem: '#startTime'
	      ,type: 'time'
	    });  
	  
  
	  laydate.render({
	      elem: '#endTime'
	      ,type: 'time'
	    });  
  
    function rs(){
    	$("#shiftForm")[0].reset();
    }
  
   //保存 包括修改操作
   function saveRuleN(){
	   if($("#shiftName").val()==""){
		   $("#shiftName").tips({
				side:3,
	            msg:'请填写规则名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#shiftName").focus();
			return false; 
	   }
	   
	    
	    $("#shiftForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	   
	   
   }
  
  
  $(function(){
	  var crossD =$("#crossD").val();
	  var svType =$("#svType").val();
	  var isWA =$("#isWA").val();
	  var isWT =$("#isWT").val();
	  var stu =$("#stu").val();
	  
	  $("#crossDayType").val(crossD);
	  $("#shiftValueType").val(svType);
	  $("#status").val(stu);
	  if(isWA=='true'){
		  $("#isWorkAttendance").attr("checked",true);
	  }
	  else if(isWA=='false' || isWA==''){
		  $("#isWorkAttendance").attr("checked",false);
	  }
	  if(isWT=='false'){
		  $("#isWorkTime").attr("checked",true);
	  }
	  if(isWT=='true' || isWT==''){
		  $("#isWorkTime").attr("checked",false);
	  }
	  
	  
	  
  });
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  </script>

</body>
</html>