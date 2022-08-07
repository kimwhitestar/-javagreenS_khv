package com.spring.javagreenS_khv;



import java.util.Date;
import java.util.Locale;
/*
 * DecimalFormat formatter = new DecimalFormat("#########.00");
 * resultNum = formatter.format((double) large / (double) small);
 */
public class StringFormat {
  public static void main(String[] args) {
  	
  	String str = "comp12";
    System.out.println((String.format("%10s", "comp12")).trim());

  	
    //%o : 8진수, %x : 16진수
    int su1 = 10;
    int su2 = 100;
    System.out.println(String.format("%o", su1));
    System.out.println(String.format("%o", su2));
    System.out.println(String.format("%x", su1));
    System.out.println(String.format("%x", su2));
  }
}
