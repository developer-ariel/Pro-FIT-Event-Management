

@isTest 
public with sharing class EventDetailsClassController_Test {
    static Id createTestLocation(){
        Location__c loc = new Location__c();
        loc.Name = 'Baluyot Drive';
        loc.Street__c = '113 Baluyot II';
        loc.City__c = 'Drive';
        insert loc;
        return loc.Id;
    }
    static Id createTestEvent(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Event';
        evt.Max_Seats__c = 199;
        evt.Event_Type__c = 'In-Person';
        evt.Location__c = createTestLocation();
        evt.Live__c = true;
        evt.Start__c = System.now()+1;
        evt.End__c = System.now()+2;
        insert evt;
        return evt.Id;
    }
    static Id createTestSpeaker(){
        Speaker__c spk = new Speaker__c();
        spk.Name = 'Test Spek';
        insert spk;
        return spk.Id;
    }
    static Id createTestAttendee(){
        Attendees__c att = new Attendees__c();
        att.Name = 'Test Attendee';
        insert att;
        return att.Id;
    }
    @IsTest
    static void testSpeaker(){ 

        Test.startTest();
        Event_Speaker__c eS = new Event_Speaker__c();
        eS.Event__c = createTestEvent();
        eS.Speaker__c = createTestSpeaker();
        eS.Name = 'Test Name';
        insert eS;
        Event_Speaker__c name;
        List<Event_Speaker__c> retrievedSpeaker = EventDetailsClassController.getSpeakers(eS.Event__c);
        name = retrievedSpeaker.get(0);
        Test.stopTest();
        System.assertEquals('Test Name',name.Name);
    }
    @IsTest
    static void testLocation(){
        Test.startTest();
        String recId = createTestEvent();
        Event__c evts = EventDetailsClassController.getLocationDetails(recId);
        Test.stopTest();
        System.assertEquals('Test Event',evts.Name__c);
    }
    @isTest
    static void testAttendee(){
        Test.startTest();
        Event_Attendee__c evtAtt = new Event_Attendee__c();
        evtAtt.Attendee__c = createTestAttendee();
        evtAtt.Event_for_Pro_FIT__c = createTestEvent();
        evtAtt.Name = 'Test EA';
        insert evtAtt;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = EventDetailsClassController.getAttendees(evtAtt.Event_for_Pro_FIT__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals('Test EA', name.Name);
    }
}