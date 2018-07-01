package com.yangzi.fullR.util;

import com.fasterxml.jackson.databind.ser.BeanPropertyWriter;
import com.yangzi.fullR.annotation.JsonCode2Name;

public class CustomBeanPropertyWriter extends BeanPropertyWriter {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected CustomBeanPropertyWriter(BeanPropertyWriter base) {
		super(base);
	}

	private JsonCode2Name getCode2Name() {
		if (_accessorMethod != null) {
			return _accessorMethod.getAnnotation(JsonCode2Name.class);
		}
		return _field.getAnnotation(JsonCode2Name.class);
	}

	
}
