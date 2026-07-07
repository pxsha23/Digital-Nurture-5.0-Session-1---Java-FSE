package com.dsa.financial;

public class ForecastTest {
    public static void main(String[] args) {
        double presentValue = 10000.0;
        double growthRate   = 0.08;
        int years           = 5;
        double futureValue = FinancialForecast.calculateFutureValue(presentValue, growthRate, years);

        System.out.println("Present Value : Rs. " + presentValue);
        System.out.println("Growth Rate   : " + (growthRate * 100) + "%");
        System.out.println("Years         : " + years);
        System.out.printf("Future Value  : Rs. %.2f%n", futureValue);
        System.out.println("\nAnalysis");
        System.out.println("Time Complexity : O(n) - one recursive call per year");
    }
}