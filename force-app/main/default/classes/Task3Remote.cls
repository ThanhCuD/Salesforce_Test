global with sharing class Task3Remote {
    public static AccountContactCustom currentRecord {get;set;}
    public Task3Remote() {
    }
    public void initRecordById(){
        String recordId = Apexpages.currentPage().getParameters().get('id');
        String recordType = Apexpages.currentPage().getParameters().get('type');
        if(String.isBlank(recordId) || String.isBlank(recordType)){
            currentRecord = new AccountContactCustom();
        } else {
            if(recordType == 'Account'){
                
                Account acc = [
                SELECT Id,Name,Owner.Name,Counter_of_type_Number__c
                        FROM Account 
                        WHERE Id = :recordId
                ];
                currentRecord = new AccountContactCustom(acc);
            }
            else{
                Contact ct = 
                [SELECT Id,LastName, FirstName,Counter_of_type_Number__c,Email from Contact where Id = :recordId];
                currentRecord  = new AccountContactCustom(ct);
            }
        }
    }
    @RemoteAction
    global static Decimal UpdateAccountContact(string type,string recordId) {
        try{
            if(type == 'Account'){
                Account acc = [
                SELECT Id,Name,Owner.Name,Counter_of_type_Number__c
                        FROM Account 
                        WHERE Id = :recordId
                ];
                acc.Counter_of_type_Number__c =  acc.Counter_of_type_Number__c == null? 1: acc.Counter_of_type_Number__c + 1;
                upsert acc;
                return acc.Counter_of_type_Number__c;
            }
           else{
               Contact ct = 
               [SELECT Id,LastName, FirstName,Counter_of_type_Number__c,Email from Contact where Id = :recordId];
               ct.Counter_of_type_Number__c =  ct.Counter_of_type_Number__c == null? 1: ct.Counter_of_type_Number__c + 1;
               upsert ct;
               return ct.Counter_of_type_Number__c;
           }
        }catch(Exception e){
            System.debug('==errr==');
            return 0;
        }
    }
}
