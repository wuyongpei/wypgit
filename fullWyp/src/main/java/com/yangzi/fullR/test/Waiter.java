package com.yangzi.fullR.test;

public class Waiter {
  
	private final int id = counter++;  
    private static int counter = 1;  
  
    public String toString() {  
        if (id > 9)  
            return "Waiter [id=" + id + "]";  
        return "Waiter [id=0" + id + "]";  
  
    }  
}
