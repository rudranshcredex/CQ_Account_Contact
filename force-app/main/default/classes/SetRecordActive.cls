/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-11-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class SetRecordActive {
    @AuraEnabled
    public static void  SetRecordActiveMethod(String setInput, String recordId) {

        system.debug('setInput---->'+ setInput);
        
       account a = [select Summary__c, Active__c from account where id = :recordId limit 1 ];

       a.Active__c= true;
       a.Summary__c= setInput;
        
       update a;
    }
}