global class BatchApex implements Database.Batchable<SObject>, Database.AllowsCallouts {

    global Database.QueryLocator start(Database.BatchableContext context) {
        String query = 'Select Id from Animal__c';
        System.debug('Query ----> ' + query);
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext context, List<Animal__c> scope) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');

        try {
            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                List<Object> animals = (List<Object>) results.get('animals');

                List<Animal__c> animalRecords = new List<Animal__c>();
                for (Object animal : animals) {
                    if (animal instanceof String) {
                        String animalName = (String) animal;
                        if (animalName != null) {
                            Animal__c a = new Animal__c(Name = animalName);
                            animalRecords.add(a);
                        }
                    }
                }

                System.debug('Animal records ----> ' + animalRecords);

                
                Database.insert(animalRecords, true);
            } else {
                System.debug('request failed--------> ' + response.getStatusCode());
            }
        } catch (Exception ex) {
            System.debug('Exception------> ' + ex.getMessage());
        }
    }

    global void finish(Database.BatchableContext context) {}
}