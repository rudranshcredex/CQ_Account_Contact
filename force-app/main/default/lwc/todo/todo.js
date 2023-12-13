import { LightningElement, track } from 'lwc';

export default class Todo extends LightningElement {
    @track userInput = '';
    @track task = [];
    @track taskList = [];

    handleInput(event) {
        this.userInput = event.target.value;
    }

    addTaskButton() {
        this.task.push({ id: this.task.length + 1, taskName: this.userInput, isSelected: false });
        this.taskList = [...this.task];
        this.userInput = '';
    }

    handleCheckboxChange(event) {
        this.taskList.forEach(item => {
            if (item.id == event.target.value) {
                item.isSelected = true;
            }
        });

        const selectedTasks = this.taskList.filter(item => item.isSelected);
    }

    handleEnterKey(event) {
        if (event.keyCode === 13) {
            this.addTaskButton();
        }
    }
}