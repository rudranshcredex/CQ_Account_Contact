public class CheckMailingAddressInContact implements Database.Batchable<SObject>, Database.Stateful, Schedulable {
    integer count =0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode, Email FROM Contact';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        for (Contact c : scope) {
            c.mailingStreet = 'GigaByte Road';
            c.MailingCity = 'Noida';
            c.MailingState = 'Uttar Pradesh';
            c.MailingPostalCode = '201307';
            this.count+=1;     
        }            
        update scope;
        }
    public void finish(Database.BatchableContext bc) {
        System.debug('In finish');
        system.debug('count>>>>>'+ count);
        list<contact> contactList = [select id, email from contact where email != null limit 10];
        
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        for (Contact c : contactList) {  
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{c.Email});
            email.setSubject('Subject');
            email.setPlainTextBody('Email Body Text');
            emailMessages.add(email);
        }
        Messaging.sendEmail(emailMessages); 
    }
    public void execute(SchedulableContext context) {
    
	insert new ACcount (Name ='Rudy with Schedular');
      
 

  }
}