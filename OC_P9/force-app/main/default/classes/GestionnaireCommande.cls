public with sharing class GestionnaireCommande {
    public static void calculMontant (List<Order> ordersList) {
        //Create Loop and gives net Amount for each order
        for (Order newOrder : ordersList) {
            if (newOrder.ShipmentCost__c!=null) {
                newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
            } else {
            newOrder.NetAmount__c = newOrder.TotalAmount;
            }         
       }
   }

   public static void UpdateAccountCA (List<Order> ordersList) {
    // Get the Ids of the accounts concerned by the trigger with a for loop
    set<Id> setAccountIds = new set<Id>();
    for (Order newOrder : ordersList) {
        setAccountIds.add(newOrder.AccountId);
    }
    // Create a list of a Accounts that matches the previous setAccountIds set 
    // with ordered status
    List<Account> accList = [ SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN : setAccountIds];

    // Iterate through this list of accounts. 
    // For each of them, set initial CA value to 0 
    
    for(Account accToUpdate : accList){
        Decimal accountCA = 0;

    // Then iterate through all accounts' orders to add Net Amount to CA
        
        for(Order orders : accToUpdate.orders) {
            if (orders.NetAmount__c!=null) {
                accountCA = accountCA + orders.NetAmount__c;
            } 
        }
        // After the loop, set CA value to accountCa value
        accToUpdate.Chiffre_d_affaire__c = accountCA;
    }
    // Finally update list of accounts
    update accList;
    }
}