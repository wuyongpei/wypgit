﻿<div class="navbar navbar-inverse">
		  <div class="navbar-inner">
		   <div class="container-fluid">
			  <a class="brand"> 
			 <div style="margin-top: 3px;"><img class="ico-logo" src="static/images/logo.ico"><small>${pd.SYSNAME}</small></div></a>
			  <ul class="nav ace-nav pull-right">
					
					<li class="light-blue user-profile">
						<a class="user-menu dropdown-toggle" href="javascript:;" data-toggle="dropdown">
							<img alt="FH" src="static/images/user.jpg" class="nav-user-photo" />
							<span id="user_info">
							</span>
							<i class="icon-caret-down"></i>
						</a>
						<ul id="user_menu" class="pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-closer">
							<li><a onclick="editUserH();" style="cursor:pointer;"><i class="icon-user"></i> 修改资料</a></li>
							<li id="systemset"><a onclick="editSys();" style="cursor:pointer;"><i class="icon-cog"></i> 系统设置</a></li>
							<li class="divider"></li>
							<li><a href="admin/logout"><i class="icon-off"></i> 退出</a></li>
						</ul>
					</li>
			  </ul><!--/.ace-nav-->
		   </div><!--/.container-fluid-->
		  </div><!--/.navbar-inner-->
		</div><!--/.navbar-->
	
	
		<!--引入属于此页面的js -->
		<script type="text/javascript" src="static/jquery/myjs/head.js"></script>
