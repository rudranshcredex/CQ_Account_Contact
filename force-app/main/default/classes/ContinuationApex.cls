public class ContinuationApex {
    @AuraEnabled(cacheable=true continuation=true)
    public static Object makeCallout() {
        system.debug('start');
        Integer timeout = 60;
        Continuation con = new Continuation(timeout);
        con.ContinuationMethod='processResponse';

        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('https://api.sampleapis.com/beers/ale');
        con.addHttpRequest(request);

        return con;
    }

    @AuraEnabled(cacheable = true)
    public static object processResponse(List<String> labels , Object state){
        system.debug('labels-->'+labels);
        HttpResponse response = Continuation.getResponse(labels[0]);
        system.debug('response------>'+response.getBody());
        return response.getBody();
    }
    
}