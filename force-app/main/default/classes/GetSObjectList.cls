public with sharing class GetSObjectList {
    @AuraEnabled(cacheable=true)
     public static  List<String> getObjects() {
        List<Schema.SObjectType> objectTypes = Schema.getGlobalDescribe().values();
        List<String> objectNames = new List<String>();

        for (Schema.SObjectType objectType : objectTypes) {
            string name = objectType.getDescribe().getName();
            if(name.contains('__c')){
                 objectNames.add(name);
            }  
        }
         system.debug('objectNames'+objectNames);
        return objectNames;
    }
}