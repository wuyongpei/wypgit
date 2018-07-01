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
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<%@ include file="../admin/top.jsp"%>
<%@include file="../../layouts/taglib.jsp"%>
<%@include file="../../includeCssAndJS/include_bootstrap.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	$("#myTabContent *").css("height",$(window).height()-34-$(".active").height());
	$(window).resize(function() { 
		$("#myTabContent *").css("height",$(window).height()-34-$(".active").height());
    });
})

</script>
</head>
<body>
   <ul id="myTab" class="nav nav-tabs">
	<li class="active">
		<a href="#doctor" data-toggle="tab">
			医生工作站
		</a>
	</li>
<!-- 	<li> -->
<!-- 	    <a href="#nurse" data-toggle="tab"> -->
<!-- 	                       护士工作站 -->
<!-- 	    </a> -->
<!-- 	</li> -->
	<li>
	    <a href="#proscenium" data-toggle="tab">
     	       前台工作站
	    </a>
	</li>
</ul>
<div id="myTabContent" class="tab-content">
	<div class="tab-pane fade in active" id="doctor" style="height:800px;">
	   <iframe id="if-doc" scrolling="auto" frameborder="0" width="100%" height="100%" src="work/doctor"></iframe>
	</div>
<!-- 	<div class="tab-pane fade" id="nurse"> -->
<!-- 	     <iframe id="if-nur" scrolling="auto" frameborder="0" width="100%" height="100%" src="work/nurse" ></iframe> -->
<!-- 	</div> -->
	<div class="tab-pane fade" id="proscenium">
		 <iframe id="if-pm" scrolling="auto" frameborder="0" width="100%" height="100%" src="work/proscenium"></iframe>
	</div>
</div>
 
 
 
 <script type="text/javascript">
	$(top.hangge());	
 </script>
 
 
</body>
</html>