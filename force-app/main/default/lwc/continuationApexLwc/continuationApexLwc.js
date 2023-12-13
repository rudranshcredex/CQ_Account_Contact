import { LightningElement } from 'lwc';
import makeCallout from '@salesforce/apexContinuation/ContinuationApex.makeCallout';

export default class ContinuationApexLwc extends LightningElement {
    response;

    makeCallout() {
        makeCallout()
            .then(result => {
                this.response = result;
                console.log('this.response---------->',this.response)
            })
            .catch(error => {
                console.log('error--->', error);
            });
    }
}