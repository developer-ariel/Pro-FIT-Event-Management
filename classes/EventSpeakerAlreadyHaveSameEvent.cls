public with sharing class EventSpeakerAlreadyHaveSameEvent {
    public static void CheckEventSpeaker(List<Event_Speaker__c> evtSpeakerList) {
        Set<Id> eventId = new Set<Id>();
        Set<Id> eventSpeakerId = new Set<Id>();
        for(Event_Speaker__c evntSpkr : evtSpeakerList){
            eventId.add(evntSpkr.Event__c);
            eventSpeakerId.add(evntSpkr.Speaker__c);
        }
        Map<Id, DateTime> startDateEvent = new Map<Id, DateTime>();
        Map<Id, DateTime> endDateEvent = new Map<Id, DateTime>();

        List<Event__c> relatedEventList = [Select Id, Name,Start__c,End__c From Event__c 
        Where Id IN: eventId];
        for(Event__c evt : relatedEventList ){
            startDateEvent.put(evt.Id, evt.Start__c);
            endDateEvent.put(evt.Id, evt.End__c);
        }
        List<Event_Speaker__c> relatedEventSpeakerList = [ SELECT Id, Event__c, Speaker__c,Event__r.Start__c,Event__r.End__c From Event_Speaker__c WHERE Speaker__c IN : eventSpeakerId]; 
        for(Event_Speaker__c evntSpkr : evtSpeakerList){
            DateTime startTime = startDateEvent.get(evntSpkr.Event__c);
            DateTime endTime = endDateEvent.get(evntSpkr.Event__c);
            for(Event_Speaker__c rS: relatedEventSpeakerList) {
                if((rS.Event__r.Start__c < endTime && rS.Event__r.End__c > endTime)||
                (rS.Event__r.Start__c < startTime && rS.Event__r.End__c > startTime)||
                (rS.Event__r.Start__c >= startTime && rS.Event__r.End__c <= endTime)) {
                        evntSpkr.Speaker__c.addError('The Speaker has a existing event that overlap the schedule of this event.');
                }
            }
        }
    }
}