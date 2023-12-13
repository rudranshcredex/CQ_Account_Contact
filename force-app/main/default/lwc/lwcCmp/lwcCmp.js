import { LightningElement, track } from 'lwc';
 
export default class LwcCmp extends LightningElement {
 

    @track lstContacts = ["ABC", "DEF", "PQR", "XYZ"];
 
   
    selectContact(event){
        const strSelectedContact = event.target.textContent;
        var objContact  = {
            contactName : strSelectedContact
        };
        // var objContact = event.target.value;
        const evtSelectContact = new CustomEvent('selectcontactevent', {detail : objContact});
        this.dispatchEvent(evtSelectContact);
    }
     
}