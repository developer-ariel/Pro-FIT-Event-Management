

public class EventAttendeeHandler {
    public static void sendEmail(List<Event_Attendee__c> newRecordList ) {
        Set<Id> attendeesIdsSet = new Set<Id>();
        Set<Id> eventIdsSet = new Set<Id>();
        for(Event_Attendee__c ea : newRecordList){
            attendeesIdsSet.add(ea.Attendee__c);
            eventIdsSet.add(ea.Event_for_Pro_FIT__c);
        }
        Map<Id,Attendees__c> attendeeMap = new Map<Id,Attendees__c>( 
            [Select Id, Name, Email__c From Attendees__c WHERE  Id IN : attendeesIdsSet]
        );
        Map<Id, Event__c > eventMap = new Map<Id, Event__c > ( [Select Id, Name__c, Start__c, Organizer__c , Organizer__r.Name, Location__c , Location__r.Name, Location__r.City__c, Location__r.State__c, Location__r.Country__c, Location__r.Postal_Code__c, Location__r.Street__c FROM Event__c  WHERE ID IN: eventIdsSet]);
        System.debug('events: ' + eventMap);
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        for(Event_Attendee__c ea : newRecordList){
            Attendees__c att = attendeeMap.get(ea.Attendee__c);
            Event__c evt = eventMap.get(ea.Event_for_Pro_FIT__c);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject('Pass for the '+evt.Name__c);
            List<String> toAddress = new List<String>();
            toAddress.add(att.Email__c);
            mail.setToAddresses( toAddress );
            mail.setSenderDisplayName(evt.Organizer__r.Name);

            String locaton = 'https://www.google.com/maps/place/'+evt.Location__r.Street__c+' '+evt.Location__r.City__c+' '+evt.Location__r.State__c+' '+evt.Location__r.Country__c+' '+evt.Location__r.Postal_Code__c;
            System.debug('locations: ' + locaton);
            String hrefForLocation = '<a href="'+locaton+'"'+'target="_blank">here</a>';
            String emailBody = 'Dear '+ att.Name + ',<br/><br/>'+'Thank you for registering for <strong>'+evt.Name__c+'</strong> which will be organized on '+evt.Start__c.format('MMMM d, y EEEE')+' at '+evt.Start__c.format('H:mm a')+' and will be held in <strong>'+evt.Location__r.Name+'</strong>.<br/>We are excited to have you, see you in the event! <br/>You can find the location at Google Map by clicking '+hrefForLocation+'.<br/><br/><br/>Best,<br/>'+evt.Organizer__r.Name;
            mail.setHtmlBody(emailBody);
            emailList.add(mail);
        }
        List<Messaging.SendEmailResult> results =  Messaging.sendEmail(emailList, false);
        System.debug('Email Results: '+results);
        
    }
}