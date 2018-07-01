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
<!-- css -->
<link rel="stylesheet" type="text/css"
	href="static/plugins/websocketInstantMsg/ext4/resources/css/ext-all.css">
<link rel="stylesheet" type="text/css"
	href="static/plugins/websocketInstantMsg/css/websocket.css" />
<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
<link rel="stylesheet" href="static/css/font-awesome.min.css" />
<!-- bootstrap表单验证css -->
<link rel="stylesheet" href="static/bootstrapValidator/css/bootstrapValidator.css">
<!-- js -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<!-- <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script> -->
<!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script>
<!-- bootbox -->
<script type="text/javascript" src="static/bootbox4.4.0/bootbox.min.js"></script>
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<link rel="stylesheet" href="static/bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="static/bootstrap/js/bootstrap.min.js"></script>
<!-- bootstrap表单验证js -->
<script type="text/javascript" src="static/bootstrapValidator/js/bootstrapValidator.js"></script>
<!-- 简拼js -->
<script type="text/javascript" src="static/fullRC/js/pinyin_dict_withtone.js"></script>
<script type="text/javascript" src="static/fullRC/js/pinyinUtil.js"></script>

</head>
<body>
  
		<div class="modal-dialog">
			<div class="modal-content">
			<form id="dic-form" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">新增父类别</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label >字典编码</label>
						<input class="form-control" type="text" placeholder="输入字典编码" name="dictionaryCode">
					</div>
					<div class="form-group">
						<label >字典名称</label>
						<input class="form-control" type="text" placeholder="输入字典名称" name="dictionaryName" id="dictionaryName" onchange="getPinYin();">
					</div>
					<div class="form-group">
						<label >字典简拼</label>
						<input class="form-control" type="text" placeholder="" name="simpleCode" id="simpleCode" readonly="readonly">
					</div>
					<div class="form-group">
						<label >字典排序</label>
						<input class="form-control" type="text" placeholder="输入字典排序序号" name="orderIndex" id="orderIndex">
					</div>
					<div class="form-group">
						<label >备注</label>
						<input class="form-control" type="text" placeholder="" name="comment">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="save(); return false;">确定</button>
					<button type="button" class="btn btn-default" onclick="closewin();return false;">关闭</button>
				</div>
			</form>
			</div>
		</div>
	
	<script type="text/javascript">
	$(top.hangge());	

	$(function(){

        $('form').bootstrapValidator({
/* 　　　　　　　　message: 'This value is not valid', */
			feedbackIcons:{
				valid:'glyphicon glyphicon-ok',
				invalid:'glyphicon glyphicon-remove',
				validating:'glyphicon glyphicon-refresh'
			},
            fields: {
            	dictionaryCode: {
                    validators: {
                        notEmpty: {
                            message: '字典编码不能为空'
                        },
	                    regexp:{
	                    	regexp:/^[0-9_\.]+$/,
	                    	message:'只能是数字'
	                    }
                    }
                },
                dictionaryName: {
                    validators: {
                        notEmpty: {
                            message: '字典名称不能为空'
                        }
                    }
                },
                orderIndex: {
                    validators: {
                        notEmpty: {
                            message: '请输入排序序号'
                        },
	                    regexp:{
	                    	regexp:/^[0-9_\.]+$/,
	                    	message:'只能是数字'
	                    }
                    }
                } 
            }
        });
	});
	
	function save(){
		//alert($("form").data('bootstrapValidator').isValid());   false/true
		$("form").data('bootstrapValidator').validate();//手动对表单进行校验
		var temp=$("form").data('bootstrapValidator').isValid();
		if(temp==true){
			var formData=new FormData($("#dic-form")[0]);
			$.ajax({
				url:'add/dictionary/patient',
				type:'POST',
				data:formData,
				dataType:'json',
				async:false,
				cache:false,
      	     	contentType: false,  
    	      	processData: false,
    	      	success:function(data){
    	      		if(data.statue=="success"){
	    	      		//alert("新增成功");
    	      			window.location.reload();
    	      		}
    	      	},
    	      	error:function(data){
    	      		alert("新增失败");
    	      	}
			});
		}
		
	}
	function closewin(){
		$("#mymodal").modal('hide');
	}
	
	//获取简拼
	function getPinYin(){
		var dicname=$("#dictionaryName").val();
		  var pv= pinyinUtil.getFirstLetter(dicname, false);
		  $("#simpleCode").val(pv);
		  
	}
	
	</script>
</body>
</html>