public with sharing class VerifyLocation {
    @future (callout=true)
    public static void zipCodeCallOut(String locId) {
        Location__c loc = [Select Id,Is_Zip_correct__c,State__c,Street__c,Postal_Code__c,City__c from Location__c where Id = :locId];
        Http httpzip = new Http();
        HttpRequest reqzip = new HttpRequest();
        String addzip = 'https://us-zipcode.api.smartystreets.com/lookup?auth-id=d16ebdbe-8ebf-5a6e-9e81-867d53e291d6&auth-token=wmBLxM6f4Be6ve9OKFJF&city=&state=&zipcode='+loc.Postal_Code__c;
        reqzip.setEndPoint(addzip);
        reqzip.setMethod('GET');
        HttpResponse respzip= new HttpResponse();
        respzip = httpzip.send(reqzip);
        System.debug(respzip.getStatusCode());

        try {
            if(respzip.getStatusCode() == 200){
                List<Object> resultsZipList = (List<Object>)JSON.deserializeUntyped(respzip.getBody());
                    for(Object obj : resultsZipList){
                        Map<String, Object> results = (Map<String, Object>) obj;
                        List<Object> zipObject = (List<Object>) results.get('zipcodes');
                        if(zipObject!=null){
                            locationCallout(locId);
                            loc.Is_Zip_correct__c = true;
                            update loc; 
                        }
                    }
                
                }
        } 
        catch (Exception ex) {
            System.debug('Exception -- ' + ex.getMessage());
        }
    }
    public static void locationCallout(String locId){
        Location__c loc = [Select Id,Is_Zip_correct__c,State__c,Street__c,Postal_Code__c,City__c from Location__c where Id = :locId];
        Http httpst = new Http();
        HttpRequest reqst = new HttpRequest();
         String addst = 'https://us-street.api.smartystreets.com/street-address?auth-id=d16ebdbe-8ebf-5a6e-9e81-867d53e291d6&auth-token=wmBLxM6f4Be6ve9OKFJF'
         +'&street=' + EncodingUtil.urlEncode(loc.Street__c, 'UTF-8') 
         +'&city='+ EncodingUtil.urlEncode(loc.City__c, 'UTF-8')
         +'&state=' + EncodingUtil.urlEncode(loc.State__c, 'UTF-8');
         System.debug(addst);
         reqst.setEndPoint(addst);
         reqst.setMethod('GET');
        HttpResponse respst= new HttpResponse();
        respst = httpst.send(reqst); 
        try {
            if(respst.getStatusCode() == 200){
                String respstBody = respst.getBody();
                if(respstBody.length()>2){
                    loc.Verified__c = true;
                }
                update loc;
            }
        } 
        catch (Exception ex) {
            System.debug('Exception -- ' + ex.getMessage());
        }
    }

}