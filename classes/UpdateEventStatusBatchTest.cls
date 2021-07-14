@isTest
public class UpdateEventStatusBatchTest {
    public static testMethod void testUpdateBatch(){
        List<Event__c> listEvent = new List<Event__c>();
        for(Integer i=1; i<= 50; i++){
            Event__c event = new Event__c(
                Name__c = 'Test Event #'+i,
                Max_Seats__c  = 4,
                Live__c = false,
                Organizer__c = null,
                Status__c = 'In Progress',
                Event_Type__c = 'Virtual',
                Start__c = datetime.newInstance(2020, 12, 01, 11, 0, 0),
                End__c  = datetime.newInstance(2020, 12, 02, 13, 0, 0)
            );
            listEvent.add(event);
        }
        insert listEvent;
        Test.startTest();
        Database.executeBatch(new UpdateEventStatusBatch(), 100);
        Test.stopTest();
        System.AssertEquals(database.countquery('SELECT COUNT() From Event__c Where Status__c = \'Deleted\''), 50); 
    }
}