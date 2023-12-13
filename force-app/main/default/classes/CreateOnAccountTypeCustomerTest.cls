@isTest
public class CreateOnAccountTypeCustomerTest {
    @isTest
    static void triggerCreateOnAccountTypeCustomer() {
        // Test data setup
        system.debug('start');
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias='standt', Email='standarduser12344@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId=p.Id, 
                          TimeZoneSidKey='Asia/Kolkata', UserName='standarduser133322@testorg.com');
        insert u;

        system.runAs(u) {
            PermissionSet permissionSet = [select Id from PermissionSet where Name = 'Account_Manager_Set'];
            PermissionSetAssignment psa = new PermissionSetAssignment(
                AssigneeId = u.Id,
                PermissionSetId = permissionSet.Id
            );
            insert psa;
        }

        
        account a = new account(name='Test-1', Active__c=true, summary__c='test summary dummy', type='Customer');
        insert a;
        //account b = new account(name='Test-2', Active__c=true, type='Customer', summary__c=null);
       // insert b;
		system.debug('account'+a);
       
        List<Contact> contactList = [select LastName, email, phone from Contact where AccountId = :a.Id limit 1];

        String last_Name = '';
        string phoneNo;
        string emailId = '';
        if (!contactList.isEmpty()) {
            last_Name = contactList[0].LastName;
            phoneNo = contactList[0].phone;
            emailId = contactList[0].email;
        }
        system.assertEquals('Customer Representative', last_Name);
        system.assertEquals(a.Phone, phoneNo);
        system.assertEquals(a.Email__c, emailId);
        //System.assertNotEquals(null, b.Summary__c, 'Summary field should not be empty');
    }
    
   
}