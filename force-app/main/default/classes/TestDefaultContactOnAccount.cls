@istest
private class TestDefaultContactOnAccount {
    @istest	
    static void testMethodDefault(){
        account a = new account(name = 'TestAccount', type='Customer - Direct');
        insert a;
        test.starttest();
        contact c = [select LastName from contact limit 1];
        test.stoptest();
        system.assertEquals('Customer Representative', c.LastName);
    }
}