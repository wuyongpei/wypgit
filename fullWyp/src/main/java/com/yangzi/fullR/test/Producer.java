package com.yangzi.fullR.test;

public class Producer implements Runnable{

    private Center center;    
    
    public Producer(Center center) {    
        this.center = center;    
    }    
	
	@Override
	public void run() {
		// TODO Auto-generated method stub
		while (!Thread.interrupted()) {    
            //产生客户  
            center.produce();    
        }    
	}

}
