public class InsertBulkRecordsInAccount implements database.batchable<sObject> {
    
    public database.QueryLocator start (database.BatchableContext bc){
        string query = 'select id, Name from account';
        system.debug('query string' + query);
        return database.getQueryLocator(query);
    }
    public void execute(database.BatchableContext bc, list<account> scope){
        list<account> accountList = new list<account>();
        for(integer i=0; i< 10000; i++){
            account a = new account();
            a.Name = 'Account__' + string.valueof(i);
         
                a.BillingCity = 'Noida';
                a.BillingState = 'Uttar Pradesh';
                a.BillingPostalCode = '201309';
       
            accountList.add(a);
        }
		try {
            insert accountList;
        } catch (DmlException e) {
            System.debug('DML Exception: ' + e);
        }
    }
    public void finish(database.batchableContext bc){
        system.debug('in finish');
    }

}