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
	<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/bootstrap/css/bootstrap-select.css" rel="stylesheet" />
<link href="static/fullRC/css/jquery.alertable.css" rel="stylesheet">
<link href="static/fullRC/css/register.css" rel="stylesheet" />
<script type="text/javascript" src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript"src="static/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="static/jquery/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/fullRC/js/jquery.alertable.js"></script>
<script type="text/javascript"src="static/fullRC/js/pagePlugin.js"></script>

<style type="text/css">
.btn-list{
 background-color: #ffffff;
 border:1px solid #4CAF50;
 color:#4CAF50;
 display: inline-block;
}
.btn-list:hover{
   color:#fff;
   background-color: #3DADA1;
   border: 1px solid #3DADA1;
} 
.act{
 background-color: #3DADA1;
 color:#ffffff;
}
.t-center{
 text-align: center;
}
.span-div{
  margin: 10px;
}
.span-div span{
  color:#4CAF50;
}
</style>
</head>
<body>
<form action="process/list/confirm.do" method="post"></form>

   <div class="tab-content tab-div">
			<div class="tab-pane active" id="appointManager"
				style="overflow: hidden;">
				<div class="panel panel-default" style="border: none;">
				   <div class="panel-heading head-panel" style="border-bottom: 1px solid #ccc;">
						<div class="row">
							<div class="col-sm-3 col-md-4">
							  <h4>队列叫号总控   <i class="glyphicon glyphicon-refresh" onclick="window.location.reload();"></i></h4>	
							
							</div>
                            <div class="col-sm-9 col-md-8 pull-right">
                            	<form action="process/list/confirm.do" class="form-inline pull-right" method="post" id="search-Form">
									<div class="form-group">
										<input type="text" class="form-control input-sm2" name="dockey" id="dockey"
											placeholder="请输入医生姓名/简拼">
									</div>
									<div class="form-group">
										<a class="btn btn-default input-sm2" href="javascript:search();"> <i
											class="glyphicon glyphicon-search "></i></a>
									</div>
								</form>
                            </div>
						</div>
					</div>
					
						<div class="panel-body">
						<!-- 一张卡片开始 -->
						   <div class="row">
						          <c:forEach items="${callList}" var="call">
						            <div class="col-sm-6 col-md-4 col-lg-4" >
						                 <div class="panel" style="border: 1px solid #ccc;text-align: center;height: 500px;z-index: 999!important;">
                                             <h4>(${call.workUnitName})${call.officeName}:${call.empName}</h4>
                                            <div id="mzd${call.empID}">
                                               <button  class="btn btn-list act" onclick="goCallList('${call.empID}',1,this);" >正在排队</button>
                                               <button  class="btn btn-list" onclick="goCallList('${call.empID}',2,this);">已经就诊</button>
                                               <button  class="btn btn-list" onclick="goCallList('${call.empID}',3,this);">过号</button>
                                            </div>	
                                            <div class="span-div">
                                               <span>排队：${call.countList}</span>
                                               <span>过号：${call.countPass}</span>
                                               <span>已叫：${call.alreadyCall}</span>
                                               <span>已就诊：${call.alreadyTreated}</span>
                                            </div> 
                                            <div>
                          <iframe id="ifr${call.empID}" scrolling="auto" 
                           frameborder="0" width="100%" height="380px" src="process/one/list/call.do?status=1&docId=${call.empID}"></iframe>
                                            </div>					                 
						                 </div>
						             </div>
						          </c:forEach>
						   </div>
						</div>
					
						<!-- 分页 12条一页 -->
							<div>
								<div class="base_page">
									<button
										onclick="nextPage('${page.currentPage -1}','${page.showCount}')"
										type="button" class="btn btn-default pull-left">
										<i class="glyphicon glyphicon-chevron-left"></i>
									</button>
									<button type="button"
										class="btn btn-default  base_page_info pull-left"
										disabled="disabled">${page.currentPage}/${page.totalPage}</button>
									<button
										onclick="nextPage('${page.currentPage +1}','${page.showCount}')"
										type="button" class="btn btn-default pull-left">
										<i class="glyphicon glyphicon-chevron-right"></i>
									</button>
									<input type="hidden" id="showCount" value="${page.showCount}"><input
										id="toGoPage" placeholder="页码" type="number"
										class="form-control  num-input pull-left" /> <a
										class="btn btn-default j_madule_page_search_submit pull-left ml5"
										type="button" onclick="toTZ();">Go</a>
								</div>
							</div>
						<!-- 分页12 -->	
					
					
								
				</div>
              </div>
             </div> 




<script type="text/javascript">
      $(top.hangge());
       
      
      function goCallList(id,status,obj){
	      $("#ifr"+id).attr("src","process/one/list/call.do?status="+status+"&docId="+id);		
	      $("#mzd"+id+" button").removeClass("act");
    		  $(obj).addClass("act");
    		  $(obj).addClass("act");
    		  $(obj).addClass("act");
      }
      
      
      function search(){
    	  $("#search-Form").submit();
      }
      
      
      

</script>

</body>
</html>