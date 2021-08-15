public with sharing class AccountContactCustom {
    public String RecordName {get;set;}
    public String RecordType {get;set;}
    public String RecordId {get;set;}
    public Decimal CounterOfTypeNumber{get;set;}
    public AccountContactCustom(){

    }
    public AccountContactCustom(Contact contact) {
        RecordName = contact.FirstName + ' '+ contact.LastName;
        RecordType = 'Contact';
        RecordId = contact.Id;
        CounterOfTypeNumber = contact.Counter_of_type_Number__c == null? 0 : contact.Counter_of_type_Number__c;
    }
    public AccountContactCustom(Account account) {
        RecordName = account.Name;
        RecordType = 'Account';
        RecordId = account.Id;
        CounterOfTypeNumber = account.Counter_of_type_Number__c == null? 0 : account.Counter_of_type_Number__c;
    }
}
