import { LightningElement, track, api, wire } from 'lwc';
import SetRecordActiveMethod from '@salesforce/apex/SetRecordActive.SetRecordActiveMethod';

export default class NewQuickAction extends LightningElement {
    

    @track getInput;

    @api
    recordId;

    setInput;
    
    getSummaryInput(event) {
        this.getInput = event.target.value;
        console.log('this.getInput------>', this.getInput);
        console.log('this.recordsID-------->', this.recordId);
    }

    addButton() {
        this.setInput = this.getInput;
       
        SetRecordActiveMethod({ setInput: this.setInput, recordId: this.recordId })
            .then(result => {   
                console.log('success------>', result);
            })
            .catch(error => {
                console.error('Error---->', error);
            });
    }

    //@wire(SetRecordActive, { setInput: '$setInput', recordId: '$recordId' }) account;

}