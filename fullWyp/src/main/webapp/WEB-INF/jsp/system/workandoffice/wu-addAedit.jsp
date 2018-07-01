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
<%@include file="../../layouts/taglib.jsp"%>
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="static/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/fullRC/js/pinyin_dict_withtone.js"></script>
	<script type="text/javascript" src="static/fullRC/js/pinyinUtil.js"></script>
	<script type="text/javascript" src="static/fullRC/js/jquery.form.js"></script>
<style type="text/css">
.d-title{
text-align: center;
}
</style>

</head>
<body>
<div style="width:98%;">
   <div class="d-title">
      <h3>新增工作单位</h3>
   </div>
   <form class="form-horizontal" action="" role="form" method="post" id="wu_Form" >
   <input type="hidden" name="workUnitID" id="workUnitID" value="${pd.WorkUnitID}">
   
  <div class="form-group">
    <label class="col-sm-2 control-label">单位编码:</label>
    <div class="col-sm-8">
      <input class="form-control" id="workUnitCode" name="workUnitCode" type="text" value="${pd.WorkUnitCode}" placeholder="请输入单位编码">
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">单位名称:</label>
    <div class="col-sm-8">
      <input class="form-control" id="workUnitName" name="workUnitName" type="text" value="${pd.WorkUnitName}" placeholder="请输入单位名称" onchange="getPinYin();">
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">简拼:</label>
    <div class="col-sm-3">
      <input class="form-control" id="nameSpell" name="nameSpell" type="text" value="${pd.NameSpell}" placeholder="请输入单位名称简拼">
    </div>
    <label class="col-sm-2 control-label">简称:</label>
    <div class="col-sm-3">
      <input class="form-control" id="shortName" name="shortName" type="text" value="${pd.ShortName}" placeholder="请输入单位简称">
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">单位地址:</label>
    <div class="col-sm-8">
      <input class="form-control" id="address" name="address" type="text" value="${pd.Address}" placeholder="地址">
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">联系方式:</label>
    <div class="col-sm-3">
      <input class="form-control" id="telphone" name="telphone" type="text" value="${pd.Telphone}" placeholder="联系方式">
    </div>
    <label class="col-sm-2 control-label">email:</label>
    <div class="col-sm-3">
      <input class="form-control" id="email" name="email" type="text" value="${pd.Email}" placeholder="邮箱">
    </div>
  </div>
   <div class="form-group">
    <label class="col-sm-2 control-label">网址:</label>
    <div class="col-sm-8">
      <input class="form-control" id="uRL" name="uRL" type="text" value="${pd.URL}" placeholder="网址">
    </div>
  </div>
    <div class="form-group">
    <label class="col-sm-2 control-label">负责人:</label>
    <div class="col-sm-3">
      <input class="form-control" id="linkman" name="linkman" type="text" value="${pd.Linkman}" placeholder="负责人姓名">
    </div>
    <label class="col-sm-2 control-label">负责人联系方式:</label>
    <div class="col-sm-3">
      <input class="form-control" id="linkmanTelphone" name="linkmanTelphone" type="text" value="${pd.LinkmanTelphone}" placeholder="负责人联系方式">
    </div>
  </div>
    <div class="form-group">
   <label class="col-sm-2 control-label">负责人email:</label>
    <div class="col-sm-3">
      <input class="form-control" id="linkmanEmail" name="linkmanEmail" type="text" value="${pd.linkmanEmail}" placeholder="负责人邮箱">
    </div>
    <label class="col-sm-2 control-label">状态:</label>
    <div class="col-sm-2">
      <select class="form-control" id="status" name="status" >
        <option value="0" <c:if test="${pd.Status==0}">selected="selected"</c:if>>启用</option>
        <option value="1" <c:if test="${pd.Status==1}">selected="selected"</c:if>>禁用</option>
      </select>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">备注:</label>
    <div class="col-sm-8">
      <input class="form-control" id="comment" name="comment" type="text" value="" placeholder="备注">
    </div>
  </div>
</form>
  <div style="text-align: center;">
    <button type="button" class="btn btn-primary" onclick="saveWu();">保存</button>
   <button type="button" class="btn btn-danger">取消</button>
  </div>
</div>
 <script type="text/javascript">
   $(function(){
    var code=$("#workUnitCode").val();
	   if(code!=''){
		   $("#workUnitCode").attr("disabled","disabled");
	   }
	   
   }); 
 
 
   function getPinYin(){
	  var wun = $("#workUnitName").val();  
	  var pv= pinyinUtil.getFirstLetter(wun, false);
	  $("#nameSpell").val(pv);
   }
 
 
 
    //保存
    function saveWu(){
     if($("#workUnitCode").val()==""){
			$("#workUnitCode").tips({
				side:3,
	            msg:'请输入编号',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#workUnitCode").focus();
			return false;
		}
     if($("#workUnitName").val()==""){
			$("#workUnitName").tips({
				side:3,
	            msg:'请输入名称',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#workUnitName").focus();
			return false;
		}
    	
     if($("#telphone").val()==""){
			$("#telphone").tips({
				side:3,
	            msg:'请输入联系方式',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#telphone").focus();
			return false;
		}
//           $("#wu_Form").ajaxSubmit(function(){
//         	 alert("提交成功"); 
// //              $("#wu_Form")[0].reset();
//              parent.location.reload();
//           });
           var formData = new FormData($("#wu_Form")[0]);
           $.ajax({
        	    url:'waf/addWu.do',
        	    type:'POST',
        	    data:formData,
        	    dataType: "json",
        	      async: false,  
        	      cache: false,  
        	      contentType: false,  
        	      processData: false,  
        	      success:function(data){
        	    	  alert("保存成功"); 
        	    	  parent.location.reload();
        	    	  
        	      },error:function (data){
        	    	  alert("添加失败");
        	      }
        	    
        	    
           });
          
    }
 
 
 
 </script>

</body>
</html>