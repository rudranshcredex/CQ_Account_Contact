import { LightningElement,wire } from 'lwc';
import { publish, MessageContext } from "lightning/messageService";
import messageChannel from '@salesforce/messageChannel/SampleChannel__c';
export default class LightningMessageService extends LightningElement {
   @wire(MessageContext)
    messageContext;
    message;
 
    handleChange(event){
        this.message = event.detail.value;
    }
 
    handleClick() {
        let message = {message: this.message};
        publish(this.messageContext, messageChannel, message);
    }   
}