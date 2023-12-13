import { LightningElement, api } from 'lwc';

export default class Todo_apex extends LightningElement {
   @api userInput ='';
    
    
    handleUserInput(event){
        this.userInput = event.target.value;
        console.log('this.userInput--------->', this.userInput);
    }
}