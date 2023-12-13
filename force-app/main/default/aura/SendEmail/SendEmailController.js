({

    sendEmail: function (component, event, helper) {
        let index = 0;
        if (index === 0) {
            index = 1;
            var emailSubject = component.get("v.emailSubject");
            var emailTo = component.get("v.emailTo");
            var emailBody = component.get("v.emailBody");


            console.log('emailSubject----->', emailSubject);
            console.log('emailTo----->', emailTo);
            console.log('attachment:', component.get("v.uploadedFiles"));


            var action = component.get("c.sendEmailToAddress");
            action.setParams({
                emailSubject: emailSubject,
                emailTo: emailTo,
                emailBody: emailBody,
                attachments: component.get("v.uploadedFiles")
            });

            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    console.log('Email sent successfully');
                } else {
                    console.error('Error sending email: ' + response.getError()[0].message);
                }
            });

            $A.enqueueAction(action);
        }
    },

    handleUploadFinished: function (component, event, helper) {
        console.log('inside upload finished');
        var uploadedFiles = event.getParam("files");
    
        console.log('uploadedFiles: ', uploadedFiles);
    
        
        var attachments = uploadedFiles.map(file => {
            return {
                contentVersionId: file.documentId,
                documentId: file.documentId,
                mimeType: file.mimeType,
                name: file.fileName
            };
        });
    
        console.log('attachments: ', attachments);
        component.set("v.uploadedFiles", attachments);
    },
    

    handleChange: function (cmp, e) {
        console.log('inside handle change');
        console.log('event: ', e);
    }
})