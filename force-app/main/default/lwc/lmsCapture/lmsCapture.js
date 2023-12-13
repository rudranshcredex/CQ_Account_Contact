import { LightningElement, wire } from 'lwc';
import { subscribe, unsubscribe, MessageContext } from 'lightning/messageService';
import messagingChannel from "@salesforce/messageChannel/SampleChannel__c";

export default class LmsCapture extends LightningElement {
    @wire(MessageContext) messageContext;
    subscription = null;
    publisherMessage;

    connectedCallback() {
        this.handleSubscribe();
    }

    handleSubscribe() {
        if (this.subscription) {
            return;
        }
        this.subscription = subscribe(this.messageContext, messagingChannel, (message) => {
            console.log(message.message);
            this.publisherMessage = message.message;
            this.ShowToast('Success', message.message, 'success');
        });
    }

    ShowToast(title, message, variant){
        const event = new ShowToastEvent({
            title: title,
            message:message,
            variant: variant,
            
        });
        this.dispatchEvent(event);
    }
}