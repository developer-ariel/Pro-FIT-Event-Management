@isTest
public with sharing class AttendeeEventsService_Test {
    static Id createTestNewEvent(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Future Event';
        evt.Start__c = System.today()+1;
        evt.Live__c = true;
        evt.Max_Seats__c = 20;
        evt.Event_Type__c = 'Virtual';
        insert evt;
        return evt.Id;
    }
    static Id createTestOldEvent(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Past Event';
        evt.Start__c = datetime.newInstance(2020, 12, 01, 12, 0, 0);
        evt.Live__c = true;
        evt.Max_Seats__c = 20;
        evt.Event_Type__c = 'Virtual';
        insert evt;
        return evt.Id;
    }
    static Id createTestAttendee(){
        Attendees__c att = new Attendees__c();
        att.Name = 'Test Attendee';
        insert att;
        return att.Id;
    }
    @isTest
    static void testUpcomingEvents(){

        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Attendee__c = createTestAttendee();
        eA.Event_for_Pro_FIT__c = createTestNewEvent();
        eA.Name = 'Test EA';
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = AttendeeEventsService.getUpcomingEvents(eA.Attendee__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals('Test EA', name.Name);
    }
    @isTest
    static void testPastEvents(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Attendee__c = createTestAttendee();
        eA.Event_for_Pro_FIT__c = createTestOldEvent();
        eA.Name = 'Test EA';
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = AttendeeEventsService.getPastEvents(eA.Attendee__c);
        name = retrievedAttendee.get(0);
        Test.stopTest();
        System.assertEquals('Test EA', name.Name);
    }
}