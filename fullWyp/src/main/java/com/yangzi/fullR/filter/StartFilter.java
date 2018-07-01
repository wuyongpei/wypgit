package com.yangzi.fullR.filter;


import java.io.IOException;
import java.net.UnknownHostException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.java_websocket.WebSocketImpl;


import com.yangzi.fullR.controller.base.BaseController;
import com.yangzi.fullR.plugin.ChatServer;
import com.yangzi.fullR.plugin.OnlineChatServer;

public class StartFilter extends BaseController implements Filter{

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.startWebsocketInstantMsg();
		this.startWebsocketOnline();
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	/**
	 * 启动即时聊天服务
	 */
	public void startWebsocketInstantMsg(){
		WebSocketImpl.DEBUG = false;
		int port = 8887; //端口
		ChatServer s;
		try {
			s = new ChatServer(port);
			s.start();
			//System.out.println( "websocket服务器启动,端口" + s.getPort() );
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 启动在线管理服务
	 */
	public void startWebsocketOnline(){
		WebSocketImpl.DEBUG = false;
		int port = 8889; //端口
		OnlineChatServer s;
		try {
			s = new OnlineChatServer(port);
			s.start();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}
}
