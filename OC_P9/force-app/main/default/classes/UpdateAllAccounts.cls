public class UpdateAllAccounts implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 

       return Database.getQueryLocator 
       ('SELECT Id, Chiffre_d_affaire__c, FROM Account' 
       + 'WHERE  Status = \'Ordered\')');
        }

   global void execute(Database.BatchableContext info, List<Account> scope){
       // process each batch of accounts
       for(Account accToUpdate : scope){
        Decimal accountCA = 0; 
        // Then iterate through all accounts' orders to add Net Amount to CA
            
        for(Order orders : accToUpdate.orders) {
           if (orders.NetAmount__c!=null) {
               accountCA = accountCA + orders.NetAmount__c;
           } 
       }
       // After the loop, set accountCa value to Chiffre_d_affaire__c value
       accToUpdate.Chiffre_d_affaire__c = accountCA; 
   } 
   // Finally update list of accounts
   update scope;
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}