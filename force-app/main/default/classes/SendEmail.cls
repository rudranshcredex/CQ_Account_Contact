/**
 * @description       : Apex Class for Aura Component to handle sending email
 * @author            : Rudransh Shukla
 * @group             : 
 * @last modified on  : 11-17-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

 public with sharing class SendEmail {
    @AuraEnabled
    public static void sendEmailToAddress(String emailSubject, String emailTo, String emailBody, List<AttachmentWrapper> attachments) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        System.debug('attachments: ' + attachments);
    
        System.debug('emailSubject------->' + emailSubject);
        System.debug('emailto---->' + emailTo);
        System.debug('emailBody------>' + emailBody);
    
        email.setSubject(emailSubject);
        email.setToAddresses(new String[]{emailTo});
        email.setPlainTextBody(emailBody);
    
        List<Messaging.EmailFileAttachment> fileAttachments = new List<Messaging.EmailFileAttachment>();
        for (AttachmentWrapper attachment : attachments) {
            Messaging.EmailFileAttachment fileAttachment = new Messaging.EmailFileAttachment();
            
            
            Blob fileContent = getFileContent(attachment);
            System.debug('getFileContent(attachment): '+ fileContent);
            fileAttachment.setBody(fileContent);
            
            fileAttachment.setFileName(attachment.name);
            fileAttachments.add(fileAttachment);
        }
        email.setFileAttachments(fileAttachments);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    }
    
    private static Blob getFileContent(AttachmentWrapper attachment) {
        if (attachment.contentVersionId != null) {
            ContentVersion contentVersion = [SELECT VersionData FROM ContentVersion WHERE Id = :attachment.contentVersionId LIMIT 1];
            return contentVersion.VersionData;
        } else if (attachment.documentId != null) {
            Document document = [SELECT Body FROM Document WHERE Id = :attachment.documentId LIMIT 1];
            return document.Body;
        }
    
        return null;
    }
    public class AttachmentWrapper {
        @AuraEnabled public String contentVersionId { get; set; }
        @AuraEnabled public String documentId { get; set; }
        @AuraEnabled public String mimeType { get; set; }
        @AuraEnabled public String name { get; set; }
    }
 }