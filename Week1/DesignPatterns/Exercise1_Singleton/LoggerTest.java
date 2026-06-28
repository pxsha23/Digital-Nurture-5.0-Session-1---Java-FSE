package com.singleton;

public class LoggerTest{
    public static void main(String[] args){
        Logger logger1 = Logger.getInstance();
        logger1.log("First message from logger1");
        Logger logger2 = Logger.getInstance();
        logger2.log("Second message from logger2");
        if (logger1 == logger2){
            System.out.println("SUCCESS: logger1 and logger2 are the same instance.");
        }else{
            System.out.println("FAILURE: logger1 and logger2 are different instances.");
        }
        System.out.println("logger1 hashCode: " + logger1.hashCode());
        System.out.println("logger2 hashCode: " + logger2.hashCode());
    }
}