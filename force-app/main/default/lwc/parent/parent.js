import { LightningElement } from 'lwc';

export default class Parent extends LightningElement {

    showData = false;
    message = 'Updated count will appear here!';

    handleClick() {
        this.showData = !this.showData;
    }
    updateMessage(event) {
        this.message = event.detail.message;
    }
}