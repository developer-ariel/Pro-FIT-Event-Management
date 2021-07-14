@isTest
public with sharing class VerifyLocation_Test {
    public static testMethod void testZip(){
        Location__c loc = new Location__c(
            Name = '3301 South Greenfield Rd',
            Street__c = '3301 South Greenfield Rd',
            City__c = 'Gilbert',
            State__c = 'AZ',
            Postal_Code__c = '85297',
            Country__c = 'United States of America',
            Is_Zip_correct__c = false
        );

        insert loc;

        Test.setMock(HttpCalloutMock.class, new ZipCalloutMock());
        Test.startTest();
        VerifyLocation.zipCodeCallOut(''+loc.Id+'');
        Test.stopTest();

        Location__c verifiedZipCode = [Select Is_Zip_correct__c from Location__c where Id =: loc.Id];
        System.debug('Is_Zip_correct__c boolean value: ' + verifiedZipCode.Is_Zip_correct__c);
        System.assertEquals(true, verifiedZipCode.Is_Zip_correct__c);

    }
    public static testMethod void testLoc(){
        Location__c loc = new Location__c(
            Name = '3301 South Greenfield Rd',
            Street__c = '3301 South Greenfield Rd',
            City__c = 'Gilbert',
            State__c = 'AZ',
            Postal_Code__c = '85297',
            Country__c = 'United States of America',
            Verified__c = false
        );

        insert loc;

        Test.setMock(HttpCalloutMock.class, new LocationMockCallout());
        Test.startTest();
        VerifyLocation.locationCallout(''+loc.Id+'');
        Test.stopTest();

        Location__c verifiedStreet = [Select Verified__c from Location__c where Id =: loc.Id];
        System.debug('Verified__c boolean value: ' + verifiedStreet.Verified__c);
        System.assertEquals(true, verifiedStreet.Verified__c);
    }
}