@isTest
public class UpdateAllAccountsTest {
    @TestSetup
    static void setup() {
        TestDataFactory df = new TestDataFactory();
    }
    @isTest
    static void UpdateAllAccountsTest() {
        // Create 20 accounts with 10 orders for each of them.
        Test.startTest();
        TestDataFactory.makeOrders(20,10);
        UpdateAllAccounts batch = new UpdateAllAccounts();
        Id batchId = Database.executeBatch(batch);
        Test.stopTest();
        Account testAccountAfterUpdate = [ SELECT Id, Chiffre_d_affaire__c 
                                        FROM Account WHERE Name 
                                        LIKE 'TestAccount%' LIMIT 1 ];
        // As orders' Net Amount = 100, Account CA should be 1000.
        System.assertEquals(1000,testAccountAfterUpdate.Chiffre_d_affaire__c);
    }
}