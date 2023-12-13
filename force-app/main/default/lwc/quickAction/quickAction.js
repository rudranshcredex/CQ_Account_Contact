import { LightningElement } from 'lwc';

export default class QuickAction extends LightningElement {
    startTime;

    connectedCallback() {
        var today = new Date();
        this.startTime = today.getHours() + ':' + today.getMinutes() + ":" + today.getSeconds();
        console.log('this.startTime', this.startTime);
    }
}