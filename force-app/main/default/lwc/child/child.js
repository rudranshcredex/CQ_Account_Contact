import { LightningElement, track } from 'lwc';

export default class Child extends LightningElement {

    handleChange(event) {
        const value = event.target.value;
        console.log('value------>', value);
        const valueChangeEvent = new CustomEvent('uploadevent', {
            detail: { value }
        });
        this.dispatchEvent(valueChangeEvent);
    }
}