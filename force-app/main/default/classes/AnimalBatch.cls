global class AnimalBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext context){
        string query = 'select name from account limit 10';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext context, List<Account> scope){
        List<Animal__c> animalList = new List<Animal__c>();
        for(account a: scope){
            Animal__c animal = new Animal__c();
            animal.Name = a.Name;
            animalList.add(animal);
        }
        system.debug('animallist------>'+animalList);
        insert animalList;
    } 
    global void finish(Database.BatchableContext context) {}
}