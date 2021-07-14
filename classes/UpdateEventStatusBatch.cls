public class UpdateEventStatusBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        String Query = 'Select Id, Name__c From Event__c Where Live__c = false AND End__c < LAST_N_MONTHS:4 AND Organizer__c = null AND Status__c != \'Completed\' ';
        return Database.getQueryLocator(Query);
    }
    public void execute(Database.BatchableContext batchContext, List<Event__c> eventList ){
        if(!eventList.isEmpty()){
            List<Event__c> updateEvtStatList = new List<Event__c>();
            for(Event__c evt: eventList){
                evt.Status__c = 'Deleted';
                updateEvtStatList.add(evt);
            }
            update updateEvtStatList;
        }
    }
    public void finish(Database.BatchableContext batchContext){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('Batch Processing Completed');
        List<String> toAddress = new List<String>();
        toAddress.add('arielayenegrido@gmail.com');
        mail.setToAddresses( toAddress );
        mail.setSenderDisplayName('Ariel Negrido');
        mail.setHtmlBody('The execution of the batch has been processed.');
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage> {mail};
        Messaging.sendEmail(emails);
    }
}