public with sharing class EventDetailsClassController {
    @AuraEnabled(cacheable=true)
    public static List<Event_Speaker__c> getSpeakers(String eventId){
        List<Event_Speaker__c> spkrList = [SELECT Id, Name, Event__c,Event__r.Name__c, Speaker__c, Speaker__r.Name, Speaker__r.Phone__c, Speaker__r.Email__c, Speaker__r.Company__c FROM Event_Speaker__c WHERE Event__c = :eventId]; 
        return spkrList;
    }

    @AuraEnabled(cacheable=true)
    public static Event__c getLocationDetails(String eventId){
        Event__c  evntRec = [SELECT Id, Name__c, Location__c, Location__r.Name, Location__r.City__c, Location__r.Country__c, Location__r.Landmark__c, Location__r.Postal_Code__c, Location__r.State__c, Location__r.Street__c FROM Event__c WHERE Location__c != :null AND Id = :eventId]; 
        return evntRec;
    }

    @AuraEnabled(cacheable=true)
    public static List<Event_Attendee__c> getAttendees(String eventId){
        List<Event_Attendee__c> evntAttendeeList = [SELECT Id, Name, Attendee__c, Event_for_Pro_FIT__c, Attendee__r.Name,Attendee__r.Phone__c, Attendee__r.Email__c, Attendee__r.Company_Name__c, Attendee__r.Location_Address_Book__c, Attendee__r.Location_Address_Book__r.Name FROM Event_Attendee__c WHERE Event_for_Pro_FIT__c = :eventId]; 
        return evntAttendeeList;
    }
  
}
    
