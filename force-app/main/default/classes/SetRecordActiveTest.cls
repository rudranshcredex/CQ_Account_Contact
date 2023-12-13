@isTest
public class SetRecordActiveTest {
    
    @isTest
    static void testSetRecordActiveMethod() {

        Account a = new Account(
            Name = 'Test Account',
            Summary__c = 'dummy ',
            Active__c = false
        );
        insert a;
        
        SetRecordActive.SetRecordActiveMethod('update Summary', a.Id);
        
        
        Account updatedAccount = [select Summary__c, Active__c from Account where Id = :a.Id Limit 1];
        
        
        System.assertEquals('update Summary', updatedAccount.Summary__c);
        System.assertEquals(true, updatedAccount.Active__c);
        
    }
}