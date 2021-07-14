@istest
public with sharing class EventDetailsRestService_Test {
    static Id createEventTestRecord(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test REST Service';
        evt.Start__c = System.today()+1;
        evt.End__c = System.today()+2;
        evt.Event_Type__c ='Virtual';
        evt.Live__c = true;
        evt.Status__c = 'Created';
        evt.Max_Seats__c = 1;
        insert evt;
        return evt.Id;
    }
    @IsTest
    static void doGetTest(){
        Test.startTest();
        Id EventId =  createEventTestRecord();
        RestRequest req = new RestRequest();
        req.requestURI = 'https://stefaniniconsultoriaeassessoriaemi--prjsandbox.my.salesforce.com/services/apexrest/api/Event__c/'+EventId;
        req.httpMethod = 'GET';
        RestContext.request = req;
        Event__c evt = EventDetailsRestService.doGetEvt();
        Test.stopTest();
        System.assertEquals(EventId, evt.Id);
    }
}