public with sharing class OpportunityTriggerHandler {

    private static final String CLOSED_WON = 'Closed Won';
    private static final String STANDARD_WOOD_TYPE = 'Standard';
    private static final String RECYCLED_WOOD_TYPE = 'Recycled';

    private Id oppCorporateRT = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Corporate').getRecordTypeId();
    
    private List<Account> accsToUpdate = new List<Account>();

    private Double totalSalesStandard = 0.0;
    private Double totalSalesRecycled = 0.0;

    public void updateTotalSales(List<Opportunity> oppList) {
        Set<Id> accIds = new Set<Id>();
        for (Opportunity opp : oppList) {
            accIds.add(opp.AccountId);
        }
        
        Map<Id, Account> accMap = new Map<Id, Account>([SELECT Id, Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account WHERE Id IN :accIds]);

        for (Opportunity opp : oppList) {
            if (opp.Wood_Type__c.equals(STANDARD_WOOD_TYPE) && opp.StageName.equals(CLOSED_WON) && opp.RecordTypeId == oppCorporateRT) {
                totalSalesStandard += opp.Amount;
            }
            if (opp.Wood_Type__c.equals(RECYCLED_WOOD_TYPE) && opp.StageName.equals(CLOSED_WON) && opp.RecordTypeId == oppCorporateRT) {
                totalSalesStandard += opp.Amount;
            }
            Account acc = accMap.get(opp.AccountId);
            acc.Total_Sales_Standard_Wood__c = totalSalesStandard;
            acc.Total_Sales_Recycled_Wood__c = totalSalesRecycled;
            accsToUpdate.add(acc);
        }

        try {
            update accsToUpdate;
        } catch (Exception e) {
            System.debug(e);
        }
    }
}