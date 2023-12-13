/**
 * @description       : Apex Class for Aura Component to handle sending email
 * @author            : Rudransh Shukla
 * @group             : 
 * @last modified on  : 11-17-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class SendEmailClass {

    @AuraEnabled
    public static void sendEmail(String emailSubject, String emailTo, String emailBody, List<AttachmentWrapper> attachments) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();


        system.debug('emailSubject------->'+emailSubject);
        system.debug('emailto---->'+ emailto);
        system.debug('emailBody------>'+emailBody);

        email.setSubject(emailSubject);
        email.setToAddresses(new String[]{emailTo});
        email.setPlainTextBody(emailBody);

        List<Messaging.EmailFileAttachment> fileAttachments = new List<Messaging.EmailFileAttachment>();
        for (AttachmentWrapper attachment : attachments) {
            Messaging.EmailFileAttachment fileAttachment = new Messaging.EmailFileAttachment();
            fileAttachment.setBody(Blob.valueOf(attachment.fileContent));
            fileAttachment.setFileName(attachment.fileName);
            fileAttachments.add(fileAttachment);
        }
        email.setFileAttachments(fileAttachments);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    }

    public class AttachmentWrapper {
        @AuraEnabled public String fileName { get; set; }
        @AuraEnabled public String fileContent { get; set; }
    }
}