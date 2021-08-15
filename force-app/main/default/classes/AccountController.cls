public with sharing class AccountController {

public List<AccountContactCustom> data {get;set;}
public List<Account> accounts {get;set;}
public List<Contact> contacts {get;set;}
public String searchCondition {get;set;}
public AccountContactCustom currentRecord {get;set;}
public AccountController() {}

public void searchAccount(){
    data = new List<AccountContactCustom>();
    System.debug('==recordId==');
    if(String.isNotBlank(searchCondition)){
        String likeCondition = '%'+searchCondition+'%';
        accounts = [select Id,Owner.Name ,Counter_of_type_Number__c, Name FROM Account 
        WHERE Name LIKE :likeCondition];
        for(Account a: accounts){
            AccountContactCustom item = new AccountContactCustom(a);
            data.add(item);
        }
        contacts = [SELECT Id,LastName,Counter_of_type_Number__c, FirstName,Email from Contact where LastName Like :likeCondition or FirstName LIKE :likeCondition];
        for(Contact a: contacts){
            AccountContactCustom item = new AccountContactCustom(a);
            data.add(item);
            
        }
    }else{
        accounts = [select Id,Owner.Name ,Counter_of_type_Number__c, Name FROM Account ];
        for(Account a: accounts){
            AccountContactCustom item = new AccountContactCustom(a);
            data.add(item);
        }
        contacts = [SELECT Id,LastName,Counter_of_type_Number__c, FirstName,Email from Contact ];
        for(Contact a: contacts){
            AccountContactCustom item = new AccountContactCustom(a);
            data.add(item);
        }
    }
}

public void initRecordById(){
    String recordId = Apexpages.currentPage().getParameters().get('id');
    String recordType = Apexpages.currentPage().getParameters().get('type');
    System.debug('==recordId==' + recordId);
    System.debug('==type==' + recordType);
    System.debug('==recordId==');
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

}
