@isTest
public with sharing class MyTeamOrdersControllerTest {

        @TestSetup
        static void setup() {
            TestDataFactory df = new TestDataFactory();
        }
        @isTest
        static void TestNewOrder() {
            // Create one account with one order
            TestDataFactory.makeOrders(1,1);
            MyTeamOrdersController test = new MyTeamOrdersController();
    
            // Total amount should equals to 100
            System.assertEquals(100, test.SumOrders);
        }
}