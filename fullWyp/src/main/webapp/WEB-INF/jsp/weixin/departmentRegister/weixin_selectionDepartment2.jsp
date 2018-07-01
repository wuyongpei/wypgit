<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();//上下文路径
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>预约挂号选择科室</title>
<base href="<%=basePath%>">
<%@include file="/WEB-INF/jsp/layouts/taglib.jsp"%>
<link rel="stylesheet" type="text/css" href="static/jquery-weui/css/jquery-weui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-weui/lib/weui.css">
<style type="text/css">
*{
	font-family: 微软雅黑;
	font-size: 14px;
}
div.show{
	display: block;
}
a.background{
	background: #F5F5F5;
	color: #00BFFF;　
}
.container ::-webkit-scrollbar {display: none;}
div.hidediv{
	display: none;
}
.btn-appoint{
	width: 60px;height: 30px;font-size: 14px;line-height: 2em;float: right;background-color: #1E90FF;position: absolute;right: 5px;top: 50%;margin-top: -15px;
}
a.weui-btn.weui-btn_primary.btn-appoint:active{
	background-color: #1E90FF;
}

div.bg_div{
	text-align: center;
}
div.hide{
	display: none;
}
/* 提示信息toast */
div.weui-toast{
	position:fixed;
	left:50%;
	top:25%;
	margin-top:54px;
	margin-left: 2px;
	
}
/* 改变提示框样式颜色 */
.weui-toast .weui-icon-warn{
	color: #f5f5f5;
}
.weui-toast .weui-icon-cancel{
	color: #f5f5f5;
}
</style>
</head>
<body>
	<!-- 只有一级科室 -->
	<div >
		<div class="weui-search-bar" id="searchBar" style="height: 50px">
		  <form id="searchForm" class="weui-search-bar__form" method="post" action="javascript:searchKeyword();">
		    <div class="weui-search-bar__box" onclick="seachLike();">
		      <i class="weui-icon-search"></i>
		      <input type="search" class="weui-search-bar__input" id="keyword" name="keyword" placeholder="输入科室或医生姓名" >
		      <a href="javascript:" class="weui-icon-clear" id="searchClear" onclick="cannelSeach();"></a>
		    </div>
		    <label class="weui-search-bar__label" id="searchText" >
		      <i class="weui-icon-search"></i>
		      <span>输入科室或医生姓名</span>
		    </label>
		  </form>
	 		<a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel" onclick="cannelSeach();">取消</a>
		</div>
		<div id="dediv">	
<!-- 			<div class="weui-cells" style="margin-top: 0;">
				<a href="weixin/noFollowDoctor" class="weui-cell weui-cell_access">
					<div class="weui-cell__hd"><img src="static/weixinImages/love.png" style="width: 16px;height: 16px;"></div>
					<div class="weui-cell__bd">
						<p>我的收藏</p>
					</div>
					<div class="weui-cell__ft"></div>
				</a>
			</div> -->
			<div class="weui-cells" style="margin-top: 0;">			
<!-- 	 			<a href="javascript:jumpSelectDoctor();" class="weui-cell weui-cell_access">
					<div class="weui-cell__bd">
						<p>[东街]心血管内科</p>
					</div>
					<div class="weui-cell__ft">说明文字</div>
				</a>  --> 
			<c:forEach items="${deplist }" var="deplist">
				<a href="weixin/selectDoctor/${deplist.OfficeID }" class="weui-cell weui-cell_access">
					<div class="weui-cell__bd">
						<p>${deplist.OfficeName }</p>
					</div>
					<div class="weui-cell__ft"></div>
				</a>
			</c:forEach>
			</div>
		</div>
		<div class="container">
			<!-- 搜索结果  科室信息 -->
			<div id="searchDepResult" class="hidediv" style="margin-top: -23px;">
				<div class="weui-cells">	
				
				</div>
			</div>
			<!-- 搜索结果 医生信息 -->
			<div id="searchDocResult" class="hidediv" style="margin-top: -21px;">
 				<div class="weui-cells">

				</div>
			</div>
		
		</div>


<script type="text/javascript" src="static/jquery-weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/jquery-weui/lib/fastclick.js"></script>
<script type="text/javascript" src="static/jquery-weui/js/jquery-weui.js"></script>
<script type="text/javascript">

	$(function(){
		
		FastClick.attach(document.body);
	});
	
	//查询科室或医生
	function searchKeyword(){
			var keyword=$("#keyword").val();
			//还需判断输入是否为空???
			if(keyword==null || keyword==""){
				$.toast("请输入搜索信息","forbidden");
			}else{
				
				$.ajax({
					url:"weixin/search/keyword",
					type:'POST',
					dataType:'json',
					data:{keyword:keyword},
					success:function(data){
						$("#searchDepResult div.weui-cells").empty();
						$("#searchDocResult div.weui-cells").empty();
						$("#searchDepResult div.bg_div").empty();
						var deplist=data.deplist;
						var emplist=data.emplist;
						if(deplist!="" && deplist!=null || emplist!="" && emplist!=null){
							//查询科室结果
							if(deplist!="" && deplist!=null){
								$("#searchDepResult").removeClass("hidediv");//显示科室
									$("#searchDepResult div.weui-cells").append(
										"<div class='weui-cell__bd' style='padding: 5px 0px 5px 15px;color: #999999;font-size: 12px;'>科室信息(&nbsp;"+data.deptotal+"&nbsp;)</div>"
									);
								for(var i=0;i<deplist.length;i++){
									$("#searchDepResult div.weui-cells").append(
										"<a href='weixin/selectDoctor/"+deplist[i].OfficeID+"' class='weui-cell weui-cell_access'>"
										+"<div class='weui-cell__bd'><p>"+deplist[i].OfficeName+"</p>"
										+"</div>"
										+"<div class='weui-cell__ft'></div> "
										+"</a>"
									);
								}
							}
							//查询医生结果
							if(emplist!="" && emplist!=null){
								//显示医生
								$("#searchDocResult").removeClass("hidediv");
								$("#searchDocResult div.weui-cells").append(
										"<div class='weui-cell__bd' style='padding: 5px 0px 5px 15px;color: #999999;font-size: 12px;'>医生信息&nbsp;(&nbsp;"+data.emptotal+"&nbsp;)</div>"
								);	
								for(var i=0;i<emplist.length;i++){	
									$("#searchDocResult div.weui-cells").append(
											"<div class='weui-panel weui-panel_access' style='margin-top: 0px;'>"
											+"<div class='weui-panel__bd' >"
											+"<div href='javascript:void(0);' class='weui-media-box weui-media-box_appmsg' style='border-bottom: 1px solid #F5F5F5;padding: 0 10px 5px 10px;height: auto;'>"
											+"<div class='weui-media-box__hd' style='position: relative;'><img class='weui-media-box__thumb' src='static/weixinImages/doctorHead.png' style='height: 40px;width: 40px;position: absolute;top: 50%;margin-top: -20px;left: 10px;'></div>"
											+"<div style='text-align: left;width: 100%;position: relative;padding-top: 5px;'>"
											+"<div class='weui-laber' style='line-height: 1.7em;float: left;width: 75%;'>"
											+"<div class='weui-media-box__title' style='float: left;font-weight: bold;font-size: 14px;'>"+emplist[i].E_Name+"&nbsp;</div>"
											+"<label class='weui-laber' style='color: #808080;margin-left: 10px;font-size: 12px;'>"+emplist[i].doctorPosition+"&nbsp;</label><br>"
											+"<div class='weui-laber' style='color: #808080;text-align: left;font-size: 12px;'>&nbsp;科室:&nbsp;"+emplist[i].OfficeName+"</div>"
											+"</div>"
											+"<a href='weixin/selectSchedule/"+emplist[i].Emp_ID+"' class='weui-btn weui-btn_primary btn-appoint'>预约</a>"
											+"</div>"
											+"</div>"
											+"</div>"
											+"</div>"
									);
								}
								if(emplist.length>3){
									//增加查看全部医生按钮
									$("#searchDocResult div.weui-cells").append(
											"<div id='loadmore' class='weui-cells' style='margin-top: 0;'>"
											+"<a class='weui-cell weui-cell_access weui-cell_link' onclick='loadmoreDoctor();'>"
											+"<div class='weui-cell__bd'>查看全部医生</div>"
											+"<span class='weui-cell__ft'></span>"
											+"</a>"
											+"</div>"
									);
									hideDoctor();//显示前3条数据
								}
								
							}
						}else{
							$("#searchDepResult").append(
									"<div class='bg_div'>"
									+"<div style='padding-top:40%;'>"
									+"<img class='div_img' src='static/weixinImages/nodata.png'>"
									+"<p style='color: #808080;text-align: center;line-height: 2em;'>未能找到相应的科室或医生</p>"
							);
						}
					},
					error:function(data){
						alert("error");
					}
				});
			}

	}
	//显示搜索医生 前3条数据
	function hideDoctor(){
		$("#searchDocResult div.weui-panel.weui-panel_access").each(function(index){
			if(index>2){//只显示前三条数据
				$(this).addClass('hide');
				$("#loadmore").removeClass('hide');//显示加载更多
			}
		});
	}
	//加载更多医生
	function loadmoreDoctor(){
		$("#searchDocResult div.weui-panel.weui-panel_access").removeClass('hide');//显示所有医生
		$("#loadmore").addClass('hide');//隐藏加载更多
	}
	//点击搜索
	function seachLike(){
		$("#dediv").addClass("hidediv");
		$("#searchBar").addClass('weui-search-bar_focusing');
		//测试搜索加载页面
		$("#searchDepResult").removeClass("hidediv");
		$("#searchDocResult").removeClass("hidediv");
	}
	//取消搜索
	function cannelSeach(){
		$("#dediv").removeClass("hidediv");
		//隐藏搜索结果
		$("#searchDepResult").addClass("hidediv");
		$("#searchDocResult").addClass("hidediv");
		$("#searchBar").removeClass('weui-search-bar_focusing');
	}
	
	
	
</script>




</body>
</html>