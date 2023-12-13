public class Batch implements Database.Batchable<sObject>, Database.Stateful {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select id, BillingPostalCode, (select MailingPostalCode from Contacts) from Account limit 10');
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        List<Contact> contactsToUpdate = new List<Contact>();
        for(Account a : scope){
            for(Contact c : a.Contacts){
                c.MailingPostalCode = a.BillingPostalCode;
                contactsToUpdate.add(c);
            }
        }
        update contactsToUpdate;
    }
    public void finish(Database.BatchableContext bc){}

}