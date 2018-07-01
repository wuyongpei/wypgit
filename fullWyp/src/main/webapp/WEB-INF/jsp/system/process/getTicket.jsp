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
  <form action="process/make/callList.do" method="post" id="t-Form">
  <table class='tab'>
    <tr>
      <td>
          <label>请输入卡号：</label><input type="text" name="cardno" id="cardno"value="">
      </td>
    </tr>
    <tr>
      <td>
          <label>请输入电话号码：</label><input type="text" name="phone" id="phone"value="">
      </td>
    </tr>
    <tr>
      <td>
          <label>请输入身份证：</label><input type="text" name="idNum" id="idNum"value="">
      </td>
    </tr>
  </table>
  </form>
   <button onclick="getTicket();">取票</button>
   
   
   <script type="text/javascript">
   $(top.hangge());
   
   function getTicket(){
	   $("#t-Form").submit();
   }
   
   </script>
</body>
</html>