public class MyTeamOrdersController {
    public decimal SumOrders{
        get{
			AggregateResult groupedResults = [SELECT SUM(NetAmount__c) total FROM Order WHERE Status= 'Ordered'];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}