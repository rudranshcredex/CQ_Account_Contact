({
    getValueFromLwc : function(component, event, helper) {
        component.set("v.inputValue", event.getParam('value'));
    }
})