@isTest
private class CheckMailingAddressInContact_Test {
	@testSetup
    static void setupData(){
        list<contact> contactList = new list<contact>();
        for(integer i =0; i< 5; i++){
            contact c = new contact();
            c.LastName = 'contact__'+i;
            c.Email = 'abc@gmail.com';
            contactList.add(c);
        }
        insert contactList;
    }
    @isTEst
    private static void givenContacts_WhenMailingAddress_ThenChangeMailingAdress(){
        
        test.startTest();
        CheckMailingAddressInContact batch = new CheckMailingAddressInContact();
        Database.executeBatch(batch);
		List<Messaging.SendEmailResult> emailResults = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>());        
        test.stopTest();
        
        system.assertEquals(5,[select count() from contact where mailingCity = 'Noida']);
        
        for (Messaging.SendEmailResult result : emailResults) {
            System.assertEquals( true, result.isSuccess(), 'Email should be sent');
        }
    }
}