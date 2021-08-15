trigger Task1 on Contact (after insert,after delete) {
    if (Trigger.isInsert) {
    for (Contact contact : Trigger.new) {
        Id objectId = contact.Id;
        Approval.ProcessSubmitRequest  procRequest = new Approval.ProcessSubmitRequest();
        procRequest.setObjectId(objectId);
        Approval.ProcessResult  result = Approval.process(procRequest);
        Boolean isSuccess = result.isSuccess();
        if(isSuccess){
             Contact contact_new = [Select Active__c,Id From Contact Where Id = :objectId];
             contact_new.Active__c = true;
             update contact_new;
             Account account = [Select Total_Contacts__c,Name From Account Where Id = :contact.AccountId];
             if(account!=null){
                List<Contact> lstContact = [Select Active__c,Id From Contact Where AccountId = :account.Id];
                account.Total_Contacts__c  =lstContact.size();
                update account;
             }
        }
    }}
    else if (Trigger.isDelete) {
        for (Contact contact : Trigger.old) {
            Id objectId = contact.Id;
            Account account = [Select Total_Contacts__c,Name From Account Where Id = :contact.AccountId];
            if(account!=null){
                List<Contact> lstContact = [Select Active__c,Id From Contact Where AccountId = :account.Id];
                account.Total_Contacts__c  =lstContact.size();
                update account;
            }
        }
    }
}