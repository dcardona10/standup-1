@isTest
private class OpportunityTriggerHandlerTest {

    @isTest
    static void testOpportunityCreate() {

        List<Opportunity> opps = new List<Opportunity>();

        Id rt = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Corporate').getRecordTypeId();
        Account acc = new Account(
            Name = 'Test Account'            
        );
        insert acc;

        Opportunity opp1 = new Opportunity(
            Name = 'Test Opportunity 1',
            CloseDate = Date.today(),
            Amount = 100000.0,
            Wood_Type__c = 'Standard',
            StageName = 'Closed Won',
            AccountId = acc.Id,
            RecordTypeId = rt
        );
        opps.add(opp1);

        Opportunity opp2 = new Opportunity(
            Name = 'Test Opportunity 2',
            CloseDate = Date.today(),
            Amount = 150000.0,
            Wood_Type__c = 'Standard',
            StageName = 'Qualification',
            AccountId = acc.Id,
            RecordTypeId = rt
        );
        opps.add(opp2);

        Opportunity opp3 = new Opportunity(
            Name = 'Test Opportunity 3',
            CloseDate = Date.today(),
            Amount = 80000.0,
            Wood_Type__c = 'Recycled',
            StageName = 'Closed Won',
            AccountId = acc.Id,
            RecordTypeId = rt
        );
        opps.add(opp3);

        test.startTest();
        insert opps;
        test.stopTest();
    }
}