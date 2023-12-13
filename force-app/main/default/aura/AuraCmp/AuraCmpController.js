({
    contactSelected : function(component, event, helper) {
        component.set("v.selectedContact", event.getParam('contactName'));
    }
})