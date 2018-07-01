package com.yangzi.fullR.test;

public class Customer {
  
	private final int id = counter++;  
    private static int counter = 1;  
  
    public String toString() {  
        if (id > 9) {  
            return "Customer [id=" + id + "]";  
        }  
        return "Customer [id=0" + id + "]";  
    } 
}
