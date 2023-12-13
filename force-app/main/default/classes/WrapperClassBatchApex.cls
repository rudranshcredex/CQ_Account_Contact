public with sharing class WrapperClassBatchApex {
    public list<string> animalList {get; set;}

    public static void getApiResponse(){
        Http http = new http();
        String endpoint = 'https://th-apex-http-callout.herokuapp.com/animals';
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        if(response.getStatusCode()==200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> animals = (List<Object>) results.get('animals');

            system.debug('animals---->'+animals);
        }
        else{
            system.debug('request failed----->'+ response.getStatusCode());
        }
    }

}