package com.yangzi.fullR.test;


import com.yangzi.fullR.util.DateUtil;

public class Main {
  
	
	 public static void main(String[] args) {
    	 
		 Account    account=new Account();
         account.setBalance(1000);
         Company    company=new Company(account);
         Thread companyThread=new Thread(company);
         Bank bank=new Bank(account);
         Thread bankThread=new Thread(bank);
         
         companyThread.start();
         bankThread.start();
         try {
             companyThread.join();///直到线程companyThread结束后才执行以下线程
             bankThread.join();
             System.out.printf("Account : Final Balance: %f\n",account.getBalance());
         } catch (InterruptedException e) {
             e.printStackTrace();
         }
	}
	
}
