
@isTest
public class EventAttendeeTest {
    static Id createTestEventOrg(){    
        Event_Organizer__c evtOrg = new Event_Organizer__c();
        evtOrg.Name = 'George Matt';
        evtOrg.Phone__c = '999999';
        evtOrg.Email__c = 'arielayenegrido@gmail.com';
        insert evtOrg;
        return evtOrg.Id;
    }
    static Id createTestEvent(){    
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Event';
        evt.Organizer__c = createTestEventOrg();
        evt.Event_Type__c = 'Virtual';
        evt.Max_Seats__c = 199;
        evt.Live__c = true;
        evt.Start__c = System.now()+1;
        evt.End__c = System.now()+2;
        insert evt;
        return evt.Id;
    }
    static Id createTestAttendee(){    
        Attendees__c att = new Attendees__c();
        att.Name = 'John Cons';
        att.Phone__c = '12312';
        att.Email__c = 'arielayenegrido@gmail.com';
        insert att;
        return att.Id;
    }
    
    @isTest
    static void sendEmailTest(){
        Test.startTest();
        Event_Attendee__c evtAtt = new Event_Attendee__c();
        evtAtt.Attendee__c = createTestAttendee();
        evtAtt.Event_for_Pro_FIT__c = createTestEvent();
        evtAtt.Name = 'Test EA';
        insert evtAtt;
        List <Event_Attendee__c> evtAttRecord = [Select Id, Name, Attendee__c, Event_for_Pro_FIT__c from Event_Attendee__c where Id =:evtAtt.Id];
        EventAttendeeHandler.sendEmail(evtAttRecord);
        Test.stopTest();
        System.assertEquals('Test EA', evtAtt.Name);
    }
}