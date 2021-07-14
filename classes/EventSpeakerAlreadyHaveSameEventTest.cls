
@isTest
private class EventSpeakerAlreadyHaveSameEventTest {
    Static Id createTestRecordID(){
      Event__c evt = new Event__c();
      evt.Name__c = 'Test Event';
      evt.Live__c = true;
      evt.Max_Seats__c = 5;
      evt.Event_Type__c = 'Virtual';
      evt.Start__c = System.today()+1; 
      evt.End__c = System.today()+2;
      insert evt;
      return evt.Id;
    }
    @IsTest
    Static void CheckEventSpeaker(){
      Test.startTest(); 
      Event_Speaker__c eS = new Event_Speaker__c();
      eS.Name = 'Test Create Event-Speaker';
      eS.Event__c = createTestRecordID();
      es.Speaker__c = 'a0A0l000002TXJ8EAO';   
      insert eS;
      Test.stopTest();

      Event_Speaker__c result = [select Speaker__c from Event_Speaker__c where Speaker__c=: es.Speaker__c];
      System.assertEquals(eS.Speaker__c, result.Speaker__c);
    }  
}