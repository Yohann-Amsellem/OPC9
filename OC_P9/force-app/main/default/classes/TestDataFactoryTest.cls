
@isTest
public class TestDataFactoryTest {
    @isTest
    private static void MakeOrdersTest() {
        // Create 10 accounts with 30 orders
        TestDataFactory df = new TestDataFactory();
        TestDataFactory.makeOrders(10,30);
         // Get the list of accounts and a random single account for assertion
         List<account> accountList = new List<account>();
         accountList = [SELECT Id, Name FROM Account WHERE Name LIKE 'TestAccount%'];
         Account singleAccount = [ SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name LIKE 'TestAccount%' LIMIT 1 ];
        // Get the list of orders and a random single order for assertion
        List<order> orderList = new List<order>();
        orderList = [SELECT Id, Account.Name FROM Order WHERE Account.Name LIKE 'TestAccount%'];
        Order singleOrder = [ SELECT Id, Account.Name,NetAmount__c,TotalAmount FROM Order WHERE Account.Name LIKE 'TestAccount%' LIMIT 1 ];

       

         // Orders' size should be 300 (10x30)
         System.assertEquals(300, orderList.size(),'Problem : number of orders created does not match');
         //Accounts' size should be 10
         System.assertEquals(10, accountList.size(), 'Problem : number of accounts created does not match');
         //Account's Chiffre d'affaire should be 3000 =(30 x (110-10))
         System.assertEquals(3000, singleAccount.Chiffre_d_affaire__c, 'Problem : Account CA does not match');  
    }
}