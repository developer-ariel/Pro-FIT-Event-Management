public with sharing class AttendeeEventsService {
    @AuraEnabled(cacheable=true)
    public static List<Event_Attendee__c> getUpcomingEvents(String attendeeId) {
        List<Event_Attendee__c> eventLists = [SELECT Id, Name, Event_for_Pro_FIT__c, Event_for_Pro_FIT__r.Location__c, Event_for_Pro_FIT__r.Event_Type__c, Event_for_Pro_FIT__r.Location__r.Name, Event_for_Pro_FIT__r.Organizer__c, Event_for_Pro_FIT__r.Organizer__r.Name, Event_for_Pro_FIT__r.Name__c, Event_for_Pro_FIT__r.Start__c FROM Event_Attendee__c WHERE Attendee__c = :attendeeId AND Event_for_Pro_FIT__r.Start__c >= TODAY];
        return eventLists;
    }
  
    @AuraEnabled(cacheable=true)
    public static List<Event_Attendee__c> getPastEvents(String attendeeId) {
        List<Event_Attendee__c> eventLists = [SELECT Id, Name, Event_for_Pro_FIT__c, Event_for_Pro_FIT__r.Location__c, Event_for_Pro_FIT__r.Event_Type__c, Event_for_Pro_FIT__r.Location__r.Name, Event_for_Pro_FIT__r.Organizer__c, Event_for_Pro_FIT__r.Organizer__r.Name, Event_for_Pro_FIT__r.Name__c, Event_for_Pro_FIT__r.Start__c FROM Event_Attendee__c WHERE Attendee__c = :attendeeId AND Event_for_Pro_FIT__r.Start__c < TODAY];
        return eventLists;
    }
}