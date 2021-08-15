@RestResource(urlMapping='/Contact/v1/*')
global with sharing class ContactManager
{
    @HttpGet
    global static List<Contact> getContacts(){
        List<Contact> result = [SELECT Id, Name,Counter_of_type_Number__c FROM Contact];
        return result;
    }
    @HttpPut
    global static void doPost(List<RequestContactParam> contacts) {
        RestResponse res = RestContext.response;
        List <Response> lstResponse = new List <Response> ();
        Boolean isError = false;
        for(RequestContactParam ct: contacts){
            try{
                Contact old = [SELECT Id,Name,Counter_of_type_Number__c FROM Contact where Id = :ct.Id];
                old.FirstName = ct.Name;
                if(old.Counter_of_type_Number__c==null){
                    old.Counter_of_type_Number__c = 0;
                }
                update old;
                lstResponse.add(new Response('Successs update'+ct.Id, null));
            }catch(Exception ex){
                isError = true;
                lstResponse.add(new Response('Not found with '+ct.Id, null));
                lstResponse.add(new Response(ex.getMessage(),null));
            }
        }
        if(!isError){
            res.statusCode = 200;
            res.responseBody = Blob.valueOf(JSON.serialize(lstResponse));
        }else{
            res.responseBody = Blob.valueOf(JSON.serialize(lstResponse));
            res.statusCode = 404;
        }
    }
}
