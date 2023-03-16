public class TestDataFactory {
    public static List<Order> makeOrders(Integer numAccounts, Integer numOrdersPerAccount) {

        //Create the product
        Product2 product = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert product;
 
        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        insert pbe;

        //create a pricebook
        Id priceBookId = Test.getStandardPricebookId();

        // Create an Account List
        List<Account> accList = new List<Account>();
            for(Integer i=0;i<numAccounts;i++) {
                 Account a = new Account(Name='TestAccount' + i);
                 accList.add(a);
             }
        insert accList;  
             // For each account just inserted, add orders
        List<Order> orderList = new List<Order>();
        for (Integer j=0;j<numAccounts;j++) {
            for (Integer k=0;k<numOrdersPerAccount;k++) {
                Order newOrder = new Order(
                                            AccountId = cont.AccountId,  
                                            Pricebook2Id = priceBookId , 
                                            ShipmentCost__c= 10);
            orderList.add(newOrder);
            }
        }
        insert orderList;

        // For each orders just inserted, add products
        List<OrderItem> itemList = new List<OrderItem>();
        for(Order newOrder : orderList) {
            OrderItem item = new OrderItem (
                                            OrderId = newOrder.Id, 
                                            PricebookEntryId = pbe.Id, 
                                            Quantity=1, 
                                            UnitPrice = 110);
            itemList.add(item);
        }
        insert itemList;
      
        return orderList;
    }
}
