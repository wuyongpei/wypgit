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
<style type="text/css">
 

</style>
</head>
<body>
   <div>
      <table id="" class="table">
          <thead>
           <tr>
             <th class="t-center">序号</th>
             <th class="t-center">姓名</th>
             <th class="t-center">编号</th>
             <th class="t-center">时间</th>
             <th class="t-center">操作</th>
           </tr>
          </thead>
          <tbody class="t-body">
<%--      <c:choose> --%>
<%--        <c:when test=""> --%>
<%--         <c:forEach items=""> --%>
              <tr>
               <td></td> 
               <td></td> 
               <td></td> 
               <td></td> 
               <td></td> 
               </tr>
<%--         </c:forEach>  --%>
<%--        </c:when> --%>
<%--      </c:choose> --%>
         </tbody>                                             
       </table>
   
   
   
   </div>


</body>
</html>