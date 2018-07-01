<%
	String pathl = request.getContextPath();
	String basePathl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+pathl+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<!-- 本页面涉及的js函数，都在head.jsp页面中     -->
		<div id="sidebar" class="">

				<ul class="nav nav-list">

					<li class="active" id="fhindex">
					  <a href="main/index"><i class="icon-dashboard"></i><span>后台首页</span></a>
					</li>


			<c:forEach items="${menuList}" var="menu">
				<c:if test="${menu.hasMenu}">
				<li id="lm${menu.menu_Id}">
					  <a style="cursor:pointer;" class="dropdown-toggle" >
						<i class="${menu.menu_Icon == null ? 'icon-desktop' : menu.menu_Icon}"></i>
						<span>${menu.menu_Name }</span>
						<c:if test="${menu.menu_Level==1}">
						<b class="arrow icon-angle-down"></b>
						</c:if>
					  </a>
					  <ul class="submenu">
							<c:forEach items="${menu.subMenu}" var="sub">
								<c:if test="${sub.hasMenu}">
								<c:choose> 
									<c:when test="${not empty sub.menu_Url}">
									<li id="z${sub.menu_Id }">
									<a style="cursor:pointer;" target="mainFrame"  onclick="siMenu('z${sub.menu_Id}','lm${menu.menu_Id}','${sub.menu_Name}','${sub.menu_Url}')"><i class="icon-double-angle-right"></i>${sub.menu_Name }</a></li>
									</c:when>
									<c:otherwise>
									<li><a href="javascript:void(0);"><i class="icon-double-angle-right"></i>${sub.menu_Name}</a></li>
									</c:otherwise>
								</c:choose>
								</c:if>
							</c:forEach>
				  		</ul>
				</li>
				</c:if>
			</c:forEach>

				</ul><!--/.nav-list-->

				<div id="sidebar-collapse"><i class="icon-double-angle-left"></i></div>

			</div><!--/#sidebar-->

