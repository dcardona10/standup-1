trigger OpportunityTrigger on Opportunity (before insert, before update) {

    OpportunityTriggerHandler handler = new OpportunityTriggerHandler();
    handler.updateTotalSales(Trigger.new);
}