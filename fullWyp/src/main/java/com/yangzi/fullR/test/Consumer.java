package com.yangzi.fullR.test;

public class Consumer implements Runnable{

	 private Center center;    
	    
	    public Consumer(Center center) {    
	        this.center = center;    
	    }    
	
	
	@Override
	public void run() {
		// TODO Auto-generated method stub
		  while (!Thread.interrupted()) {    
	            center.consume();    
	        }    
	}

}
