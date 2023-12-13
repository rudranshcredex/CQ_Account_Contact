trigger CreateContactOnAccountTypeCustomer on Account (after insert, after update) {
    boolean hasPermission = false;
    system.debug('trugger starts');
    set<id> accountIds = new set<id>();
    list<permissionSetAssignment> permissionSetList = [SELECT Id, PermissionSet.Name
                                                       FROM PermissionSetAssignment
                                                       WHERE AssigneeId = :Userinfo.getUserId()];
    if(!permissionSetList.IsEmpty()){
        for(PermissionSetAssignment psa: permissionSetList){
            if(psa.PermissionSet.Name.equals('Account_Manager_Set')){
                hasPermission = true;
            }
        }
    }
    
    system.debug('haspermission----->'+hasPermission);
    
    if(hasPermission){
        for(account a : trigger.new){
            if(a.Active__c == true && a.Summary__c == null){
                a.addError('Summary field cannot be empty');
            }
        }
        
        system.debug('hasPermission'+hasPermission);
        if(trigger.isInsert || trigger.isUpdate){
            for(account a : trigger.new){
                if(a.Type == 'Customer' && a.Active__c == true){
                    accountIds.add(a.id);
                    system.debug('account id'+ accountIds);
                }
            }
        }
        if (!accountIds.isEmpty()) {
            
            list<Contact> contactList = [select Id, AccountId from Contact where accountId in :accountIds];
            
            Map<Id, Boolean> accountContactMap = new Map<Id, Boolean>();
            for (Contact c :contactList) {
                accountContactMap.put(c.AccountId, true);
                system.debug('account contact map before'+ accountContactMap);
            }
            
            
            list<Contact> newContacts = new list<Contact>();
            
            for (Id accountId : accountIds) {
                if (!accountContactMap.containsKey(accountId)) {
                    system.debug('account contact map in loop----->'+ accountContactMap);
                    Account relatedAccount = Trigger.newMap.get(accountId);
                    newContacts.add(new Contact(
                        FirstName = relatedAccount.Name,
                        LastName = 'Customer Representative',
                        Email = relatedAccount.Email__c,
                        Phone= relatedAccount.Phone,
                        AccountId = accountId
                    ));
                }
            }
            if (!newContacts.isEmpty()) {
                insert newContacts;
            }
        }
    }
    else {
        for(account a: trigger.new){
            a.addError('Dont have permission');
        }
    }
}