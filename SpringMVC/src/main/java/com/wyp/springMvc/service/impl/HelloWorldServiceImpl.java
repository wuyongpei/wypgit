package com.wyp.springMvc.service.impl;

import org.springframework.stereotype.Service;

import com.wyp.springMvc.service.HelloWorldService;


@Service
public class HelloWorldServiceImpl {

	public String getNewName(String userName) {
		return "hello spring!"+userName;
	}

}