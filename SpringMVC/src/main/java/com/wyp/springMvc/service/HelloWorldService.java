package com.wyp.springMvc.service;

import org.springframework.stereotype.Service;

@Service
public class  HelloWorldService {
	public String getNewName(String userName) {
		return "hello spring!"+userName;
	}
}

